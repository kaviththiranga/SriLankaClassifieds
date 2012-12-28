<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome to SLClassifieds - OnLine</title>
		
		<spring:url value="/resources/styles/style.css" var="sitemaincssUrl" />	
		<spring:url value="/resources/bootstrap/css/bootstrap.css" var="bootstrapUrl" />
		<spring:url value="/resources/bootstrap/js/bootstrap.js" var="bootstrapJsUrl" />
		<spring:url value="/resources/jquery-1.8.3.min.js" var="JQueryUrl" />
		<spring:url value="/resources/styles/notifications.css" var="notificssUrl" />
		<link href="${sitemaincssUrl}" rel="stylesheet"/>
		<link href="${bootstrapUrl}" rel="stylesheet"/>
		<link href="${notificssUrl}" rel="stylesheet"/>
		<script type="text/javascript" src="${JQueryUrl}"></script>
		<script type="text/javascript" src="${bootstrapJsUrl}"></script>
		<script type="text/javascript">
				window.onload = function()
		        {		
					$('#msgmodel').modal('show')
		        };
		</script>
		
	</head>
	<body>
		<div class="container" style="padding-top: 50px;">
			
			<div class="header">
				<div class="row" style="padding-bottom: 5px;" >
					<div class="span6" style="text-align: left;" >
						<img id="logo" alt="SLClassifieds Logo" src="<spring:url value="/resources/images/logo.png"/>"/>
					</div>
					<div class="span6" style="text-align: right;" >
					    <security:authorize access="isAuthenticated()">
					    
					    <div class="dropdown">
					    logged in as 
							<div class="btn-group">
								
								<a href="profile"><button class="btn"><security:authentication property="principal.username" /></button></a>
								<button class="btn dropdown-toggle" data-toggle="dropdown">
									<span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu" aria-labelledby="dropdownMenu">
									<li><a href="profile/edit">settings</a></li>
						        	<li><a href="profile">profile</a></li>	
						        	<li class="divider"></li>			        
						        	<li><a href="j_spring_security_logout">logout</a></li>
								</ul>
							</div>
						</div>
					</security:authorize>
					
					    <security:authorize access="! isAuthenticated()">
					        <a href="login" data-toggle="modal" data-target="#loginFormModel">Sign In</a><br>
				        	<div id="registerNow" >
								<a href="register">
								<img src="resources/images/RegisterNow.gif" alt="Register Now" />
								</a>
							</div>
					    </security:authorize>			
					</div>
				</div>
			</div>
		<div class="navbar" style="margin-bottom: 0px;padding-bottom: 0px;">
			<div class="navbar-inner">
				<div class="container">
					<a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse"> 
						<span class="icon-bar"></span> 
						<span class="icon-bar"></span> 
						<span class="icon-bar"></span>
					</a> 
					<a class="brand" href="#">
							<img src="/images/w3r.png"	width="111" height="30" alt="SL Classifieds" />
					</a>
					<div class="nav-collapse">
						<ul class="nav">
							<li><a href="<spring:url value="/home"/>">Home</a></li>
							<li><a href="<spring:url value="/register"/>">Register</a></li>
							<li><a href="<spring:url value="/profile"/>">Profile</a></li>
							    
						</ul>
						<form class="navbar-search pull-right" method="get" action="/search">
							    	<input type="text" class="search-query" placeholder="Search">
						</form>
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
		<div class="container">
			<%@ include file="/WEB-INF/views/includes/loginIFrame.jsp" %>	
			<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	
