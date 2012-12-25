
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<div class="row"  >
	<div class="span6">
	
		<h3> Sign up for a SLClassifieds Account</h3>
		<img id="free" src="<spring:url value="/resources/images/free.gif"/>" alt="Free"/>
		
		<div id="" class="span6">
			<form:form  class="form-horizontal" method="POST" action="register" commandName="user">
				<fieldset>
					<div class="control-group" id="name">
						
						<label class="control-label">Name</label>
						<span class="" style="font-size: small;">Full Name</span>
						<div class="controls">
							<form:input path="name" />
							<span class="help-inline">
								<form:errors path="name" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<label>Username
					<span class="small">Enter a username</span>
					</label>
					<form:input path="username" />
					<form:errors path="username" cssClass="text-error" element="label" />
		
					<label>Contact 
					<span class="small">Add a valid Contact No</span>
					</label>
					<form:input path="contactNo" />
					<form:errors path="contactNo" cssClass="text-error" element="label" />
					
					<label>Email
					<span class="small">Add a valid email</span>
					</label>
					<form:input path="email" />
					<form:errors path="email" cssClass="text-error" element="label" />
					
					<label>From
					<span class="small">Select a district from list</span>
					</label>
					<form:select path="district" items="${districts}" multiple="false" />
					<form:errors path="district" cssClass="text-error" element="label" />
		
	
					<label>Password
					<span class="small">Min. size 6 chars</span>
					</label>
					<form:password path="password" />
					<form:errors path="password" cssClass="text-error" element="label" />
					
					<label>Confirm Password
					<span class="small">Min. size 6 chars</span>
					</label>
					<form:password path="confirmPassword" />
					<form:errors path="confirmPassword" cssClass="text-error" element="label" />
		
					<div>
						<button value="Register" type="submit">Sign-up</button>
						
						<button type="reset" style="margin-left:10px;">Reset</button>
					
					</div>
				</fieldset>
			</form:form>
		</div>
	</div>
	<div class="span6" >
		<h3> Connect with FaceBook</h3>
		<br><br>
		<img id="FBconnect" src="resources/images/fb-connect-large.png" alt="FB Connect" />
	</div>
</div>


<%@ include file="/WEB-INF/views/includes/footer.jsp" %>