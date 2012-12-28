

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li class="active">Profile</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	


<div class="span2">
	
</div>
<div class="span10">
	<h4>User Profile - ${user.name}</h4>
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>