South Florida ColdFusion User Group Meeting March
=====================

How to optimize your websites with the tools we all have readily available.
---------------------

###The Group
---------------------
* [South Florida ColdFusion User's Website]([http://www.cfug-sfl.org/](http://www.cfug-sfl.org/)
* [Follow us on Twitter](https://twitter.com/sfcfug)
* [Like us on Facebook](https://www.facebook.com/cfugsfl)


###Requirements
---------------------
* [Adobe ColdFusion 10](http://www.adobe.com/products/coldfusion-standard.html)
* [node.js](http://nodejs.org/) 
* [Grunt <small>The JavaScript Task Runner</small>](http://gruntjs.com/)
* Apache or IIS 7+

###Setup
---------------------
Easy .. clone GIT repo to your desired location, preferably in a path accesible by your test webserver :-).

__DEMO URL__<br />
[http://dev.fusedev.com/cfug/2014.03.27/](http://dev.fusedev.com/cfug/2014.03.27/)

###File Summary
---------------------
* __step_1.cfm__  
This is the file using none of the features discussed, such as cache busting, minification and server caching.
* __step_2.cfm__  
This is the file only using the minification feature
* __step_3.cfm__  
This is the file using all the features, minification, cache busting, optimized assets (if set to tru in app vars) and server side caching.
* __step_4.cfm__  
Same as step 3 except not using server side caching, instead using appcache to store localy and work competely without the need of being online and fetching the data from the server

###Included Cache Admin
---------------------
A simple cache admin is available by navigating to cacheadmin/. The rest of the URL is based on your location of the files in your webroot.

###Using Grunt
---------------------
After installing [node.js](http://nodejs.org/) and [Grunt](http://gruntjs.com/), you should be able to go to the directory in your terminal (or command prompt) and type the following command to install all the dependecies.

<code>
npm install --save-dev 
</code>

Then you can run the default task by typing.

<code>
grunt
</code>

All are included in the grunt default task except the image optimizing process which you can call by running the following command


<code>
grunt imagemin
</code>

###Additional Resources
---------------------
* [A Beginner's Guide to Using the Application Cache](http://www.html5rocks.com/en/tutorials/appcache/beginner/)
* [Grunt for People Who Think Things Like Grunt are Weird and Hard](http://24ways.org/2013/grunt-is-not-weird-and-hard/)
* [htmlcompressor on google code](https://code.google.com/p/htmlcompressor/)
* [Chrome Developer Tools](https://developers.google.com/chrome-developer-tools/)
* [Safari Web Inspector Guide](https://developer.apple.com/library/safari/documentation/AppleApplications/Conceptual/Safari_Developer_Guide/Introduction/Introduction.html)
* [Firefox Developer Tools](https://developer.mozilla.org/en-US/docs/Tools)
* [Firebug](http://getfirebug.com/)
* [IIS UrlRewrite](http://www.iis.net/downloads/microsoft/url-rewrite)
* [Apache mod_rewrite](http://httpd.apache.org/docs/current/mod/mod_rewrite.html)



