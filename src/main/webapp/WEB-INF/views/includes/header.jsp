<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome to SLClassifieds - OnLine</title>
		
		<spring:url value="/resources/styles/style.css" var="sitemaincssUrl" />	
		<spring:url value="/resources/bootstrap/css/bootstrap.css" var="bootstrapUrl" />
		<spring:url value="/resources/styles/notifications.css" var="notificssUrl" />
		<link href="${sitemaincssUrl}" rel="stylesheet"/>
		<link href="${bootstrapUrl}" rel="stylesheet"/>
		<link href="${notificssUrl}" rel="stylesheet"/>
		
	</head>
	<body>
		<div class="container" style="padding-top: 50px;">
			
			<div class="header">
				<div class="container" >
					<div id="leftHeader" >
						<img id="logo" alt="SLClassifieds Logo" />
					</div>
					<div id="rightHeader" >			
	
					    <security:authorize access="isAuthenticated()">
					    logged in as <a href="profile"><security:authentication property="principal.username" /></a>  
					    <br>
					        <a class="textLink" href="profile/edit">settings</a> | 
					        <a class="textLink" href="profile">profile</a> | 				        
					        <a class="textLink" href="j_spring_security_logout">logout</a>
					    <br>
					    </security:authorize>
					
					    <security:authorize access="! isAuthenticated()">
					        <a href="login">Sign In</a><br>
					    </security:authorize>			
					</div>
				</div>
			</div>
		<div class="navbar">
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
					</div>
					<!--/.nav-collapse -->
				</div>
			</div>
		</div>
		<div class="container" >
			
			<div class="alerts">
				<div class="${mainmsgclass}">
					<p>${mainmsg}</p>
				</div>
			</div>