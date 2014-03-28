<cfscript>
    request.layout  = false;
    request.nodebug = true;
</cfscript>
<cfcontent reset="true" type="text/cache-manifest">CACHE MANIFEST
# <cfoutput>#dateTimeFormat(application.timestamp,"mmddyyyy-hhnnss")#</cfoutput>

# Explicitly cached "master entries".
CACHE:
<cfoutput>
## NETWORK FILES
//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css
//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css
//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js
//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js
//netdna.bootstrapcdn.com/bootstrap/3.1.1/fonts/glyphicons-halflings-regular.woff

## LOCAL FILES
#request.base#includes/css/#cacheBuster('styles.full.css')##chr(13)#
#request.base#includes/css/#cacheBuster('dashboard.full.css')##chr(13)#
#request.base#includes/js/#cacheBuster('dashboard.full.js')##chr(13)#

## IMAGES
<cfloop from="1" to="5" index="i">
#request.base#includes/img/#cacheBuster('src/slide#i#.jpg')##chr(13)#
</cfloop>
<cfloop from="1" to="3" index="i">
#request.base#includes/img/#cacheBuster('src/round#i#.jpg')##chr(13)#
#request.base#includes/img/#cacheBuster('src/feat#i#.jpg')##chr(13)#
</cfloop>
</cfoutput>


# Resources that require the user to be online.
NETWORK:
*

# offline.html will be displayed if the user is offline
FALLBACK:
# offline.html