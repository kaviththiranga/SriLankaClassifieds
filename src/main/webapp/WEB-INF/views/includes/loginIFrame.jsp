<div id="loginFormModel" class="modal hide fade">
	<div class="modal-header">					
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4>Log in to slclassifieds.lk</h4>
	</div>
	<form name="f" class="form-horizontal" style="margin-bottom: 0px;" action="<spring:url value="/j_spring_security_check" />" method="POST">
		<div class="modal-body">
			
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
							
		</div>
		<div class="modal-footer" >					
				<button type="submit" class="btn btn-primary">Login</button>
				<button data-dismiss="modal" class="btn btn-warning">Cancel</button>
		</div>
		</fieldset>	 
	</form>
</div>