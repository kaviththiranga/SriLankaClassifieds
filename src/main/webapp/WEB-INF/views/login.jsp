

<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li class="active">Login</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	
<div class="container" >
	
	<div class="span3">
	</div>
	<div class="span6">
		<h3 style="text-align: center;">Login to SLClassifieds</h3>
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
	<div class="span3">
	</div>
</div>	
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>