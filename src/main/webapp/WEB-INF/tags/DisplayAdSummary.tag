<%@ include file="/WEB-INF/views/includes/includes.jsp" %>
<%@tag description="Displays a ad summary" pageEncoding="UTF-8"%>

<%@ attribute name="ad" required="true" rtexprvalue="true" type="com.slclassifieds.adsonline.model.Advertisement"%>



<spring:url value="/viewProfile?userId=${ad.user.userId}" var="profileLink"/>
<spring:url value="/ads/viewAd?adId=${ad.adId}" var="adLink"/>
<spring:url value="/ads/viewAdsByCategory?catId=${ad.category.catId}" var="catLink"/>
<spring:url value="/ads/addToFavs?adId=${ad.adId}" var="addToFavLink"/>

<div class="well" style="border-radius:20px">
	<div class="row">
	     <div class="span3">
	     	
	     	<div id="gallery" data-toggle="modal-gallery" data-target="#modal-gallery1" data-selector="img.gallery-item">
	     	
	     		<c:forEach items="${ad.images}" var="img" varStatus="status">
	     			<c:if test="${status.count == 1}">				
	     				<a href="" onclick="return false" class="thumbnail"><img class="gallery-item" data-href="<spring:url value="/${img.url}"/>" src="<spring:url value="/${img.thumbnail_url}" />" alt=""/></a>
	     			</c:if>
	     			<c:if test="${status.count ne 1}">
	     				<img style="display: none;" class="gallery-item" data-href="<spring:url value="/${img.url}"/>" src="<spring:url value="/${img.thumbnail_url}" />" alt=""/>
	     			</c:if>
	     		</c:forEach>
			</div>
		    <ul class="unstyled" style="text-align: right;margin-top: 10px;">
		    	<li ><c:if test="${ad.buying== false}">seller : </c:if><c:if test="${ad.buying == true}">Buyer : </c:if>
		    		<a rel="tooltip" title="Click here to view details of seller ${ad.user.username}" href="${profileLink}">${ad.user.username}</a></li>
		    		
				 <li >category : <a rel="tooltip" title="Click here to view ads under ${ad.category.catName} category" href="${catLink}">${ad.category.catName}</a></li>          	
				
		    </ul>
		</div>
		<div class="span8" >
		    <ul class="inline" >
		    	<c:if test="${ad.buying == true}">
			 	 	
			 	 	<li><span class="badge badge-warning">Wanted</span></li>
			 	 </c:if>		           
				<li><a rel="tooltip" title="Click here to view this ad" href="${adLink}"><h4>${ad.title}</h4></a></li>	
				
				
				<li><a id="addToFav${ad.adId}" href="${addToFavLink}" rel="tooltip" title="Click here to add this wish list"   ><i class="icon-star icon-1x" style="color: #FFCC00;"></i></a></li>		           	
				<li><img style="display: none;" src="<spring:url value="/resources/images/ajax-loader.gif"/>" id="loading-indicator${ad.adId}"/></li>
				
				<li style="font-size:small;">${ad.user.district}, <slclassifieds:TimeDef createdOn="${ad.createdOn}"/> ago</li>
			</ul>
			<blockquote>
				<p>${fn:substring(ad.desc,0,120)}...</p>
				<small><a rel="tooltip" title="Click here to view this ad" href="${adLink}">read more</a></small>
			</blockquote>
			<div class="span3" style="vertical-align: middle;">
				<c:if test="${ad.buying== false}"><!-- <a class="btn  btn-success btn" href="${adLink}">View</a> -->
			           
			 	<security:authorize access="isAuthenticated()">
			           
			       <!--<a class="btn btn-primary btn" href="${adLink}#bid">Bid</a>-->
			       
			 	</security:authorize>
			    <span class="label label-success" style="font-size: large;padding: 7px;">Rs. <fmt:formatNumber type="number" maxFractionDigits="2" value="${ad.price}" /> /- </span>     
			 	
			 	 </c:if>
			 	 <c:if test="${ad.buying == true}">
			 	 	<a class="btn btn btn-primary">Contact Buyer</a>
			 	 	
			 	 </c:if>
			 </div>
			 <div class="inline" style="text-align:right;padding-top: 10px;">
			     <ul class="inline" >
			     	<li><label id="adSummaryMsg${ad.adId}" style="text-align:right;"></label></li>
			     	<li><a rel="tooltip" title="Click here to view comments" href="${adLink}#comments">${fn:length(ad.allComments)} comments</a></li>
			      	<c:if test="${ad.buying == false}">| 
			      		<li><a  rel="tooltip" title="Click here to view bids" href="${adLink}#bids">${fn:length(ad.allBids)} bids</a></li>
			      	</c:if>
			      </ul>	
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

});
	 
$(document).ajaxComplete(function(event, request, settings) {
	if(settings.url == '${addToFavLink}'){
		$('#loading-indicator${ad.adId}').hide();
		 $("#addToFav${ad.adId}").show();
	}
});

</script>