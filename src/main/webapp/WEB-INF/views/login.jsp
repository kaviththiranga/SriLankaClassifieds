

<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li class="active">Login</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	
<div class="container" >
	<div class="span1">
	</div>
	<div class="span6">
		<h4 style="text-align: center;">You need to login to view this resource.</h4><br>
		 <div >
			<form name="f" class="form-horizontal" action="<c:url value='/j_spring_security_check' />" method="POST">
		 		<fieldset>
					<div class="control-group"  id="j_username" >
						<label class="control-label">Username</label>
						<div class="controls">
							<input type="text" id="j_username" name="j_username" />
						</div>
					</div>
					<div class="control-group" id="j_password" >
						<label class="control-label">Password</label>
						<div class="controls">
							<input type="password" id="j_password" name="j_password" />
						</div>
					</div>
					<div class="form-actions" style="background-color: transparent;border: 0;">
						
						<button type="submit" class="btn btn-primary">Login</button>
						<button type="reset" class="btn btn-warning">Cancel</button>
					</div>
				</fieldset>	 
			</form>
		</div>
	</div>
	<div class="span3 well">
		<h4>Problem with login?</h4>
		<p>Try following options.</p>
		<spring:url value="/profile/passwordReset" var="resetUrl"/>
		<a href="${resetUrl}" class="btn btn-primary">Reset Password</a>
		<h4>Not a member?</h4>
		<p>Create a free account.</p>
		<a href="<spring:url value="/register"/>" 
				class="btn btn-success">Sign up NOW</a>
	</div>
</div>	
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>