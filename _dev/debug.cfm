<!---
*************************************************** 
*	THIS SECTION IS USED TO DUMP VARIABLES REQUESTED
*	ENABLE AND DISABLE DEBUGGING INFORMATION 
*	AS WELL AS ADDING IP TO DEBBUGER
*
*	IMPORTANT - SECTION MUST BE REMOVED BEFORE PLACING LIVE!
*
*	THIS IS A DEVELOPMENT ONLY SECTION
*************************************************** 
--->    
<cfscript>
    param name="url.expand" default="true";
    param name="url.top"    default="9999";
    // save vars not found
    local.novar = [];
    local.str   = "";
    // loop if exists
    if ((
            (structKeyExists(application,"allowDebug") && application.allowDebug) 
            || structKeyExists(url,"forcedump")
        ) && structKeyExists(url,"dump") && len(url.dump)
        ){
    
        // output variables requested
        for(local.key in url.dump){
            // try to dump request and if fails append to nonvar
            try{
                savecontent variable="local.str"{
                    writeOutput(local.str);
                    writeDump(var:evaluate(local.key),label:" REQUESTED OUTPUT FOR VAR - #local.key#",expand:url.expand,top:val(url.top));
                }   
            }
            catch(Any e){
                // if the call fails lets add it to our nonvars
                arrayAppend(local.novar,local.key);                 
            }
        }   
        // output if we have something to show
        if (len(local.str))
            writeOutput("<div class=""debug-var"">" & local.str & "</div>");    
        
        // output variables not found
        if(arrayLen(local.novar)){
            local.str = "<div class=""debug-novar""><p>The following variables requested do not exist;</p><ul>";
            for(local.key in local.novar){
                local.str &= "<li>" & local.key & "</li>";
            }
            local.str &= "</ul></div>";
            writeOutput(local.str); 
        }
        
    }
</cfscript>