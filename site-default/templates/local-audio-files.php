<?php
/********************************************************************************************
* @script_type -  PHP ProcessWire Main PageTemplate for LocalAudioFiles
* -------------------------------------------------------------------------
* @author      -  Horst Nogajski <coding@nogajski.de>
* @copyright   -  (c) 2002 - 2013
* -------------------------------------------------------------------------
* $Source: /WEB/pw_LAF/htdocs/site/templates/local-audio-files.php,v $
* $Id: local-audio-files.php,v 1.11 2013/05/19 18:50:26 horst Exp $
*********************************************************************************************/


// first, check / set charset
$myCharset = 'UTF8'==strtoupper($config->dbCharset) ? 'UTF-8' : strtoupper($config->dbCharset);
ini_set('default_charset',$myCharset);
if( ! strtolower(trim(ini_get('default_charset')))==$myCharset ) {
	echo "WRONG CHARACTERSET IN PHP!\n\texpected: $myCharset \n\tactually: '". strval(ini_get('default_charset'))."'\n";
	exit(1);
}


// get a FrontEndHandle,
// - if this page was loaded directly, we pass this page-object to the FrontEndHandler, otherwise we pass the childpage-object to it
$lafPage = !empty($lafPage) ? $lafPage : $page;
$fe = $modules->get("LocalAudioFiles")->localAudioFilesFrontend( $lafPage );


// print a HTML-HEAD and Body-Start
$cssCorrection = 'dbinfo'!=$fe->template ? '' : "\n\tdiv#topMenu {width:17%; min-width:100px;}\n\tdiv#mainContent {width:70%;}";
echo "<!doctype html>
<html>
<head>
<meta http-equiv=\"content-type\" content=\"text/html; charset=$myCharset\">
<title>{$fe->browsertitle}</title>
<style type=\"text/css\">
	html, body {padding:0 0 0 0; margin:0 0 0 0; width:100%; height:100%;}
	body {height:101%; position:relative; text-align:left; background:#BBB;}
	body,h1,h2,h3,h4,h5,h6,p,ul,ol,li,td,th,a {font-family: Verdana,Helvetica,Arial,sans-serif;}
	a, a:link, a:visited, a:hover, a:active {text-decoration:none; background:transparent;}
	a:link {color:#00A0E1;}
	a:visited {color:#00A0E1;}
	a:hover {color:#E40128; text-decoration:underline;}
	a:active {color:#E40128;}
	h1#headline {margin-left:40px; color:#EEE;}
	div#topMenu {float:left; width:37%; min-width:200px; padding:10px 10px 10px 10px; margin:10px 10px 10px 10px; background-color:#D0D0D0; overflow:hidden;}
	div#topMenu ul, div#topMenu ul li  {margin-left:-10px;}
	div#topMenu ul, div#topMenu ul li , div#topMenu ul li a {font-size:0.94em;}
	div#mainContent {float:left; width:50%; padding:10px 10px 10px 10px; margin:10px 10px 10px 10px; background-color:#AAA; font-size:0.9em;}
	div#mainContent table {width:100%; font-size:0.9em;}
	div#mainContent table th, div#mainContent table td {border-bottom:1px solid #777;}
	div#mainContent table th {color:#777;}
	div#mainContent a {padding:2px 7px 2px 7px; background-color:#AAA; color:#EEE;}
	div#mainContent a:hover {color:#F93;}
	div.playlist {display:block; background-color:#BBB; padding:10px 10px 10px 10px}
	div.playlist a {background-color:#BBB !important; color:#EEE !important;}
	a.stream {background-color:#F4DC61 !important; color:#333 !important;}
	a.child  {background-color:#EC2295 !important; color:#EEE !important;}
	ul.child {margin:0; padding:0; width:100%;}
	ul.child li, ul.child li a {display:block;}
	ul.child li {margin:5px;}
	a.parent {background-color:#BBB !important; color:#777 !important;}
	p.dbinfo {font-size:0.9em;}$cssCorrection
</style>
</head>
<body>
<h1 id='headline'>{$fe->headline}</h1>
<div id='topMenu'>
";



// create a basic menu with Somas cool MarkupSimpleNavigation-Module
$menu = $modules->get("MarkupSimpleNavigation");
$options = array(
    'levels' => true,
    'max_levels' => 2,
    'collapsed' => true,
    'show_root' => true,
    'selector' => 'template=GENRES|ALBUMS|ARTISTS|dbinfo|genre|album|artist|DEMOS|demo|sitemap' //|SONGS|song
);
echo $fe->topMenu($menu,$options);

echo "</div>\n<div id='mainContent'>\n";


if('dbinfo'==$fe->template) {

	// if the DB-Info-Page is called, we show some Info

	$GENRES              = $fe->dbGetInfoGenres();
	$ARTISTS             = $fe->dbGetInfoArtists();
	$ALBUMS              = $fe->dbGetInfoAlbums();
	$bitrates            = $fe->dbGetInfoBitrates();
	$totalPlaytime       = $fe->dbGetInfoTotalPlaytime();
	$totalPlaytimeString = $fe->dbGetInfoTotalPlaytimeString();
	$totalSongs          = $pages->get('template=SONGS')->numChildren;

	echo "<p class='dbinfo'>There are $totalSongs Songs in the DB, belonging to ".count($ALBUMS)." Albums which belongs to ".count($ARTISTS)." different Artists.</br>";
	echo "and there are ".count($GENRES)." different Genres noted.</p>";
	echo "<p class='dbinfo'>The total Playingtime of all Songs is around $totalPlaytimeString, ($totalPlaytime seconds).</p>";

	// check permission and display more infos for admins
    if(wire('user')->hasRole('localaudiofiles_admin|superuser')) {
 		foreach(array('GENRES','ARTISTS','ALBUMS','bitrates','totalPlaytime') as $var) {
		    $fe->hn->my_var_dump(array($var=>$$var),1);
		}
	}

}
else {

	// or we do something other here, ...


		// every time?, ...

	if( ! $fe->singlePage) { // ..., or only if we are not on a singlePage?

		if('SONGS'==$page->template) {
			echo "<p>there are ".$page->numChildren." Songs stored in the DB with a total playtime of around ".$fe->dbGetInfoTotalPlaytimeString()."!</p>";
		}

		$pagetype = strtolower(substr($page->template,0,strlen($page->template)-1)); //get the (branch root) page type and strip the trailing s
		echo 'song'==$pagetype ? '' : $fe->getUL( $pagetype ); // 'genre' | 'artist' | 'album'

	}

}


// close HTML-Body if we are not on a singlePage
if(!$fe->singlePage) {
	echo "<p><br/><br/><br/><i>Want to see some (more) demo usage?</i> <a href='/demos/'><i>look here</i></a></p>\n";
	echo "</div>\n</body>\n</html>\n";
}




