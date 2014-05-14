<?php
/********************************************************************************************
* @script_type -  PHP ProcessWire Sub PageTemplate for LocalAudioFiles
* -------------------------------------------------------------------------
* @author      -  Horst Nogajski <coding@nogajski.de>
* @copyright   -  (c) 2002 - 2013
* -------------------------------------------------------------------------
* $Source: /WEB/pw_LAF/htdocs/site/templates/local-audio-files_single.php,v $
* $Id: local-audio-files_single.php,v 1.9 2013/05/19 18:50:26 horst Exp $
*********************************************************************************************/


// if you don't want load the YahooWebplayer, set this to false
$YahooPlayerAllowed = true;



// this file contain all mods to the $page variable, and we only need to process it when on a single page,
// therefor I have _not_ wrapped the code into a autoload module
require_once($config->paths->LocalAudioFiles.'/LocalAudioFiles.pageHooks.php');

// we set this to tell the included local-audio-files.php that there is allready set a page-object
$lafPage = $page;

// get the FrontEndHandler, output a Headline and a basic TopMenu
include(dirname(__FILE__).'/local-audio-files.php');


// if allowed, we want to use the YahooPlayer on album and song pages
$useYahooPlayer = true===$YahooPlayerAllowed && in_array($page->template,array('song','album')) ? true : false;


// retrieve the PageInfo as StringArray, - only for demo or debug purposes
$info = $fe->pageInfo();


	// just for the Demo we display the info array, ...
	echo '<div id="laf_single">'."\n<p style='margin-top:-4px;font-weight:bold; color:#DDD;'>PageInfo - <small>this</small> <strong style='color:#C0E7FA'><i>\$page</i></strong> <small>is of type </small><strong style='color:#C0E7FA'>".$fe->template."</strong></p>\n";
	echo "<table>\n";
	echo "  <tr>\n    <th style='text-align:left;'><i>fieldname</i></th><th style='text-align:left;'><i>fieldvalue</i></th>\n  </tr>\n";
	foreach($info as $k=>$v) {
		echo "  <tr>\n    <td>$k</td><td>".(empty($v)?'&nbsp;':$v)."</td>\n  </tr>\n";
	}
	echo "</table>\n";
	echo "</div>\n";





   // .., but normally you want do something related to the current Page-Type:


if('genre'==$page->template) {

	// children of genre are artists
	if(0 < count($page->artists)) {
		echo "<ul class='child'>\n";
		foreach($page->artists as $artist) {
			echo "<li><a class='child' href='{$artist->url}'>{$artist->title}</a></li>\n";
		}
		echo "</ul>\n";
	}

}





if('artist'==$page->template) {

	// (root)Parent of artist
    echo "<p><a class='parent' href='".$page->genre->url."'>Genre: ".$page->genre->title."</a></p>\n";

	// children of artist are albums
	if(0 < count($page->albums)) {
		echo "<ul class='child'>\n";
		foreach($page->albums as $album) {
			echo "<li><a class='child' href='{$album->url}'>{$album->title}</a></li>\n";
		}
		echo "</ul>\n";
	}

}





if('album'==$page->template) {

	// rootParent is always genre
    echo "<p><a class='parent' href='".$page->genre->url."'>Genre: ".$page->genre->title."</a>\n";

	// Parent
    echo "<a class='parent' href='".$page->artist->url."'>Artist: ".$page->artist->title."</a></p>\n";

	// children of album are songs
	if(0 < count($page->songs)) {
		foreach($page->songs as $song) {
			echo " <a class='child' href='$song->url' title='{$song->artist->title} - {$song->title}'>{$song->songnumber}</a> \n";
		}
	}

    // the coverImage
	if(strlen($page->coverImage)>0) {
		echo "<p><img src='".$page->coverImage->width(170)->url."' alt='' title='{$page->artist->title} - {$page->title}' style='align-left;vertical-align:middle;'/>\n
        		<a class='stream' href='{$page->playlistM3u}'>Playlist M3U</a> <a class='stream' href='{$page->playlistPls}'>Playlist PLS</a></p>\n";
	}

	// children of album are songs
	if(0 < count($page->songs)) {
		echo "<div class='playlist'>\n";
		foreach($page->songs as $song) {
			echo "<a href='".$song->streamUrl."' title='{$song->artist->title} - {$song->title}'>{$song->songnumber} - {$song->artist->title} - {$song->title} <small><i>(".$song->songlengthString.")</i></small></a><br />\n";
		}
		echo "<small><i>(Total Playtime: ".$page->totalPlaytimeString.")</i></small><br />\n";
		echo "</div>\n";
	}

}





if('song'==$page->template) {

	// rootParent of song
    echo "<p><a class='parent' href='".$page->genre->url."'>Genre: ".$page->genre->title."</a>\n";

	// grandParent of song
    echo "<a class='parent' href='".$page->artist->url."'>Artist: ".$page->artist->title."</a>\n";

	// parent of song
    echo "<a class='parent' href='".$page->album->url."'>Album: ".$page->album->title."</a></p>\n";

    // the coverImage
	if(strlen($page->coverImage)>0) {
		echo "<img src='".$page->coverImage->width(120)->url."' alt='' title='' />";
	}

	// we can output a default streamLink, ...
    //echo "<p>{$page->streamLink}</p>\n";

	// ..., or a custom styled link
    echo "<p><a class='stream' href='{$page->streamUrl}' title='{$page->artist->title} - {$page->title}'>{$page->songnumber} - {$page->artist->title} - {$page->title} <small><i>(".$page->songlengthString.")</i></small></a></p>\n";

    // will be only of rare use: Playlists for 1 Song, - but is useful when a player is configured to enqueue to existing Playlists instead of exchanging Playlists!
    echo "<p><a class='stream' href='{$page->playlistM3u}'>Playlist M3U</a> <a class='stream' href='{$page->playlistPls}'>Playlist PLS</a></p>\n";

}





// close HTML-Body
echo "</div>\n";
if(!empty($useYahooPlayer)) echo "<script src='http://mediaplayer.yahoo.com/js'></script>\n";
echo "</body>\n</html>\n";


