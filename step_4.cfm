<cfoutput>
<!DOCTYPE html>
<html lang="en" manifest="#request.base#app.appcache">
  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>#application.title#</title>
    <link rel="icon" href="#request.base#favicon.ico" type="image/x-icon"/>
	<link rel="shortcut icon" href="#request.base#favicon.ico" type="image/x-icon"/>
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap-theme.min.css">
    <link rel="stylesheet" href="#request.base#includes/css/#cacheBuster('styles.full.css')#">
  </head>
  <body>

<!-- NAVBAR
================================================== -->
    <div class="navbar-wrapper">
      <div class="container">

        <div class="navbar navbar-default navbar-static-top" role="navigation">
          <div class="container">
            <div class="navbar-header">
              <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
              </button>
              <a class="navbar-brand" href="##">Project name</a>
            </div>
            <div class="navbar-collapse collapse">
              <ul class="nav navbar-nav">
                <li class="active"><a href="##">Home</a></li>
                <li><a href="##about">About</a></li>
                <li><a href="##contact">Contact</a></li>
                <li class="dropdown">
                  <a href="##" class="dropdown-toggle" data-toggle="dropdown">Dropdown <b class="caret"></b></a>
                  <ul class="dropdown-menu">
                    <li><a href="##">Action</a></li>
                    <li><a href="##">Another action</a></li>
                    <li><a href="##">Something else here</a></li>
                    <li class="divider"></li>
                    <li class="dropdown-header">Nav header</li>
                    <li><a href="##">Separated link</a></li>
                    <li><a href="##">One more separated link</a></li>
                  </ul>
                </li>
              </ul>
            </div>
          </div>
        </div>

      </div>
    </div>

    <!-- Carousel
    ================================================== -->
    <div id="myCarousel" class="carousel slide" data-ride="carousel">
      <!-- Indicators -->
      <ol class="carousel-indicators">
        <cfloop from="0" to="4" index="i">
          <li data-target="##myCarousel" data-slide-to="#i#" class="#!compare(i,0) ? 'active' : ''#"></li>
        </cfloop>
      </ol>
      <div class="carousel-inner">
        <cfloop from="1" to="5" index="i">
          <div class="item item_#i# #!compare(i,1) ? 'active' : ''#">
            <img src="#request.base#includes/img/#cacheBuster('src/slide#i#.jpg')#" width="900" height="500" alt="First slide">
            <div class="container">
              <div class="carousel-caption">
                <h1>Example Headline #i#</h1>
                <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Voluptatem, saepe, sapiente consequatur maxime error obcaecati non molestias ea aliquam nulla nobis adipisci id officia. Maiores, quo quis magnam ducimus earum.</p>
                <p><a class="btn btn-lg btn-primary" href="##" role="button">Learn More</a></p>
              </div>
            </div>
          </div>
        </cfloop>
      </div>
      
      <a class="left carousel-control" href="##myCarousel" data-slide="prev"><span class="glyphicon glyphicon-chevron-left"></span></a>
      <a class="right carousel-control" href="##myCarousel" data-slide="next"><span class="glyphicon glyphicon-chevron-right"></span></a>
    </div><!-- /.carousel -->

    <!-- Marketing messaging and featurettes
    ================================================== -->
    <!-- Wrap the rest of the page in another container to center all the content. -->

    <div class="container marketing">

      <div class="alert alert-success alert-block text-center" style="margin-top:-3em;">
          I was created on #DateTimeFormat(now(),"mm/dd/yyyy hh:nn:ss aa")#
      </div>

      <!-- Three columns of< text below the carousel -->
      <div class="row">
        <div class="col-lg-4">
          <img class="img-circle" src="#request.base#includes/img/#cacheBuster('src/round1.jpg')#" width="140" height="140" alt="Generic placeholder image">
          <h2>Heading</h2>
          <p>Donec sed odio dui. Etiam porta sem malesuada magna mollis euismod. Nullam id dolor id nibh ultricies vehicula ut id elit. Morbi leo risus, porta ac consectetur ac, vestibulum at eros. Praesent commodo cursus magna.</p>
          <p><a class="btn btn-default" href="##" role="button">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
          <img class="img-circle" src="#request.base#includes/img/#cacheBuster('src/round2.jpg')#" width="140" height="140" alt="Generic placeholder image">
          <h2>Heading</h2>
          <p>Duis mollis, est non commodo luctus, nisi erat porttitor ligula, eget lacinia odio sem nec elit. Cras mattis consectetur purus sit amet fermentum. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh.</p>
          <p><a class="btn btn-default" href="##" role="button">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
        <div class="col-lg-4">
          <img class="img-circle" src="#request.base#includes/img/#cacheBuster('src/round3.jpg')#" width="140" height="140" alt="Generic placeholder image">
          <h2>Heading</h2>
          <p>Donec sed odio dui. Cras justo odio, dapibus ac facilisis in, egestas eget quam. Vestibulum id ligula porta felis euismod semper. Fusce dapibus, tellus ac cursus commodo, tortor mauris condimentum nibh, ut fermentum massa justo sit amet risus.</p>
          <p><a class="btn btn-default" href="##" role="button">View details &raquo;</a></p>
        </div><!-- /.col-lg-4 -->
      </div><!-- /.row -->
      
      <!-- START THE FEATURETTES -->
      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">First featurette heading. <span class="text-muted">It'll blow your mind.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive img-rounded" src="#request.base#includes/img/#cacheBuster('src/feat1.jpg')#" width="500" height="500" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-5">
          <img class="featurette-image img-responsive img-rounded" src="#request.base#includes/img/#cacheBuster('src/feat2.jpg')#" width="500" height="500" alt="Generic placeholder image">
        </div>
        <div class="col-md-7">
          <h2 class="featurette-heading">Oh yeah, it's that good. <span class="text-muted">See for yourself.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
      </div>

      <hr class="featurette-divider">

      <div class="row featurette">
        <div class="col-md-7">
          <h2 class="featurette-heading">And lastly, this one. <span class="text-muted">Checkmate.</span></h2>
          <p class="lead">Donec ullamcorper nulla non metus auctor fringilla. Vestibulum id ligula porta felis euismod semper. Praesent commodo cursus magna, vel scelerisque nisl consectetur. Fusce dapibus, tellus ac cursus commodo.</p>
        </div>
        <div class="col-md-5">
          <img class="featurette-image img-responsive img-rounded" src="#request.base#includes/img/#cacheBuster('src/feat3.jpg')#" width="500" height="500" alt="Generic placeholder image">
        </div>
      </div>

      <hr class="featurette-divider">
      <!-- /END THE FEATURETTES -->

      <!-- FOOTER -->
      <footer>
        <p class="pull-right"><a href="##">Back to top</a></p>
        <p>&copy; 2014 Company, Inc. &middot; <a href="##">Privacy</a> &middot; <a href="##">Terms</a></p>
      </footer>

    </div><!-- /.container -->

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="//ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
    <script src="//netdna.bootstrapcdn.com/bootstrap/3.1.1/js/bootstrap.min.js"></script>
  </body>
</html>
</cfoutput>