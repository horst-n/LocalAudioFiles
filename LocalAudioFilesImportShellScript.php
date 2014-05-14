<?php
/********************************************************************************************
* @script_type -  PHP-CLI for use with ProcessWire LocalAudioFiles
* -------------------------------------------------------------------------
* @author      -  Horst Nogajski <coding@nogajski.de>
* @copyright   -  (c) 2002 - 2013
* -------------------------------------------------------------------------
* $Source: /WEB/pw_LAF/htdocs/LocalAudioFilesImportShellScript.php,v $
* $Id: LocalAudioFilesImportShellScript.php,v 1.2 2013/05/22 09:21:14 horst Exp $
*********************************************************************************************/

/**
*  TODO:
*
*  [x] check/allow for duplicate Album-Titles but from different Artists:
*
*  [x] run this script not as user guest, because all imported files are then owned by user 'guest'!
*
*  [x] do not save tracknumber for unknown albums!  (check if it works:: around LINE 206, search for: "// skip tracknumber for unknown albums !" )
*
*  [x] method to ReBuild complete Cache: code should go into the modules file!
*
*  [x] coverimage-import for empty albums do not work correct! stores a (virtual) filename.
*
*  [ ]
*
*  [ ]
*
*/



// the absolute path or relative path to processwires index.php
	$PATH2PWindex = dirname(__FILE__).'/index.php';


// $username and $pass of the user who 'owns' the imported files. (when importing from _your_ filesystem I assume _you_ should be the owner, so please set your name and pass here :-) )
// this will be of importance if you, for example, further allow different users to upload files
// and let them choose if the files are for private or public use, (or want to do some other user/owner-related things)
	$PWuser = '';
	$PWpass = '';


// Names for empty Genre-Tags and empty Album-Tags
	define('HNPW_UNKNOWN_GENRE','-unknown-');
	define('HNPW_UNKNOWN_ALBUM','-unknown-');


// SET THIS TO TRUE AND RUN THE SCRIPT IF YOU WANT TO RESET YOUR DB !!
	$DROPALLCHILDREN = false;




class LocalAudioFilesShellImporter {

	//private $encodingCharset = 'UTF-8';  // UTF-8 | ISO-8859-1 | or what ever you have in your ID3Tags
	private $dbCharset = 'UTF-8';
	private $blockNewPages = array('samplerate','bitrate','bitratemode');
	private $bitrates = array();
	private $dbModified = false;
	private $addedPages = array();

	public $fi = null; 	  /** mp3 file info = assoc array:
	                        *
	                        *   filename dirname basename extension
	                        *   filesize timestamp checksum
	                        *   artist genre
	                        *   album year
	                        *   song songnumber songlength samplerate bitrate bitrate_mode comment unsynchronised_lyric
	                        */
						  /** the used checksum is as follows:
							*
							*   $checksum = md5( serialize($metadata) . $file_size . $timestamp );
							*
							*   first I have used crc32 checksum of filedata but this was very very slow :(
							*   than I've tried with md5_file(), it was about 4 times faster, but also slow :(
							*   so I decided to use the serialized complete ID3-Data + filesize and timestamp of the file to get a (hopefully) unique checksum
							*   e.g. would it be better only to use serialized ID3 + filesize? Can it then detect duplicate files with different timestamp?
							*/

    public function __construct($dbCharset='UTF-8') {
		$this->dbCharset = strtoupper($dbCharset);
		$children = wire('pages')->get('title=bitrates')->children;
		foreach($children as $child) {
			$this->bitrates[] = intval($child->title);
		}
		sort($this->bitrates);
    }

	public function __destruct() {
		$this->revertLastChanges();
		if($this->dbModified) {
			$GLOBALS['laf']->setLastModified(time());
		}
	}


//	public function setEncodingCharset($ID3encodingCharset='UTF-8') {
//		$this->encodingCharset = strtoupper($ID3encodingCharset)=='UTF8' ? 'UTF-8' : strtoupper($ID3encodingCharset);
//		if(isset($this->mp3)) {
//			$this->mp3->setEncodingCharset( $this->encodingCharset );
//		}
//	}


	// this function is called from within the class hn_dir_PWshell :: addFile($file) when scanning filesystem
	public function info($mp3Filename,$cover=false) {
		$mp3 = new hn_mp3();
        // we check if we should override the EncodingCharset with a fix one
		$CHARENC = $GLOBALS['laf']->getConfig('encodingCharset');
		if(empty($CHARENC)) {
	        $ver = $mp3->getID3V2version($mp3Filename);      // retrieve ID3v2 version, 3 or 4
	        $CHARENC = (4===$ver ? 'UTF-8' : 'ISO-8859-1');  // with version 2.3 we have to use ISO-8859-1, with 2.4 we use UTF-8, (on fail we use ISO-8859-1 = used by ID3v1)
		}
		$this->encodingCharset = $CHARENC;
		$mp3->setEncodingCharset( $this->encodingCharset );
		$res = $mp3->read_infos($mp3Filename,false,$cover);
		$mp3->close();
		unset($this->mp3,$mp3);
		$a = array();
		$b = $this->encodingCharset===$this->dbCharset ? array() : array('artist','album','song','genre','comment','unsynchronised_lyric');
		foreach(array('artist','album','song','songnumber','year','genre','comment','unsynchronised_lyric','bpm') as $k) {
			if(in_array($k,array('artist','album','song','genre'))) {
				$tmp = trim(preg_replace('/[^a-zA-Z0-9 _\-]/', '', str_replace(array('ä','ö','ü','ß','Ä','Ö','Ü',"\r\n","\n","\t"), array('ae','oe','ue','ss','Ae','Oe','Ue','','',' '), $res['id3_merged'][$k]) ));
				$a[$k] = in_array($k,$b) ? iconv($this->encodingCharset, $this->dbCharset."//TRANSLIT//IGNORE", $tmp) : $tmp;
				$a[$k] = ucwords(strtolower(trim(str_replace(array('     ','    ','   ','  '),' ',$a[$k]))));
			}
			else {
				$a[$k] = in_array($k,$b) ? iconv($this->encodingCharset, $this->dbCharset."//TRANSLIT//IGNORE", $res['id3_merged'][$k]) : $res['id3_merged'][$k];
			}
		}
		$a['songlength']   = $res['main']['playtime_seconds'];
		$a['samplerate']   = $res['main']['sample_rate'];
		$a['bitrate']      = intval($res['main']['bitrate']/1000);
		$a['bitratemode']  = $res['main']['bitrate_mode'];
		return $a;
	}


	public function addCover2Album($album,$id) {
		$album->of(true);
		if(strlen($album->cover->url)>0) {
			return true;
		}
		$laf = wire('modules')->get('LocalAudioFiles');
		//$url = $laf->getConfig('httpHost') . "/stream/cover/$id/albumcover_{$id}.jpg";  // $id from song-page = indicates where we have get the cover from ??
		$url = $laf->getConfig('httpHost') . "/stream/cover/$id/albumcover_{$album->id}.jpg";  // more logical = cover has same id as album-page
		$res = file_get_contents($url);
		if(false===$res || empty($res)) {
			return false;
		}
		$album->of(true);
        $album->cover = $url;
		$album->of(false);
        $album->save();
		$album->of(true);
        $p = $album->cover;
        return strlen($p->url)>0 ? true : false;
	}



	public function isSong($checkModified=false, $deleteOnModified=false) {
		// check if we have that file already in DB
		$p = wire('pages')->get("template=song,filename=".wire('sanitizer')->selectorValue($this->fi['filename']));
		if($p->id != 0) {
			if($checkModified && wire('sanitizer')->selectorValue($this->fi['checksum']) != $p->checksum) {
                // the file is stored in DB but is modified in filesystem
                if($deleteOnModified) {
                	$p->delete();
				}
				return false;
			}
			return true;
		}
		$p = wire('pages')->get("template=song,checksum=".wire('sanitizer')->selectorValue($this->fi['checksum']));  // if filename isn't in DB, it could be a duplicate file, so the checksum will match
		if($p->id != 0) return true;
		$p = $this->getPageSong();  // to play save, we also check if it is a slightly modified duplicate file, - we check if there is already an entry with same songname, albumname and artist
		if($p->id != 0) return true;
		return false;
	}

	public function import() {
		$this->addedPages = array();
		// TODO 1 -c improvement: implementing optional strict genre usage ? (v1 = 80 and v2 = ca. 150)
		$this->fi['genre'] = empty($this->fi['genre']) ? HNPW_UNKNOWN_GENRE : $this->fi['genre']; // avoid empty Genre-Entries
		$this->fi['album'] = empty($this->fi['album']) ? HNPW_UNKNOWN_ALBUM .' '. $this->fi['artist'] : $this->fi['album']; // avoid empty Album-Entries
		$this->fi['album'] = HNPW_UNKNOWN_ALBUM == $this->fi['album'] ? HNPW_UNKNOWN_ALBUM .' '. $this->fi['artist'] : $this->fi['album']; // avoid empty Album-Entries
		if( empty($this->fi['genre']) || empty($this->fi['artist']) || empty($this->fi['album']) || empty($this->fi['song']) ) {
			return false;
		}

		// get / create the pages for genre, artist, album, song
		foreach(array('genre','artist','album','song') as $part) {
			if(false===($$part = $this->getPage($part))) {
				return false;
			}
		} unset($part);

		// store additional data to artist
		$artist->genre = empty($artist->genre->title) || HNPW_UNKNOWN_GENRE == $artist->genre->title ? $genre : $artist->genre;
		$artist->save();

		// at least we have the first new Data stored here into DB and have to set the modifiedFlag
		$this->dbModified = true;

		// store additional data to album
		foreach(array('year') as $k) {
			if(empty($album->$k) && !empty($d[$k])) $album->$k = $d[$k];
		} unset($k);
		if(empty($album->artist->title)) {
			$album->artist = $artist;
		}
		$album->save();

		// store additional data to song
		foreach(array('songnumber','songlength','bpm','comment','unsynchronised_lyric') as $k) {
			if('songnumber'==$k && HNPW_UNKNOWN_ALBUM==substr($album->title,0,strlen(HNPW_UNKNOWN_ALBUM))) continue; // skip tracknumber for unknown albums !
			if(!empty($this->fi[$k])) $song->$k = $this->fi[$k];
		} unset($k);
		foreach(array('samplerate','bitrate','bitratemode') as $k) {
			if(!empty($this->fi[$k])) {
            	$p = $this->getPage($k, $this->fi[$k]);
            	$song->$k = $p;
			}
		} unset($k,$p);
		$song->album = $album;
		$song->save();

		// ok, seems to be all went well :), let's empty our revertArray
		$this->addedPages = array();
		return true;
	}

	public function revertLastChanges() {
		if(count($this->addedPages)<=0) {
			return true;
		}
        foreach($this->addedPages as $id) {
			$p = wire('pages')->get("id=$id");
			if(0!=$p->id && in_aray($p->template,array('genre','artist','album','song'))) {
				$p->delete();
			}
        }
		return true;
	}



	private function getPage($template) {
		switch($template) {
			case 'genre':
				$p = $this->getPageGenre();
				break;
			case 'artist':
				$p = $this->getPageArtist();
				break;
			case 'album':
				$p = $this->getPageAlbum();
				break;
			case 'song':
				$p = $this->getPageSong();
				break;
			default:
				if(in_array($template,$this->blockNewPages)) {
					$p = wire('pages')->get("template=basic-page,name=".trim(wire('sanitizer')->pageName($this->fi[$template],true)));
					if(0==$p->id && is_numeric($this->fi[$template]) && 32<=intval($this->fi[$template])) {
						$cur = intval($this->fi[$template]);
						$last = $min = 32;
						foreach($this->bitrates as $b) {
							if($min<=$cur && $b>$cur) {
								$p = wire('pages')->get("name=".($b-$cur > $cur-$last ? $last : $b));
								break;
							}
							$last = $b;
						} unset($last,$b,$min,$cur);
					}
				}
				break;
		}
		if(0==$p->id && !in_array($template,$this->blockNewPages)) {
			// create the page
			$p = new Page();
			$p->template = $template;
			$p->title = $this->fi[$template];  // is already sanitized with: preg_replace('/[^a-zA-Z0-9 _\-]/', '', $title);
			// Genres and Artists have to be unique,
			// whereas Albums may have duplicate entries but with different Artists
			// and Songs may have duplicate entries but assigned to different Albums / Artists
			if(in_array($template,array('genre','artist'))) {
				$p->name = trim(wire('sanitizer')->pageName(substr($this->fi[$template],0,128),true));
			}
			$p->parent = wire('pages')->get('template='.strtoupper($template).'S');
			if('song'==$template) {
				$p->checksum = $this->fi['checksum'];  // required field! - we must set it now, can't do it later!
				$p->filename = $this->fi['filename'];  // required field!
			}
			$p->save();
			$this->dbModified = true;
			$this->addedPages[] = $p->id;
		}
		return $p;
	}
	private function getPageGenre() {
		$name = trim(wire('sanitizer')->pageName(substr($this->fi['genre'],0,128),true));
		$p = wire('pages')->get("template=genre,name=".wire('sanitizer')->selectorValue($name));
		$id = $p->id;
		return $p;
	}
	private function getPageArtist() {
		$name = trim(wire('sanitizer')->pageName(substr($this->fi['artist'],0,128),true));
		$p = wire('pages')->get("template=artist,name=".wire('sanitizer')->selectorValue($name));
		$id = $p->id;
		return $p;
	}
	private function getPageAlbum() {
		$p = wire('pages')->get("template=album,title^=".wire('sanitizer')->selectorValue(substr($this->fi['album'],0,50)).",artist.".$this->nameSelector($this->fi['artist']));
		$id = $p->id;
		return $p;
	}
	private function getPageSong() {
		$p = wire('pages')->get("template=song,title^=".wire('sanitizer')->selectorValue(substr($this->fi['song'],0,50)).",album.title^=".wire('sanitizer')->selectorValue(substr($this->fi['album'],0,50)).",artist.".$this->nameSelector($this->fi['artist']));
		$id = $p->id;
		return $p;
	}
	// we use the name instead of title for genre and artist because they have to be unique!
	private function nameSelector($title, $operator='=') {
		$s = trim(wire('sanitizer')->pageName(substr($title,0,128),true));
		return 'name'.$operator.wire('sanitizer')->selectorValue($s);
	}

}



require_once($PATH2PWindex);

// get pathes and config data
$docroot    = $config->paths->root;
$incroot    = $config->paths->LocalAudioFiles . 'phpclasses/';
$logroot    = $config->paths->logs . 'LAF_import_'.date('Ymd_Hi').'/';
require_once($incroot . 'hn_mp3.class.php');
$hn = new hn_basic();


// first let's sync charset
$charset = strtoupper($config->dbCharset)=='UTF8' ? 'UTF-8' : strtoupper($config->dbCharset);
ini_set('default_charset',$charset);
if( ! strtolower(trim(ini_get('default_charset')))==$charset ) {
	echo "WRONG CHARACTERSET IN PHP!\n\texpected: $charset \n\tactually: '". strval(ini_get('default_charset'))."'\n";
	$hn->cl_ask("\n...(press enter to close the importer script)");
	exit(1);
}


// get config data
$laf        = $wire->modules->get('LocalAudioFiles');
$Pathes     = $laf->getConfig('pathes');
$Filetypes  = $laf->getConfig('filetypes');


// choose user-account who should own the imported files
wire('session')->login($PWuser,$PWpass);
if(!wire('user')->active && !wire('user')->hasRole('superuser|localaudiofiles_admin')) {
	echo "\n\nERROR: Incorrect UserLogin!\n\nScript stop now!\n";
	$hn->cl_ask("...(press enter to close the importer script)");
	exit(1);
}
echo "\nSuccessful Login as : " . wire('user')->name ."\n\n";



// should we empty the LocalAudioFiles ?
if(isset($DROPALLCHILDREN) && $DROPALLCHILDREN) {
	if(dropAllChildren()) {
		$laf->setLastModified(time());
		$laf->emptyCache(true);
	}
	$hn->cl_ask("\n\nNow you have a nice empty DB to do a fresh restart!\n ... (press enter to close the importer script)");
	exit(0);
}



$mp3 = new LocalAudioFilesShellImporter();
if(in_array(strtolower(trim($hn->cl_ask("\nDo you want to scan filesystem and import MP3-files? (yes/no) ENTER"))),array('y','yes')) ) {

	// traverse directories and collect mp3file data & id3 data
	$dir_init = array(
		'debugoutput'		=> DBG_LOG_NONE,
		'debugpattern'      => '/parseDir|timer/',
		'depth'             => -1,
		'fileextensions'    => $Filetypes,
		'checksum'          => true,
		'very_basic_result' => false,
		'use_timer'         => true
	);
	$dir = new hn_dir_PWshell($dir_init);
	$dir->debugoutput = DBG_LOG_CMDL;
	$dir->setMP3($mp3);



	echo "\nNow start FileSystemScan and parse FileMetadata, ...\n\n";
	$summary = $dir->getDir($Pathes);
	$tmps = array();
	foreach($dir->directorys as $tmp) $tmps[] = $tmp['fullname'];
	laflog((implode("\n",$Pathes)).strip_tags($summary).("\n\n".implode("\n",$tmps)),'summary');
	echo "\nThe FileSystemScan found ".strval(count($dir->files))." valid Audiofiles \nwith a total of ".$dir->friendly_filesize($dir->totalfilesize) . $dir->br2nl($summary);



	echo "\n\nNow start importing into DB, ...\n\n";
	$total = count($dir->files);
	$cur = 0;
	$imported = 0;
	foreach($dir->files as $f) {
		$cur++;

		// make a nice output line :-)
		$s1 = "[ $cur / $total ] ($imported) = ";
		$s2 = strlen($f['basename']) >= (80 - strlen($s1)) ? substr($f['basename'],0,intval((80 - strlen($s1) - 4)/2)).'...'.substr($f['basename'],(intval((80 - strlen($s1) - 4)/2) * -1)) : str_pad($f['basename'],(80 - strlen($s1)),' ',STR_PAD_RIGHT);
		echo "\r{$s1}{$s2}";
	    // check for invalid chars in filename
		if(htmlentities($f['filename'], ENT_QUOTES, $charset)=='') {
	        $s1b = " - invalid filename [$cur] ";
			$s2b = strlen($f['basename']) >= (80 - strlen($s1b)) ? substr($f['basename'],0,intval((80 - strlen($s1b) - 4)/2)).'...'.substr($f['basename'],(intval((80 - strlen($s1b) - 4)/2) * -1)) : str_pad($f['basename'],(80 - strlen($s1b)),' ',STR_PAD_RIGHT);
			echo "\r{$s1b}{$s2b}\n";
			laflog($f['filename'],'invalid');
	        continue;
		}
		if( empty($f['genre']) ) {
	        $f['genre'] = HNPW_UNKNOWN_GENRE;
		}
		if( empty($f['album']) ) {
	        $f['album'] = HNPW_UNKNOWN_ALBUM;
		}
		if( empty($f['artist']) || empty($f['song']) || empty($f['genre']) || empty($f['album']) ) {
			laflog($f['filename'],'missingid3');
	        continue;
		}
		// load fileinfo into class
		$mp3->fi = $f;
		// check if the Song is already stored in DB,
		// additionally, if is already stored, check if file is modified since last import and if true, delete entry (because we import it new)
		if($mp3->isSong(true,true)) {
			laflog($f['filename'],'skipped');
	        continue;
		}
		if($mp3->import()) {
			$imported++;
			laflog($f['filename'],'success');
		}
		else {
			$mp3->revertLastChanges();
			laflog($f['filename'],'failed');
		}
		// reset
		$mp3->fi = null;
	}

	// make last output line, ...
	$s1 = "[ $cur / $total ] ($imported) = ";
	$s2 = strlen($f['basename']) >= (80 - strlen($s1)) ? substr($f['basename'],0,intval((80 - strlen($s1) - 4)/2)).'...'.substr($f['basename'],(intval((80 - strlen($s1) - 4)/2) * -1)) : str_pad($f['basename'],(80 - strlen($s1)),' ',STR_PAD_RIGHT);
	echo "\r{$s1}{$s2}\n";
	echo "\nOk, we are ready with importing files and Metadata!\n";

}



// ask for importing Albumcovers!
$hn = new hn_basic();
if( in_array(strtolower(trim($hn->cl_ask("\nDo you want to import Albumcovers now? (yes/no) ENTER"))),array('y','yes')) ) {
	// OK, we import new Albumcovers
	$albums = wire('pages')->find("template=album");
	$cur = 0;
	$total = count($albums);
	$hasCover = 0;
	$newOnes = 0;
	foreach($albums as $album) {
		$cur++;
		$album->of(true);
		if(strlen($album->cover->url)>0) {
			$hasCover++;
			$tmp = $album->name . ': allready in DB!';
			$s1 = "[ $cur / $total ] ($hasCover) = ";
			$s2 = strlen($tmp >= (80 - strlen($s1))) ? substr($tmp,0,intval((80 - strlen($s1) - 4)/2)).'...'.substr($tmp,(intval((80 - strlen($s1) - 4)/2) * -1)) : str_pad($tmp,(80 - strlen($s1)),' ',STR_PAD_RIGHT);
			echo "\r{$s1}{$s2}";
			continue;
		}
	    // album has no cover yet, get album tracks and scan for one
		$coverAdded = false;
		$tracks = wire('pages')->find("template=song, album.id=".$album->id);
		foreach($tracks as $track) {
			if(true==$mp3->addCover2Album($album,$track->id)) {
				$coverAdded = true;
				$hasCover++;
				$newOnes++;
				break;
			}
		}
		laflog($album->name, ($coverAdded ? 'cover_success' : 'cover_failed') );

		$tmp = $album->name . ($coverAdded ? ': added!' : ': has no cover!');
		$s1 = "[ $cur / $total ] ($hasCover) = ";
		$s2 = strlen($tmp >= (80 - strlen($s1))) ? substr($tmp,0,intval((80 - strlen($s1) - 4)/2)).'...'.substr($tmp,(intval((80 - strlen($s1) - 4)/2) * -1)) : str_pad($tmp,(80 - strlen($s1)),' ',STR_PAD_RIGHT);
		echo "\r{$s1}{$s2}";
	}
	$s1 = "There are $total Albums in DB, - $hasCover of them have a Coverimage.";
	$s1 = str_pad($s1,80,' ',STR_PAD_RIGHT);
	$s2 = "\n(with this run we have added $newOnes new Coverimages)\n";
	echo "\r{$s1}{$s2}";
}



// ask for recreate the ChacheData!
$hn = new hn_basic();
if( in_array(strtolower(trim($hn->cl_ask("\nDo you want to recreate the Chachedata now? (yes/no) ENTER"))),array('y','yes')) ) {
	$laf->emptyCache(true);
	$laf->rebuildCache(true);
}




// we are ready but want to keep the Window open
if(is_dir($GLOBALS['logroot'])) echo "\n\nAll logs of this Import are located here: \n    ".$GLOBALS['logroot'];
$hn->cl_ask("\n\n...(press enter to close the importer script)");


exit(0);













//*******[FUNCTIONS]******************************************************

// (L)ocal (A)udio (F)iles - LOG
function laflog($file,$type='failed') {
	$type = in_array(strtolower($type),array('invalid','success','failed','skipped','missingid3','summary','cover_failed','cover_success')) ? strtolower($type) : 'errors';
	if(!is_dir($GLOBALS['logroot'])) {
		if(!mkdir($GLOBALS['logroot'])) {
			echo "\nWARNING: cannot create Folder for ImporterLogfiles\n - {$GLOBALS['logroot']}\n";
			return;
		}
	}
    $path = $GLOBALS['logroot'] . strtolower($type) . '.txt';
    if('summary'==$type) {
    	$GLOBALS['hn']->string2file(date('Y/m/d H:i:s')."\n\n$file", $path, false);
    	return;
    }
    $msg = date('Y/m/d H:i:s')."   {$file}";
    $GLOBALS['hn']->string2file($msg . PHP_EOL, $path, true);
}


function dropAllChildren() {
	@require_once(wire('config')->paths->LocalAudioFiles . 'phpclasses/hn_basic.class.php');
	if(!class_exists('hn_basic')) {
		echo sprintf("cannot load phpclass: %s - ( %s aborted! )", 'hn_basic', basename(__FILE__));
		exit(13);
	}
	$hn = new hn_basic();
	$answer = strtolower(trim($hn->cl_ask('DO YOU REALLY WANT TO DROP ALL AUDIO-DB_ENTRIES? [Yes|No] and ENTER')));
	if(!in_array($answer,array('yes','y'))) {
		echo sprintf("you have answered '%s' - ( %s aborted! )", $answer, basename(__FILE__));
		echo "\n\n.. phwew, - that was a close thing! ;-)\n";
		exit(0);
	}
	echo "- please wait, - dropping childpages, ...\n\n";
	$tops = array('GENRES','ARTISTS','ALBUMS','SONGS');
	foreach($tops as $top) {
		$children = wire('pages')->get("template=$top")->children;
		foreach($children as $child) {
			$s = strlen($child->title) >= 80 ? substr($child->title, 0, intval(76/2)).'...'.substr($child->title,(intval(76/2) * -1)) : str_pad($child->title,80,' ',STR_PAD_RIGHT);
			echo "\r$s";
			$child->delete();
		}
    }
    return true;
}

