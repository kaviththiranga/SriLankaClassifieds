<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<%@tag description="Displays a ad summary" pageEncoding="UTF-8"%>

<%@ attribute name="ad" required="true" rtexprvalue="true" type="com.slclassifieds.adsonline.model.Advertisement"%>

<spring:url value="/${ad.imageOne}" var="imageOneUrl"/>
<spring:url value="/viewProfile?userId=${ad.user.userId}" var="profileLink"/>
<spring:url value="/ads/viewAd?adId=${ad.adId}" var="adLink"/>
<spring:url value="/ads/viewAdsByCategory?catId=${ad.category.catId}" var="catLink"/>
<spring:url value="/ads/addToFavs?adId=${ad.adId}" var="addToFavLink"/>

<div class="well">
	<div class="row">
	     <div class="span3">
		    <a href="${imageOneUrl}" class="thumbnail">
		    	<img src="${imageOneUrl}" alt=""/>
		    </a>
		</div>
		<div class="span8" >
		    <ul class="inline" >		           
				<li><a rel="tooltip" title="Click here to view this ad" href="${adLink}"><h4>${ad.title}</h4></a></li>	
				
				
				<li><a id="addToFav${ad.adId}" href="${addToFavLink}" rel="tooltip" title="Click here to add this wish list"   ><i class="icon-star-empty"></i></a></li>		           	
				<li><img style="display: none;" src="<spring:url value="/resources/images/ajax-loader.gif"/>" id="loading-indicator${ad.adId}"/></li>
				
				<li style="font-size:small;"> Category : <a rel="tooltip" title="Click here to view ads under this category" href="${catLink}">${ad.category.catName}</a></li>
				
				<li style="font-size:small;">Posted by : <a rel="tooltip" title="Click here to view details of seller" href="${profileLink}">${ad.user.username}</a></li>
				           	
				<li style="font-size:small;">${ad.user.district},<slclassifieds:TimeDef createdOn="${ad.createdOn}"/> ago</li>
			</ul>
			<p>${fn:substring(ad.desc,0,100)}...<a rel="tooltip" title="Click here to view this ad" href="${adLink}">read more</a></p>
			
			<p>
				<a class="btn  btn-success btn" href="${adLink}">View</a>
			           
			 	<security:authorize access="isAuthenticated()">
			           
			       <a class="btn btn-primary btn" href="${adLink}#bid">Bid</a>
			       
			 	</security:authorize>
			         
			 	<a class="btn btn btn-primary disabled">Rs. <fmt:formatNumber type="number" maxFractionDigits="2" value="${ad.price}" /> /- </a>
			 	<label id="adSummaryMsg${ad.adId}"></label>
			 </p>
			 <div style="text-align:right;">
			     <p>
			     	<a rel="tooltip" title="Click here to view comments" href="${adLink}#comments">${fn:length(ad.allComments)} comments</a>
			      	| 
			      	<a  rel="tooltip" title="Click here to view bids" href="${adLink}#bids">${fn:length(ad.allBids)} bids</a></p>
			  </div>         
		</div>
	             
	</div>
</div>

<script type="text/javascript">
$(document).ready(function() {
	$("#addToFav${ad.adId}").click(function () {
	    
		var data="";
		
		$.post('${addToFavLink}', data, function(response) {
			
			$("#adSummaryMsg${ad.adId}").text(response.message);
			
		}, 'json');
		
		
	    return false;
	});

});

$(document).ajaxSend(function(event, request, settings) {
	   $('#loading-indicator${ad.adId}').show();
	  

});
	 
$(document).ajaxComplete(function(event, request, settings) {
		$('#loading-indicator${ad.adId}').hide();
	
});

</script>