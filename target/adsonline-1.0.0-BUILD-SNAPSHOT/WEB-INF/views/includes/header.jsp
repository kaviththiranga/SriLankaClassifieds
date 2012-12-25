<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Welcome to SLClassifieds - OnLine</title>
		<link rel="stylesheet" type="text/css" href="resources/styles/style.css" />
	</head>
	<body>
		<div id="main" class="clearFix">
			
			<div id="header">
				
				<div id="leftHeader" >
					<img id="logo" alt="SLClassifieds Logo" />
				</div>
				<div id="rightHeader" >			

				    <security:authorize access="isAuthenticated()">
				        logged in as <security:authentication property="principal.username" /> 
				        <a href="profile/edit">settings</a> | <a href="profile">profile</a> | <a href="logout">logout</a>
				    <br><br>
				    </security:authorize>
				
				    <security:authorize access="! isAuthenticated()">
				        <a href="login">Sign In</a><br><br>
				    </security:authorize>			
					
					<input id="SearchBox" type="text" />
				</div>
			
			</div>
			
			<div id="body" class="clearFix" >
			<h1 class="${mainmsgclass}">${mainmsg}</h1>