

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li class="active">Profile</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	

<div class="row">
	<div class="span2">
		<ul class="nav nav-tabs nav-stacked">
	    	<li class="active">
				<a href="<spring:url value="/profile"/>">My Profile</a>
			</li>
			<li><a href="<spring:url value="/profile/edit"/>">Edit My Account</a></li>
			<li><a href="<spring:url value="/j_spring_security_logout"/>">Logout</a></li>
	    </ul>
	</div>
	<div class="span10">
		<div class="well">
			<h4>User Profile - ${user.name}</h4>
		</div>
	</div>
</div>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>