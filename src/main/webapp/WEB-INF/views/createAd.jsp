
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ include file="/WEB-INF/views/includes/includes.jsp" %>





<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li><a href="<spring:url value="/ads/viewAllAds"/>">ads</a> <span class="divider">/</span></li>
	    <li class="active">new</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	
<spring:url value="/ads/uploadImage" var="imgUploadUrl"/>
<div class="row"  >
	<div class="span12" style="padding-left: 20px;">
	
		<h3 style="text-align: center;"> Post a free Advertisement</h3>
		<img id="free" src="<spring:url value="/resources/images/free.gif"/>" alt="Free"/>
		<spring:url value="/ads/new" var="adSubmitUrl"/>
		<!-- Start Create Ad Form -->
		<form:form id="createAd" class="form-horizontal" method="POST" action="${adSubmitUrl}" commandName="ad" >
		<fieldset>
		
		<div class="span12" >
			
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
					<div class="control-group" id="isBuying">						
						<label class="control-label">Buying or Selling</label>						
						<div class="controls">
							<form:radiobutton path="isBuying" value="1"/>Buying 
							<form:radiobutton path="isBuying" value="0"/> Selling
							<span class="help-inline">
								<form:errors path="isBuying" cssClass="text-error" element="label" />
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
					<input id="img0" name="img0" type="text" style="display: none;">
					<input id="img1" name="img1" type="text" style="display: none;">
					<input id="img2" name="img2" type="text" style="display: none;">
					<input id="img3" name="img3" type="text" style="display: none;">
					<input id="img4" name="img4" type="text" style="display: none;">
				
					<div class="form-actions" style="background-color: transparent;border: 0;">
						<button class="btn btn-primary" value="Register" type="submit">Create</button>
						
						<button class="btn " type="reset" style="margin-left:10px;">Reset</button>	
					</div>
		</div>
		</fieldset>
		</form:form>
		<!--<form id="fileupload2" class="form-horizontal" method="POST" action="${imgUploadUrl}"  enctype="multipart/form-data" >
		<div class="span4 well">
			<h6>Upload Images</h6>
			<span id='filename'></span>
			<a href="#" id="addImage">add an image</a>
			<input id="uploadImg" type="file" name="files[]" style="opacity: 0; filter:alpha(opacity: 0);" multiple="multiple" >
			<button class="btn btn-primary" value="Register" type="submit">Upload</button>
		</div>  
		</form>-->
		
		 <!-- The file upload form used as target for the file upload widget -->
		    <form id="fileupload" action="${imgUploadUrl}" method="POST" enctype="multipart/form-data">
		        
		        <!-- The fileupload-buttonbar contains buttons to add/delete files and start/cancel the upload -->
		        <div class="row fileupload-buttonbar">
		            <div class="span7">
		                <!-- The fileinput-button span is used to style the file input field as button -->
		                <span class="btn btn-success fileinput-button">
		                    <i class="icon-plus icon-white"></i>
		                    <span>Add images...</span>
		                    <input type="file" name="files[]" multiple>
		                </span>
		                <button type="submit" class="btn btn-primary start">
		                    <i class="icon-upload icon-white"></i>
		                    <span>Start upload</span>
		                </button>
		                <button type="reset" class="btn btn-warning cancel">
		                    <i class="icon-ban-circle icon-white"></i>
		                    <span>Cancel upload</span>
		                </button>
		                <button type="button" class="btn btn-danger delete">
		                    <i class="icon-trash icon-white"></i>
		                    <span>Delete</span>
		                </button>
		                <input type="checkbox" class="toggle">
		            </div>
		            <!-- The global progress information -->
		            <div class="span5 fileupload-progress fade">
		                <!-- The global progress bar -->
		                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100">
		                    <div class="bar" style="width:0%;"></div>
		                </div>
		                <!-- The extended global progress information -->
		                <div class="progress-extended">&nbsp;</div>
		            </div>
		        </div>
		        <!-- The loading indicator is shown during file processing -->
		        <div class="fileupload-loading"></div>
		        <br>
		        <div class="well">Drag and Drop Images Here</div>
		        <!-- The table listing the files available for upload/download -->
		        <table role="presentation" class="table table-striped"><tbody class="files" data-toggle="modal-gallery" data-target="#modal-gallery"></tbody></table>
		    </form>
		</div>
		
		
	</div>
</div>
<script type="text/javascript">
var imgCnt;
$(document).ready(function() {
	imgCnt = 0;
	$("#addImage").click(function () {
	    $("#uploadImg").trigger('click');
	    return false;
	});
	
	$('#fileupload')
    .bind('fileuploaddone', function (e, data) {
    	
    	for (var i = 0; i < data.result.files.length; i++) {
    		
    		 $('#img'+ imgCnt).val(data.result.files[i].imgID);
    		 imgCnt++;
    	}
    	
    
    });

});
</script>
<!-- The template to display files available for upload -->
<script id="template-upload" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-upload fade">
        <td class="preview"><span class="fade"></span></td>
        <td class="name"><span>{%=file.name%}</span></td>
        <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
        {% if (file.error) { %}
            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else if (o.files.valid && !i) { %}
            <td>
                <div class="progress progress-success progress-striped active" role="progressbar" aria-valuemin="0" aria-valuemax="100" aria-valuenow="0"><div class="bar" style="width:0%;"></div></div>
            </td>
            <td class="start">{% if (!o.options.autoUpload) { %}
                <button class="btn btn-primary">
                    <i class="icon-upload icon-white"></i>
                    <span>Start</span>
                </button>
            {% } %}</td>
        {% } else { %}
            <td colspan="2"></td>
        {% } %}
        <td class="cancel">{% if (!i) { %}
            <button class="btn btn-warning">
                <i class="icon-ban-circle icon-white"></i>
                <span>Cancel</span>
            </button>
        {% } %}</td>
    </tr>
{% } %}
</script>
<!-- The template to display files available for download -->
<spring:url value="/" var="root"/>
<script type="text/javascript">
tmpl.helper += ",root=${root}";
</script>
<script id="template-download" type="text/x-tmpl">
{% for (var i=0, file; file=o.files[i]; i++) { %}
    <tr class="template-download fade">
        {% if (file.error) { %}
            <td></td>
            <td class="name"><span>{%=file.name%}</span></td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td class="error" colspan="2"><span class="label label-important">Error</span> {%=file.error%}</td>
        {% } else { %}
            <td class="preview">{% if (file.thumbnail_url) { %}
                <a href="{%=root+file.url%}" title="{%=file.name%}" data-gallery="gallery" download="{%=file.name%}"><img src="{%=root+file.thumbnail_url%}"></a>
            {% } %}</td>
            <td class="name">
                <a href="{%=root+file.url%}" title="{%=file.name%}" data-gallery="{%=root+file.thumbnail_url&&'gallery'%}" download="{%=file.name%}">{%=file.name%}</a>
            </td>
            <td class="size"><span>{%=o.formatFileSize(file.size)%}</span></td>
            <td colspan="2"></td>
        {% } %}
        <td class="delete">
            <button class="btn btn-danger" data-type="{%=file.delete_type%}" data-url="{%=file.delete_url%}"{% if (file.delete_with_credentials) { %} data-xhr-fields='{"withCredentials":true}'{% } %}>
                <i class="icon-trash icon-white"></i>
                <span>Delete</span>
            </button>
            <input type="checkbox" name="delete" value="1">
        </td>
    </tr>
{% } %}
</script>
<div id='msgbox' title='' style='display:none'></div>
<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
