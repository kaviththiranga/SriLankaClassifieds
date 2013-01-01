
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li><a href="<spring:url value="/ads"/>">ads</a> <span class="divider">/</span></li>
	    <li class="active">view Ad id=${ad.adId}</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	

<h1>${ad.title}<h1>
<h1>${ad.user.name}<h1>
<h1>${ad.category.catName}<h1>



<%@ include file="/WEB-INF/views/includes/footer.jsp" %>