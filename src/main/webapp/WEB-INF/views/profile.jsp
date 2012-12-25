

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<h1>${user.name}</h1>

<% //User uu= (User)request.getAttribute("user"); %>
<% //request.setAttribute("size", uu.getUserRoles().size()); %>

<h1>${size}</h1>

<a href="<c:url value="/j_spring_security_logout" />" > Logout</a>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>