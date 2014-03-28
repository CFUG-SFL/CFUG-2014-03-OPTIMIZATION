/**
*   @extends    org.fusedevelopments.simple
*   @output     false
*/
component {
    
    this.name                   = "cfug_20140327";
    this.sessionmanagement      = true;
    this.sessiontimeout         = createTimeSpan(0,1,0,0);
    
    // java settings
    this.javaSettings   = {
        LoadPaths       : ["/bin"], 
        reloadOnChange  : true, 
        watchInterval   : 60
    };

    public function onApplicationStart(){    
        // application start
        application.title           = "SF:CFUG 2014.03.27";
        application.timestamp       = getHttpTimeString();
        application.allowDebug      = true;
        application.appcache        = false;
        application.minifiedAssets  = application.optimizedImages = false;
        // define root of application
        local.fileObj               = createObject("java", "java.io.File");
        application.base            = "/" & replace(getDirectoryFromPath(getCurrentTemplatePath()),expandPath("/"),"");
        // if our OS file separator is different than /
        if (compare(local.fileObj.separator,"/" ))
            application.base  = replace(application.base, local.fileObj.separator, "/","ALL");
       return true;
    }

    public function onRequestStart(){
        // define our request.path_info variable
        defineHttpPath();
        // restart app request (simple)
        if (structKeyExists(url,"reinit")){
            // stop application
            applicationStop();
            // reset for relocation
            local.qString  = replace(cgi.query_string, "reinit=" & url.reinit,"");
            local.qString  = reReplace(local.qString,"&{2}","&");
            local.qString  = reReplace(local.qString,"&$|^&","","all");
            local.qString  = (len(local.qString ) ? "?" & local.qString : "");
            location (request.path_info & local.qString,false);
        } 
        // set the base path for this application
        request.base = application.base;
    }
    
    /*
    * Normal onRequest - no caching no minification
    public function onRequest( string targetPage ) {
        include arguments.targetPage;
    }
    */

    /*
    * OnRequest with only minification
    public function onRequest(string targetPage){
        // save the page into a local variable
        savecontent variable = "local.view" { include targetpage; }
        // now tidyup the html and output - DO NOT MINIFY app.appcache
        if (structKeyExists(url,"ws") || findNoCase("app.appcache",request.path_info))
            writeOutput(local.view);    
        else
            writeOutput(removeWhitespaceFromHtml(local.view));  
    }
    */

    /**
    *   OnRequest with ColdFusion Caching and Minification
    */
    public function onRequest (required string targetPage){
        // local settings   
        local.usecache      = true;
        local.nocachedir    = "cacheadmin";
        local.nocachefile   = "app.appcache,favicon.ico,step_1,step_2,step_4";
        // check if we use cache or not
        if (
                structKeyExists(url,"dump") ||
                listFindNoCase(local.nocachedir,listFirst(replace(request.path_info,request.base,""),"/")) ||
                listFindNoCase(local.nocachefile,listLast(request.path_info,"/"))
            )
        {
            local.useCache = false;
        }
        // attempt to grab from cache
        if (local.useCache){
            // create the key
            local.key = request.path_info & (len(cgi.query_string) ? "?" & cgi.query_string : "");
            // create cache region
            if(!cacheRegionExists(cgi.server_name))
                cacheRegionNew(cgi.server_name);
            // get view from cache
            local.view = CacheGet(local.key,cgi.server_name);
        }
        // fetch view
        if (isNull(local.view)){
           savecontent variable = "local.view" { include targetpage; }
           // now tidyup the html and output - DO NOT MINIFY app.appcache or step_1
            if (!structKeyExists(url,"ws") && ( !findNoCase("app.appcache",request.path_info) && !findNoCase("step_1",request.path_info) ))
                local.view = removeWhitespaceFromHtml(local.view);
            // save to cache if ok
            if (local.useCache && !structKeyExists(request,"nocache")){
                CachePut(local.key,local.view,7,3,cgi.server_name);
                // id, value, timeSpan (decimal ==== days), idleTime, region
            }
        }
        // output view
        writeOutput(local.view);
    }
    
    public function onRequestEnd(){
        // DEBUG OUTPUT
        include "_dev/debug.cfm";
    }

}