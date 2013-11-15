<!DOCTYPE html>
<html>
  <head>
    <title>memoi.se</title>
    <link rel="stylesheet" type="text/css" href="static/bootstrap.min.css">
    <link rel="icon" type="image/png" href="/static/favicon.png">
  </head>
  <body>
    <div class="container-fluid">
      <div class="navbar navbar-inverse">
        <div class="navbar-inner">
          <a class="brand" href="/">memoi.se</a>
          <ul class="nav">
            <li><a href="https://hackage.haskell.org/package/memoise">Hackage</a></li>
            <li><a href="https://github.com/ryantrinkle/memoise">GitHub</a></li>
            <li><a href="#">Tutorial</a></li>
          </ul>
        </div>
      </div>
      <div class="hero-unit">
        <h1>memoi.se</h1>
        <p>The world's laziest hyperlink shortener</p>
        <form action="/" class="form-inline" method="post">
          <input main-textbox type="text" name="url" autofocus="autofocus" placeholder="Enter URL">
          <input type="submit" class="btn btn-primary" value="Submit">
        </form>
      </div>
      <div class="row-fluid">
        <p class="lead span8 offset2">memoi.se is implemented in <a href="http://haskell.org">Haskell</a> using the <a href="http://snapframework.com/">Snap Framework</a>. It's part of a <a href="#">tutorial</a> designed to help you create your own Haskell web apps.</p>
      </div>
      <div class="navbar navbar-fixed-bottom container-fluid">
        <div class="navbar-inner">
          <a class="brand" style="padding-left:38px;"><img src="static/logo.svg"></a>
          <ul class="nav pull-right">
            <li class=""><a href="http://opensource.org/licenses/BSD-3-Clause">Available under BSD3 License</a></li>
          </ul>
        </div>
      </div>
    </div>
  </body>
</html>
