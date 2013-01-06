
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li><a href="<spring:url value="/ads"/>">ads</a> <span class="divider">/</span></li>
	    <li class="active">new</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	

<div class="row"  >
	<div class="span12" style="padding-left: 20px;">
	
		<h3 style="text-align: center;"> Post a free Advertisement</h3>
		<img id="free" src="<spring:url value="/resources/images/free.gif"/>" alt="Free"/>
		<spring:url value="/ads/new" var="adSubmitUrl"/>
		<!-- Start Create Ad Form -->
		<form:form id="createAd" class="form-horizontal" method="POST" action="${adSubmitUrl}" commandName="ad" >
		<fieldset>
		<div class="span6" >
			
					<div class="control-group" id="category">						
						<label class="control-label">Select Category</label>						
						<div class="controls">
							<form:select path="category">
						        <form:options items="${cats}" itemValue="catName" itemLabel="catName"/>
						    </form:select>
							<span class="help-inline">
								<form:errors path="category" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="title">	
						<label class="control-label">Ad Title</label>	
						<div class="controls">
							<form:textarea rows="2" cols="200" maxlength="200" path="title" />
							<span class="help-inline">
								<form:errors path="title" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="desc">
						<label class="control-label">Description</label>
						<div class="controls">
							<form:textarea rows="5" cols="200" maxlength="2000" path="desc"/>
							<span class="help-inline">
								<form:errors path="desc" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
					<div class="control-group" id="price">	
						<label class="control-label">Price</label>
						<div class="controls">
							<div class="input-prepend">
								<span class="add-on">Rs</span>
								<form:input id="prependedInput" path="price" cssStyle="width:180px;"/>
							</div>
							<span class="help-inline">
								<form:errors path="price" cssClass="text-error" element="label" />
							</span>
						</div>
					</div>
				
					<div class="form-actions" style="background-color: transparent;border: 0;">
						<button class="btn btn-primary" value="Register" type="submit">Create</button>
						
						<button class="btn " type="reset" style="margin-left:10px;">Reset</button>	
					</div>
		</div>
		<spring:url value="/ads/uploadImage" var="imgUploadUrl"/>
		<div class="span4 well">
			<h6>Upload Images</h6>
			<span id='filename'></span>
			<a href="#" id="addImage">add an image</a>
			<input id="uploadImg" type="file" name="file" data-url="${imgUploadUrl}" multiple style="opacity: 0; filter:alpha(opacity: 0);"/>
		</div>
		</fieldset>
		</form:form>
	</div>
</div>
<script type="text/javascript">
$(document).ready(function() {
	$("#addImage").click(function () {
	    $("#uploadImg").trigger('click');
	});

});
</script>
<<script type="text/javascript">

</script>
<div id='msgbox' title='' style='display:none'></div>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>