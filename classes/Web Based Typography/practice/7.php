<!doctype html>
<html lang="en" class="no-js">
<head>
  <meta charset="utf-8">

  <!-- www.phpied.com/conditional-comments-block-downloads/ -->
  <!--[if IE]><![endif]-->

  <!-- Always force latest IE rendering engine (even in intranet) & Chrome Frame 
       Remove this if you use the .htaccess -->
  <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">

  <title></title>
  <meta name="description" content="">
  <meta name="author" content="">

  <!--  Mobile Viewport Fix
        j.mp/mobileviewport & davidbcalhoun.com/2010/viewport-metatag 
  device-width : Occupy full width of the screen in its current orientation
  initial-scale = 1.0 retains dimensions instead of zooming out if page height > device height
  maximum-scale = 1.0 retains dimensions instead of zooming in if page width < device width
  -->
  <meta name="viewport" content="width=device-width; initial-scale=1.0; maximum-scale=1.0;">


  <!-- Place favicon.ico and apple-touch-icon.png in the root of your domain and delete these references -->
  <link rel="shortcut icon" href="../favicon.ico">
  <link rel="apple-touch-icon" href="../apple-touch-icon.png">


  <!-- CSS : implied media="all" -->
  <link rel="stylesheet" href="../css/style.css?v=1">

  <!-- For the less-enabled mobile browsers like Opera Mini -->
  <link rel="stylesheet" media="handheld" href="../css/handheld.css?v=1">

  <!-- Google Font API Fonts -->
  <link href='http://fonts.googleapis.com/css?family=Vollkorn&subset=latin' rel='stylesheet' type='text/css'>

 
  <!-- All JavaScript at the bottom, except for Modernizr which enables HTML5 elements & feature detects -->
  <script src="../js/modernizr-1.5.min.js"></script>

  <script src="../js/Hyphenator.js"></script>
  <script>
            Hyphenator.run();
  </script>

</head>

<!-- paulirish.com/2008/conditional-stylesheets-vs-css-hacks-answer-neither/ -->

<!--[if lt IE 7 ]> <body class="ie6"> <![endif]-->
<!--[if IE 7 ]>    <body class="ie7"> <![endif]-->
<!--[if IE 8 ]>    <body class="ie8"> <![endif]-->
<!--[if IE 9 ]>    <body class="ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <body> <!--<![endif]-->

  <header id="header">
	<div class="container hyphenate">
		<h1 id="goog">Web Typography for Lawyers (7)</h1>
		<img src="../images/leaf.png" alt="~" class="leaf" />
		<h2>A class supplemental on how typography on the internet works, how it's changing, and how to keep up with the changes.</h2>
		<img src="../images/leaf2.png" alt="~" class="leaf2" />
		<p><span class="large">I</span>n October of 2009, the popular website <a href="http://www.boingboing.net">BoingBoing</a> (2 million unique visitors per month) released a major website redesign they’d been developing for months.  The redesign used what was then, and is still largely, cutting edge CSS techniques; specifically, @font-face. A few days later, the @font-face portion of the redesign was taken down because of issues it was causing<sup><a name="id394062" href="#ftn.id394062">[1]</a></sup>. BoingBoing had developed their website using newer computers, with newer browsers, and -- this is important -- newer web standards. It almost seems like website tests on older technology were largely overlooked.</p>
		<a href="../images/boingboinglg.png"><img src="../images/boingboingsm.png" "Boing Boing Redesign" class="image alignright" /></a>
		<p>In combination with these factors, another problem was added: BoingBoing's original font choice had been a licensed font, which they were denied use of.  The font they ended up building the site with was a free font with some pretty clear flaws for many of BoingBoing's visitors.</p>
		<p>So what does this have to do with web typography for lawyers?</p>
		<p>The slow introduction of a new web standard, CSS3, into a web developer's daily toolkit is driving innovation in the way typography is used on the web.  This is really an exciting time for web designers and font foundries on the internet.  Yet, CSS3, @font-face, and the display of non-system standard typography online is <em>still</em> not an exact science.  How web designers choose to display non-standard fonts on a website largely depends on their knowledge of different web technologies, cross-browser compatibility, and client burden considerations.  That's why the BoingBoing story is important.  Many of the techniques we see being used, like sIFR, or cuf&oacute;n, are largely a product of web designers trying to find the  best way to display fonts on their websites.</p>
		<p>The other side of this story is that there are many web designers out there, both amateur and professional, who are breaking font EULA's (sometimes unwittingly) to display the font they want on their website.  How we determine if any given website is doing this is as much of as an exact science as implementing @font-face.  Since there are so many technologies being used to display fonts, a person looking to determine if a font EULA is being broken on a website needs the proper knowledge and tools; even then, it can be hard or impossible at times to determine what font is being used.</p>
    </div>
  </header>
    
  <div id="main">
	<div class="container">
		<ul>
			<div class="alignleft">
				<li class="box shadow">
					<h2>Methods</h2>
					<ul>
						<li><a href="http://en.wikipedia.org/wiki/Adobe_Flash">Flash</a></li>
						<li><a href="http://en.wikipedia.org/wiki/JavaScript">Javascript</a></li>
						<li><a href="http://en.wikipedia.org/wiki/PHP">PHP</a></li>
						<li><a href="http://www.font-face.com/#lime_content">@font-face</a></li>
					</ul>
				</li>
				<li class="box shadow">
					<h2>Demonstration</h2>
					<ul>
						<li><a href="http://www.mikeindustries.com/blog/files/sifr/2.0/">sIFR 2</a></li>
						<li><a href="http://dev.novemberborn.net/sifr3/beta2/demo/">sIFR 3</a></li>
						<li><a href="http://www.acidsmile.co.uk/">cuf&oacute;n</a></li>
						<li><a href="http://www.artypapers.com/csshelppile/pcdtr/">P+C DTR</a></li>
						<li><a href="http://facelift.mawhorter.net/">FLIR</a></li>
						<li><a href="http://www.whaleofadive.com/misc/siir/about.php">SIIR</a></li>
						<li><a href="http://typeface.neocracy.org/examples.html">Typeface.js</a></li>
						<li><a href="http://www.shauninman.com/archive/2004/04/23/ifr_revisited_and_revised">IFR</a></li>
						<li><a href="http://css-tricks.com/examples/RethinkingImageReplacement2/">CSS Image Replacement</a></li>
						
						<li><a href="#goog">Google Fonts API</a></li>
						<li>Hosted (<a href="http://typekit.com/">Typekit</a> - <a href="http://design.carsonified.com/typekit/typekit.html">in use</a>, <a href="http://kernest.com/">Kernest</a>)</li>
						<li>User Submitted / Hosted (<a href="http://typefront.com/">Typefront</a>, <a href="http://sifrvault.com/">sifr vault</a>)</li>
					</ul>
				</li>
			</div>
			<div class="alignleft">
				<li class="box shadow">
					<h2>Practice</h2>
					<ul>
						<li><a href="1.php">One</a></li>
						<li><a href="2.php">Two</a></li>
						<li><a href="3.php">Three</a></li>
						<li><a href="4.php">Four</a></li>
						<li><a href="5.php">Five</a></li>
						<li><a href="6.php">Six</a></li>
						<li><a href="7.php">Seven</a></li>
						<li><a href="8.php">Eight</a></li>
						<li><a href="9.php">Nine</a></li>
						<li><a href="10.php">Ten</a></li>
					</ul>
				</li>
			</div>
			<div class="alignleft">
				<li class="box shadow">
					<h2>Tools</h2>
					<ul>
						<li><a href="http://getfirebug.com/">Firebug</a> (for Firefox)</li>
						<li><a href="https://addons.mozilla.org/en-US/firefox/addon/11905/">Firefinder</a> (for Firebug)</li>
						<li><a href="http://new.myfonts.com/WhatTheFont/">What The Font</a></li>
						<li><a href="http://typenav.fontshop.com/">Type Navigator</a></li>
					</ul>
				</li>
				<li class="box shadow">
					<h2>Resources</h2>
					<ul>
						<li><a href="http://www.alistapart.com/">A List Apart</a></li>
						<li><a href="http://blog.typekit.com/">Typekit Blog</a></li>
						<li><a href="http://ilovetypography.com/">I Love Typography</a></li>
						<li><a href="http://www.webtypography.net">Webtypography.net</a></li>
						<li><a href="http://www.smashingmagazine.com/">Smashing Magazine</a></li>
						<li><a href="http://nicewebtype.com/notes/">Nicewebtype Blog</a></li>
						<li><a href="http://typophile.com/forums">Typophile Forums</a></li>
					</ul>
				</li>
			</div>
		</ul>
		<div id="description">
			<h2></h2>
			<p></p>
		</div>
		<div style="clear:both;"></div>
	</div> <!--! end of .container -->
  </div><!-- end #main -->
    
    <footer>
		<small>This website class, and all accompanying materials created by the author, is licensed under the <a href="http://www.opensource.org/licenses/gpl-3.0.html">GPLv3</a>  The author, <a href="http://www.jaymargalus.com">Jay Margalus</a>, can be reached <a href="mailto:hi@poplicola.com">here</a>.</small>
    </footer>


  <!-- Javascript at the bottom for fast page loading -->

  <!-- Grab Google CDN's jQuery. fall back to local if necessary -->
  <script src="http://ajax.googleapis.com/ajax/libs/jquery/1.4.2/jquery.min.js"></script>
  <script>!window.jQuery && document.write('<script src="../js/jquery-1.4.2.min.js"><\/script>')</script>


  <script src="../js/plugins.js?v=1"></script>
  <script src="../js/script.js?v=1"></script>

  <!--[if lt IE 7 ]>
    <script src="js/dd_belatedpng.js?v=1"></script>
  <![endif]-->


  <!-- yui profiler and profileviewer - remove for production -->
  <script src="../js/profiling/yahoo-profiling.min.js?v=1"></script>
  <script src="../js/profiling/config.js?v=1"></script>
  <!-- end profiling code -->


  <!-- asynchronous google analytics: mathiasbynens.be/notes/async-analytics-snippet 
       change the UA-XXXXX-X to be your site's ID -->
  <script>
   var _gaq = [['_setAccount', 'UA-XXXXX-X'], ['_trackPageview']];
   (function(d, t) {
    var g = d.createElement(t),
        s = d.getElementsByTagName(t)[0];
    g.async = true;
    g.src = '//www.google-analytics.com/ga.js';
    s.parentNode.insertBefore(g, s);
   })(document, 'script');
  </script>
  
</body>
</html>