<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div id="leftBody" >
	<h3> Sign up for a SLClassifieds Account</h3>
	
	<img id="free" src="resources/images/free.gif" alt="Free"/>
	<div id="signupForm">
		<form:form method="POST" action="register" commandName="user">
			
			<label>Name
			<span class="small">Full Name</span>
			</label>
			<form:input path="name" />
			<form:errors path="name" cssClass="error" element="label" />
			
			<label>Username
			<span class="small">Add your last name</span>
			</label>
			<form:input path="username" />
			<form:errors path="username" cssClass="error" element="label" />

			<label>Contact 
			<span class="small">Add a valid Contact No</span>
			</label>
			<form:input path="contactNo" />
			<form:errors path="contactNo" cssClass="error" element="label" />
			
			<label>Email
			<span class="small">Add a valid email</span>
			</label>
			<form:input path="email" />
			<form:errors path="email" cssClass="error" element="label" />
			
			<label>From
			<span class="small">Select a district from list</span>
			</label>
			<form:select path="district" items="${districts}" multiple="false" />
			<form:errors path="district" cssClass="error" element="label" />

>
			<label>Password
			<span class="small">Min. size 6 chars</span>
			</label>
			<form:password path="password" />
			<form:errors path="password" cssClass="error" element="label" />
			
			<label>Confirm Password
			<span class="small">Min. size 6 chars</span>
			</label>
			<form:password path="confirmPassword" />
			<form:errors path="confirmPassword" cssClass="error" element="label" />

			<div>
				<button type="submit">Sign-up</button>
				
				<button type="reset" style="margin-left:10px;">Reset</button>
			
			</div>
			<div class="spacer"></div>
		</form:form>
	</div>
</div>
<div id="rightBody" >
	<h3> Connect with FaceBook</h3>
	<br><br>
	<img id="FBconnect" src="resources/images/fb-connect-large.png" alt="FB Connect" />
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>