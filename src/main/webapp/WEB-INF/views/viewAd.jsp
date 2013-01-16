
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
<spring:url value="/ads/addBid?adId=${ad.adId}" var="addBidLink"/>

<div id="contactFormModel" class="modal hide fade">
	<div class="modal-header">					
		<button type="button" class="close" data-dismiss="modal"
			aria-hidden="true">&times;</button>
		<h4>Send an Email to owner of this ad</h4>
	</div>
	
	<form name="f" class="form-horizontal" style="margin-bottom: 0px;" action="<spring:url value="/sendOwnerEmail?adId=${ad.adId}" />" method="POST">
		<div class="modal-body">
			
 		<fieldset>
			<div class="control-group"  id="subject" >
				<label class="control-label">Subject</label>
				<div class="controls">
					<input type="text" id="subject" name="subject" value="${ad.title }"/>
				</div>
			</div>
			<div class="control-group" id="j_password" >
				<label class="control-label">Message</label>
				<div class="controls">
					<textarea type="text" id="msg" name="msg" ></textarea>
				</div>
			</div>
							
		</div>
		<div class="modal-footer" >	
				
							
				<button type="submit" class="btn btn-primary">Send Email</button>
				<button data-dismiss="modal" class="btn btn-warning">Cancel</button>
				
		</div>
		</fieldset>	 
	</form>
</div>

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
				<div class="span4" style="margin-left: 60px;margin-top:30px;clear: both;">
					<c:if test="${ad.buying== true}">
								Offers placed for this Ad.
					</c:if>
					<c:if test="${ad.buying== false}">
						Bargains placed for this Ad.
					</c:if>
				</div>
				<c:if test="${ad.user.userId == currentUser.userId}">
					<div class="span4 well" style="margin-left: 50px;clear: both;">
						<c:forEach items="${ad.allBids}" var="bid" varStatus="status">
							<spring:url value="/viewProfile?userId=${bid.user.userId}" var="userLink"/>
							<c:if test="${ad.buying== true}">
						    	<p><a href="${userLink}">${bid.user.username}</a> placed an offer - Rs. <fmt:formatNumber type="number" maxFractionDigits="2" value="${bid.amount}" /> /- 
							</c:if>
							<c:if test="${ad.buying== false}">
						    	<p><a href="${userLink}">${bid.user.username}</a> bargained - Rs. <fmt:formatNumber type="number" maxFractionDigits="2" value="${bid.amount}" /> /- 
							</c:if>
							<br><span style="font-size: smaller;"><slclassifieds:TimeDef createdOn="${bid.placedOn}"/> ago</span></p>
						
						</c:forEach>
					</div>
				</c:if>
				<c:if test="${ad.user.userId ne currentUser.userId}">
					<div class="span4 well" style="margin-left: 50px;clear: both;">
						<p>You are not authorized to see 
						<c:if test="${ad.buying== true}">
							offers place for this Ad.
						</c:if>
						<c:if test="${ad.buying== false}">
							bargains placed for this Ad.
						</c:if>
						
						</p>
					</div>
				</c:if>
				
				<div class="span4 well" style="margin-left: 50px;margin-top:30px;clear: both;">
				
					<c:if test="${ad.buying== true}">
			 	 			<p>Give an Offer to Buyer (
								<a href="#placeOffer" id="bidPop" rel="popover" 
									data-content="You can give an offer here. Owner of this ad will be notified with your contact details when you place the offer.If buyer is interested in your offered price, he/she will contact you. Offers are only visible to the owner of this ad." 
									data-original-title="Giving an Offer" 
									style="font-size: small;">what is this?
								</a>)
							</p>
			 	 		</c:if>
			 	 		<c:if test="${ad.buying== false}">
			 	 			<p>Make a Bargain Request (
								<a href="#placeBargain" id="bidPop" rel="popover" 
									data-content="You can place a bargain request here. Owner of this ad will be notified with your contact details when you place the bargain.If seller is interested in your price, he/she will contact you. bargains are only visible to the seller." 
									data-original-title="Giving an Offer" 
									style="font-size: small;">what is this?
								</a>)
							</p>
			 	 		</c:if>
					<div id="placeOffer"></div>
					<div id="placeBargain"></div>
					<form id="BidForm" style="text-align: center;" action="${addBidLink}" method="POST">
						<div class="input-prepend">
								<span class="add-on">Rs</span>
			 	 				<input name="amount" type="text" >
			 	 				
			 	 		</div>
			 	 		<c:if test="${ad.buying== true}">
			 	 			<button type="submit" class="btn">Place Offer</button>
			 	 		</c:if>
			 	 		<c:if test="${ad.buying== false}">
			 	 			<button type="submit" class="btn">Place Bargain</button>
			 	 		</c:if>
			 	 		<img style="display: none;" src="<spring:url value="/resources/images/ajax-loader.gif"/>" id="loading-indicator_bid"/>
			 	 	</form>
			 	 	<label id="bidMsg" class="" style="text-align:left;"></label>
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
			 	 	<a class="label label-info" style="font-size: medium;padding: 7px;"  href="${adLink}#placeBargain">Bargain</a>
		 	
			 	 </c:if>
			 	  <c:if test="${ad.buying == true}">
			 	 	<span class="label label-success" style="font-size: medium;padding: 7px;">Preffered Price - Rs. <fmt:formatNumber type="number" maxFractionDigits="2" value="${ad.price}" /> /- </span>     
			 	 
			 	 	<a class="label label-info" style="font-size: medium;padding: 7px;" href="${adLink}#placeOffer">Place an offer</a>
			 	 	
			 	 </c:if><br>
				
				<a rel="tooltip" title="Send an Email to seller/buyer" class="btn btn-success" style="margin-top: 20px;" data-toggle="modal" data-target="#contactFormModel" href="#"><i class="icon-envelope icon-1x" style="color: #FFF;"></i> Email</a>
			 	 <a id="showContact" class="btn btn-primary" style="margin-top: 20px;" >Show Contact Number</a>
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
			 	 	<label id="commentMsg" class="text-error" style="text-align:left;"></label>
			 	 </div>
			</div>
		</div>
	</div>

</div>
<h1 id="comments"></h1>



<script type="text/javascript">
$(document).ready(function() {
	$("#bidPop").popover();
	function collectFormData(fields) {
		var data = {};
		for (var i = 0; i < fields.length; i++) {
			var $item = $(fields[i]);
			data[$item.attr('name')] = $item.val();
		}
		return data;
	}
	var $form2= $('#BidForm');
	$form2.bind('submit', function(e) {
		// Ajax validation
		var $inputs = $form2.find('input,textarea');
		var data = collectFormData($inputs);
		
		
		$.post('${addBidLink}', data, function(response) {
			
			if (response.status == 'OK') {
				
				$("#bidMsg").text(response.msg);
			} else {
				$("#bidMsg").text(response.msg);
				$("#bidMsg").addClass("text-error");
				
			}
		}, 'json');
		
		e.preventDefault();
		return false;
	});
	
	var $form = $('#CommentForm');
	$form.bind('submit', function(e) {
		// Ajax validation
		var $inputs = $form.find('input,textarea');
		var data = collectFormData($inputs);
		
		
		$.post('${addCommentLink}', data, function(response) {
			
			if (response.status == 'OK') {
				
				$("#comments").append(tmpl("template-comment", response));
			} else {
				$("#commentMsg").text(response.error);
				
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
	$("#showContact").click(function () {
	    
		var text=$("#showContact").text();
		
		if(text == 'Show Contact Number'){
			
			$("#showContact").text('${ad.user.contactNo}')
		}else{
			
			$("#showContact").text('Show Contact Number')
		}
		
		
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
	if(settings.url == '${addBidLink}'){
		   $('#loading-indicator_bid').show();
		   
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
	if(settings.url == '${addBidLink}'){
		   $('#loading-indicator_bid').hide();
	} 
});

</script>
<script id="template-comment" type="text/x-tmpl">
    <p>by <a href="${userLink}">{%=o.username%}</a>
								    {%=o.comment%}<br><span style="font-size: smaller;">just now</span></p>
						
</script>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>