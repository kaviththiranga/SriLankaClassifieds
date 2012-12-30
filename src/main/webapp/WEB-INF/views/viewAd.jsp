
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li><a href="<spring:url value="/ads"/>">ads</a> <span class="divider">/</span></li>
	    <li class="active">view Ad id="${ad.id}"</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	

<h1>${ad.title }<h1>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>