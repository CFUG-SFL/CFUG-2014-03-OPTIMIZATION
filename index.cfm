<cfoutput>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>#application.title#</title>
    <link rel="icon" href="#request.base#favicon.ico" type="image/x-icon"/>
    <link rel="shortcut icon" href="#request.base#favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
    <link rel="stylesheet" href="#request.base#includes/css/styles.full.css">
  </head>
  <body>
  <div class="container">
    <h1 class="page-header">South Florida ColdFusion User Group - March 2014 Meeting</h1>
    <ul>
        <li><a href="./step_1/">Step 1 File</a><br />This is the file using none of the features discussed, such as cache busting, minification and server caching.</li>
        <li><a href="./step_2/">Step 2 File</a><br />This is the file only using the minification feature</li>
        <li><a href="./step_3/">Step 3 File</a><br />This is the file using all the features, minification, cache busting, optimized assets (if set to tru in app vars) and server side caching.</li>
        <li><a href="./step_4/">Step 4 File</a><br />Same as step 3 except not using server side caching, instead using appcache to store localy and work competely without the need of being online and fetching the data from the server</li>
        <li><a href="./cacheadmin/">Cache Admin</a><br />Simple Cache Admin</li>
    </ul>
    <hr />
    <div class="text-center">
      <div class="btn-group">
        <a href="http://www.cfug-sfl.org/" target="_blank" class="btn btn-success"><i class="fa fa-group"></i> Join our group</a>
        <a href="https://www.facebook.com/cfugsfl" target="_blank" class="btn btn-primary"><i class="fa fa-facebook"></i> Like us on Facebook</a>
        <a href="https://twitter.com/sfcfug" target="_blank" class="btn btn-info"><i class="fa fa-twitter"></i> Follow us on Twitter</a>
      </div>
    </div>
  </div>
  </body>
</html>
</cfoutput>