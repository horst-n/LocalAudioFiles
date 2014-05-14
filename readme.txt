Hi, this is the LocalAudioFiles SiteProfile in a alpha state (19.05.2013) Version 0.1.4.


You have to install it together with a fresh copy of PW. I have used it with 2.3.0

After your site is up:

1) the Modules "LocalAUdioFiles" and "MarkupSimpleNavigation" must be installed

2) go to ADMIN->SETUP->LocalAudioFiles and set the config

3) go to the ShellImporterScript open it and set the config:

     $PATH2PWindex = './index.php';
     $PWuser = 'myusername';
     $PWpass = 'my0secret0pass';

   after that you can run it!

   ( first you have to make it executable, or when on Windows you may use the
     mp3_import_starter4win.cmd to start it. Open the mp3_import_starter4win.cmd
     with a Editor and set the 2 path-variables, save it and run )

4) Now you (hopefully) should have some Audiofiles listed in your PageTree!  :)

Horst