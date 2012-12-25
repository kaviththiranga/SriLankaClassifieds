

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<h1>Login to SLClassifieds</h1>
	<c:if test="${not empty error}">
		<div class="alerts">
			<div class="alert-message error">
				Your login attempt was not successful, try again.<br /> Caused :
				${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
			</div>
		</div>
	</c:if>
	
 <div id=leftBody>
	 <div >
		<form name="f" class="form-horizontal" action="<c:url value='j_spring_security_check' />" method="POST">
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
				<div class="form-actions">
					<button type="submit" class="btn btn-primary">Login</button>
					<button type="reset" class="btn">Cancel</button>
				</div>
			</fieldset>	 
		</form>
	</div>
</div>	
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>