
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li><a href="<spring:url value="/ads"/>">ads</a> <span class="divider">/</span></li>
	    <li class="active">adId=${ad.adId}</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	

<slclassifieds:DisplayAdSummary  ad="${ad}"/>
<slclassifieds:DisplayAdSummary  ad="${ad2}"/>

<img src="<spring:url value="/images?img=Jellyfish.jpg"/>">
<h1 id="comments"></h1>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>