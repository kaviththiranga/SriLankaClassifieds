
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
		<div id="signupForm" class="span6">
			<form:form  class="form-horizontal" method="POST" action="${registerSubmitUrl}" commandName="user">
				<fieldset>
					<div class="control-group" id="name">						
						<label class="control-label">Name in Full</label>						
						<div class="controls">
							<form:input path="name" />
							<span class="help-inline">
								<form:errors path="name" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="username">	
						<label class="control-label">Username</label>	
						<div class="controls">
							<form:input path="username" />
							<span class="help-inline">
								<form:errors path="username" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="contactNo">
						<label class="control-label">Contact Number</label>
						<div class="controls">
							<form:input path="contactNo" />
							<span class="help-inline">
								<form:errors path="contactNo" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="email">	
						<label class="control-label">Email</label>
						<div class="controls">
							<form:input path="email" />
							<span class="help-inline">
								<form:errors path="email" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="district">	
						<label class="control-label">From</label>
						<div class="controls">
							<form:select path="district" items="${districts}" multiple="false" />
							<span class="help-inline">
								<form:errors path="district" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="password">	
						<label class="control-label">Password</label>
						<div class="controls">
							<form:password path="password" />
							<span class="help-inline">
								<form:errors path="password" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="confirmPassword">	
						<label class="control-label">Confirm Password</label>
						<div class="controls">
							<form:password path="confirmPassword" />
							<span class="help-inline">
								<form:errors path="confirmPassword" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
		
					<div class="form-actions" style="background-color: transparent;border: 0;">
						<button class="btn btn-primary" value="Register" type="submit">Sign-up</button>
						
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


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>