
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li class="active">Register</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	


<div class="row"  >
	<div class="span7" style="padding-left: 20px;">
	
		<h3 style="text-align: center;"> Sign up for a SLClassifieds Account</h3>
		<img id="free" src="<spring:url value="/resources/images/free.gif"/>" alt="Free"/>
		
		<spring:url value="/register" var="registerSubmitUrl"/>
		<spring:url value="/register.json" var="registerJsonUrl" />
		<div id="signupForm" class="span6">
			<form:form id="signupform2" class="form-horizontal" method="POST" action="${registerSubmitUrl}" modelAttribute="user">
				<fieldset>
					<div class="control-group" id="nameCG">						
						<label class="control-label">Name in Full</label>						
						<div class="controls">
							<form:input path="name" />
							<span class="help-inline">
								<form:errors path="name" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="usernameCG">	
						<label class="control-label">Username</label>	
						<div class="controls">
							<form:input path="username" />
							<span class="help-inline">
								<form:errors path="username" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="contactNoCG">
						<label class="control-label">Contact Number</label>
						<div class="controls">
							<form:input path="contactNo" />
							<span class="help-inline">
								<form:errors path="contactNo" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="emailCG">	
						<label class="control-label">Email</label>
						<div class="controls">
							<form:input path="email" />
							<span class="help-inline">
								<form:errors path="email" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="districtCG">	
						<label class="control-label">From</label>
						<div class="controls">
							<form:select path="district" items="${districts}" multiple="false" />
							<span class="help-inline">
								<form:errors path="district" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="passwordCG">	
						<label class="control-label">Password</label>
						<div class="controls">
							<form:password path="password" />
							<span class="help-inline">
								<form:errors path="password" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="confirmPasswordCG">	
						<label class="control-label">Confirm Password</label>
						<div class="controls">
							<form:password path="confirmPassword" />
							<span class="help-inline">
								<form:errors path="confirmPassword" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
		
					<div class="form-actions" style="background-color: transparent;border: 0;">
						<button id="submitBtn" class="btn btn-primary" value="Register" type="submit">Sign-up</button>
						 <img src="<spring:url value="/resources/images/ajax-loader.gif"/>" id="loading-indicator" style="display:none"/>
						<button class="btn " type="reset" style="margin-left:10px;">Reset</button>	
					</div>
				</fieldset>
			</form:form>
			
		</div>
	</div>
	<div class="span2" >
	</div>
	<div class="span3" >
		<h3> Connect with FaceBook</h3>
		<br><br>
		<img id="FBconnect" src="resources/images/fb-connect-large.png" alt="FB Connect" />
	</div>
</div>
<script type="text/javascript">

	function collectFormData(fields) {
		var data = {};
		for (var i = 0; i < fields.length; i++) {
			var $item = $(fields[i]);
			data[$item.attr('name')] = $item.val();
		}
		return data;
	}
	$(document).ready(function() {
		var $form = $('#signupform2');
		$form.bind('submit', function(e) {
			// Ajax validation
			var $inputs = $form.find('input');
			var data = collectFormData($inputs);
			
			
			$.post('${registerJsonUrl}', data, function(response) {
				$form.find('.control-group').removeClass('error');
				$form.find('.help-inline').empty();
				$form.find('.alert').remove();
				
				if (response.status == 'FAIL') {
					for (var i = 0; i < response.errorMessageList.length; i++) {
						
						var item = response.errorMessageList[i];
						var $controlGroup = $('#' + item.fieldName + 'CG');
						$controlGroup.addClass('error');
						$controlGroup.find('.help-inline').html(item.message);
					}
				} else {
					$form.unbind('submit');
					$form.submit();
				}
			}, 'json');
			
			e.preventDefault();
			return false;
		});
	});
	 $(document).ajaxSend(function(event, request, settings) {
		   $('#loading-indicator').show();
		   $("#submitBtn").attr("disabled", "disabled");
	 });
		 
	 $(document).ajaxComplete(function(event, request, settings) {
	   $('#loading-indicator').hide();
	   $("#submitBtn").removeAttr("disabled");   
	 });

</script>


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>