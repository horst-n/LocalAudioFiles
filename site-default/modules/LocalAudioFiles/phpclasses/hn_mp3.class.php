<?php
/********************************************************************************************
* @script_type -  PHP-CLASS, modified for use with ProcessWire LocalAudioFiles
* @php_version -  4.2.x      ( but here together with getid3 for PHP5 ! )
* @version     -  0.4
* @SOURCE-ID   -  1.14
* -------------------------------------------------------------------------
* @author      -  Horst Nogajski <coding@nogajski.de>
* @copyright   -  (c) 2002 - 2013
* -------------------------------------------------------------------------
* $Source: /WEB/pw_LAF/htdocs/site/modules/LocalAudioFiles/phpclasses/hn_mp3.class.php,v $
* $Id: hn_mp3.class.php,v 1.7 2013/05/19 18:50:26 horst Exp $
*********************************************************************************************/


if( ! class_exists('hn_basic') || !class_exists('hn_dir') )
{
	#require_once(dirname(__FILE__).'/hn_basic.class.php');
	require_once(dirname(__FILE__).'/hn_dir.class.php');
}
if( ! class_exists('getID3') )
{
	require_once(dirname(__FILE__).'/getid3.php5/getid3.php');
	require_once(dirname(__FILE__).'/getid3.php5/write.php');
}


class hn_mp3
{
	var $mp3_in         = null;
	var $infos          = null;
	var $log            = array();
	var $chunk_length   = 32768;    // 32768 = 32 * 1024

	#var $cli            = null;
	var $getID3         = null;
	var $ID3_encodingCharset  = 'UTF-8'; //'ISO-8859-1';
	var $tags_id3       = array('artist','album','title','track','year','genre','comment','unsynchronised lyric','bpm');
	var $tags_audio     = array('channels','sample_rate','bitrate','bitrate_mode');


	function hn_mp3( $mp3_in=null, $save_blankvalues=TRUE, $getCover=FALSE )
	{
		$this->log[] = array(date('H:m:s')=>'initialize');
		$this->getID3 = new getID3();
		//$this->getID3->encoding = $this->ID3_encodingCharset;
		#$this->cli = new hn_cli_basic();
		if(!is_null($mp3_in))
		{
			$this->read_infos( $mp3_in, $save_blankvalues, $getCover );
		}
	}


	function getID3V2version($filename,$returnOnlyMajor=true)
	{
		$fp = fopen($filename, 'rb');
		fseek($fp, 0, SEEK_SET);
		$header = fread($fp, 10);
		fclose($fp);
		if(substr($header, 0, 3) == 'ID3'  &&  strlen($header) == 10)
		{
			$majorversion = ord($header{3});
			$minorversion = ord($header{4});
			return $returnOnlyMajor ? intval($majorversion) : array($majorversion,$minorversion);
		}
		return false;
	}



	function setEncodingCharset($charset='UTF-8')
	{
		$this->getID3->encoding = $this->ID3_encodingCharset = $charset;
		return $charset === $this->getID3->encoding && $charset === $this->ID3_encodingCharset;
	}


	function read_infos( $mp3_in, $save_blankvalues=TRUE, $getCover=FALSE )
	{
		$this->infos = null;
		if( is_string($mp3_in) && file_exists($mp3_in) && is_readable($mp3_in) )
		{
			$this->log[] = array(date('H:m:s')=>'get in-filename');
			$this->mp3_in = $mp3_in;
		}
		else
		{
			$msg = file_exists($mp3_in) ? 'infile is not readable' : 'infile does not exist';
			$this->log[] = array(date('H:m:s')=>$msg);
			return FALSE;
		}
		$ThisFileInfo = $this->getID3->analyze( $this->mp3_in );
		$this->getID3->CleanUp();
		if( ! isset($ThisFileInfo['mime_type']) || $ThisFileInfo['mime_type']!='audio/mpeg' )
		{
			$this->log[] = array(date('H:m:s')=>'infile is not a valid audio/mpeg');
			return FALSE;
		}
		$infos = array('main'=>array(),'id3v1'=>array(),'id3v2'=>array(),'id3_merged'=>array());
		$infos['main']['filesize'] = isset($ThisFileInfo['filesize']) ? intval($ThisFileInfo['filesize']) : -1;
		$infos['main']['playtime_seconds'] = isset($ThisFileInfo['playtime_seconds']) ? intval($ThisFileInfo['playtime_seconds']) : -1;
		$infos['main']['playtime_string'] = isset($ThisFileInfo['playtime_string']) ? $ThisFileInfo['playtime_string'] : '';
		foreach( $this->tags_audio as $v )
		{
			$infos['main'][$v] = isset($ThisFileInfo['audio'][$v]) ? $ThisFileInfo['audio'][$v] : '';
		}
		if( $getCover )
		{
			$infos['cover'] = isset($ThisFileInfo['id3v2']['APIC'][0]['data']) ? @$ThisFileInfo['id3v2']['APIC'][0]['data'] : null;    // binary image data
		}
		foreach( $this->tags_id3 as $v )
		{
			// ID3-V1
			if(isset($ThisFileInfo['tags']['id3v1'][$v][0]))
			{
				if(trim($ThisFileInfo['tags']['id3v1'][$v][0])!='')
				{
					$infos['id3v1'][$v] = trim($ThisFileInfo['tags']['id3v1'][$v][0]);
				}
				elseif($save_blankvalues)
				{
					$infos['id3v1'][$v] = '';
				}
			}
			elseif($save_blankvalues)
			{
				$infos['id3v1'][$v] = '';
			}

			// ID3-V2
			if(isset($ThisFileInfo['tags']['id3v2'][$v][0]))
			{
				if(trim($ThisFileInfo['tags']['id3v2'][$v][0])!='')
				{
					$infos['id3v2'][$v] = trim($ThisFileInfo['tags']['id3v2'][$v][0]);
				}
				elseif($save_blankvalues)
				{
					$infos['id3v2'][$v] = '';
				}
			}
			elseif($save_blankvalues)
			{
				$infos['id3v2'][$v] = '';
			}

			// ID3-merged
			// have to do some mapping to fit with PW-LocalAudioFiles Templates and Pages
			$k = $v;
			if($v==='title') $k = 'song';
			if($v==='track') $k = 'songnumber';
			if($v==='sample_rate') $k = 'samplerate';
			if($v==='unsynchronised lyric') $k = 'unsynchronised_lyric';
			if($save_blankvalues && $infos['id3v1'][$v]==='' && $infos['id3v2'][$v]==='')
			{
				$infos['id3_merged'][$k] = '';
			}
			elseif(isset($infos['id3v2'][$v]) && $infos['id3v2'][$v]!=='')
			{
				$infos['id3_merged'][$k] = $infos['id3v2'][$v];
			}
			elseif(isset($infos['id3v1'][$v]) && $infos['id3v1'][$v]!=='')
			{
				$infos['id3_merged'][$k] = $infos['id3v1'][$v];
			}
		}

		$this->infos = $infos;
		$this->log[] = array(date('H:m:s')=>'retrieve audio & id3 infos');

		return $this->infos;
	}



	function mp3split($file_in,$file_out,$cut1,$cut2,$id3v2=null)
	{
		$this->getID3->CleanUp();
		$CurrentFileInfo = $this->getID3->analyze($file_in);
		if($CurrentFileInfo['fileformat'] != 'mp3' || !isset($CurrentFileInfo['avdataend']) || !isset($CurrentFileInfo['avdataoffset']) || !isset($CurrentFileInfo['playtime_seconds']))
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: not all needed infos found in \$CurrentFileInfo');
			return FALSE;
		}
		if(strtolower($file_in) == strtolower($file_out))
		{
			$file_tmp = $file_out.'.tmp';
		}
		else
		{
			$file_tmp = $file_out;
		}

		// get infos from sourcefile and calculate bytesPerSecond
		$data_size = intval($CurrentFileInfo['avdataend'] - $CurrentFileInfo['avdataoffset']);
		$time_size = intval($CurrentFileInfo['playtime_seconds'] * 1000);
		$bytesPerSec = $data_size / $CurrentFileInfo['playtime_seconds']; // / 1000;

		// check if split-points are valid
		if(intval($cut1)>=intval($cut2))
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: cut1 is equal or greater than cut2');
			return FALSE;
		}
		if($cut2 > $time_size)
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: cut2 is greater than data_size');
			return FALSE;
		}
		if($cut1 < 0)
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: cut1 is not greater than 0');
			return FALSE;
		}

		// calculate data-splitpoints
		$byte_start = intval($cut1 / 1000 * $bytesPerSec);
		$byte_end   = intval($cut2 / 1000 * $bytesPerSec);

		// open files
		if(! $fp_source = @fopen($file_in, 'rb'))
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: cannot open file_in for reading');
			return FALSE;
		}
		if(! $fp_output = @fopen($file_tmp, 'wb'))
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: cannot open file_out for writing');
			fclose($fp_source);
			return FALSE;
		}

		// copy audio data from in_file to out_file
		fseek($fp_source, $CurrentFileInfo['avdataoffset'] + $byte_start, SEEK_SET);
		while(!feof($fp_source) && (ftell($fp_source) < $byte_end))
		{
			fwrite($fp_output, fread($fp_source, $this->chunk_length));
		}

		// trim post-audio data (if any) copied from first file that we don't need or want
		$CurrentOutputPosition = ftell($fp_output);
		$EndOfFileOffset = $CurrentOutputPosition + ($byte_start - ($CurrentFileInfo['avdataoffset'] + $byte_start));
		fseek($fp_output, $EndOfFileOffset, SEEK_SET);
		ftruncate($fp_output, $EndOfFileOffset);

		// close filepointers
		fclose($fp_source);
		fclose($fp_output);

		if($file_out == $file_tmp)   // die Ausgabedatei ist ungleich der Eingabedatei
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: successful cutted');
			$res = TRUE;
		}
		elseif(unlink($file_out))    // die Ausgabedatei ist gleich der Eingabedatei, deshalb wurde bis hierher eine TMP-Datei genutzt
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: successful cutted, now try to rename file_tmp to file_out');
			$res = rename($file_tmp,$file_out);
		}
		else                         //
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: not successful cutted');
			$res = FALSE;
		}
		// bei Fehlern beenden
		if($res===FALSE)
		{
			return FALSE;
		}
		// wenn keine ID3-Tags mitgeliefert wurden, dann wird die Bearbeitung hier ohne schreiben von ID3-Tags beendet
		if(is_null($id3v2))
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: no id3-tag handling wanted');
			return $res;
		}
		// wenn fuer die ID3-Tags ein boolean TRUE gesetzt ist, sollen die Tags aus dem Original uebernommen werden
		if($id3v2===TRUE)
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: file_out should get same id3-tags as file_in');
			// wir lesen die ID3V1 zuerst, falls welche gesetzt sind
			if(isset($CurrentFileInfo['tags']['id3v1']) && count($CurrentFileInfo['tags']['id3v1'])>0)
			{
				$id3v2 = array();
				foreach($CurrentFileInfo['tags']['id3v1'] as $k=>$v)
				{
					$id3v2[$k] = $v[0];
				}
			}
			// und ueberschreiben gegebenenfalls mit gleichnamigen aus der 2er Version
			if(isset($CurrentFileInfo['tags']['id3v2']) && count($CurrentFileInfo['tags']['id3v2'])>0)
			{
				$id3v2 = is_array($id3v2) ? $id3v2 : array();
				foreach($CurrentFileInfo['tags']['id3v2'] as $k=>$v)
				{
					if(!isset($id3v2[$k]))
					{
						$id3v2[$k] = $v[0];
						continue;
					}
					if(in_array(strtolower($k),array('artist','title','genre','track','year')))
					{
						$id3v2[$k] = $v[0];
						continue;
					}
					// wir schreiben beide Inhalte, falls vorhanden (Comments, Lyrics, ...)
					$id3v2[$k] = trim($id3v2[$k])=='' ? $v[0] : $id3v2[$k]."\r\n".$v[0];
				}
			}
		}
		// ID3-Tags schreiben ?!
		if(is_array($id3v2))
		{
			$this->log[] = array(date('H:m:s')=>'mp3split: try to set id3-tags');
			return $this->write_infos($file_out,$id3v2,FALSE,FALSE);
		}
		$this->log[] = array(date('H:m:s')=>'mp3split: id3-tag handling wanted, but no tags found in sourcefile');
		return $res;
	}



	function write_infos($mp3file, $id3v2_data, $copy_also_2_id3v1=TRUE, $write_blank_values=FALSE)
	{
		if(!is_array($id3v2_data))
		{
			$this->log[] = array(date('H:m:s')=>'write_infos: id3v2_data is not an array');
			return FALSE;
		}
		// erstelle korrekt configuriertes id3tag array
		$id3 = array();
		// pruefe / setze alle Standard-Tags, evtl auch mit Leer-Werten
		foreach($this->tags_id3 as $tag)
		{
			if(isset($id3v2_data[$tag]))
			{
				$id3[$tag][] = $id3v2_data[$tag];
			}
			elseif(!isset($id3v2_data[$tag]) && $write_blank_values)
			{
				$id3[$tag][] = '';
			}
		}
		// uebernehme auch eventuell vorhandene andere Tags
		foreach($id3v2_data as $tag=>$data)
		{
			if(isset($id3[$tag]))
			{
				continue;
			}
			$id3[$tag][] = $data;
		}
		// erstelle und konfiguriere eine Writer-Instanz
		$tagwriter = new getid3_writetags;
		$tagwriter->tag_encoding   		= $this->ID3_encodingCharset;
		$tagwriter->overwrite_tags 		= TRUE;
		$tagwriter->remove_other_tags 	= TRUE;
		$tagwriter->filename  			= $mp3file;
		$tagwriter->tagformats          = $copy_also_2_id3v1 ? array('id3v1','id3v2.3') : array('id3v2.3');
		$tagwriter->tag_data            = $id3;
		// schreibe Tags und werte das Ergebnis aus
		if($tagwriter->WriteTags())
		{
			$res = TRUE;
			$msg = empty($tagwriter->warnings) ? 'succes writing id3data' : 'writing id3data = '.implode("\n", $tagwriter->warnings);
			$this->log[] = array(date('H:m:s')=>$msg);
		}
		else
		{
			$res = FALSE;
			$msg = "ERROR writing id3data\n".implode("\n", $tagwriter->errors);
			$this->log[] = array(date('H:m:s')=>$msg);
		}
		unset($tagwriter);
		return $res;
	}




	function close()
	{
		$this->getID3->CleanUp();
		unset($this->getID3);
		#unset($this->cli);
		unset($this->infos);
		unset($this->log);
		unset($this->mp3_in);
	}



	function send_mp3($mp3file)
	{
		if(!is_file($mp3file) || !is_readable($mp3file))
		{
			return FALSE;
		}
		header("Pragma: no-cache");
		header("Cache-Control: no-cache, must-revalidate");
		header("Expires: " . date('r'));
		header("Content-Type: audio/mp3");
		header("Content-Disposition: filename=\"".basename($mp3file)."\"");
		header("Content-Length: ".filesize($mp3file));
		readfile($mp3file);
		exit(0);
	}


	function build_target_basename($track,$artist,$title)
	{
		$search  = array(' ', '"', "'", '?', '!', '§', '$', '%', '&', '+', '*', '=', '#', ';', ',', '.', 'ß',  'ä',  'ö',  'ü',  'Ä',  'Ö',  'Ü'  );
		$replace = array('_', '',  "",  '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', '_', 'ss', 'ae', 'oe', 'ue', 'AE', 'OE', 'UE' );

		$artist = strtolower(str_replace($search,$replace,$artist));
		$title  = strtolower(str_replace($search,$replace,$title));
		$target = $track.'_'.$artist.'_-_'.$title.'.mp3';
		return $target;
	}


	function check_avdata($file_in)
	{
		$this->getID3->CleanUp();
		$CurrentFileInfo = $this->getID3->analyze($file_in);
		if($CurrentFileInfo['fileformat'] != 'mp3' || !isset($CurrentFileInfo['avdataend']) || !isset($CurrentFileInfo['avdataoffset']) || !isset($CurrentFileInfo['playtime_seconds']))
		{
			return FALSE;
		}
		$data_size = intval($CurrentFileInfo['avdataend'] - $CurrentFileInfo['avdataoffset']);
		$time_size = intval($CurrentFileInfo['playtime_seconds'] * 1000);
		$bytesPerSec = $data_size / $CurrentFileInfo['playtime_seconds'] / 1000;

		echo "  $bytesPerSec\t$time_size\t$data_size\n";
		return array($data_size,$time_size,$bytesPerSec);
	}

}





class hn_dir_PWshell extends hn_dir
{
    var $totalfilesize = 0;
    var $checksum = false;
    var $mp3 = null;

	function hn_dir_PWshell($config='',$secure=TRUE)
	{
    	$this->hn_Dir($config,$secure);
	}

	function setMP3(&$mp3)
	{
		$this->mp3 =& $mp3;
	}

	/** Adds a matching file to the ResultArray.
	  * If you need more / other file informations in the ResultArray,
      * you can set 'basic_result' to FALSE. So also the addFile_Extended
      * Funktion will executed.
	  *
	  * @shortdesc Adds information of a matching file to the ResultArray.
	  * @private
	  **/
	function addFile($file)
	{
		$this->matched_files++;
		$file_size            = filesize($file);
		$this->totalfilesize += $file_size;
		if($this->very_basic_result)
		{
			$this->files[] = array('fullname'=>$file);
			return;
		}

		$fileInfo             = pathinfo($file);
		$timestamp            = filemtime($file);
		$metadata             = $this->mp3->info($file);
		$a                    = array();
		$a['filename']        = $file;
		$a['dirname']         = $fileInfo['dirname'];
		$a['basename']        = $fileInfo['basename'];
		$a['extension']       = $fileInfo['extension'];
		$a['filesize']        = $file_size;
		$a['timestamp']       = $timestamp;
		if($this->checksum) {
			$a['checksum']    = md5( serialize($metadata) . $file_size . $timestamp );
			//$a['checksum']    = md5( serialize($metadata) . $file_size ); // maybe this would be enough ??
		}

		$this->files[] = array_merge($a,$metadata);
	}


	function getDir( $sDir_or_aDirs, $reset=true )
	{
		if( $reset )
		{
			$this->hn_dir_reset();
		}
		if( $this->use_timer )
		{
			$this->timer_init();
		}
		if( isset($this->remote_sys) && preg_match('/.*win.*/i',$this->remote_sys) && $this->local_sys == 'WIN' )
		{
			$this->case_sensitive = FALSE;
		}
		else
		{
			$this->case_sensitive = (!isset($this->remote_sys) && $this->local_sys == 'WIN') ? FALSE : $this->case_sensitive;
		}
		$this->prepare_lists();
		foreach( (array)$sDir_or_aDirs as $v )
		{
			$v = $this->nobacks($v);
			$this->sourcename = $v;
			if( $this->hn_is_dir($v) )
			{
				$this->loadDir($v);
			}
		}
		if( $this->use_timer )
		{
			return nl2br($this->timer_result('LocalAudioFiles_Backend',true));
		}
	}


	function timer_result($name='',$print=TRUE)
	{
		$t = $this->timer->timer_get_current($name);
		unset($this->timer);
		if(!$print) return $t;
		if($name === '')
		{
			$this->print_timer_result('');
			$this->print_timer_result('hn_Dir results:');
			$this->print_timer_result("- scanned directories:\t".$this->scanned_dirs);
			$this->print_timer_result("- scanned files:      \t".$this->scanned_files);
			//$this->print_timer_result("- matched directories:\t".$this->matched_dirs);
			$this->print_timer_result("- matched files:      \t".$this->matched_files);
			$this->print_timer_result("- total filesize:     \t".$this->friendly_filesize($this->totalfilesize));
			$this->print_timer_result("- time:               \t".$t);
			$this->print_timer_result("----------------------------------------------");
			$this->print_timer_result('');
		}
		elseif($name==='LocalAudioFiles_Backend')
		{
			$s = "\n- scanned directories:\t".$this->scanned_dirs;
			$s .= "\n- scanned files:      \t".$this->scanned_files;
			$s .= "\n- matched files:      \t".$this->matched_files;
			$s .= "\n- total filesize:     \t".$this->friendly_filesize($this->totalfilesize);
			//$s .= "\n- time:               \t".$t;
			return $s;
		}
	}

}
