#LocalAudioFiles - MP3-DB#

###A ProcessWire (2.3.0+) Siteprofile###

####Livedemo: http://pwlaf.biriba.de/ ####


The Local Audio Files DB is a combination of a Module and a SiteProfile. It is intended to import MP3-files from your filesystem into ProcessWire, read ID3-Tags and pull coverImages from it to feed the DB.


####How does it work?####

* The Site has _4 sibling Tree Branches_: __genres - artists - albums - songs__
* Each of them hold child-pages: __genre - artist - album - song__
* The _logical relations_ are _nested parent-children_ ones: a genre hold artists, each artist hold albums, each album hold songs
* To support both, slim and fast data relations & the logical hirarchy, the module extends the ProcessWire variable **_$page_** with some additions. It uses the addHookProperty mechanism to achieve that
* It uses an own __caching mechanism__ for large lists, that can be prebuild when running the __importer-shellscript__, or it build the cache on demand
* Also it comes with a __FrontEndHandler class__ that provides a lot of functionality, for example fully customizable FormSelectFields of all genres, artists or albums
* More __detailed informations__ and __code examples__ are collected in __a demo section__ of the site

The __extended *$page* variable__ together with the **_LocalAudioFiles-FrontEndHandler_** gives you comprehensive tools to work with your music collection.

