<?php
/********************************************************************************************
* @script_type -  PHP ProcessWire LocalAudioFiles Functions
* -------------------------------------------------------------------------
* @author	   -  Horst Nogajski <coding@nogajski.de>
* @copyright   -  (c) 2002 - 2013
* -------------------------------------------------------------------------
* $Source: /WEB/pw_LAF/htdocs/site/modules/LocalAudioFiles/LocalAudioFiles.pageHooks.php,v $
* $Id: LocalAudioFiles.pageHooks.php,v 1.1 2013/05/19 18:50:26 horst Exp $
*********************************************************************************************/


if(!function_exists('lafPageHookArtists')) { // run only once!

	// create the Properties (Hooks)
	$lafHookProperties = array(
							// additions useful for album & song
							'coverImage','playlistM3u','playlistPls',
							// additions only useful for song
							'streamUrl','songlengthString',
							// additions only useful for albums
							'totalPlaytime','totalPlaytimeString',
							// missing Children
							'artists','albums','songs',
							// missing Parent / RootParent
							'artist','genre'
	);
	foreach($lafHookProperties as $lafProperty) {
		wire()->addHookProperty("Page::$lafProperty", null, "lafPageHook$lafProperty");
	}
	unset($lafHookProperties,$lafProperty);




  // missing children

	// only genre
	function lafPageHookArtists($event) {
		if(in_array($event->object->template,array('genre','artist','album','song'))){
			$event->return = 'genre'==$event->object->template ? wire('pages')->find("template=artist, genre.id=".$event->object->id) : new PageArray();
		}
	}

	// only artist
	function lafPageHookAlbums($event) {
		if(in_array($event->object->template,array('genre','artist','album','song'))){
			$event->return = 'artist'==$event->object->template ? wire('pages')->find("template=album, artist.id=".$event->object->id) : new PageArray();
		}
	}

	// only album
	function lafPageHookSongs($event) {
		if(in_array($event->object->template,array('genre','artist','album','song'))){
			$event->return = 'album'==$event->object->template ? wire('pages')->find("template=song, album.id=".$event->object->id) : new PageArray();
		}
	}



  // missing parents

	function lafPageHookGenre($event) {
		if(in_array($event->object->template,array('song','album'))) {
			$event->return = 'album'==$event->object->template ? $event->object->artist->genre : $event->object->album->artist->genre;
		}
	}

	function lafPageHookArtist($event) {
		if('song'==$event->object->template) {
			$event->return = $event->object->album->artist;
		}
	}




  // nice to have

	// album and song
	function lafPageHookPlaylistM3u($event) {
		if(in_array($event->object->template,array('song','album'))) {
			$event->return = "/playlist/m3u/{$event->object->id}/";
		}
	}

	// album and song
	function lafPageHookPlaylistPls($event) {
		if(in_array($event->object->template,array('song','album'))) {
			$event->return = "/playlist/pls/{$event->object->id}/";
		}
	}

	// album and song
	function lafPageHookCoverImage($event) {
		if(in_array($event->object->template,array('song','album'))) {
			$cover = 'album'==$event->object->template ? $event->object->cover : $event->object->album->cover;
			//$event->return = (0<strlen($cover->url)) ? $cover : localAudioFilesFrontendClass::getDefaultCover();
			if(0<strlen($cover->url)) {
				$event->return = $cover;
			}else{
				$res = localAudioFilesFrontendClass::getDefaultCover();
				$event->return = $res;
			}
		}
	}


	// only album
	function lafPageHookTotalPlaytime($event) {
		if('album'==$event->object->template) {
			$event->return = localAudioFilesFrontendClass::dbGetInfoTotalPlaytime($event->object->id);
		}
	}

	// only album
	function lafPageHookTotalPlaytimeString($event) {
		if('album'==$event->object->template) {
			$event->return = localAudioFilesFrontendClass::seconds2mmss(localAudioFilesFrontendClass::dbGetInfoTotalPlaytime($event->object->id));
		}
	}


	// only song
	function lafPageHookSonglengthString($event) {
		if('song'==$event->object->template) {
			$event->return = localAudioFilesFrontendClass::seconds2mmss($event->object->songlength);
		}
	}

	// only song
	function lafPageHookStreamUrl($event) {
		$event->return = localAudioFilesFrontendClass::songStreamUrl($event->object->id);
	}

	// only song
	function lafPageHookStreamLink($event) {
		$event->return = localAudioFilesFrontendClass::songStreamLink($event->object->id);
	}

}


