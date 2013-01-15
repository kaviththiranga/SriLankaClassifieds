
<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<ul class="breadcrumb" style="background-color: transparent;">
		<li>You are here<span class="divider">/</span></li>
	    <li><a href="<spring:url value="/home"/>">Home</a> <span class="divider">/</span></li>
	    <li><a href="<spring:url value="/ads/viewAllAds"/>">ads</a> <span class="divider">/</span></li>
	    <li class="active">${ad.title}</li>
</ul>
<%@ include file="/WEB-INF/views/includes/msgIFrame.jsp" %>	


<spring:url value="/viewProfile?userId=${ad.user.userId}" var="profileLink"/>
<spring:url value="/ads/viewAd?adId=${ad.adId}" var="adLink"/>
<spring:url value="/ads/viewAdsByCategory?catId=${ad.category.catId}" var="catLink"/>
<spring:url value="/ads/addToFavs?adId=${ad.adId}" var="addToFavLink"/>
<spring:url value="/ads/addComment?adId=${ad.adId}" var="addCommentLink"/>

<div class="container">
	<div class="container" style="margin-right: 30px;">
			
		<div class="row">
			<div class="span6">
				<ul class="inline" >
					<c:if test="${ad.buying == true}">
			 	 	
			 	 		<li><span class="badge badge-warning">Wanted</span></li>
			 	 	</c:if>		           
					<li><a rel="tooltip" title="Click here to view this ad" href="${adLink}"><h4>${ad.title}</h4></a></li>	
					
					
					<li><a id="addToFav${ad.adId}" href="${addToFavLink}" rel="tooltip" title="Click here to add this wish list"   ><i class="icon-star icon-1x" style="color: #FFCC00;"></i></a></li>		           	
					<li><img style="display: none;" src="<spring:url value="/resources/images/ajax-loader.gif"/>" id="loading-indicator${ad.adId}"/></li>
					
					<li style="font-size:small;">${ad.user.district}, <slclassifieds:TimeDef createdOn="${ad.createdOn}"/> ago</li>
					<li><label id="adSummaryMsg${ad.adId}" style="text-align:right;"></label></li>
				</ul>
		     	
		     	<div id="gallery" data-toggle="modal-gallery" data-target="#modal-gallery1" data-selector="img.gallery-item">
		     		
			     		<c:forEach items="${ad.images}" var="img" varStatus="status">
				     		
			     			<c:if test="${status.count == 1}">
			     				<div class="span5">				
			     					<a href="" onclick="return false" class="thumbnail"><img class="gallery-item" data-href="<spring:url value="/${img.url}"/>" src="<spring:url value="/${img.url}" />" alt=""/></a>
			     				</div>
			     			</c:if>
			     			<c:if test="${status.count ne 1}">
				     			<div class="span2">	
				     					<a href="" onclick="return false" class="thumbnail" style="margin: 10px;"><img  class="gallery-item" data-href="<spring:url value="/${img.url}"/>" src="<spring:url value="/${img.thumbnail_url}" />" alt=""/></a>
				     			</div>		
			     			</c:if>
			     		</c:forEach>
			     		
				</div>
			</div>
			<div class="span6">
			    <ul class="inline" style="text-align: right;margin-top: 10px;">
			    	<li ><c:if test="${ad.buying== false}">seller : </c:if><c:if test="${ad.buying == true}">Buyer : </c:if>
			    		<a rel="tooltip" title="Click here to view details of seller ${ad.user.username}" href="${profileLink}">${ad.user.username}</a></li>
			    		
					 <li >category : <a rel="tooltip" title="Click here to view ads under ${ad.category.catName} category" href="${catLink}">${ad.category.catName}</a></li>          	
					
			    </ul>
			    <label>Description</label>
			    <div class="hero-unit" style="font-size: medium; padding: 10px;">
			    	<p><c:if test="${ad.buying== true}"><span class="badge badge-warning">Wanted</span></c:if> ${ad.desc}</p>
			    </div>
			    <c:if test="${ad.buying== false}">
			    	<span class="label label-success" style="font-size: large;padding: 7px;">Rs. <fmt:formatNumber type="number" maxFractionDigits="2" value="${ad.price}" /> /- </span>     
			 	
			 	 </c:if>
			 	 <c:if test="${ad.buying == true}">
			 	 	<a class="btn btn btn-primary">Contact Buyer</a>
			 	 	
			 	 </c:if>
			 	 
			 	 <div  style="padding-top: 5px;">
			 	 	<p>Comments for this ad</p>
			 	 	<div id="comments" class="well" style="padding: 5px;">
			 	 		
			 	 		<c:forEach items="${ad.allComments}" var="cmt" varStatus="status">
			 	 				<spring:url value="/viewProfile?userId=${cmt.user.userId}" var="userLink"/>
			 	 			    
								    <p>by <a href="${userLink}">${cmt.user.username}:</a>
								    ${cmt.comment}<br><span style="font-size: smaller;"><slclassifieds:TimeDef createdOn="${cmt.commentedOn}"/> ago</span></p>
								
				 	 	</c:forEach>
			 	 	</div>
			 	 	<form id="CommentForm" class="form-inline" action="${addCommentLink}" method="POST">
			 	 		<textarea name="comment" type="text" cols="200" class="input" maxlength="200" ></textarea>
			 	 		<button type="submit" class="btn">Comment</button>
			 	 		<img style="display: none;" src="<spring:url value="/resources/images/ajax-loader.gif"/>" id="loading-indicator_cmt"/>
			 	 	</form>
			 	 </div>
			</div>
		</div>
	</div>

</div>
<h1 id="comments"></h1>



<script type="text/javascript">
$(document).ready(function() {
	
	function collectFormData(fields) {
		var data = {};
		for (var i = 0; i < fields.length; i++) {
			var $item = $(fields[i]);
			data[$item.attr('name')] = $item.val();
		}
		return data;
	}
	
	var $form = $('#CommentForm');
	$form.bind('submit', function(e) {
		// Ajax validation
		var $inputs = $form.find('input,textarea');
		var data = collectFormData($inputs);
		
		
		$.post('${addCommentLink}', data, function(response) {
			
			if (response.status == 'OK') {
				
				$("#comments").append(tmpl("template-comment", response));
			} else {
				
			}
		}, 'json');
		
		e.preventDefault();
		return false;
	});
	
	$("#addToFav${ad.adId}").click(function () {
	    
		var data="";
		
		$.post('${addToFavLink}', data, function(response) {
			
			$("#adSummaryMsg${ad.adId}").text(response.message);
			$("#adSummaryMsg${ad.adId}").attr('class' , response.style);
			
		}, 'json');
		
		
	    return false;
	});

});

$(document).ajaxSend(function(event, request, settings) {
	
	if(settings.url == '${addToFavLink}'){
	   $('#loading-indicator${ad.adId}').show();
	   $("#addToFav${ad.adId}").hide();
	}
	if(settings.url == '${addCommentLink}'){
		   $('#loading-indicator_cmt').show();
		   
	} 

});
	 
$(document).ajaxComplete(function(event, request, settings) {

	if(settings.url == '${addToFavLink}'){
	   $('#loading-indicator${ad.adId}').hide();
	   $("#addToFav${ad.adId}").show();
	}
	if(settings.url == '${addCommentLink}'){
		   $('#loading-indicator_cmt').hide();
	} 
});

</script>
<script id="template-comment" type="text/x-tmpl">
    <p>by <a href="${userLink}">{%=o.username%}</a>
								    {%=o.comment%}<br><span style="font-size: smaller;">just now</span></p>
						
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>