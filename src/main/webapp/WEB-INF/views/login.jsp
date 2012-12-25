

<%@ include file="/WEB-INF/views/includes/header.jsp" %>

<h1>Login to SLClassifieds</h1>
	<c:if test="${not empty error}">
		<div class="errorblock">
			Your login attempt was not successful, try again.<br /> Caused :
			${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
		</div>
	</c:if>
	
 <div id=leftBody>
	 <div id="signupForm" style="display: block;">
		<form name="f" action="<c:url value='j_spring_security_check' />" method="POST">
	 
			<table>
				<tr>
					<td>User:</td>
					<td><input type="text" name="j_username"' value="">
					</td>
				</tr>
				<tr>
					<td>Password:</td>
					<td><input type="password" name="j_password" />
					</td>
				</tr>
				<tr>
					<td colspan="2"><input name="submit" type="submit"
						value="submit" />
					</td>
				</tr>
				<tr>
					<td colspan="2"><input name="reset" type="reset" />
					</td>
				</tr>
			</table>
	 
		</form>
	</div>
</div>	
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>