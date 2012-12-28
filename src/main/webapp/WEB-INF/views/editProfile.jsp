

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li><a href="<spring:url value="/profile"/>">Profile</a> <span class="divider">/</span></li>
	    <li class="active">edit</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	

<div class="row">
	<div class="span2">
		<ul class="nav nav-tabs nav-stacked">
	    	<li >
				<a href="<spring:url value="/profile"/>">View Profile</a>
			</li>
			<li class="active"><a href="<spring:url value="/profile/edit"/>">Edit Account</a></li>
			<li><a href="j_spring_security_logout">Logout</a></li>
	    </ul>
	</div>
	<div class="span10">
		<div class="well">
			<h4>User Profile - ${user.name}</h4>
		</div>
		<spring:url value="/profile/edit" var="ProfileEditUrl"/>
		<form:form  class="form-horizontal" method="POST" action="${ProfileEditUrl}" commandName="user">
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
							<form:input readonly="true" cssClass="uneditable-input" path="username" />
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
							<form:input cssClass="uneditable-input" readonly="true" path="email" />
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
						<label class="control-label">New Password</label>
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
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>