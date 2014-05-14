<?php
/********************************************************************************************
* @script_type -  PHP ProcessWire Module LocalAudioFiles
* -------------------------------------------------------------------------
* @author      -  Horst Nogajski <coding@nogajski.de>
* @copyright   -  (c) 2002 - 2013
* -------------------------------------------------------------------------
* $Source: /WEB/pw_LAF/htdocs/site/modules/LocalAudioFiles/localAudioFilesFrontend.class.php,v $
* $Id: localAudioFilesFrontend.class.php,v 1.16 2013/05/19 18:50:26 horst Exp $
*********************************************************************************************/

/**
 * ProcessWire LocalAudioFiles FrontendClass
**/
class localAudioFilesFrontendClass /*extends Wiredata*/ {

	private $page;
	private $template;
	private $singlePage;
	private $headline;
	private $browsertitle;
	private $validPropertynames = array('page','template','singlePage','headline','browsertitle','hn','cacheRoot');
	private $hn;
	private $laf;
	private $cacheRoot;
	private $menu;
	private $menuOptions;
	private $defaultCoverImage = false;
	private $defaultCover = null;


    public function __construct($lafPage) {
		if(!in_array($lafPage->template,array('GENRES','ALBUMS','ARTISTS','SONGS','genre','album','artist','song','dbinfo','local-audio-files_stream','DEMOS','demo','sitemap'))) {
			return;
		}
		$this->page         = $lafPage;
		$this->template     = $this->page->template;
		$this->singlePage   = in_array($this->template, array('genre','album','artist','song'));
		$this->headline     = $this->singlePage ? $this->page->parent->template .' :: '. $this->page->title : $this->template;
		$this->browsertitle = ($this->singlePage ? $this->page->title .' :: '. $this->page->parent->template : $this->template) .' :: LocalAudioFiles-DB';
		$this->cacheRoot    = wire('config')->paths->cache . 'LocalAudioFiles.';
		$this->laf          = wire('modules')->get('LocalAudioFiles');
		@require_once(dirname(__FILE__).'/phpclasses/hn_basic.class.php');
		if(class_exists('hn_basic')) {
			$this->hn = new hn_basic();
		}
		$this->defaultCover = $this->getDefaultCover();
		$this->defaultCoverImage = (bool)(null!=$this->defaultCover); // $album = wire('pages')->get('template=LocalAudioFilesConfig, name=lafc');
	}


	public function pageInfo($pageId=null) {
		$p = null===$pageId ? $this->page : wire('pages')->get('id='.intval($pageId));
		if(0==$p->id || ! in_array($p->template,array('genre','artist','album','song')) ) {
			return null;
		}
		$info = array();
		foreach($p->fields as $f) {
			if(in_array($f->name, array('unsynchronised_lyric','cover','checksum') )) {
				continue;
			}
			if('FieldtypePage'==$f->type) { // FieldtypePage, FieldtypeInteger, FieldtypePageTitle, FieldtypeText, FieldtypeTextarea
				$info[$f->name] = $p->{$f->name}->title;
			}
			else {
				$info[$f->name] = ('FieldtypeInteger'==$f->type ? intval($p->{$f->name}) : strval($p->{$f->name}));
			}
		}
		$a = array(	'song'=>array('artist','genre','coverImage','songlengthString','streamUrl','playlistM3u','playlistPls'),
					'album'=>array('genre','coverImage','totalPlaytime','totalPlaytimeString','playlistM3u','playlistPls','songs'),
					'artist'=>array('albums'),
					'genre'=>array('artists')
		);
		$template = $p->template->name;
        foreach(array(	'artist','genre',
						'coverImage',
						'songlengthString','streamUrl',
						'playlistM3u','playlistPls','totalPlaytime','totalPlaytimeString',
						'artists','albums','songs',
				) as $property) {
			if( ! in_array($property, $a[$template]) ) {
				continue;
			}
			$info[$property] = isset($p->$property->title) ? $p->$property->title : $p->$property;
        }

        return $info;
	}

/*	public function pageInfo($pageId=null,&$info) {
		$p = null===$pageId ? $this->page : wire('pages')->get('id='.intval($pageId));
		if(0==$p->id || ! in_array($p->template,array('genre','artist','album','song')) ) {
			return null;
		}
		$obj   = array();
		$info  = array();
		foreach($p->fields as $f) {
			if(in_array($f->name,array('unsynchronised_lyric','checksum'))) {
				continue;
			}
			if('FieldtypePage'==$f->type) { // FieldtypePage, FieldtypeInteger, FieldtypePageTitle, FieldtypeText, FieldtypeTextarea
				$info[$f->name] = $p->{$f->name}->title;
				$obj[$f->name]  = $p->{$f->name};
			}
			else {
				$obj[$f->name] = $info[$f->name] = ('FieldtypeInteger'==$f->type ? intval($p->{$f->name}) : strval($p->{$f->name}));
			}
		}

		$info['id'] = $p->id;
		$info['name'] = $p->name;
		$info['url'] = $p->url;
		$info['httpUrl'] = $p->httpUrl;

		switch($p->template) {
			case 'song':
				$obj['album']       = $obj['parent']       = $p->album;
				$obj['artist']      = $p->album->artist;
				$obj['genre']       = $obj['rootParent']   = $p->album->artist->genre;
				//$obj['children']    = $info['children']    = new NullPage();          // TODO 7 -c validate Type: NullPage() or NULL ???
				$obj['children']    = $info['children']    = null;          // TODO 7 -c validate Type: NullPage() or NULL ???
				$obj['parent_id']   = $info['parent_id']   = $p->album->id;
				$obj['cover']       = $info['cover']       = (strlen($p->album->cover)>0) ? $p->album->cover : $this->defaultCover;
				$obj['streamUrl']   = $info['streamUrl']   = $this->songStreamUrl($p->id);
				$obj['playlistM3u'] = $info['playlistM3u'] = "/playlist/m3u/{$p->id}/";
				$obj['playlistPls'] = $info['playlistPls'] = "/playlist/pls/{$p->id}/";
				$obj['songlengthString'] = $info['songlengthString'] = $this->seconds2mmss($p->songlength);
                break;
			case 'album':
				$obj['artist']      = $obj['parent']       = $p->artist;
				$obj['genre']       = $obj['rootParent']   = $p->artist->genre;
				$obj['children']    = $info['children']    = wire('pages')->find("template=song, album.id=".$p->id);
				$obj['parent_id']   = $info['parent_id']   = $p->artist->id;
				$obj['cover']       = $info['cover']       = (strlen($p->cover)>0) ? $p->cover : $this->defaultCover;
				$obj['playlistM3u'] = $info['playlistM3u'] = "/playlist/m3u/{$p->id}/";
				$obj['playlistPls'] = $info['playlistPls'] = "/playlist/pls/{$p->id}/";
				break;
			case 'artist':
				$obj['genre']       = $obj['parent']       = $obj['rootParent'] = $p->genre;
				$obj['parent_id']   = $info['parent_id']   = $p->genre->id;
				$obj['children']    = $info['children']    = wire('pages')->find("template=album, artist.id=".$p->id);
				break;
			case 'genre':
				$obj['parent']      = $obj['rootParent']   = new NullPage();
				$obj['parent_id']   = 0;
				$obj['children']    = $info['children']    = wire('pages')->find("template=artist, genre.id=".$p->id);
				break;
		}
		$obj['numChildren']         = (isset($obj['children']) ? count($obj['children']) : 0);
		$info['numChildren']        = (isset($obj['children']) ? count($obj['children']) : '0');

		foreach(array('genre','artist','album','parent','rootParent') as $k) {
			if(isset($obj[$k])) {
				$info[$k] = $obj[$k]->title;
			}
		}

		$object = new stdClass();  // we create an object depending on the page type: $genre, $artist, $album, $song
		foreach($obj as $k=>$v) {
			$object->$k = $v;
		}

        return $object;
	}
*/

	public function topMenu(&$menu,&$options) {
		$this->menu &= $menu;
		$this->menuOptions =& $options;
		// check if we have a valid cache version
		$cachefile = $this->cacheRoot .'topmenu_'. substr(strtoupper($this->template),0,5) .'.cache';
		$cache = '<p style="color:red;">ERROR CREATING TOPMENU</p>';
		if(!file_exists($cachefile) || $this->checkCacheRefresh($cachefile) || !$this->hn->GetCacheArray($cache,$cachefile)) {
			// we have to refresh it
			$cache = array($menu->render($options));
			$this->hn->SetCacheArray($cache,$cachefile);
		}
		return is_array($cache) ? $cache[0] : $cache;
	}



	public static function songStreamUrl($id,$withSongName=true) {
		$p = wire('pages')->get($id);
		if(empty($p) || 'song'!=$p->template) {
			return null;
		}
        $url = (wire("config")->https ? 'https://' : 'http://') . wire("config")->httpHost."/stream/$id/";
        return $withSongName!==true ? $url : $url . $p->name . '.mp3';
	}

	public static function songStreamLink($id,$withSongName=true) {
		$p = wire('pages')->get($id);
		if(empty($p) || 'song'!=$p->template) {
			return null;
		}
		return '<a href="'.$p->streamurl.'" target="_blank">'.(10>$p->songnumber ? '0':'').$p->songnumber.' - '.$p->title.' <small>('.$p->songlengthString.')</small></a>';
	}




	/**
	* $category = ['genres'|'artists'|'albums'] for MultipleSelect-Field or ['genre'|'artist'|'album'] for a SingleSelect-Field
	*
	* $size     = 9   (lines to display opened)
	*
	* $options = array(
	*    'NameIdPrefix'   => 'SEL_',   // (prefix for the name and the id tag, - is followed by the category: 'SEL_albums')
	*    'withChildCount' => false,    // (if it should display the count of children, with genres it displays number of artists |  )
	*    'forMonospace'   => false,    // (withChildCount is displayed before the Title by default, if you use a monospace it can be displayed align-right)
	*    'style'          => null,     // (optional inline-css, for example: 'float:left;width:50%;')
	*    'class'          => null      // (optional css class name(s))
	* );
	*/
    public function getFormSelect($category='genre', $size=9, $options=null) {
    	if(!in_array($category,array('genres','artists','albums','genre','artist','album'))) {
    		return "getFormSelect for ".htmlentities($category).' not available';
		}
        $NameIdPrefix   = isset($options['NameIdPrefix']) ? $options['NameIdPrefix'] : 'SEL_';
        $withChildCount = isset($options['withChildCount']) && true===$options['withChildCount'] ? true : false;
        $forMonospace   = isset($options['forMonospace']) && true===$options['forMonospace'] ? true : false;
        $class          = isset($options['class']) && is_string($options['class']) ? " class='{$options['class']}'" : null;
        $style          = isset($options['style']) && is_string($options['style']) ? " style='{$options['style']}'" : null;
		$func = in_array($category,array('genres','artists','albums')) ? '_getFormMultiSelect' : '_getFormSelect';
		return $this->$func($category,$size,$NameIdPrefix,$withChildCount,$forMonospace,$style,$class);
    }

	public function getFormSelectQuantity($start=10, $end=50, $step=5, $size=9, $NameIdPrefix='SEL_', $style=null) {
		if($start+$step>=$end) {
			return 'invalid params for FormSelectQuantity';
		}
    	if(!empty($style)) {
    		$style = " style='$style'";
		}
		$out = "  <select size='$size' id='{$NameIdPrefix}quantity' name='quantity'{$style}>\n";
		for($i=$start;$i<=$end;$i+=$step) {
			$out .= "    <option value='$i'>$i</option>\n";
		}
		$out .= "  </select>\n";
		return $out;
	}


    public function getFormSelectOptions($category='albums', $withChildCount=false, $forMonospace=false) {
    	if(!in_array($category,array('genres','artists','albums'))) {
    		return "FormSelectOptions for ".htmlentities($category).' not available';
		}
		$countname = ('genres'==$category ? 'artist' : ('artists'==$category ? 'album' : 'song')) . 'count';
		$func = "dbGetInfo{$category}";
		if(true===$forMonospace && true===$withChildCount) {
			$lines = array();
			foreach($this->$func() as $cat) {
				$lines[] = $cat['title'];
			}
		    $indents = array_map('strlen', $lines);
			if($indents) $m = max($indents) + 6;
			$out = '';
			foreach($this->$func() as $cat) {
				$t = $cat['title'];
				$c = strval($cat[$countname]);
				$out .= "    <option value='{$cat['id']}'>$t" . str_repeat('.', $m - strlen($t) - strlen($c)) . "$c</option>\n";
			}
			return $out;
		}
		$out = '';
		foreach($this->$func() as $cat) {
			$t = $cat['title'];
			$c = strval($cat[$countname]);
			$out .= true===$withChildCount ? "    <option value='{$cat['id']}'>".str_repeat('0', 3 - strlen($c))."$c -- $t</option>\n" : "    <option value='{$cat['id']}'>$t</option>\n";
		}
		return $out;
    }
    private function _getFormMultiSelect($category='albums', $size=9, $NameIdPrefix='SEL_', $withChildCount=false, $forMonospace=false, $class=null, $style=null) {
		$out = "  <select multiple='multiple' size='$size' id='{$NameIdPrefix}{$category}' name='{$category}[]'{$class}{$style}>\n";
		$out .= $this->getFormSelectOptions($category, $withChildCount, $forMonospace);
		$out .= "  </select>\n";
		return $out;
    }
    private function _getFormSelect($category='album', $size=9, $NameIdPrefix='SEL_', $withChildCount=false, $forMonospace=false, $class=null, $style=null) {
		$out = "  <select size='$size' id='{$NameIdPrefix}{$category}' name='{$category}'{$class}{$style}>\n";
		$out .= $this->getFormSelectOptions($category.'s', $withChildCount, $forMonospace);
		$out .= "  </select>\n";
		return $out;
    }




    public function getUL($category='genre',$ulId=null,$liClass=null) {
        if('genre'==$category) {
			$pa = $this->dbGetGenres();
        }
        elseif('artist'==$category) {
			$pa = $this->dbGetArtists();
        }
        elseif('album'==$category) {
			$pa = $this->dbGetAlbums();
        }
        else {
			return;
        }
    	$id = null===$ulId ? '' : " id='$ulId'";
    	$class = null===$liClass ? '' : " class='$liClass'";
        $out = "  <ul{$id}>\n";
        foreach($pa as $p) {
			$out .= "    <li{$class}><a href='".$p->url."'>".$p->title."</a></li>\n";
        }
        $out .= "  </ul>\n";
        return $out;
    }



	// these functions return PageArrays, sorted by title
    public function dbGetGenres() {
		$pa = wire('pages')->getById($this->dbGetInfoGenres(true));
		$pa->sort('title');
		return $pa;
    }

    public function dbGetArtists() {
		$pa = wire('pages')->getById($this->dbGetInfoArtists(true));
		$pa->sort('title');
		return $pa;
    }

    public function dbGetAlbums() {
		$pa = wire('pages')->getById($this->dbGetInfoAlbums(true));
		$pa->sort('title');
		return $pa;
    }

	public function dbGetFullTree($asUL=false) {
		$cachefile = $this->cacheRoot .'dbFullTreeArray.cache';
		$a = array();
		if( ! file_exists($cachefile) || $this->checkCacheRefresh($cachefile) || ! $this->getCacheArray($a,$cachefile)) {
			$genres = $this->dbGetGenres();
			foreach($genres as $genre) {
				$tmp = array('url'=>$genre->url,'title'=>$genre->title,'artists'=>array());
				$artists = wire('pages')->find("template=artist, genre.id=".$genre->id);
				foreach($artists as $artist) {
					$tmp['artists'][$artist->id] = array('url'=>$artist->url,'title'=>$artist->title,'albums'=>array());
					$albums = wire('pages')->find("template=album, artist.id=".$artist->id);
					foreach($albums as $album) {
                        $tmp['artists'][$artist->id]['albums'][$album->id] = array('url'=>$album->url,'title'=>$album->title,'songs'=>array());
						$songs = wire('pages')->find("template=song, album.id=".$album->id);
						foreach($songs as $song) {
							$tmp['artists'][$artist->id]['albums'][$album->id]['songs'][$song->id] = array('url'=>$song->url,'title'=>$song->title);
						}
					}
				}
				$a[] = $tmp;
			}
			$this->setCacheArray($a,$cachefile);
		}
		if(true!==$asUL) {
			return $a;
		}
		$cachefile = $this->cacheRoot .'dbFullTreeASUL.cache';
		$out = '';
		if( ! file_exists($cachefile) || $this->checkCacheRefresh($cachefile) || ! $this->getCacheArray($out,$cachefile)) {
			$out = '';
	        foreach($a as $k=>$genre) {
				// open genre
				$out .= "<ul class='treeview genre'>\n";
				$out .= "  <li class='genre' id='".str_replace('/','',$genre['url'])."'><a href='".$genre['url']."'>".$genre['title']."</a>\n";
					foreach($genre['artists'] as $k2=>$artist) {
						// open artist
						$out .= "    <ul class='treeview artist'>\n";
						$out .= "      <li class='artist' id='".str_replace('/','',$artist['url'])."'><a href='".$artist['url']."'>".$artist['title']."</a>\n";
							foreach($artist['albums'] as $k3=>$album) {
								// open album
								$out .= "      <ul class='treeview album'>\n";
								$out .= "        <li class='album' id='".str_replace('/','',$album['url'])."'><a href='".$album['url']."'>".$album['title']."</a>\n";
									$out .= "        <ul class='treeview song'>\n";
									foreach($album['songs'] as $k4=>$song) {
										// add song
										$out .= "          <li class='song'><a href='".$song['url']."'>".$song['title']."</a></li>\n";
									}
									$out .= "        </ul>\n";
								// close album
								$out .= "        </li>\n      </ul>\n";
							}
						// close artist
						$out .= "      </li>\n    </ul>\n";
					}
				// close genre
				$out .= "  </li>\n</ul>\n";
	        }
			$this->setCacheArray($out,$cachefile);
		}
		return $out;
	}

	public function dbGetFullTreeAsUlList() {
		$a = $this->dbGetFullTree();
		$cachefile = $this->cacheRoot .'dbFullTreeASULblank.cache';
		$out = '';
		if( ! file_exists($cachefile) || $this->checkCacheRefresh($cachefile) || ! $this->getCacheArray($out,$cachefile)) {
			$out = '';
	        foreach($a as $k=>$genre) {
				// open genre
				$out .= "    <ul>\n";
				$out .= "      <li><a href='".$genre['url']."'>".$genre['title']."</a>\n";
					foreach($genre['artists'] as $k2=>$artist) {
						// open artist
						$out .= "      <ul>\n";
						$out .= "        <li><a href='".$artist['url']."'>".$artist['title']."</a>\n";
							foreach($artist['albums'] as $k3=>$album) {
								// open album
								$out .= "        <ul>\n";
								$out .= "          <li><a href='".$album['url']."'>".$album['title']."</a>\n";
									$out .= "          <ul>\n";
									foreach($album['songs'] as $k4=>$song) {
										// add song
										$out .= "            <li><a href='".$song['url']."'>".$song['title']."</a></li>\n";
									}
									$out .= "          </ul>\n";
								// close album
								$out .= "          </li>\n        </ul>\n";
							}
						// close artist
						$out .= "        </li>\n      </ul>\n";
					}
				// close genre
				$out .= "      </li>\n    </ul>\n";
	        }
			$this->setCacheArray($out,$cachefile);
		}
		return $out;
	}

	public function dbGetInfoGenres($ids=false) {
		$cachefile = $this->cacheRoot .'dbinfo_GENRE.cache';
		$all = array();
		if(!file_exists($cachefile) || $this->checkCacheRefresh($cachefile) || !$this->getCacheArray($all,$cachefile)) {
			$r = wire('db')->query("SELECT data,count(data) FROM field_genre GROUP BY data ORDER BY data");
			$ID = array();
			$info = array();
			while($row = $r->fetch_row()) {
				$name = wire('pages')->get('id='.$row[0])->title;
				$info[$row[0]] = array('id'=>$row[0],'title'=>$name,'artistcount'=>$row[1]);
				$ID[] = intval($row[0]);
			}
			$info = $this->hn->hn_array_sort($info,array('title','artistcount'),false,false,false);
			$all = array('ids'=>$ID,'info'=>$info);
			$this->setCacheArray($all,$cachefile);
		}
        return true===$ids ? $all['ids'] : $all['info'];
	}

	public function dbGetInfoArtists($ids=false) {
		$cachefile = $this->cacheRoot .'dbinfo_ARTIS.cache';
		$all = array();
		if(!file_exists($cachefile) || $this->checkCacheRefresh($cachefile) || !$this->getCacheArray($all,$cachefile)) {
			$r = wire('db')->query("SELECT data,count(data) FROM field_artist WHERE sort=0 GROUP BY data ORDER BY data");
			$ID = array();
			$info = array();
			while($row = $r->fetch_row()) {
				$name = wire('pages')->get('id='.$row[0])->title;
				$info[$row[0]] = array('id'=>$row[0],'title'=>$name,'albumcount'=>$row[1]);
				$ID[] = intval($row[0]);
			}
			$info = $this->hn->hn_array_sort($info,array('title','albumcount'),false,false,false);
			$all = array('ids'=>$ID,'info'=>$info);
			$this->setCacheArray($all,$cachefile);
		}
        return true===$ids ? $all['ids'] : $all['info'];
	}

	public function dbGetInfoAlbums($ids=false) {
		$cachefile = $this->cacheRoot .'dbinfo_ALBUM.cache';
		$all = array();
		if(!file_exists($cachefile) || $this->checkCacheRefresh($cachefile) || !$this->getCacheArray($all,$cachefile)) {
			$r = wire('db')->query("SELECT data,count(data) FROM field_album WHERE sort=0 GROUP BY data ORDER BY data");
			$ID = array();
			$info = array();
			while($row = $r->fetch_row()) {
				$name = wire('pages')->get('id='.$row[0])->title;
				$totaltime = $this->dbGetInfoTotalPlaytime($row[0]);
				$info[$row[0]] = array('id'=>$row[0],'title'=>$name,'songcount'=>$row[1],'totalplaytime'=>$totaltime);
				$ID[] = intval($row[0]);
			}
			$info = $this->hn->hn_array_sort($info,array('title','songcount'),false,false,false);
			$all = array('ids'=>$ID,'info'=>$info);
			$this->setCacheArray($all,$cachefile);
		}
        return true===$ids ? $all['ids'] : $all['info'];
	}



	public function dbGetInfoBitrates() {
		$cachefile = $this->cacheRoot .'dbinfo_BITRA.cache';
		$ids = array();
		if(!file_exists($cachefile) || $this->checkCacheRefresh($cachefile) || !$this->hn->GetCacheArray($ids,$cachefile)) {
			$r = wire('db')->query("SELECT data,count(data) FROM field_bitrate GROUP BY data");
			$ids = array();
			while($row = $r->fetch_row()) {
				$key = wire('pages')->get('id='.$row[0])->title;
				$ids[$key] = $row[1];
			}
			$this->hn->SetCacheArray($ids,$cachefile);
		}
        return $ids;
	}

    public static function dbGetInfoTotalPlaytime($albumId=null) {
    	if(empty($albumId)) {
			$r = wire('db')->query("SELECT sum(data) FROM field_songlength");
			if($row = $r->fetch_row()) {
				return $row[0];
			}
	        return 0;
		}
        $album = wire('pages')->get("$albumId");
        $songs = wire('pages')->find("template=song, album=$album");
        $total = 0;
        foreach($songs as $song) {
			$total += $song->songlength;
        }
        return $total;
    }

    public function dbGetInfoTotalPlaytimeString($albumId=null) {
		return $this->hn->friendly_timer_str($this->dbGetInfoTotalPlaytime($albumId));
    }

	public static function milliseconds2mmss($milliseconds,$separatorstring=':') {
		$nMSec = $milliseconds;
		$nSec = intval($nMSec / 1000);
		$nMin = intval($nSec / 60);
		$nSec -= ($nMin * 60);

		// Test auf "geschlabberte" 1/1000 sekunden
		$L = (($nMin * 60) + $nSec);
		$L = $L * 1000;

		if($nMSec > $L)
		{
			return str_pad($nMin,2,'0',STR_PAD_LEFT) . $separatorstring . str_pad($nSec,2,'0',STR_PAD_LEFT) . '.' . (str_pad(intval(($nMSec - $L) / 10),2,'0',STR_PAD_LEFT));
		}
		elseif($nMSec < $L)
		{
			return str_pad($nMin,2,'0',STR_PAD_LEFT) . $separatorstring . str_pad($nSec-1,2,'0',STR_PAD_LEFT) . '.' . (str_pad(intval(($L-$nMSec) / 10),2,'0',STR_PAD_LEFT));
		}
		else
		{
			return str_pad($nMin,2,'0',STR_PAD_LEFT) . $separatorstring . str_pad($nSec,2,'0',STR_PAD_LEFT) . '.00';
		}
	}

	public static function seconds2mmss($seconds,$separatorstring=':') {
		$res = localAudioFilesFrontendClass::milliseconds2mmss($seconds * 1000, $separatorstring);
		$pos = strrpos($res,'.');
		return substr($res,0,$pos);
	}

    public static function getDefaultCover() {
    	$album = wire('pages')->get('template=LocalAudioFilesConfig, name=lafc');
		$album->of(true);
		if(strlen($album->cover->url)>0) {
        	return $album->cover;
		}
		$url = (wire("config")->https ? 'https://' : 'http://') . wire("config")->httpHost . "/stream/cover/nocover/albumcover_default.gif";
		$res = file_get_contents($url);
		if(false===$res || empty($res)) {
			return null;
		}
		$album->of(true);
        $album->cover = $url;
		$album->of(false);
        $album->save();
		$album->of(true);
		return $album->cover;
	}



	private function checkCacheRefresh($cachefile) {
		if($this->getConfig('cacheDisabled')) {
			return true;
		}
		$lastModified = NULL===wire('pages')->get('title=LAFC')->LAFC_lastModified ? time() : wire('pages')->get('title=LAFC')->LAFC_lastModified;
 		return $lastModified > filemtime($cachefile);
	}

	/**
	* can make protected and private class-properties accessible in ReadOnly-mode
	*
	* example:   $x = $class->propertyname;
	*
	* @param mixed $property_name
	*/
	public function __get( $propertyname ) {
		if( in_array( $propertyname, $this->validPropertynames ) )
		{
			return $this->$propertyname;
		}
		return null;
	}

	private function getCacheArray(&$Array,$filename) {
		$s = $this->hn->file2string($filename);
		if(trim($s)=='') return FALSE;
		$Array = unserialize($s);
		return ! empty($Array);
	}

	private function setCacheArray(&$Array,$filename) {
		$cache_data = serialize($Array);
		return $this->hn->string2file($cache_data,$filename);
	}

	public function getConfig($param='lastModified') {
		if(in_array($param, $this->laf->getValidConfigKeys())) {
			return $this->laf->getConfig($param);
		}
	}


}



/*
//	public function dbGetPageIDs($fieldname) {
//		$tablename = "field_{$fieldname}";
//		$db_name = wire('config')->dbName;
//		$r = wire('db')->query("SELECT COLUMN_NAME FROM INFORMATION_SCHEMA.COLUMNS WHERE table_name = '$tablename' AND table_schema = '$db_name' AND column_name LIKE 'sort'");
//		$WHERE = '';
//		if($row = $r->fetch_row()) {
//			$WHERE = $row[0]=='sort' ? ' WHERE sort=0' : '';
//		}
//		$r = wire('db')->query("SELECT pages_id,data FROM $tablename{$WHERE}");
//		$ids = array();
//		while($row = $r->fetch_row()) {
//			$ids[$row[0]] = $row[1];
//		}
//        return $ids;
//		//		$results = wire('pages')->getById(implode('|', $ids));
//		//		return $results;
//	}
*/
