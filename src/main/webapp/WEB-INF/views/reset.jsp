

<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li><a href="<spring:url value="/profile"/>">profile</a> <span class="divider">/</span></li>
	    <li class="active">Reset password</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	
<spring:url value="/profile/passwordReset.json" var="resetFormSubmitUrl"/>
<spring:url value="/profile/securityQuestion.json" var="getQuestionUrl"/>
<spring:url value="/profile/confirmAnswer.json" var="confirmAnswerUrl"/>
<spring:url value="/login" var="loginUrl"/>
<div class="container" >
	<div class="span1">
	</div>
	<div  class="span6">
			<form id="resetForm1" name="f" class="form-horizontal"  method="POST">
				<h4 style="text-align: center;">please enter your username</h4><br>
		 		<fieldset>
					<div class="control-group"  id="j_username" >
						<label class="control-label">Username</label>
						<div class="controls">
							<input type="text" id="j_username" name="j_username" />
							<span class="help-inline">
								<label id="usernameErrorLbl" class="text-error"></label>
							</span>
						</div>
					</div>
					<div class="form-actions" style="background-color: transparent;border: 0;">
						
						<button type="submit" class="btn btn-primary">Get Security Question</button>
						<img style="display: none;" src="<spring:url value="/resources/images/ajax-loader.gif"/>" class="loading-indicator" />
					</div>
				</fieldset>	 
			</form>
			
				
				
			
			<form id="resetForm2"  name="f" class="form-horizontal" action="${resetUrl}" method="POST">
				<h4 style="text-align: center;">please enter the answer</h4><br>
				<p id="nameLbl"  class="text-info well" style="text-align: center;">Welcome </p>
		 		<fieldset>
					<div class="control-group" id="answer" >
						<label id="questionLbl" class="control-label"></label>
						<div class="controls">
							<input type="text" id="answer" name="answer" />
							<span class="help-inline">
								<label id="answerErrorLbl" class="text-error"></label>
							</span>
						</div>
					</div>
					<input type="text" style="display: none;" id="usernameHidden" name="j_username" />
					<div class="form-actions" style="background-color: transparent;border: 0;">
						
						<button type="submit" class="btn btn-primary">Reset Password</button>
						<img style="display: none;" src="<spring:url value="/resources/images/ajax-loader.gif"/>" class="loading-indicator" />
					</div>
				</fieldset>	 
			</form>
			
			<form id="resetForm3"  name="f" class="form-horizontal" action="${resetUrl}" method="POST">
				<h4 style="text-align: center;">please enter new password</h4><br>
				<p id="nameLbl2"  class="text-info well" style="text-align: center;">Hi </p>
		 		<fieldset>
					
					<div class="control-group" id="passwordCG">	
						<label class="control-label">New Password</label>
						<div class="controls">
							<input type="password" id="password" name="password" />
							<span class="help-inline">
								<label class="help-inline"></label>	
							</span>
						</div>
					</div>
					<div class="control-group" id="confirmPasswordCG">	
						<label class="control-label">Confirm Password</label>
						<div class="controls">
							<input type="password" id="confirmPassword" name="confirmPassword" />
							<span class="help-inline">
								<label class="help-inline"></label>	
							</span>
						</div>
					</div>
					<input type="text" style="display: none;" id="usernameHidden2" name="j_username" />
					<div class="form-actions" style="background-color: transparent;border: 0;">
						
						<button type="submit" class="btn btn-primary">Reset Password</button>
						<img style="display: none;" src="<spring:url value="/resources/images/ajax-loader.gif"/>" class="loading-indicator" />
					</div>
				</fieldset>	 
			</form>

	</div>
	
	<div class="span3 well">
		<h4>Problem with login?</h4>
		<p>Try following options.</p>
		
		<a href="${resetUrl}" class="btn btn-primary">Reset Password</a>
		<h4>Not a member?</h4>
		<p>Create a free account.</p>
		<a href="<spring:url value="/register"/>" 
				class="btn btn-success">Sign up NOW</a>
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
		$("#resetForm2").hide();
		$("#resetForm3").hide();
		var $form1 = $('#resetForm1');
		$form1.bind('submit', function(e) {
			
			var $inputs = $form1.find('input');
			var data = collectFormData($inputs);
			
			$.post('${getQuestionUrl}', data, function(response) {
				
				if (response.status == 'OK') {
					
					$("#resetForm1").hide();
					$("#questionLbl").text(response.question);
					$("#nameLbl").append(response.name);
					$("#resetForm2").show();
					$("#usernameHidden").val(response.username);
				}else{
					
					$("#usernameErrorLbl").text("Sorry, username is not valid.");
					
				}
			}, 'json');
			
			e.preventDefault();
			return false;
		});
		
		var $form2 = $('#resetForm2');
		$form2.bind('submit', function(e) {
			
			var $inputs = $form2.find('input');
			var data = collectFormData($inputs);
			
			$.post('${confirmAnswerUrl}', data, function(response) {
				
				if (response.status == 'CORRECT') {

					$("#resetForm2").hide();
					$("#nameLbl2").append(response.name+", enter your new password");
					$("#resetForm3").show();
					$("#usernameHidden2").val(response.username);
				}else{
					
					$("#answerErrorLbl").text("Sorry, Answer is not correct.");
					
				}
			}, 'json');
			
			e.preventDefault();
			return false;
		});
		var $form3 = $('#resetForm3');
		$form3.bind('submit', function(e) {
			
			var $inputs = $form3.find('input');
			var data = collectFormData($inputs);
			
			$.post('${resetFormSubmitUrl}', data, function(response) {
				
				if (response.status == 'ERROR') {
					for (var i = 0; i < response.errorMessageList.length; i++) {
						
						var item = response.errorMessageList[i];
						var $controlGroup = $('#' + item.fieldName + 'CG');
						$controlGroup.addClass('error');
						$controlGroup.find('.help-inline').html(item.message);
					}
				} else {
					window.location = '${loginUrl}';
				}
			}, 'json');
			
			e.preventDefault();
			return false;
		});
	});

    $(document).ajaxSend(function(event, request, settings) {
    	   $('.loading-indicator').show();
    	  

    });
    	 
    $(document).ajaxComplete(function(event, request, settings) {
    		$('.loading-indicator').hide();
    	
    });

</script>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>