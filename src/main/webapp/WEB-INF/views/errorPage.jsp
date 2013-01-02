<%@ page isErrorPage="true" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li class="active">error</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	

<div class="alert alert-error" style="margin-left: 30px;margin-right: 30px;">
		<a class="close" data-dismiss="alert">×</a>
		<p><i class="icon-info-sign" style="margin-right: 5px;"></i> 
	    Ooops! SOmething wrong happened in server. <br>
		${pageContext.exception.message}</p>
</div>



<%@ include file="/WEB-INF/views/includes/footer.jsp" %>