<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome to SLClassifieds - OnLine</title>
		
		<spring:url value="/resources/styles/style.css" var="sitemaincssUrl" />	
		<spring:url value="/resources/bootstrap/css/bootstrap.css" var="bootstrapUrl" />
		<spring:url value="/resources/bootstrap/css/bootstrap-image-gallery.min.css" var="imgGalleryCssUrl" />
		<spring:url value="/resources/bootstrap/js/bootstrap.js" var="bootstrapJsUrl" />
		<spring:url value="/resources/bootstrap/js/load-image.min.js" var="loadImageJsUrl" />
		<spring:url value="/resources/bootstrap/js/bootstrap-image-gallery.min.js" var="imageGalleryJsUrl" />
		<spring:url value="/resources/jquery-1.8.3.min.js" var="JQueryUrl" />
		<spring:url value="/resources/jQuery.maxlen.js" var="JQueryMaxLenUrl" />		
		<spring:url value="/resources/styles/notifications.css" var="notificssUrl" />
		<spring:url value="/resources/bootstrap/css/font-awesome.min.css" var="fontAwesomeUrl" />
		<link href="${sitemaincssUrl}" rel="stylesheet"/>
		<link href="${bootstrapUrl}" rel="stylesheet"/>
		<link href="${fontAwesomeUrl}" rel="stylesheet"/>
		<link href="${notificssUrl}" rel="stylesheet"/>
		<link href="${imgGalleryCssUrl}" rel="stylesheet"/>
		
		<script type="text/javascript" src="${JQueryUrl}"></script>
		
		<script type="text/javascript" src="${JQueryMaxLenUrl}"></script>
		
		
		
		
		<spring:url value="/" var="root"/>
		<script type="text/javascript"  src="${root}resources/JqueryPlugins/jQueryFileUpload/js/jquery.ui.widget.js"></script>
		<script type="text/javascript"  src="${root}resources/JqueryPlugins/jQueryFileUpload/js/tmpl.min.js"></script>
		<script type="text/javascript" src="${loadImageJsUrl}"></script>
		<script type="text/javascript"  src="${root}resources/JqueryPlugins/jQueryFileUpload/js/canvas-to-blob.min.js"></script>
		<script type="text/javascript" src="${bootstrapJsUrl}"></script>
		<script type="text/javascript" src="${imageGalleryJsUrl}"></script>
		<script type="text/javascript" src="${root}resources/JqueryPlugins/jQueryFileUpload/js/jquery.iframe-transport.js"></script>
		<script type="text/javascript"  src="${root}resources/JqueryPlugins/jQueryFileUpload/js/jquery.fileupload.js"></script>
		
		<script type="text/javascript"  src="${root}resources/JqueryPlugins/jQueryFileUpload/js/jquery.fileupload-fp.js"></script>
		
		<script type="text/javascript"  src="${root}resources/JqueryPlugins/jQueryFileUpload/js/jquery.fileupload-ui.js"></script>		
		<script type="text/javascript"  src="${root}resources/JqueryPlugins/jQueryFileUpload/js/main.js"></script>
		<link rel="stylesheet" href="${root}resources/JqueryPlugins/jQueryFileUpload/css/jquery.fileupload-ui.css">
		 <script type="text/javascript">
				window.onload = function()
		        {		
					$('#msgmodel').modal('show')
		        };
		</script>
	<div id="top"></div>	
	</head>
	<body>
		<div class="container" style="padding-top: 50px;">
			
			<div class="header">
				<div class="row" style="padding-bottom: 5px;" >
					<div class="span6" style="text-align: left;" >
						<a href="<spring:url value="/home"/>">
							<img id="logo" alt="SLClassifieds Logo" src="<spring:url value="/resources/images/logo.png"/>"/>
						</a>
					</div>
					<div class="span6" style="text-align: right;" >
					    <security:authorize access="isAuthenticated()">
					    
					    <div class="dropdown">
					    logged in as 
							<div class="btn-group">
								
								<a href="profile">
									<button class="btn">
										<security:authentication property="principal.username" />
										<i class="icon-user"></i>
									</button>
								</a>
								<button class="btn dropdown-toggle" data-toggle="dropdown">
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
									<li><a href="<spring:url value="/profile/edit"/>"/>
											<i class="icon-wrench" style="margin-right: 2px;"></i>
											edit account
										</a>
									</li>
						        	<li><a href="<spring:url value="/profile"/>">
						        			<i class="icon-user" style="margin-right: 2px;"></i>
						        			profile
						        		</a>
						        	</li>	
						        	<li class="divider"></li>			        
						        	<li><a href="<spring:url value="/j_spring_security_logout"/>">
						        			<i class="icon-arrow-right" style="margin-right: 2px;"></i>
						        			logout
						        		</a>
						        	</li>
								</ul> 
							</div>
						</div>
					</security:authorize>
					
					    <security:authorize access="! isAuthenticated()">
					    	<a rel="tooltip" title="Click here to Register" href="<spring:url value="/register"/>" >register</a><span class="divider"> /</span>
					        <a rel="tooltip" title="Click here to Login" href="login" data-toggle="modal" data-target="#loginFormModel">
					        		login
					        		<i class="icon-user"></i>
					        </a>
					        
				        	<div id="registerNow" >
								<a  href="<spring:url value="/register"/>">
								<img src="<spring:url value="/resources/images/RegisterNow.gif"/>" alt="Register Now" />
								</a>
							</div>
					    </security:authorize>			
					</div>
				</div>
			</div>
		<div class="navbar" style="margin-bottom: 0px;padding-bottom: 0px;">
			<div class="navbar-inner" >
				<div class="container">
					<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> 
						<span class="icon-bar"></span> 
						<span class="icon-bar"></span> 
						<span class="icon-bar"></span>
					</a> 
					<a class="brand" href="#">
							SL Classifieds
					</a>
					<div class="nav-collapse">
						<ul class="nav">
							<li><a href="<spring:url value="/home"/>">Home</a></li>
							<li><a href="<spring:url value="/register"/>">Register</a></li>
							<li><a href="<spring:url value="/ads/new"/>">Post a Ad</a></li>
							<li><a href="<spring:url value="/profile"/>">Profile</a></li>
							
							    
						</ul>
						<!-- <form class="navbar-search pull-right" method="get" action="/search">
							    	<input type="text" class="search-query" placeholder="Search">
						</form>-->
						<form class="form-search navbar-search pull-right">
							<div class="input-append">
								<input type="text" class="span2 search-query">
								<button type="submit" class="btn">Search</button>
							</div>
						</form>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
		<div class="container">
			<%@ include file="/WEB-INF/views/includes/loginIFrame.jsp" %>
			<%@ include file="/WEB-INF/views/includes/imgGallery.jsp" %>		
			
