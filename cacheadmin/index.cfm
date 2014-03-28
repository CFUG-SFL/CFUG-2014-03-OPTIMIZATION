<cfscript>
    // create cache region
    if(!cacheRegionExists(cgi.server_name))
        cacheRegionNew(cgi.server_name);

    // handle posts
    if (isAjax() && !structIsEmpty(form)){
        param name="form.act" default="remove_all";
        switch (form.act){
                case "remove":
                    // remove cached item
                    cacheRemove(form.id,true,cgi.server_name,false);
                break;

                default:
                    // remove all cached items
                    cacheRemoveAll(cgi.server_name);
                break;
        }        
        // update response
        rtn= {"success" : true};
        // return response
        renderJSON(rtn);
    }
    // get cache items
    local.cachekeys = cacheGetAllIds(cgi.server_name);
</cfscript>
<cfoutput>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>#application.title# : CACHE ADMIN</title>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
    <link rel="icon" href="#request.base#favicon.ico" type="image/x-icon"/>
    <link rel="shortcut icon" href="#request.base#favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="../includes/css/#cacheBuster('dashboard.full.css')#">
  </head>

  <body id="cache">

    <div class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <span class="navbar-brand">Cache Admin <small>&nbsp; Application Time : #dateTimeFormat(application.timestamp,"mm/dd/yyyy hh:nn:ss tt")#</small></span>
        </div>
        <form class="navbar-form navbar-right" role="search">
        <cfif arrayLen(local.cachekeys)><button class="btn btn-danger" data-role="clear-all"><i class="glyphicon glyphicon-trash"></i> Clear all cached templates</button></cfif>
        <button class="btn btn-success" data-role="reinit"><i class="glyphicon glyphicon-refresh"></i> Re-init Application</button>
        </form>
      </div>
    </div>

    <div class="container-fluid" style="position:relative;">
        <h1 class="page-header">Site Cashed Pages</h1>
        <p>
            Below is a list of cached pages. Pages are cleared from cache when any change occurs on them. 
            If a page is created, deleted, child pages sorted or settings saved the entire cache is cleared in order to make sure the navigation and any settings render properly on next request.
            Below you can choose to clear each page individually or the entire cache.<br />
            <span class="text-muted">* Caching of pages assist in site performance.</span>
        </p>
        <cfif !arrayLen(local.cachekeys)>
            <div class="alert alert-warning text-center">Your cache is currently empty.</div>
        <cfelse>
            <table class="table table-striped" id="cache-list">
            <colgroup>
                <col width="30%" />
                <col width="20%" />
                <col width="20%" />
                <col width="10%" />
                <col width="10%" />
                <col width="10%" />
            </colgroup>
            <thead>
                <tr style="text-transform:uppercase;">
                    <th>ID</th>
                    <th>Created</th>
                    <th>Last Hit</th>
                    <th>Hit Count</th>
                    <th colspan="2">TTL</th>
                </tr>
                <tbody>
                <cfloop array="#local.cachekeys#" index="item">
                <cfset local.data = cacheGetMetaData(item,"",cgi.server_name) />
                <tr>
                    <td>#lcase(item)#</td>
                    <td>#dateTimeFormat(local.data.createdtime,"mm/dd/yyyy hh:nn aa")# EST</td>
                    <td>#dateTimeFormat(local.data.lasthit,"mm/dd/yyyy hh:nn aa")# EST</td>
                    <td>#local.data.hitcount#</td>
                    <td>#pluralize("day",((local.data.timespan/60)/60)/24,"",true)#</td>
                    <td class="text-right"><button data-id="#lcase(item)#" class="btn btn-danger" data-role="clear"><i class="glyphicon glyphicon-trash"></i></button></td>
                </tr>
                </cfloop>
                </tbody>
            </thead>
            </table>
        </cfif>
    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
    <script src="//getbootstrap.com/assets/js/docs.min.js"></script>
    <script src="../includes/js/#cacheBuster('dashboard.full.js')#"></script>
  </body>
</html>
</cfoutput>
