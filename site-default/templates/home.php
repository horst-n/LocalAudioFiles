<?php
/**
* Home template
*/


// print a HTML-HEAD and Body-Start
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
	div#mainContent {width:90%; padding:20px 20px 20px 20px; margin:0 auto 0 auto; background-color:#DDD; font-size:1em;}
	div#mainContent a {padding:2px 7px 2px 7px; color:#2295EC;}
	div#mainContent h3 {margin-left:20px; color:#777;}
	div#mainContent pre {margin-left:20px;}
</style>
</head>
<body>
";



$mindmapUrl = $pages->get('name=general-overview')->images->first()->url;



$adminUrl = $config->urls->admin . 'setup/localaudiofiles/';


?>
<h1 id='headline'>Hi, welcome to the LocalAudioFiles DB!</h1>

<div id='mainContent'>
<div style='width:100%;'><a href='<?php echo $mindmapUrl;?>' target='_blank'><img src='<?php echo $mindmapUrl;?>' alt='' style='width:100%;' /></a></div>




<h3><span style='padding:10px;background-color:orange;color:white;'>Quickstart-Guide</span></h3>
<pre style="font-weight:800;font-size:1.2em;">

1) the Modules <span style='background-color:orange;'>'LocalAudioFiles'</span> and <span style='background-color:orange;'>'MarkupSimpleNavigation'</span> must be installed

2) go to <span style='background-color:orange;'><a href='<?php echo $adminUrl;?>'>ADMIN->SETUP->LocalAudioFiles</a></span> and set the config (one or more pathes to directory with mp3 files)

3) go to the <span style='background-color:orange;'>ShellImporterScript</span>, open it and set the config:

     <span style='background-color:orange;'>$PATH2PWindex</span> = './index.php';
     <span style='background-color:orange;'>$PWuser</span> = 'myusername';
     <span style='background-color:orange;'>$PWpass</span> = 'my0secret0pass';

   after that you can run it!

   ( first you have to <span style='background-color:orange;'>make it executable</span>, or when on Windows you may use the
     mp3_import_starter4win.cmd to start it. Open the mp3_import_starter4win.cmd
     with a Editor and set the 2 path-variables, save it and run )

4) Now you (hopefully) should have some Audiofiles listed in your PageTree!  :)

<i>Horst</i>
</pre>

<hr />

<h3><span style='padding:10px;background-color:orange;color:white;'> Usage </span></h3>
<pre style="font-weight:800;font-size:1.2em;">

1) if you have imported some audio files, you can get a short overview of what your DB contains here: <a href='/dbinfo/'>DB-INFOS</a>

2) or you may use one of these BranchesRootLinks: <a href='/genre/'>GENRES</a>, <a href='/artist/'>ARTISTS</a>, <a href='/album/'>ALBUMS</a>, <a href='/song/'>SONGS</a>

3) the two mainTemplates are in files: local-audio-files.php &amp; local-audio-files_single.php!

4) some interesting <a href='/demos/general-overview/'>DEMOS</a> are available too.
   They show how to use the FrontEndHandler and also there are some docu. (So, not much, but more than nothing)

5) want to add more directories to scan, or want to bypass the Cache for a short testing/debugging period?
   Go here: <a href='<?php echo $adminUrl;?>'>Setup (Admin)</a>!

</pre>

<hr />

<p><br/><br/><br/><br/><br/>About Sounds in HTML-Pages:
<br /><ul><li><a target='_blank' href='http://www.w3schools.com/html/html_sounds.asp'>www.w3schools.com</a></li></ul>
<br />and some Players:
<br /><ul><li><a target='_blank' href='http://webplayer.yahoo.com/'>yahoo webplayer</a></li>
<br /><li><a target='_blank' href='http://kolber.github.io/audiojs/'>audio.js/</a></li>
<br /><li><a target='_blank' href='http://www.schillmania.com/projects/soundmanager2/'>SoundManager 2</a>&nbsp;<a target='_blank' href='http://wheelsofsteel.net/'>Awesome&nbsp;Demo</a>&nbsp;<a target='_blank' href='http://www.schillmania.com/projects/soundmanager2/demo/cassette-tape/'>Another&nbsp;Awesome&nbsp;Demo</a></li>
<br /><li><a target='_blank' href='http://mediaelementjs.com/'>MediaElement.js</a></li>
</ul>
</p>
<hr />
<h4>The Yahoo Webplayer can be embedded with a single line of code. It's perfect for lazy coders. On the other hand, what data do they send?</h4>
<p>I have captured some packets when starting a page with it embedded and starting a song. Seems that there are 'only' some small parts of each file will be send to an analytics-server.</p>
<hr />
<pre>
GET /fpc.pl?v=5.1.0.14.js&a=1000255860556&dpid=2316371183&fpc=ZVOD7UcK%7CLvTWyj0Maa%7Cfses1000255860556%3D%7CLvTWyj0Maa%7CZVOD7UcK%7Cfvis1000255860556%3D%7C8M0HoM1HoH%7C8M0HoM1HoH%7C8M0HoM1HoH%7C8%7C8M0HoM1HoH%7C8M0HoM1HoH&ittidx=1&f=http%3A%2F%2Fpw5.kawobi.local%2Fsong%2Fa-hard-days-night%2F&b=A%20Hard%20Days%20Night%20%3A%3A%20SONGS%20%3A%3A%20LocalAudioFiles-DB&enc=UTF-8&e=http%3A%2F%2Fpw5.kawobi.local%2Fsong%2F&x=2&cf21=PAGE_MEDIA_CLICK&cf22=flashengine&cf23=false&cf17=http%3A%2F%2Fpw5.kawobi.local%2Fstream%2F51708%2Fsong.mp3&cf18=http%3A%2F%2Fpw5.kawobi.local%2Fstream%2F51708%2Fsong.mp3&cf19=play%3A%20A%20Hard%20Days%20Night&cf20=AUDIO&ca=true HTTP/1.1
Host: o.analytics.yahoo.com
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:20.1) Gecko/20100101 Firefox/20.1
Accept: */*
Accept-Language: de-de,de;q=0.8,en-us;q=0.5,en;q=0.3
Accept-Encoding: gzip, deflate
DNT: 1
Connection: keep-alive
Referer: http://pw5.kawobi.local/song/a-hard-days-night/
Cookie: B=1te8io58of118&b=3&s=a9; itsc=LvTWyj0Maa|ZVOD7UcK|fvis1000255860556=|H|H|H|T|8M0HoM1H7T|H

HTTP/1.1 200 OK
Date: Mon, 06 May 2013 10:23:15 GMT
P3P: policyref="http://info.yahoo.com/w3c/p3p.xml", CP="CAO DSP COR CUR ADM DEV TAI PSA PSD IVAi IVDi CONi TELo OTPi OUR DELi SAMi OTRi UNRi PUBi IND PHY ONL UNI PUR FIN COM NAV INT DEM CNT STA POL HEA PRE LOC GOV"
Set-Cookie: itsc=LvTWyj0Maa|ZVOD7UcK|fvis1000255860556=|H|H|H|1|8M0HoM1H71|H; path=/; domain=.analytics.yahoo.com
TS: 0 192 onodc1-ac4
Pragma: no-cache
Expires: Mon, 06 May 2013 10:23:16 GMT
Cache-Control: no-cache, private, must-revalidate
Content-Length: 48
Accept-Ranges: bytes
Tracking-Status: fpc site tracked
Vary: Accept-Encoding
Connection: close
Content-Type: application/x-javascript

// First Party Cookies
// TS: 0 192 onodc1-ac4
</pre>
<hr />

</div>
</body>
</html>

<?php

