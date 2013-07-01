<!DOCTYPE html>
<!--[if lt IE 7 ]> <html lang="en" class="no-js ie6"> <![endif]-->
<!--[if IE 7 ]>    <html lang="en" class="no-js ie7"> <![endif]-->
<!--[if IE 8 ]>    <html lang="en" class="no-js ie8"> <![endif]-->
<!--[if IE 9 ]>    <html lang="en" class="no-js ie9"> <![endif]-->
<!--[if (gt IE 9)|!(IE)]><!--> <html lang="en" class="no-js"><!--<![endif]-->
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title><g:layoutTitle default="Grails"/></title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="shortcut icon" href="${resource(dir: 'images', file: 'favicon.ico')}" type="image/x-icon">
    <link rel="apple-touch-icon" href="${resource(dir: 'images', file: 'apple-touch-icon.png')}">
    <link rel="apple-touch-icon" sizes="114x114" href="${resource(dir: 'images', file: 'apple-touch-icon-retina.png')}">
    <r:require modules="bootstrap"/>
    <r:layoutResources />
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'main.css')}" type="text/css">   
    <g:layoutHead/>  
</head>
<body>
  <div id="grailsLogo" role="banner" class="row-fluid">
    <div class="span1" style="background-color: black; height: 77px; width: 4px;">
    </div>
    <div class="span3" style="margin-left: 0px;">
      <g:link controller="home">
        <img src="${resource(dir: 'images', file: 'miage_logo.jpg')}" width="100px" style="margin-right: 10px;"/>
        Alumni Miage Sorbonne
      </g:link>
    </div>
    <div class="span5" style="margin: 0px;">
      <ul id="menu">
        <div class="row-fluid">
          <div class="span1" style="background-color: black; height: 77px; width: 4px; margin: 0px;">
          </div>
          <div class="span3" style="margin: 0px;">
            <li class="">
            <g:link controller="home">Annuaire</g:link>
            </li>
          </div>        
          <div class="span1" style="background-color: black; height: 77px; width: 4px; margin: 0px;">
          </div>
          <div class="span3" style="margin: 0px;">
            <li class="">
            <g:link controller="profil">Mon profil</g:link>
            </li>
          </div>
          <div class="span1" style="background-color: black; height: 77px; width: 4px; margin: 0px;">
          </div>
          <div class="span3" style="margin: 0px;">
            <li class="">
            <g:link controller="stats">Statistiques</g:link>
            </li>
          </div>
          <div class="span1" style="background-color: black; height: 77px; width: 4px; margin: 0px;">
          </div>
        </div>
      </ul>
    </div>
  </div> 
  <div class="row-fluid">
    <div class="span12 content">
         <g:layoutBody/>
    </div>
  </div>
  <div class="footer" role="contentinfo"></div>
  <div id="spinner" class="spinner" style="display:none;"><g:message code="spinner.alt" default="Loading&hellip;"/></div>
<g:javascript library="application"/>
<r:layoutResources />
</body>
</html>
