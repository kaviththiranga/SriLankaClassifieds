<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<div id="leftBody" >
	<h3> Sign up for a LKGarage Account</h3>
	
	<img id="free" src="resources/images/free.gif" alt="Free"/>
	<div id="signupForm">
		<form id="form" name="form" method="post" action="Register">
			
			<label>First Name
			<span class="small">First name</span>
			</label>
			<input type="text" name="fname" id="fname" />
			
			<label>Last Name
			<span class="small">Add your last name</span>
			</label>
			<input type="text" name="lname" id="lname" />

			<label>Mobile
			<span class="small">Add a valid address</span>
			</label>
			<input type="text" name="mobile" id="mobile" />
			
			<label>Email
			<span class="small">Add a valid mobile</span>
			</label>
			<input type="text" name="email" id="email" />

			<label>Password
			<span class="small">Min. size 6 chars</span>
			</label>
			<input type="password" name="password" id="password" />
			
			<label>Confirm Password
			<span class="small">Min. size 6 chars</span>
			</label>
			<input type="password" name="cpassword" id="cpassword" />

			<div>
				<button type="submit">Sign-up</button>
				
				<button type="cancel" style="margin-left:10px;">Cancel</button>
			
			</div>
			<div class="spacer"></div>
		</form>
	</div>
</div>
<div id="rightBody" >
	<h3> Connect with FaceBook</h3>
	<br><br>
	<img id="FBconnect" src="resources/images/fb-connect-large.png" alt="FB Connect" />
</div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>