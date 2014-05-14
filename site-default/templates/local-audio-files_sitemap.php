<?php
/**
* jQuery TreeView taken from: https://github.com/jzaefferer/jquery-treeview
*
*/


$urlCss = $config->urls->templates . 'css/';
$urlJs = $config->urls->templates . 'js/';


// get a FrontEndHandle,
$fe = $modules->get("LocalAudioFiles")->localAudioFilesFrontend($page);




$demos = $pages->get('template=DEMOS');
if($demos->numChildren) {
	$demoUL = "    <li><span><strong>demos</strong></span>\n      <ul>\n";
	foreach($demos->children as $child) {
		$demoUL .= "        <li><a href='{$child->url}'>{$child->title}</a></li>\n";
	}
	$demoUL .= "      </ul>\n    </li>\n";
}
else {
	$demoUL = "    <li><a href="/demos/">demos</a></li>\n";
}



?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title><?php echo $fe->browsertitle;?></title>
<link type="text/css" rel="stylesheet" href="<?php echo $urlCss;?>jquery.treeview.css" />
<link type="text/css" rel="stylesheet" href="<?php echo $urlCss;?>screen.css" />
<style type="text/css">
	body {background:#BBB;margin-left:40px;}
	h1#headline {color:#EEE;}
	a {text-decoration: none;}
</style>
<script type="text/javascript" src="<?php echo $urlJs;?>jquery.172.min.js"></script>
<script type="text/javascript" src="<?php echo $urlJs;?>jquery.cookie.js"></script>
<script type="text/javascript" src="<?php echo $urlJs;?>jquery.treeview.js"></script>
<script type="text/javascript">
	$(function() {
		$("#tree").treeview({
			collapsed: true,
			animated: "fast",
			control:"#sidetreecontrol",
			persist: "location"
		});
	})
</script>
</head>
<body>
<h1 id='headline'><?php echo $fe->headline;?></h1>
<h3>Example of jQueryTreeView Usage with <strong>$fe->dbGetFullTreeAsUlList()</strong></h3>

<div id="sidetree">
  <div id="sidetreecontrol"><a href="?#">Collapse All</a> | <a href="?#">Expand All</a></div>
  <ul id="tree">
    <li><a href="/">home</a></li>
    <li><a href="/dbinfo/">dbinfo</a></li>
<?php echo $demoUL;?>
    <li><span><strong>genres</strong></span>
<?php echo $fe->dbGetFullTreeAsUlList();?>
    </li>
  </ul>
</div>

</body>
</html>
