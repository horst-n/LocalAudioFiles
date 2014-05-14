@echo off

REM set this to the absolute path of your php5-exe file
SET PHPEXE=C:\php\php.exe


REM set this to the absoulte path of the importer scriptfile
SET SCRIPTNAME=%~dp0LocalAudioFilesImportShellScript.php



ECHO press Ctrl-C to abort - or any key to start:
ECHO  - %SCRIPTNAME%
PAUSE>NUL


TITLE PHP RUNNING: %SCRIPTNAME% ...
"%PHPEXE%" -d output_buffering=0  "%SCRIPTNAME%"


PAUSE
END
