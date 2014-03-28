/**
*   @output     false
*/
component
{
    /**
    * @output   true
    * @hint     Defines the current path to request.path_info.
    *           If using friendly URLs it tries to build off server cgi variables and last attempt uses cgi.path_info (as it is not always reliable)
    */
    private void function defineHttpPath(){
        // cgi variables if they do not exists they always return an empty string
        if (len(cgi.http_x_original_url))                    // iis7 rewrite default
            request.path_info = listFirst(cgi.http_x_original_url,"?");
        else if (len(cgi.redirect_url))                      // apache mod_rewrite default
            request.path_info = listFirst(cgi.redirect_url,'?');
        else if (len(cgi.request_uri))                        // apache fallback
            request.path_info = listFirst(cgi.request_uri,'?');
        else                                                                                      // fallback to cgi.path_info
            request.path_info = cgi.path_info;
        // finally lets remove the index.cfm because some of the custom cgi variables don't bring it back
        // like this it means at the root we are working with / instead of /index.cfm
        request.path_info = reReplace(request.path_info,'index.cfm','');
        // fix for apache (returns emptry string at root)
        if (!len(request.path_info))
            request.path_info = "/";
    }

    /**
    * @output   false
    * @hint     Checks if the request made is an XMLHttpRequest == AJAX
    */
    public boolean function isAjax(){
        var req = getHttpRequestData().headers;
        if (structKeyExists(req,"X-Requested-With") && !compareNoCase(req["X-Requested-With"],"XMLHttpRequest"))
            return true;
        else
            return false;
    }

    /**
    * @output   true
    * @hint     Outputs response as application/json
    */
    public void function renderJSON(any value, boolean serializeQueryByColumns = false){
        var pc = getpagecontext().getresponse();
            pc.getresponse().setcontenttype("application/json");
            writeOutput(serializeJSON(arguments.value,arguments.serializeQueryByColumns));
            abort;
    }

    /**
    * @output   true
    * @hint     Minifies the template source by using the htmlcompressor Java Library (https://code.google.com/p/htmlcompressor/)
    */
    private string function removeWhitespaceFromHtml(required string o_html){
        local.html = CreateObject("java","com.googlecode.htmlcompressor.compressor.HtmlCompressor").init();
        local.html.setCompressCss(true);               //compress inline css 
        local.html.setCompressJavaScript(true);        //compress inline javascript
        return local.html.compress(arguments.o_html);
    }

    /**
    * @output   false
    * @hint     Returns a string with the cache buster applied. Also handles changing the type of file or image path if 
    *           the minifiedAssets or optimizedImaged application variables exists and are set to true
    */
    public string function cacheBuster(
        required string file, 
        string fullcss      =".full.", 
        string mincss       =".full.", 
        string imgsrc       = "src/", 
        string imgopt       = "opt/",
        string extensions   = "js|css|png|jpg|gif"
    ){
        local.file = arguments.file;
        if(structKeyExists(application,"minifiedAssets") && application.minifiedAssets)
            local.file = replace(local.file,arguments.fullcss,arguments.mincss);
        if(structKeyExists(application,"optimizedImages") && application.optimizedImages)
            local.file = replace(local.file,arguments.imgsrc,arguments.imgpath);
        //  use the applicaiton timestamp - set if it does not exists
        if (!structKeyExists(application,"timeStamp"))
            application.timeStamp = now();
        //  set the fileversion variable to be inserted in the string
        //  uses application.timestamp but can be overwritten if request.fileversion exists
        local.fileversion   = structKeyExists(request,"fileversion") ? request.fileversion : dateTimeformat(application.timeStamp,"yyyymmddhhnnss"); 
        try{
            local.ext = listLast(local.file,".");
            if (reFind(arguments.extentions,local.ext)){
                local.file = left(local.file,len(local.file)-len(local.ext)) & local.fileversion & "." & local.ext;
            }
        }catch(Any e){} // ignore error
        return local.file;
    }
    
    /**
    * @output       "false"
    * @hint         "Returns the plural form of the passed in word. Can also pluralize a word based on a value passed to the `count` argument."
    * @text         "String to pluralize."
    * @count        "Pluralization will occur when this value is not `1`."
    * @alternate    "The text to use in the pluralize function." 
    * @returnCount  "Will return `count` prepended to the pluralization when `true` and `count` is not `-1`."
    */
    public string function pluralize(
        required string text,
        numeric count   = -1,
        string  alternate   = "",
        boolean returnCount = false
    ){
        return $singularizeOrPluralize(text:arguments.text, which:"pluralize", count:arguments.count, returnCount:arguments.returnCount,alternate:arguments.alternate);
    }
    
    /**
    *   @output         "false"
    *   @hint           "Returns the singular form of the passed in word."
    *   @text           "String to singularize."
    *   @alternate      "The text to use in the singular function." 
    */
    public string function singularize(
        required string text,
        string  alternate   = ""
    ){
        return $singularizeOrPluralize(text:arguments.text,which:"singularize",alternate:arguments.alternate);
    }
    
    /**
    * @output       "false"
    * @hint         "Returns the plural form of the passed in word. Can also pluralize a word based on a value passed to the `count` argument."
    * @text         "The text to pluralize."
    * @count        "Pluralization will occur when this value is not `1`."
    * @alternate    "The word to use in the pluralize function." 
    * @returnCount  "Will return `count` prepended to the pluralization when `true` and `count` is not `-1`."
    */
    public string function $singularizeOrPluralize(
        required string text,
        required string which,
        numeric count       = -1,
        string  alternate   = "",
        boolean returnCount = true
    ){
        var loc = {};
    
        // by default we pluralize/singularize the entire string
        loc.text = arguments.text;

        // when count is 1 we don't need to pluralize at all so just set the return value to the input string
        loc.returnValue = loc.text;

        if (arguments.count != 1)
        {

            if (REFind("[A-Z]", loc.text))
            {
                // only pluralize/singularize the last part of a camelCased variable (e.g. in "websiteStatusUpdate" we only change the "update" part)
                // also set a variable with the unchanged part of the string (to be prepended before returning final result)
                loc.upperCasePos = REFind("[A-Z]", Reverse(loc.text));
                loc.prepend = Mid(loc.text, 1, Len(loc.text)-loc.upperCasePos);
                loc.text = Reverse(Mid(Reverse(loc.text), 1, loc.upperCasePos));
            }
            loc.uncountables = "advice,air,blood,deer,equipment,fish,food,furniture,garbage,graffiti,grass,homework,housework,information,knowledge,luggage,mathematics,meat,milk,money,music,pollution,research,rice,sand,series,sheep,soap,software,species,sugar,traffic,transportation,travel,trash,water,feedback";
            loc.irregulars = "child,children,foot,feet,man,men,move,moves,person,people,sex,sexes,tooth,teeth,woman,women";
            if (len(arguments.alternate))
                loc.returnValue = arguments.alternate;
            else if (ListFindNoCase(loc.uncountables, loc.text))
                loc.returnValue = loc.text;
            else if (ListFindNoCase(loc.irregulars, loc.text))
            {
                loc.pos = ListFindNoCase(loc.irregulars, loc.text);
                if (arguments.which == "singularize" && loc.pos MOD 2 == 0)
                    loc.returnValue = ListGetAt(loc.irregulars, loc.pos-1);
                else if (arguments.which == "pluralize" && loc.pos MOD 2 != 0)
                    loc.returnValue = ListGetAt(loc.irregulars, loc.pos+1);
                else
                    loc.returnValue = loc.text;
            }
            else
            {
                if (arguments.which == "pluralize")
                    loc.ruleList = "(quiz)$,\1zes,^(ox)$,\1en,([m|l])ouse$,\1ice,(matr|vert|ind)ix|ex$,\1ices,(x|ch|ss|sh)$,\1es,([^aeiouy]|qu)y$,\1ies,(hive)$,\1s,(?:([^f])fe|([lr])f)$,\1\2ves,sis$,ses,([ti])um$,\1a,(buffal|tomat|potat|volcan|her)o$,\1oes,(bu)s$,\1ses,(alias|status)$,\1es,(octop|vir)us$,\1i,(ax|test)is$,\1es,s$,s,$,s";
                else if (arguments.which == "singularize")
                    loc.ruleList = "(quiz)zes$,\1,(matr)ices$,\1ix,(vert|ind)ices$,\1ex,^(ox)en,\1,(alias|status)es$,\1,([octop|vir])i$,\1us,(cris|ax|test)es$,\1is,(shoe)s$,\1,(o)es$,\1,(bus)es$,\1,([m|l])ice$,\1ouse,(x|ch|ss|sh)es$,\1,(m)ovies$,\1ovie,(s)eries$,\1eries,([^aeiouy]|qu)ies$,\1y,([lr])ves$,\1f,(tive)s$,\1,(hive)s$,\1,([^f])ves$,\1fe,(^analy)ses$,\1sis,((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$,\1\2sis,([ti])a$,\1um,(n)ews$,\1ews,(.*)?ss$,\1ss,s$,#Chr(7)#";
                loc.rules = ArrayNew(2);
                loc.count = 1;
                loc.iEnd = ListLen(loc.ruleList);
                for (loc.i=1; loc.i <= loc.iEnd; loc.i=loc.i+2)
                {
                    loc.rules[loc.count][1] = ListGetAt(loc.ruleList, loc.i);
                    loc.rules[loc.count][2] = ListGetAt(loc.ruleList, loc.i+1);
                    loc.count = loc.count + 1;
                }
                loc.iEnd = ArrayLen(loc.rules);
                for (loc.i=1; loc.i <= loc.iEnd; loc.i++)
                {
                    if(REFindNoCase(loc.rules[loc.i][1], loc.text))
                    {
                        loc.returnValue = REReplaceNoCase(loc.text, loc.rules[loc.i][1], loc.rules[loc.i][2]);
                        break;
                    }
                }
                loc.returnValue = Replace(loc.returnValue, Chr(7), "", "all");
            }

            // this was a camelCased string and we need to prepend the unchanged part to the result
            if (StructKeyExists(loc, "prepend"))
                loc.returnValue = loc.prepend & loc.returnValue;

        }

        // return the count number in the string (e.g. "5 sites" instead of just "sites")
        if (arguments.returnCount && arguments.count != -1)
            loc.returnValue = LSNumberFormat(arguments.count) & " " & loc.returnValue;  
            
        return loc.returnValue;
    }
}