<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li class="active">ads</li>
	    
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	

<c:forEach var="ad" items="${ads}" varStatus ="status">
	<slclassifieds:DisplayAdSummary  ad="${ad}"/>

</c:forEach>

<h1 id="comments"></h1>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>