
DROP TABLE IF EXISTS `field_album`;
CREATE TABLE `field_album` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pages_id`,`sort`),
  KEY `data` (`data`,`pages_id`,`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_artist`;
CREATE TABLE `field_artist` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pages_id`,`sort`),
  KEY `data` (`data`,`pages_id`,`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_bitrate`;
CREATE TABLE `field_bitrate` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pages_id`,`sort`),
  KEY `data` (`data`,`pages_id`,`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_bitratemode`;
CREATE TABLE `field_bitratemode` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pages_id`,`sort`),
  KEY `data` (`data`,`pages_id`,`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_bpm`;
CREATE TABLE `field_bpm` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_checksum`;
CREATE TABLE `field_checksum` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_comment`;
CREATE TABLE `field_comment` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` mediumtext NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_cover`;
CREATE TABLE `field_cover` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` varchar(255) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  `description` text NOT NULL,
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`pages_id`,`sort`),
  KEY `data` (`data`),
  KEY `modified` (`modified`),
  KEY `created` (`created`),
  FULLTEXT KEY `description` (`description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_filename`;
CREATE TABLE `field_filename` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_genre`;
CREATE TABLE `field_genre` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pages_id`,`sort`),
  KEY `data` (`data`,`pages_id`,`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_images`;
CREATE TABLE `field_images` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` varchar(255) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  `description` text NOT NULL,
  `modified` datetime DEFAULT NULL,
  `created` datetime DEFAULT NULL,
  PRIMARY KEY (`pages_id`,`sort`),
  KEY `data` (`data`),
  KEY `modified` (`modified`),
  KEY `created` (`created`),
  FULLTEXT KEY `description` (`description`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `field_images` (pages_id, data, sort, description, modified, created) VALUES('61151', 'pw_localaudiofiles_mindmap.png', '0', '', '2013-05-18 21:40:54', '2013-05-18 21:40:54');

DROP TABLE IF EXISTS `field_laf_demo_code`;
CREATE TABLE `field_laf_demo_code` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` mediumtext NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `field_laf_demo_code` (pages_id, data) VALUES('61146', 'echo $fe->getUL(\'genre\');  // \'genre\' - \'artist\' - \'album\'\r\n\r\necho $fe->getUL(\'artist\');');
INSERT INTO `field_laf_demo_code` (pages_id, data) VALUES('61147', 'echo $fe->dbGetFullTree(true);\r\n\r\n//$fe->hn->my_var_dump($fe->dbGetFullTree(),1);');
INSERT INTO `field_laf_demo_code` (pages_id, data) VALUES('61149', '$fe->hn->my_var_dump( $fe->dbGetInfoArtists( true ), 1 );\r\n$fe->hn->my_var_dump( $fe->dbGetInfoArtists(), 1 );');
INSERT INTO `field_laf_demo_code` (pages_id, data) VALUES('60753', 'echo \"<form id=\'formAlbum\' action=\'/playlist/m3u/\' method=\'post\'>\\n\";\r\n\r\necho $fe->getFormSelect(\'album\');\r\n\r\necho \"  <br /><input type=\\\"Submit\\\" name=\\\"submit\\\" value=\\\"create playlist for one album\\\">\\n\";\r\necho \"</form>\\n\";');
INSERT INTO `field_laf_demo_code` (pages_id, data) VALUES('60754', 'echo \"<form id=\'formAlbum\' action=\'/playlist/m3u/\' method=\'post\'>\\n\";\r\n\r\necho $fe->getFormSelect(\'albums\');\r\n\r\necho \"  <br /><input type=\\\"Submit\\\" name=\\\"submit\\\" value=\\\"create playlist for multiple albums\\\">\\n\";\r\necho \"</form>\\n\";');
INSERT INTO `field_laf_demo_code` (pages_id, data) VALUES('60755', '$options = array(\r\n   \'NameIdPrefix\'   => \'SELALBUMS_\',\r\n   \'withChildCount\' => true );\r\necho \"<form id=\'formAlbums\' action=\'/playlist/m3u/\' method=\'post\'>\\n\";\r\necho $fe->getFormSelect(\'albums\', 13, $options);\r\necho \"  <br /><input type=\\\"Submit\\\" name=\\\"submit\\\" value=\\\"create playlist for multiple albums\\\">\\n\";\r\necho \"</form>\\n\";\r\n\r\n$options = array(\r\n   \'NameIdPrefix\'   => \'SELALBUM_\',\r\n   \'withChildCount\' => true,\r\n   \'forMonospace\'   => true,\r\n   \'style\'          => \"font-family:courier,monospace;font-size:0.74em\" );\r\necho \"<form id=\'formAlbum\' action=\'/playlist/m3u/\' method=\'post\'>\\n\";\r\necho $fe->getFormSelect(\'album\', 13, $options);\r\necho \"  <br /><input type=\\\"Submit\\\" name=\\\"submit\\\" value=\\\"create playlist for one album\\\">\\n\";\r\necho \"</form>\\n\";');
INSERT INTO `field_laf_demo_code` (pages_id, data) VALUES('60756', '$options = array(\r\n   \'NameIdPrefix\'   => \'SEL_\',\r\n   \'withChildCount\' => false,\r\n   \'forMonospace\'   => false,\r\n   \'style\'          => \"float:left;width:44%;\"\r\n);\r\necho \"<form id=\'formRandom\' action=\'/playlist/m3u/\' method=\'post\'>\\n\";\r\n\r\necho $fe->getFormSelect(\'genre\', 9, $options);\r\necho $fe->getFormSelect(\'artists\', 9, $options);\r\n\r\necho $fe->getFormSelectQuantity(10, 50, 5, 9, \'SEL_\', \"float:left;width:10%;\");\r\n\r\necho \"  <p style=\'clear:both;margin:0 0 0 0\'>&nbsp;</p>\\n\";\r\necho \"  <input type=\\\"Submit\\\" name=\\\"submit\\\" value=\\\"create a random playlist\\\">\\n\";\r\necho \"</form>\\n\";');
INSERT INTO `field_laf_demo_code` (pages_id, data) VALUES('60758', 'echo \"<form id=\'formAlbum\' action=\'/playlist/pls/\' method=\'post\'>\\n\";\r\n\r\necho $fe->getFormSelect(\'albums\');\r\n\r\necho \"  <br /><input type=\\\"Submit\\\" name=\\\"submit\\\" value=\\\"create playlist for multiple albums\\\">\\n\";\r\necho \"</form>\\n\";');

DROP TABLE IF EXISTS `field_laf_demo_summary`;
CREATE TABLE `field_laf_demo_summary` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` mediumtext NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('60753', '<p>With the following code you can create FormSelectFields for Genres, Artists and Albums.</p><p>The form <strong>action</strong> must be <strong>/playlist/m3u/</strong> or <strong>/playlist/pls/</strong> and the <strong>method</strong> must be <strong>post</strong>.</p><p><strong>   $fe-&gt;getFormSelect($category</strong>=\'genre\',<strong> $size</strong>=9,<strong> $options</strong>=null<strong>)<br /></strong><em></em></p><p>You can call the method for a genre-selectfield without any params. Setting the fisrt param to genre, album or artist returns a SingleSelectField of the specified category. Setting the first param to one of its plural (genres, artists, albums) returns a MultiSelectField!</p><p><strong>    $category = [ genre | artist | album</strong><em> OR</em><strong> genre<em>s</em> | artist<em>s</em> | album<em>s</em> ]<br />    $size = 9 </strong>// these are the static lines of the selectfield</p><p>See the first example here, and more examples in following demos:</p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('61148', '<p>asfasfaf fafasfa</p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('60754', '<p>This is the same example but with <strong>albums</strong> passed as param instead of <strong>album</strong> :</p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('60755', '<p>As the third param you can pass an options-array():</p><pre>$options = array(\r\n   // (prefix for the name and the id tag, - is followed by the category: \'SEL_albums\')\r\n   \'NameIdPrefix\'   =&gt; \'SEL_\',                   \r\n   // (if it should display the count of children, with genres it displays number of artists | with artists it displays number of albums etc.)\r\n   \'withChildCount\' =&gt; false,                    \r\n   // (withChildCount is displayed before the Title by default, if you use a monospace it can be displayed align-right)\r\n   \'forMonospace\'   =&gt; false,                    \r\n   // (optional inline-css, for example: \'float:left;width:50%;\')\r\n   \'style\'          =&gt; \"float:left;width:44%;\"   \r\n);</pre><p>This example shows two forms, one with childCount and the other with childCount &amp; forMonospace:</p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('60756', '<p>If you create a form with one or more MultipleSelectFields you should add a quantity to limit the number of returned Songs in the playlist. If you don\'t do that,  the default of 25 Tracks is used! If you want the user have to select the number, you may use the following method:</p><p>  <strong>$fe-&gt;getFormSelectQuantity</strong>( <strong>$start</strong>=10, <strong>$end</strong>=50, <strong>$step</strong>=5, <strong>$size</strong>=9, $NameIdPrefix=\'SEL_\', $style=null)</p><p>This example provides a single SelectField for a <strong>genre</strong> and a MultipleSelectField for <strong>artists</strong> and a <strong>quantity</strong> SelectField.</p><p>You may select only a Genre, or only one ore multiple Artists or any combination of it and send it to the server to get a random m3u-Playlist :-)</p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('61146', '<p>You can retrieve PageArrays of all Genres, Artists and Albums and than iterate through it and create some output:</p><pre><code><strong>$genres = $fe-&gt;dbGetGenres(); // dbGetArtists() dbGetAlbums()</strong>\r\n\r\necho \"&lt;ul&gt;\\n\";\r\nforeach(<strong>$genres</strong> as <strong>$genre</strong>) {\r\n    echo \"  &lt;li&gt;&lt;a href=\'\".<strong>$genre-&gt;url</strong>.\"\'&gt;\".<strong>$genre-&gt;title</strong>.\"&lt;/a&gt;&lt;/li&gt;\\n\";\r\n}\r\necho \"&lt;/ul&gt;\\n\";</code></pre><p>Below you see the short version of this, - pulled from the FrontEndHandler:</p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('60757', '<p>Creating a Playlist can be done with a simple <strong>GET</strong>-Request as follows:<br />send an album-page-id as part of the url to: <strong>/playlist/m3u/{ID}/</strong> and you get a m3u-playlist for that album. If you send it to <strong>/playlist/pls/{ID}/</strong> you get a pls-playlist returned.</p><p>If you want get playlists other than for a simple album, you have to use a <strong>POST</strong>-Request as follows:<br />send it to <strong>/playlist/m3u/</strong> or <strong>/playlist/pls/,</strong></p><p>within the form you can create a single SelectField named \'<strong>album</strong>\', or a MultipleSelectField named \'<strong>albums</strong>\'. Or you create a combination of fields named <strong>genre</strong> | <strong>genres</strong> and <strong>artist</strong> | <strong>artists</strong>. You can use only one field or any combination, but a good choice for example would be: single genre and multiple artists.</p><p>The following demos show the use of some FormSelectFields allready provieded by the LocalAudioFiles-FrontEndHandler.</p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('61147', '<p>With<strong> $fe-&gt;dbGetFullTree()</strong> you get a Multidimensional Array with all genres, artists, albums and songs in logical Parent-Child-Relations.</p><p>With <strong>$fe-&gt;dbGetFullTree(<em>true</em>)</strong> you get that Multidimensional Array as simple &lt;ul&gt;&lt;li&gt; output. Maybe useful together with jQuery-Treeview-Menu-Plugins!</p><p>Once output is created, it is cached until you add/modify the DB or set the option to bypass the cache!</p><p>As an example you may also look to the <a href=\"/sitemap/\">sitemap!</a></p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('60758', '<p>Instead of m3u you can use pls to retrieve a Playlist in that format:</p><p>  &lt;form action=\'<strong>/playlist/pls/</strong>\' method=\'post\'&gt;</p>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('61149', '<p>There are also some methods that lets you pull very fast informations of all sibling branches:</p><ul><li>dbGetInfoGenres($ids=false)</li><li>dbGetInfoArtists($ids=false)</li><li>dbGetInfoAlbums($ids=false)</li></ul><p>If you set the optional param to true you simply get an array with all ids of relevant pages. This can be turned into PageArray with: $pa = $pages-&gt;getById($ids); This is used by the FrontEndHandler class when you call the dbGetGenres(), dbGetArtists(), ... methods. (they pull data from that methods/cache, turn into PageArray and sort by title).</p><p>If you use the default output you have some useful informations. Look to the second var_dump output below!</p><p>There are some more methods that can return useful informations:</p><ul><li>dbGetInfoBitrates()</li><li>dbGetInfoTotalPlaytime($albumId=null)</li><li>dbGetInfoTotalPlaytimeString($albumId=null)</li></ul>');
INSERT INTO `field_laf_demo_summary` (pages_id, data) VALUES('61151', '<p><a href=\"http://pw5.kawobi.local/site/assets/files/61151/pw_localaudiofiles_mindmap.png\" target=\"_blank\"><img src=\"/site/assets/files/61151/pw_localaudiofiles_mindmap.299x0.png\" width=\"299\" height=\"177\" alt=\"pw_localaudiofiles_mindmap.png\" /></a></p><p>This image shows a MindMap of the DB-structure and it controls.</p><p>The DB extends the ProcessWire variable <em><strong>$page</strong></em> with some additions. These additions depend of the type (or path) of the <strong><em>$page</em></strong>. In fact, the template name also reflect the path/type.</p><p>So, if the <strong><em>$page-&gt;template</em></strong> is <strong>album,</strong> the<em><strong> $page</strong></em> has following additions:</p><ul><li><em><strong>artist</strong> </em>(linked to artist page, its the logical parent)</li><li><em><strong>genre</strong></em> (linked to genre page, its the logical rootParent)</li><li><em><strong>songs</strong> </em>(holds a pageArray with all song pages, the logical child pages)</li></ul><p>There are other additions like<strong><em> totalPlaytime, totalPlaytimeString, playlistM3u, playlistPls</em></strong>, but<em> </em>the above ones, reflecting the logical parent-child-relations are of more interest. Here are the summary for all four page types:</p><ul><li><em><strong>genre</strong></em> has: <em><strong>artists</strong> </em>(logical child pages)</li><li><em><strong>artist</strong> </em>has: <em><strong>genre</strong> </em>(logical parent page), <em><strong>albums</strong> </em>(logical child pages)</li><li><em><strong>album</strong> </em>has: <em><strong>genre</strong> </em>(logical rootParent page), <em><strong>artist</strong> </em>(logical parent page), <em><strong>songs</strong> </em>(logical child pages)</li><li><em><strong>song</strong> </em>has: <em><strong>album</strong> </em>(logical parent page), <em><strong>artist</strong> </em>(logical grandparent page), <em><strong>genre</strong> </em>(logical rootParent page)<br />.</li><li><em><strong>album</strong> </em>and <em><strong>song</strong> </em>have <em><strong>coverImage</strong></em> as PageImage, <br />so you can use it like <em><strong>$page-&gt;coverImage-&gt;width(200)-&gt;url</strong></em></li></ul><p>For the other additions please look into the DB, they are displayed as PageInfo on every single page, together with some simple demo code. The code you find in the Templatefiles <strong>local-audio-files_single.php</strong> and <strong>local-audio-files.php</strong>.</p><p>The <em><strong>$page</strong></em> variable together with the <em><strong>LocalAudioFiles-FrontEndHandler</strong></em> gives you comprehensive tools to work with your music collection.</p><p>For example, the FrontEndHandler (<strong>$fe</strong>) provides fully customizable FormSelectFields. You can call them like <strong>$fe-&gt;getFormSelect(\'album\')</strong> or <strong>$fe-&gt;getFormSelect(\'artists\')</strong>, whereas if you use genre, artist, album - you get a SingleSelectField, if you use the plural, genre<strong>s</strong>, artist<strong>s</strong>, album<strong>s</strong> you get a MultiSelectField!</p><p>For more examples please refer to the demos section of the DB.</p>');

DROP TABLE IF EXISTS `field_lafc_cachedisabled`;
CREATE TABLE `field_lafc_cachedisabled` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` tinyint(4) NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_lafc_encodingcharset`;
CREATE TABLE `field_lafc_encodingcharset` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_lafc_filetypes`;
CREATE TABLE `field_lafc_filetypes` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `field_lafc_filetypes` (pages_id, data) VALUES('1030', 'a:2:{i:0;s:3:\"mp3\";i:1;s:3:\"MP3\";}');

DROP TABLE IF EXISTS `field_lafc_httphost`;
CREATE TABLE `field_lafc_httphost` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` text NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `field_lafc_httphost` (pages_id, data) VALUES('1030', 'http://pw5.kawobi.local');

DROP TABLE IF EXISTS `field_lafc_lastmodified`;
CREATE TABLE `field_lafc_lastmodified` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` datetime NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `field_lafc_lastmodified` (pages_id, data) VALUES('1030', '2013-05-19 00:00:00');

DROP TABLE IF EXISTS `field_lafc_pathes`;
CREATE TABLE `field_lafc_pathes` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` mediumtext NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

INSERT INTO `field_lafc_pathes` (pages_id, data) VALUES('1030', 'a:0:{}');

INSERT INTO `field_process` (pages_id, data) VALUES('6', '17') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('3', '12') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('8', '12') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('9', '14') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('10', '7') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('11', '47') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('16', '48') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('300', '104') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('21', '50') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('29', '66') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('23', '10') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('304', '138') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('31', '136') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('22', '76') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('30', '68') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('303', '129') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('2', '87') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('302', '121') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('301', '109') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('28', '76') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('8714', '162') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('1033', '161') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_process` (pages_id, data) VALUES('11230', '165') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);

DROP TABLE IF EXISTS `field_samplerate`;
CREATE TABLE `field_samplerate` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  `sort` int(10) unsigned NOT NULL,
  PRIMARY KEY (`pages_id`,`sort`),
  KEY `data` (`data`,`pages_id`,`sort`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_songlength`;
CREATE TABLE `field_songlength` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_songnumber`;
CREATE TABLE `field_songnumber` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


INSERT INTO `field_title` (pages_id, data) VALUES('1', 'home') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1033', 'LocalAudioFiles') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1009', 'artists') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1010', 'genres') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1011', 'albums') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1012', 'songs') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1019', 'LocalAudioFiles :: User is allowed to use Frontend') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1020', 'LocalAudioFiles :: User is allowed to use Frontend and Backend') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1030', 'LAFC') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1034', 'bitrates') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1035', '32') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1036', '40') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1037', '48') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1038', '56') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1039', '64') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1040', '80') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1041', '96') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1042', '112') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1043', '128') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1044', '160') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1045', '192') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1046', '224') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1047', '256') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1048', '320') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1049', 'bitratemodes') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1050', 'vbr') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1051', 'cbr') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1052', 'samplerates') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1053', '32000') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1054', '44100') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('1055', '48000') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('8716', 'dbinfo') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('7025', '512') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('8714', 'ModulesManager') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('11229', 'stream') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('11230', 'Export Site Profile') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('40834', '11025') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('40835', '22050') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('40836', '33075') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('54644', 'playlist') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('54787', 'abr') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('60751', 'demos') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('60753', '- FormSelectField 01') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('60754', '- FormSelectField 02') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('60755', '- FormSelectField 03') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('60756', '- FormSelectField 04') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('60757', 'Playlists (m3u & pls)') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('60758', '- FormSelectField 05') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('61146', '- dbGet{categoryPageArray}') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('61147', '- dbGetFullTree') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('61148', 'DB get info - get objects') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('61149', '- dbGetInfo{category}') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('61150', 'sitemap') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);
INSERT INTO `field_title` (pages_id, data) VALUES('61151', 'general Overview') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), data=VALUES(data);

DROP TABLE IF EXISTS `field_unsynchronised_lyric`;
CREATE TABLE `field_unsynchronised_lyric` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` mediumtext NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data_exact` (`data`(255)),
  FULLTEXT KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


DROP TABLE IF EXISTS `field_year`;
CREATE TABLE `field_year` (
  `pages_id` int(10) unsigned NOT NULL,
  `data` int(11) NOT NULL,
  PRIMARY KEY (`pages_id`),
  KEY `data` (`data`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;


INSERT INTO `fieldgroups` (id, name) VALUES('1', 'home') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('83', 'basic-page') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('99', 'artist') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('98', 'genre') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('100', 'album') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('101', 'song') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('102', 'LocalAudioFilesConfig') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('103', 'ARTISTS') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('104', 'ALBUMS') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('105', 'GENRES') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('106', 'SONGS') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('107', 'local-audio-files') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('108', 'local-audio-files_single') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('109', 'dbinfo') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('110', 'local-audio-files_stream') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('112', 'local-audio-files_demos') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('113', 'DEMOS') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('114', 'demo') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);
INSERT INTO `fieldgroups` (id, name) VALUES('116', 'sitemap') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name);

INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('2', '2', '1', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('2', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('3', '3', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('3', '4', '2', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('4', '5', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('5', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('3', '92', '1', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('83', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('1', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('99', '121', '1', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('98', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('99', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('100', '99', '3', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('100', '115', '2', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('100', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '117', '11', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '116', '10', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '124', '9', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '120', '8', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('102', '107', '3', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '119', '7', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('102', '109', '4', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '118', '6', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '101', '5', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '100', '4', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '108', '3', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('100', '98', '1', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '102', '2', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '103', '1', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('103', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('104', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('105', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('106', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('107', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('108', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('109', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('102', '125', '6', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('110', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('102', '105', '2', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('101', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('102', '123', '5', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('102', '122', '1', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('112', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('113', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('114', '127', '1', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('114', '126', '2', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('114', '128', '3', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('114', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('116', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('102', '1', '0', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);
INSERT INTO `fieldgroups_fields` (fieldgroups_id, fields_id, sort, data) VALUES('102', '99', '7', '') ON DUPLICATE KEY UPDATE fieldgroups_id=VALUES(fieldgroups_id), fields_id=VALUES(fields_id), sort=VALUES(sort), data=VALUES(data);

INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('105', 'FieldtypeTextarea', 'LAFC_pathes', '0', '', '{\"inputfieldClass\":\"InputfieldTextarea\",\"rows\":2,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('107', 'FieldtypeText', 'LAFC_filetypes', '0', '', '{\"size\":0,\"maxlength\":2048,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('121', 'FieldtypePage', 'genre', '0', '', '{\"derefAsPage\":2,\"parent_id\":1010,\"labelFieldName\":\"title\",\"inputfield\":\"InputfieldSelect\",\"tags\":\"LocalAudioFiles\",\"columnWidth\":20,\"template_id\":44}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('108', 'FieldtypeText', 'checksum', '0', '', '{\"size\":0,\"maxlength\":2048,\"tags\":\"LocalAudioFiles\",\"columnWidth\":25,\"required\":1,\"collapsed\":5}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('109', 'FieldtypeText', 'LAFC_encodingCharset', '0', '', '{\"size\":0,\"maxlength\":2048,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('98', 'FieldtypePage', 'artist', '0', '', '{\"derefAsPage\":2,\"parent_id\":0,\"template_id\":45,\"labelFieldName\":\"title\",\"inputfield\":\"InputfieldSelect\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('99', 'FieldtypeImage', 'cover', '0', '', '{\"extensions\":\"gif jpg jpeg png\",\"maxFiles\":1,\"inputfieldClass\":\"InputfieldImage\",\"descriptionRows\":0,\"tags\":\"LocalAudioFiles\",\"fileSchema\":2}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('126', 'FieldtypeTextarea', 'LAF_demo_code', '0', '', '{\"inputfieldClass\":\"InputfieldTextarea\",\"rows\":10,\"tags\":\"LocalAudioFiles\",\"collapsed\":2}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('100', 'FieldtypeInteger', 'songnumber', '0', '', '{\"columnWidth\":16,\"inputType\":\"text\",\"min\":1,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('101', 'FieldtypeInteger', 'songlength', '0', '', '{\"inputType\":\"text\",\"tags\":\"LocalAudioFiles\",\"columnWidth\":16}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('102', 'FieldtypeText', 'filename', '0', '', '{\"required\":1,\"size\":0,\"maxlength\":500,\"collapsed\":5,\"tags\":\"LocalAudioFiles\",\"columnWidth\":50}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('103', 'FieldtypePage', 'album', '0', '', '{\"derefAsPage\":2,\"parent_id\":1011,\"template_id\":46,\"labelFieldName\":\"title\",\"inputfield\":\"InputfieldSelect\",\"columnWidth\":25,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('123', 'FieldtypeCheckbox', 'LAFC_cacheDisabled', '0', 'disable Caching for Menu and DB-Infos', '{\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('118', 'FieldtypePage', 'bitrate', '0', '', '{\"derefAsPage\":2,\"parent_id\":1034,\"labelFieldName\":\"title\",\"inputfield\":\"InputfieldSelect\",\"tags\":\"LocalAudioFiles\",\"columnWidth\":17}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('115', 'FieldtypeInteger', 'year', '0', '', '{\"inputType\":\"text\",\"min\":1600,\"max\":2056,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('116', 'FieldtypeTextarea', 'comment', '0', '', '{\"inputfieldClass\":\"InputfieldTextarea\",\"rows\":2,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('117', 'FieldtypeTextarea', 'unsynchronised_lyric', '0', '', '{\"inputfieldClass\":\"InputfieldTextarea\",\"rows\":5,\"tags\":\"LocalAudioFiles\",\"collapsed\":2}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('119', 'FieldtypePage', 'bitratemode', '0', '', '{\"derefAsPage\":2,\"parent_id\":1049,\"labelFieldName\":\"title\",\"inputfield\":\"InputfieldSelect\",\"tags\":\"LocalAudioFiles\",\"columnWidth\":17}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('120', 'FieldtypePage', 'samplerate', '0', '', '{\"derefAsPage\":2,\"parent_id\":1052,\"labelFieldName\":\"title\",\"inputfield\":\"InputfieldSelect\",\"tags\":\"LocalAudioFiles\",\"columnWidth\":17}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('122', 'FieldtypeDatetime', 'LAFC_lastModified', '0', '', '{\"size\":25,\"datepicker\":0,\"defaultToday\":1,\"columnWidth\":25,\"_dateInputFormat\":\"Y-m-d\",\"dateInputFormat\":\"Y-m-d\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('124', 'FieldtypeInteger', 'bpm', '0', '', '{\"columnWidth\":17,\"inputType\":\"text\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('125', 'FieldtypeText', 'LAFC_httpHost', '0', '', '{\"collapsed\":4,\"size\":0,\"maxlength\":255,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('127', 'FieldtypeTextarea', 'LAF_demo_summary', '0', '', '{\"inputfieldClass\":\"InputfieldTinyMCE\",\"rows\":8,\"tags\":\"LocalAudioFiles\",\"theme_advanced_buttons1\":\"formatselect,|,bold,italic,|,bullist,numlist,|,link,unlink,|,image,|,code,|,fullscreen\",\"theme_advanced_blockformats\":\"p,h2,h3,h4,blockquote,pre,code\",\"plugins\":\"inlinepopups,safari,table,media,paste,fullscreen,preelementfix\",\"valid_elements\":\"@[id|class],a[href|target|name],strong\\/b,em\\/i,br,img[src|id|class|width|height|alt],ul,ol,li,p[class],h2,h3,h4,blockquote,-p,-table[border=0|cellspacing|cellpadding|width|frame|rules|height|align|summary|bgcolor|background|bordercolor],-tr[rowspan|width|height|align|valign|bgcolor|background|bordercolor],tbody,thead,tfoot,#td[colspan|rowspan|width|height|align|valign|bgcolor|background|bordercolor|scope],#th[colspan|rowspan|width|height|align|valign|scope],pre,code\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);
INSERT INTO `fields` (id, type, name, flags, label, data) VALUES('128', 'FieldtypeImage', 'images', '0', '', '{\"extensions\":\"gif jpg jpeg png\",\"maxFiles\":0,\"entityEncode\":1,\"inputfieldClass\":\"InputfieldImage\",\"descriptionRows\":1,\"adminThumbs\":1,\"fileSchema\":2,\"collapsed\":2}') ON DUPLICATE KEY UPDATE id=VALUES(id), type=VALUES(type), name=VALUES(name), flags=VALUES(flags), label=VALUES(label), data=VALUES(data);

INSERT INTO `modules` (id, class, flags, data) VALUES('161', 'LocalAudioFiles', '1', '') ON DUPLICATE KEY UPDATE id=VALUES(id), class=VALUES(class), flags=VALUES(flags), data=VALUES(data);
INSERT INTO `modules` (id, class, flags, data) VALUES('162', 'ModulesManager', '1', '') ON DUPLICATE KEY UPDATE id=VALUES(id), class=VALUES(class), flags=VALUES(flags), data=VALUES(data);
INSERT INTO `modules` (id, class, flags, data) VALUES('164', 'MarkupSimpleNavigation', '1', '') ON DUPLICATE KEY UPDATE id=VALUES(id), class=VALUES(class), flags=VALUES(flags), data=VALUES(data);
INSERT INTO `modules` (id, class, flags, data) VALUES('165', 'ProcessExportProfile', '1', '') ON DUPLICATE KEY UPDATE id=VALUES(id), class=VALUES(class), flags=VALUES(flags), data=VALUES(data);

INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1', '0', '1', 'home', '9', '2013-04-29 22:59:13', '41', '0000-00-00 00:00:00', '2', '0') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('27', '1', '29', 'http404', '1035', '2013-04-12 22:57:04', '41', '2010-06-03 06:53:03', '3', '15') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1009', '1', '49', 'artist', '1', '2013-04-16 15:40:18', '41', '2013-04-12 23:52:00', '41', '4') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1010', '1', '51', 'genre', '1', '2013-04-16 15:40:07', '41', '2013-04-12 23:53:30', '41', '3') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1011', '1', '50', 'album', '1', '2013-04-16 15:40:30', '41', '2013-04-12 23:54:13', '41', '5') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1012', '1', '52', 'song', '1', '2013-04-16 15:40:48', '41', '2013-04-12 23:54:55', '41', '6') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1018', '30', '4', 'localaudiofiles_user', '1', '2013-04-14 10:38:07', '41', '2013-04-14 10:28:42', '41', '2') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1019', '31', '5', 'localaudiofiles_use', '1', '2013-04-16 02:03:03', '41', '2013-04-14 10:29:58', '41', '9') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1020', '31', '5', 'localaudiofiles_admin', '1', '2013-04-16 02:03:54', '41', '2013-04-14 10:31:33', '41', '10') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1021', '30', '4', 'localaudiofiles_admin', '1', '2013-04-16 18:14:31', '41', '2013-04-14 10:33:48', '41', '3') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1022', '29', '3', 'mp3user', '1', '2013-04-14 10:42:11', '41', '2013-04-14 10:41:17', '41', '2') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1030', '22', '48', 'lafc', '1025', '2013-05-19 22:07:36', '41', '2013-04-14 21:33:33', '41', '3') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1033', '22', '2', 'localaudiofiles', '1', '2013-04-15 00:38:58', '41', '2013-04-15 00:38:58', '41', '3') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1034', '1', '29', 'bitrates', '1', '2013-04-16 01:48:26', '41', '2013-04-16 01:48:00', '41', '7') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1035', '1034', '29', '32', '1', '2013-04-16 01:51:25', '41', '2013-04-16 01:51:25', '41', '0') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1036', '1034', '29', '40', '1', '2013-04-16 01:51:51', '41', '2013-04-16 01:51:45', '41', '1') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1037', '1034', '29', '48', '1', '2013-04-16 01:52:13', '41', '2013-04-16 01:52:13', '41', '2') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1038', '1034', '29', '56', '1', '2013-04-16 01:52:36', '41', '2013-04-16 01:52:36', '41', '3') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1039', '1034', '29', '64', '1', '2013-04-16 01:52:47', '41', '2013-04-16 01:52:47', '41', '4') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1040', '1034', '29', '80', '1', '2013-04-16 01:53:03', '41', '2013-04-16 01:52:56', '41', '5') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1041', '1034', '29', '96', '1', '2013-04-16 01:53:19', '41', '2013-04-16 01:53:19', '41', '6') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1042', '1034', '29', '112', '1', '2013-04-16 01:53:29', '41', '2013-04-16 01:53:29', '41', '7') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1043', '1034', '29', '128', '1', '2013-04-16 01:53:40', '41', '2013-04-16 01:53:40', '41', '8') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1044', '1034', '29', '160', '1', '2013-04-16 01:53:50', '41', '2013-04-16 01:53:50', '41', '9') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1045', '1034', '29', '192', '1', '2013-04-16 01:54:00', '41', '2013-04-16 01:54:00', '41', '10') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1046', '1034', '29', '224', '1', '2013-04-16 01:54:13', '41', '2013-04-16 01:54:13', '41', '11') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1047', '1034', '29', '256', '1', '2013-04-16 01:54:27', '41', '2013-04-16 01:54:27', '41', '12') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1048', '1034', '29', '320', '1', '2013-04-16 01:54:38', '41', '2013-04-16 01:54:38', '41', '13') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1049', '1', '29', 'bitratemodes', '1', '2013-04-16 15:38:18', '41', '2013-04-16 01:55:22', '41', '8') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1050', '1049', '29', 'vbr', '1', '2013-04-16 21:22:37', '41', '2013-04-16 01:55:57', '41', '2') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1051', '1049', '29', 'cbr', '1', '2013-04-16 21:22:50', '41', '2013-04-16 01:56:37', '41', '1') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1052', '1', '29', 'samplerates', '1', '2013-04-16 15:37:45', '41', '2013-04-16 01:57:14', '41', '9') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1053', '1052', '29', '32000', '1', '2013-04-16 01:57:24', '41', '2013-04-16 01:57:24', '41', '2') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1054', '1052', '29', '44100', '1', '2013-04-16 01:57:47', '41', '2013-04-16 01:57:47', '41', '4') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('1055', '1052', '29', '48000', '1', '2013-04-16 01:58:01', '41', '2013-04-16 01:57:58', '41', '5') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('7025', '1034', '29', '512', '1', '2013-04-23 23:28:37', '41', '2013-04-23 23:28:27', '41', '14') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('8714', '22', '2', 'modulesmanager', '1', '2013-04-27 16:49:32', '41', '2013-04-27 16:49:32', '41', '4') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('8716', '1', '55', 'dbinfo', '1', '2013-04-29 22:46:36', '41', '2013-04-28 23:23:42', '41', '10') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('11229', '1', '56', 'stream', '1025', '2013-04-29 21:12:20', '41', '2013-04-29 21:12:01', '41', '13') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('11230', '22', '2', 'export-site-profile', '1', '2013-04-30 01:37:32', '41', '2013-04-30 01:37:32', '41', '5') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('40834', '1052', '29', '11025', '1', '2013-05-05 16:20:16', '41', '2013-05-05 16:20:16', '41', '0') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('40835', '1052', '29', '22050', '1', '2013-05-05 16:21:05', '41', '2013-05-05 16:21:05', '41', '1') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('40836', '1052', '29', '33075', '1', '2013-05-05 16:21:41', '41', '2013-05-05 16:21:38', '41', '3') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('54643', '29', '3', 'myusername', '1', '2013-05-08 16:09:38', '41', '2013-05-08 16:07:54', '41', '3') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('54644', '1', '56', 'playlist', '1025', '2013-05-08 17:25:55', '41', '2013-05-08 17:25:26', '41', '14') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('54787', '1049', '29', 'abr', '1', '2013-05-09 01:24:24', '41', '2013-05-09 01:24:20', '41', '0') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('60751', '1', '59', 'demos', '1', '2013-05-11 12:51:23', '41', '2013-05-10 15:46:07', '41', '11') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('60753', '60751', '60', 'demo-01', '1', '2013-05-12 08:30:12', '41', '2013-05-11 12:54:34', '41', '2') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('60754', '60751', '60', 'demo-02', '1', '2013-05-12 08:30:23', '41', '2013-05-11 14:00:46', '41', '3') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('60755', '60751', '60', 'formselectfield-03', '1', '2013-05-12 08:30:34', '41', '2013-05-11 15:49:53', '41', '4') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('60756', '60751', '60', 'formselectfield-04', '1', '2013-05-12 08:30:48', '41', '2013-05-11 16:11:54', '41', '5') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('60757', '60751', '60', 'm3u-playlists', '1', '2013-05-12 14:58:35', '41', '2013-05-11 17:18:57', '41', '1') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('60758', '60751', '60', 'formselectfield-05', '1', '2013-05-12 08:30:59', '41', '2013-05-11 20:22:43', '41', '6') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('61146', '60751', '60', 'dbgetgenres', '1', '2013-05-18 02:09:28', '41', '2013-05-17 18:51:42', '41', '8') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('61147', '60751', '60', 'dbgetfulltree', '1', '2013-05-18 22:16:52', '41', '2013-05-18 00:26:32', '41', '10') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('61148', '60751', '60', 'db-get-info-get-objects', '1', '2013-05-18 01:22:49', '41', '2013-05-18 01:22:38', '41', '7') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('61149', '60751', '60', 'dbgetinfogenres', '1', '2013-05-18 02:11:17', '41', '2013-05-18 01:43:22', '41', '9') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('61150', '1', '62', 'sitemap', '1', '2013-05-18 20:42:56', '41', '2013-05-18 20:42:38', '41', '12') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);
INSERT INTO `pages` (id, parent_id, templates_id, name, status, modified, modified_users_id, created, created_users_id, sort) VALUES('61151', '60751', '60', 'general-overview', '1', '2013-05-19 19:59:13', '41', '2013-05-18 21:40:36', '41', '0') ON DUPLICATE KEY UPDATE id=VALUES(id), parent_id=VALUES(parent_id), templates_id=VALUES(templates_id), name=VALUES(name), status=VALUES(status), modified=VALUES(modified), modified_users_id=VALUES(modified_users_id), created=VALUES(created), created_users_id=VALUES(created_users_id), sort=VALUES(sort);

INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('37', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('38', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1018', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1021', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('32', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('34', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('35', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('36', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('50', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('51', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('52', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('53', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('54', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1019', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1020', '2', '2013-04-14 15:41:29') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1034', '1', '2013-04-16 01:48:00') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1035', '1', '2013-04-16 01:51:25') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1036', '1', '2013-04-16 01:51:45') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1037', '1', '2013-04-16 01:52:13') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1038', '1', '2013-04-16 01:52:36') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1039', '1', '2013-04-16 01:52:47') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1040', '1', '2013-04-16 01:52:56') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1041', '1', '2013-04-16 01:53:19') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1042', '1', '2013-04-16 01:53:30') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1043', '1', '2013-04-16 01:53:40') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1044', '1', '2013-04-16 01:53:50') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1045', '1', '2013-04-16 01:54:00') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1046', '1', '2013-04-16 01:54:13') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1047', '1', '2013-04-16 01:54:27') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1048', '1', '2013-04-16 01:54:38') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1049', '1', '2013-04-16 01:55:22') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1050', '1', '2013-04-16 01:55:57') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1051', '1', '2013-04-16 01:56:37') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1052', '1', '2013-04-16 01:57:14') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1053', '1', '2013-04-16 01:57:24') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1054', '1', '2013-04-16 01:57:47') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1055', '1', '2013-04-16 01:57:58') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1009', '1', '2013-04-16 12:10:56') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1011', '1', '2013-04-16 12:16:08') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1012', '1', '2013-04-16 12:57:31') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('1010', '1', '2013-04-16 15:35:53') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('11229', '1', '2013-04-29 21:12:01') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('8716', '1', '2013-04-28 23:23:42') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('7025', '1', '2013-04-23 23:28:27') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('40834', '1', '2013-05-05 16:20:16') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('40835', '1', '2013-05-05 16:21:05') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('40836', '1', '2013-05-05 16:21:38') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('40930', '2', '2013-05-05 19:11:55') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('40932', '2', '2013-05-05 19:11:35') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('40931', '2', '2013-05-05 19:11:21') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('40933', '2', '2013-05-05 19:11:43') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('54644', '1', '2013-05-08 17:25:26') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('54787', '1', '2013-05-09 01:24:20') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('61149', '1', '2013-05-18 01:43:22') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('61148', '1', '2013-05-18 01:22:38') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('61151', '1', '2013-05-18 21:40:36') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('60756', '1', '2013-05-11 16:11:54') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('61146', '1', '2013-05-17 18:51:42') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('60753', '1', '2013-05-11 12:54:34') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('60758', '1', '2013-05-11 20:22:43') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('61150', '1', '2013-05-18 20:42:38') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('60757', '1', '2013-05-11 17:18:57') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('61147', '1', '2013-05-18 00:26:32') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('60751', '1', '2013-05-10 15:46:07') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('60754', '1', '2013-05-11 14:00:46') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);
INSERT INTO `pages_access` (pages_id, templates_id, ts) VALUES('60755', '1', '2013-05-11 15:49:53') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), templates_id=VALUES(templates_id), ts=VALUES(ts);

INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('2', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('3', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('3', '2') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('7', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('22', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('22', '2') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('28', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('28', '2') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('29', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('29', '2') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('29', '28') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('30', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('30', '2') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('30', '28') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('31', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('31', '2') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('31', '28') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('1009', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('1010', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('1011', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('1012', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('1034', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('1049', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('1052', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);
INSERT INTO `pages_parents` (pages_id, parents_id) VALUES('60751', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), parents_id=VALUES(parents_id);

INSERT INTO `pages_sortfields` (pages_id, sortfield) VALUES('1009', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), sortfield=VALUES(sortfield);
INSERT INTO `pages_sortfields` (pages_id, sortfield) VALUES('1010', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), sortfield=VALUES(sortfield);
INSERT INTO `pages_sortfields` (pages_id, sortfield) VALUES('1011', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), sortfield=VALUES(sortfield);
INSERT INTO `pages_sortfields` (pages_id, sortfield) VALUES('1012', '1') ON DUPLICATE KEY UPDATE pages_id=VALUES(pages_id), sortfield=VALUES(sortfield);


INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('1', 'home', '1', '0', '0', '{\"useRoles\":1,\"noParents\":1,\"slashUrls\":1,\"roles\":[37]}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('29', 'basic-page', '83', '0', '0', '{\"slashUrls\":1}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('45', 'artist', '99', '0', '0', '{\"noChildren\":1,\"parentTemplates\":[49],\"slashUrls\":1,\"altFilename\":\"local-audio-files_single\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('44', 'genre', '98', '0', '0', '{\"noChildren\":1,\"parentTemplates\":[51],\"slashUrls\":1,\"altFilename\":\"local-audio-files_single\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('46', 'album', '100', '0', '0', '{\"noChildren\":1,\"parentTemplates\":[50],\"slashUrls\":1,\"altFilename\":\"local-audio-files_single\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('47', 'song', '101', '0', '0', '{\"noChildren\":1,\"parentTemplates\":[52],\"slashUrls\":1,\"altFilename\":\"local-audio-files_single\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('48', 'LocalAudioFilesConfig', '102', '0', '0', '{\"useRoles\":1,\"editRoles\":[1021],\"noChildren\":1,\"noParents\":1,\"slashUrls\":1,\"tags\":\"LocalAudioFiles\",\"roles\":[1021]}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('49', 'ARTISTS', '103', '0', '0', '{\"noParents\":1,\"childTemplates\":[45],\"slashUrls\":1,\"altFilename\":\"local-audio-files\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('50', 'ALBUMS', '104', '0', '0', '{\"noParents\":1,\"childTemplates\":[46],\"slashUrls\":1,\"altFilename\":\"local-audio-files\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('51', 'GENRES', '105', '0', '0', '{\"noParents\":1,\"childTemplates\":[44],\"slashUrls\":1,\"altFilename\":\"local-audio-files\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('52', 'SONGS', '106', '0', '0', '{\"noParents\":1,\"childTemplates\":[47],\"slashUrls\":1,\"altFilename\":\"local-audio-files\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('53', 'local-audio-files', '107', '0', '0', '{\"noChildren\":1,\"noParents\":1,\"slashUrls\":1,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('54', 'local-audio-files_single', '108', '0', '0', '{\"noChildren\":1,\"noParents\":1,\"slashUrls\":1,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('55', 'dbinfo', '109', '0', '0', '{\"noChildren\":1,\"noParents\":1,\"slashUrls\":1,\"altFilename\":\"local-audio-files\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('56', 'local-audio-files_stream', '110', '0', '0', '{\"noChildren\":1,\"noParents\":1,\"urlSegments\":1,\"slashUrls\":1,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('58', 'local-audio-files_demos', '112', '0', '0', '{\"sortfield\":1,\"noChildren\":1,\"noParents\":1,\"slashUrls\":1,\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('59', 'DEMOS', '113', '0', '0', '{\"noParents\":1,\"childTemplates\":[60],\"slashUrls\":1,\"altFilename\":\"local-audio-files_demos\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('60', 'demo', '114', '0', '0', '{\"noChildren\":1,\"parentTemplates\":[59],\"slashUrls\":1,\"altFilename\":\"local-audio-files_demos\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
INSERT INTO `templates` (id, name, fieldgroups_id, flags, cache_time, data) VALUES('62', 'sitemap', '116', '0', '0', '{\"noChildren\":1,\"noParents\":1,\"slashUrls\":1,\"altFilename\":\"local-audio-files_sitemap\",\"tags\":\"LocalAudioFiles\"}') ON DUPLICATE KEY UPDATE id=VALUES(id), name=VALUES(name), fieldgroups_id=VALUES(fieldgroups_id), flags=VALUES(flags), cache_time=VALUES(cache_time), data=VALUES(data);
