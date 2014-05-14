<?php
/********************************************************************************************
* @script_type -  PHP ProcessWire PageTemplate for LocalAudioFiles
* -------------------------------------------------------------------------
* @author      -  Horst Nogajski <coding@nogajski.de>
* @copyright   -  (c) 2002 - 2013
* -------------------------------------------------------------------------
* $Source: /WEB/pw_LAF/htdocs/site/templates/local-audio-files_stream.php,v $
* $Id: local-audio-files_stream.php,v 1.8 2013/05/18 00:24:34 horst Exp $
*********************************************************************************************/


$DO_PLAYLIST_DEBUG = false;  // when testing new selector queries, you can print the m3u to screen, and some other infos too.



// Heya! I hijack the stream script for importing album-covers! (I don't want to setup another template and / or page for that)
// So, I put all stuff for this into a function at the end of this scriptfile,
// and the only line what won't have to do with music streaming is the following one:
if('cover'==$input->urlSegment1 && ('nocover'==$input->urlSegment2 || is_numeric($input->urlSegment2))) sendCoverImage($input->urlSegment2);



// Single file streaming / download

if('m3u'!=$input->urlSegment1 && 'pls'!=$input->urlSegment1) {
	$id = intval($input->urlSegment1);
	$p  = $pages->get("id=$id");
	if(empty($p->id) || 'song'!=$p->template) {
		exit(0);
	}
	$file = $p->filename;
	$mime_type = 'audio/mpeg';
	if(is_file($file)) {
		header("Content-type: $mime_type");
		if (isset($_SERVER['HTTP_RANGE']))  { // do it for any device that supports byte-ranges not only iPhone
			rangeDownload($file);
			exit(0);
		}
		else {
			header("Content-Length: ".filesize($file));
			readfile($file);
			exit(0);
		}
	}
	else {
		// some error...
		exit(0);
	}
}





// M3U-Playlist-Generation

// first check if we have a post-request
$type = null;
$MAKE_PLS_INSTEADOF_M3U = 'pls'==$input->urlSegment1 ? true : false;
if($input->post->genre || $input->post->genres || $input->post->artist || $input->post->artists) {
	$type = 'random';
	$id = 'post';
}
elseif($input->post->albums) {
	$type = 'albums';
	$id = 'post';
}
elseif($input->post->album) {
	$type = 'album';
	$id = 'post';
}
elseif($input->urlSegment2 && is_numeric($input->urlSegment2)) {
	$type = 'album';
	$id = intval($input->urlSegment2);
}
if(empty($id) || empty($type) || ! in_array($type,array('random','albums','album'))) {
	exit(0);
}


// get a FrontEndHandle,
$fe = wire('modules')->get("LocalAudioFiles")->localAudioFilesFrontend($page);
if(isset($DO_PLAYLIST_DEBUG) && true===$DO_PLAYLIST_DEBUG) {
	echo "<p>// ".strtoupper($input->urlSegment1)."-Playlist-Generation</p><p>$type</p>";
	echo "<pre>\n";
	var_dump($_POST);
}


if('post'!==$id) { // we have a get-request for a song or album

	$p = $pages->get("id=$id");
	if(0==$p->id) {
		exit(0);
	}
	if('song'==$p->template) {
		$tracks[] = array(
			'time'   =>  $p->songlength,
			'title'  =>  $p->title,
			'url'    =>  localAudioFilesFrontendClass::songStreamUrl($p->id)
		);
	}
	elseif('album'==$p->template) {
		$children = $pages->find("template=song, album.id=".$p->id);
		$tracks = array();
		foreach($children as $child) {
			$tracks[] = array(
				'time'   =>  $child->songlength,
				'title'  =>  $child->title,
				'url'    =>  localAudioFilesFrontendClass::songStreamUrl($child->id)
			);
		}
	}
}
else {  // we have a post request, it could be a call for a random playlist, a album playlist or multiple albums playlist

	if('album'===$type) {
		$id = $input->post->album;
		$album = $pages->get("id=$id");
		if(empty($album->id) || 'album'!=$album->template) {
			exit(0);
		}
		$children = $pages->find("template=song, album.id=$id");
	}
	elseif('albums'===$type) {
		$tmp = $input->post->albums;
		$ids = array();
		foreach($tmp as $id) {
			$album = $pages->get("id=$id");
			if(empty($album->id) || 'album'!=$album->template) {
				continue;
			}
			$ids[] = $id;
		}
		shuffle($ids); // we don't want them always in an alphabetical order
		$children = $pages->find("template=song, album.id=".implode('|',$ids));
	}
	elseif('random'===$type) {
		$ids = array();
		if(!empty($input->post->genre)) {
			// find all artists for genre
			$id = intval($input->post->genre);
			$genre = $pages->get("id=$id");
			if(0!=$genre->id && 'genre'==$genre->template) {
				$tmp[] = $id;
				// now find all artists related to the genre(s)
				$artists = $pages->find("template=artist, genre.id=".implode('|',$tmp));
				foreach($artists as $p) {
					$ids[] = $p->id;
				}
			}
		}
		if(!empty($input->post->genres)) {
			// find all artists for genre
			$tmps = $input->post->genres;
			$tmp = array();
			foreach($tmps as $id) { // we don't want use pages->find, but want loop step by step to validate page type
				$genre = $pages->get("id=$id");
				if(0==$genre->id || 'genre'!=$genre->template) {
					continue;
				}
				$tmp[] = $id;
			}
			// now find all artists related to the genre(s)
			$artists = $pages->find("template=artist, genre.id=".implode('|',$tmp));
			foreach($artists as $p) {
				$ids[] = $p->id;
			}
		}
		if(!empty($input->post->artist)) {
			$id = intval($input->post->artist);
			$p = $pages->get("id=$id");
			if(0!=$p->id && 'artist'==$p->template) {
				$ids[] = $p->id;
			}
		}
		if(!empty($input->post->artists)) {
			$tmps = $input->post->artists;
			foreach($tmps as $id) {
				$p = $pages->get("id=$id");
				if(0==$p->id || 'artist'!=$p->template) {
					continue;
				}
				$ids[] = $p->id;
			}
		}
		$quantity = !empty($input->post->quantity) && is_numeric($input->post->quantity) && 0<intval($input->post->quantity) && 200>=intval($input->post->quantity) ? intval($input->post->quantity) : 25;
		$ids = array_unique($ids,SORT_NUMERIC);
		shuffle($ids);
		$children = $pages->find("template=song, album.artist.id=".implode('|',$ids).", sort=random, limit=$quantity");
	}
	else {
		exit(1);
	}

	// generate the tracks array
	$tracks = array();
	foreach($children as $p) {
		$tracks[] = array(
			'time'   =>  $p->songlength,
			'title'  =>  /*$p->songnumber .' - '. */$p->album->artist->title .' - '. $p->title,
			'url'    =>  localAudioFilesFrontendClass::songStreamUrl($p->id)
		);
	}
}

if(isset($MAKE_PLS_INSTEADOF_M3U) && true===$MAKE_PLS_INSTEADOF_M3U) {
	$i=1;
	$playlist = "[playlist]\n";
	foreach($tracks as $track) {
		$playlist .= "File{$i}={$track['url']}\n";
		$playlist .= "Title{$i}={$track['title']}\n";
		$playlist .= "Length{$i}={$track['time']}\n";
		$i++;
	}
	$playlist .= "NumberOfEntries=".($i-1)."\n";
	$playlist .= "Version=2\n";
	$mimeType = 'audio/x-scpls';
	$mimeExtension = '.pls';
}
else {
	$playlist = "#EXTM3U\n";
	foreach($tracks as $track) {
		$playlist .= "#EXTINF:{$track['time']},{$track['title']}\n";
		$playlist .= "{$track['url']}\n";
	}
	$mimeType = 'audio/x-mpegurl';
	$mimeExtension = '.m3u';
}


if(isset($DO_PLAYLIST_DEBUG) && true===$DO_PLAYLIST_DEBUG) {
	var_dump($playlist);
	echo "</pre>\n";
	exit(0);
}


header('Content-type: '.$mimeType);
header('Content-Disposition: attachment; filename="playlist_'.strval(time()).$mimeExtension.'"');
header('Content-Length: '.strlen($playlist));
echo $playlist;
exit(0);





/////////// FUNCTIONS ////////////////////////////////////////////////////////


/*******************************************************************************
Thomas Thomassen has done a great job on his PHP Resumable Download Server,
providing working PHP code which supports byte-range downloads.

The following sample code is the complete version for the one from the
first part of the article, but including byte-range support by using the
rangeDownload() function when the $_SERVER['HTTP_RANGE'] header is present
on the device’s HTTP request.
The rangeDownload() function is an exact copy&paste from Thomas Thomassen’s code
(only the relevant part).
*/
function rangeDownload($file) {

	$fp = @fopen($file, 'rb');

	$size   = filesize($file); // File size
	$length = $size;           // Content length
	$start  = 0;               // Start byte
	$end    = $size - 1;       // End byte
	// Now that we've gotten so far without errors we send the accept range header
	/* At the moment we only support single ranges.
	 * Multiple ranges requires some more work to ensure it works correctly
	 * and comply with the spesifications: http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.2
	 *
	 * Multirange support annouces itself with:
	 * header('Accept-Ranges: bytes');
	 *
	 * Multirange content must be sent with multipart/byteranges mediatype,
	 * (mediatype = mimetype)
	 * as well as a boundry header to indicate the various chunks of data.
	 */
	header("Accept-Ranges: 0-$length");
	// header('Accept-Ranges: bytes');
	// multipart/byteranges
	// http://www.w3.org/Protocols/rfc2616/rfc2616-sec19.html#sec19.2
	if (isset($_SERVER['HTTP_RANGE'])) {

		$c_start = $start;
		$c_end   = $end;
		// Extract the range string
		list(, $range) = explode('=', $_SERVER['HTTP_RANGE'], 2);
		// Make sure the client hasn't sent us a multibyte range
		if (strpos($range, ',') !== false) {

			// (?) Shoud this be issued here, or should the first
			// range be used? Or should the header be ignored and
			// we output the whole content?
			header('HTTP/1.1 416 Requested Range Not Satisfiable');
			header("Content-Range: bytes $start-$end/$size");
			// (?) Echo some info to the client?
			exit;
		}
		// If the range starts with an '-' we start from the beginning
		// If not, we forward the file pointer
		// And make sure to get the end byte if spesified
		if ($range0 == '-') {

			// The n-number of the last bytes is requested
			$c_start = $size - substr($range, 1);
		}
		else {
			$range  = explode('-', $range);
			$c_start = $range[0];
			$c_end   = (isset($range[1]) && is_numeric($range[1])) ? $range[1] : $size;
		}
		/* Check the range and make sure it's treated according to the specs.
		 * http://www.w3.org/Protocols/rfc2616/rfc2616-sec14.html
		 */
		// End bytes can not be larger than $end.
		$c_end = ($c_end > $end) ? $end : $c_end;
		// Validate the requested range and return an error if it's not correct.
		if ($c_start > $c_end || $c_start > $size - 1 || $c_end >= $size) {

			header('HTTP/1.1 416 Requested Range Not Satisfiable');
			header("Content-Range: bytes $start-$end/$size");
			// (?) Echo some info to the client?
			exit;
		}
		$start  = $c_start;
		$end    = $c_end;
		$length = $end - $start + 1; // Calculate new content length
		fseek($fp, $start);
		header('HTTP/1.1 206 Partial Content');
	}
	// Notify the client the byte range we'll be outputting
	header("Content-Range: bytes $start-$end/$size");
	header("Content-Length: $length");

	// Start buffered download
	$buffer = 1024 * 8;
	while(!feof($fp) && ($p = ftell($fp)) <= $end) {

		if ($p + $buffer > $end) {
			// In case we're only outputtin a chunk, make sure we don't
			// read past the length
			$buffer = $end - $p + 1;
		}
		set_time_limit(0); // Reset time limit for big files
		echo fread($fp, $buffer);
		flush(); // Free up memory. Otherwise large files will trigger PHP's memory limit.
	}

	fclose($fp);

}



// I don't want to deal with a lot of writing data to temporary files, importing them into PW and then clean up the temporaries etc.
// As of PW provides importing from URL - I use this!
function sendCoverImage($id) {
	if('nocover'==$id) {
		nocover();
	}
	$mp3Filename = wire('pages')->get("id=$id")->filename;
    if(empty($mp3Filename)) {
		exit(0);
    }
	$incroot = wire('config')->paths->LocalAudioFiles . 'phpclasses/';
	require_once($incroot . 'hn_mp3.class.php');
	$mp3 = new hn_mp3();
	$res = $mp3->read_infos($mp3Filename,false,true);
	$mp3->close();
	$coverData = isset($res['cover']) ? $res['cover'] : null;
	if(empty($coverData) || false===($im = imagecreatefromstring($coverData))) {
		exit(0);
	}
	header('Content-Type: image/jpeg');
	header('Last-Modified: '.gmdate('D, d M Y H:i:s').' GMT');
	header('Expires: 0');
	header('Cache-Control: private',false);
	header("Cache-Control: must-revalidate, post-check=0, pre-check=0");
	header('Content-Transfer-Encoding: binary');
	header('Connection: close');
	imagejpeg($im,null,92);
	imagedestroy($im);
	exit(0);
}



function nocover() {
$img = "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
EHl6qkzRqrmJELAaq6LzGQdhq7d6OZ+xHbvKqzoxq0EErMEaOIShCMxprGAxrKCQrBSqQM1aGavK
qo7xrMtKoshKrZ0qrZ5wrdiaota6rZjarZvwreD6onqRrMwJrfLDJzKRrNLWruHzrvOwroCHrk0K
F/fqZflqN6fBr8Lhr2IBsPGaGwNLNeK6DfP6lgr7JAxLOeVqrgaLGhArTRKrCQFbARZ7NhibsRS7
dAiLqgXbExwbULihsVORrx5bGni3rCzbsu13ACZ7jygLsuB3qzArCzdbetyqs5WQsog2qT8LtDyL
e4lKtJQQtDX/UadJq7RG+wI0y4AOi301IbUMFxyVB7WNeaRO+7SwQpB0VK8nsbWo6aJe+7UyCwJh
i0RjS7bycrVbmbWcV7btZJ9oW7TyAnhxa5h4m7ZVKxHX6bd/+30qGEiDS7j+8mJ8m0+Iaxt6W7Fn
5LYbsbSL60STS7l1m0eM+1OOm7dqO04q5LmfC7iKGK1zOy2QC36cu1iom7qgGwVsS1KjG7OlW1es
6z60W7uF6weyS1i6u7uKe5cR67qooLkPhLteWbzGq7o74LvOtrzMC7uJlbx7ArzOerzwU72cc73Y
27wSsb2l0r2hULk1FL4jOb6kUL4bdL4CGb0y970Asb2Yu7zr/9suz0tR9Bu99rstFqu/7zt6hDCl
zfm/AKy18YtVLlnABnwA/Isl+Ms8C8zAdIvA2QTBXpm+xeDAEnJZqjUWE1wNFVxGpmUcJgHCNbDB
SDNcR4lIJywEKezCMYwg2SvDNZwEMGzDOewkIqzDMozDPQzEOfDDQUzE2kDDRYzEITy9SczEYXfE
TQzFB/fEUUzFK8fDVYy6Q4zFW+zEV8zFNuvFX0y1vCvGZZx0S2zGUazFaczGB4zGbZzEawzHZizH
cyzGdWzHXIzHeYzFe8zHVOzHfwzFgSzITEzIhYzEh4zIRTzFi6zHb+zINgzJkVzDtkvJdCy8l1zI
mazJgkwwnQS8yAUAADs=";

	$buf = base64_decode(str_replace(array("\r\n","\n"), '', $img));
	header('Content-Type: image/gif');
	header('Content-Length: '.strlen($buf));
	header('Content-Transfer-Encoding: binary');
	header('Last-Modified: Sat, 24 Jul 2010 02:00:00 GMT');
	header('Expires: Sat, 25 Jul 2020 02:00:00 GMT');
	header('Cache-Control: public');
	//header('Connection: close'); // ?
	echo $buf;
	exit(0);
}

