<?php
if(isset($result) && $result) {
    echo $result;
}

echo $dbInfo;

echo "<hr style='break:both;' />\n";

echo $inputFormConfig;

echo "<hr style='break:both;' />\n";

echo $inputFormSystemscan;

echo $inputFormCacheRebuild;

echo $inputFormCacheDrop;

echo "<div style='break:both;'>&nbsp;</div>\n";

?>
<script type="text/javascript">
  $('li#wrap_pathes').addClass("InputfieldStateCollapsed");
  $('li#wrap_filetypes').addClass("InputfieldStateCollapsed");
  //$('li#wrap_encodingCharset').addClass("InputfieldStateCollapsed");
</script>
<?php

