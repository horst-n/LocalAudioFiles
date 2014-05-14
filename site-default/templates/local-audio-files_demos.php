<?php
/********************************************************************************************
* @script_type -  PHP ProcessWire Main PageTemplate for LocalAudioFiles
* -------------------------------------------------------------------------
* @author      -  Horst Nogajski <coding@nogajski.de>
* @copyright   -  (c) 2002 - 2013
* -------------------------------------------------------------------------
* $Source: /WEB/pw_LAF/htdocs/site/templates/local-audio-files_demos.php,v $
* $Id: local-audio-files_demos.php,v 1.5 2013/05/19 18:50:26 horst Exp $
*********************************************************************************************/


// first, check / set charset
$myCharset = 'UTF8'==strtoupper($config->dbCharset) ? 'UTF-8' : strtoupper($config->dbCharset);
ini_set('default_charset',$myCharset);
if( ! strtolower(trim(ini_get('default_charset')))==$myCharset ) {
	echo "WRONG CHARACTERSET IN PHP!\n\texpected: $myCharset \n\tactually: '". strval(ini_get('default_charset'))."'\n";
	exit(1);
}


// get a FrontEndHandle,
$fe = $modules->get("LocalAudioFiles")->localAudioFilesFrontend($page);


// print a HTML-HEAD and Body-Start
$cssCorrection = "\n\tdiv#topMenu {width:17%; min-width:100px;}\n\tdiv#mainContent {width:70%;}";
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
	div#mainContent {float:left; width:50%; padding:10px 10px 10px 10px; margin:10px 10px 10px 10px; background-color:#AAA;font-size:1em;}
	div#mainContent table {width:100%; font-size:0.9em;}
	div#mainContent table th, div#mainContent table td {border-bottom:1px solid #777;}
	div#mainContent table th {color:#777;}
	div#mainContent a {padding:2px 7px 2px 7px; background-color:#AAA; color:#EEE;}
	div#mainContent a:hover {color:#F93;}
	div.playlist {display:block; background-color:#BBB; padding:10px 10px 10px 10px}
	div.playlist a {background-color:#BBB !important; color:#EEE !important;}
	a.stream {background-color:#F4DC61 !important; color:#333 !important;}
	a.child  {background-color:#EC2295 !important; color:#EEE !important;}
	a.parent {background-color:#BBB !important; color:#777 !important;}
	div#mainContent h3 {margin-left:20px; color:#DDD;}
	div#examplesummary {background-color:#DADADA; border: 0 none !important; border-radius: 14px 14px 14px 14px; box-shadow: 1px 3px 11px #AAAAAA; font-size: 0.9em; padding:20px 20px 20px 30px; }
	div#examplecode {background-color:#DADADA; border: 0 none !important; border-radius: 14px 14px 14px 14px; box-shadow: 1px 3px 11px #AAAAAA; font-size: 0.9em; padding:20px 20px 20px 30px; }
	p.dbinfo {font-size:0.9em;}$cssCorrection
</style>
</head>
<body>
<h1 id='headline'>{$fe->headline}</h1>
";


$demos = $pages->get('template=DEMOS');
if($demos->numChildren) {
	echo "<div id='topMenu'>\n<ul class='nav'>\n";
	foreach($demos->children as $child) {
		echo "\t<li><a href='{$child->url}'>{$child->title}</a></li>\n";
	}
	echo "\t<li><a href='/'>home</a></li>\n";
	echo "\t<li><a href='/dbinfo/'>dbinfo</a></li>\n";
	echo "\t<li><a href='/sitemap/'>sitemap</a></li>\n";
	echo "</ul>\n</div>\n";
}



if('demo'==$page->template) {

	echo "<div id='mainContent'>\n";

	echo "<h3>{$page->title}</h3>\n";

	echo "<div id='examplesummary'>\n";
	echo $page->LAF_demo_summary;
	echo "\n</div>\n";

	if(strlen($page->LAF_demo_code)>0) {
		echo "<div id='examplecode'>\n";
		highlight_string(trim($page->LAF_demo_code));
		echo "\n</div>\n";

		echo "<hr style='margin:20px 0 20px 0;'>\n";

		eval($page->LAF_demo_code);

		echo "</div>\n";
	}
}

echo "</body>\n</html>\n";

