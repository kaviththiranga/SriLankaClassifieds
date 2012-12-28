<c:if test="${not empty mainmsg}">
	
	<div class="alert ${mainmsgclass}" style="margin-left: 30px;margin-right: 30px;">
		<a class="close" data-dismiss="alert">×</a> 
	    <p><i class="icon-info-sign" style="margin-right: 5px;"></i>${mainmsg}</p>
	</div>


</c:if>
<c:if test="${not empty error}">
	
	<div class="alert alert-error" style="margin-left: 30px;margin-right: 30px;">
		<a class="close" data-dismiss="alert">×</a>
		<p><i class="icon-info-sign" style="margin-right: 5px;"></i> 
	    Your login attempt was not successful, try again. Caused :
		${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}</p>
	</div>


</c:if>

<!-- <div id="msgmodel" class="modal hide fade">
		<div class="modal-header">					
			<button type="button" class="close" data-dismiss="modal"
				aria-hidden="true">&times;</button>
			<h4>Notificaton Msg</h4>
		</div>
		<div class="modal-body">
			<div class="alerts">
				<div class="${mainmsgclass}">
					<p>${mainmsg}</p>
				</div>
			</div>	
		</div>
		<div class="modal-footer">					
						
		</div>
		
	</div>
	
	<c:if test="${not empty error}">
		<div class="alerts">
			<div class="alert-message error">
				Your login attempt was not successful, try again.<br /> Caused :
				${sessionScope["SPRING_SECURITY_LAST_EXCEPTION"].message}
			</div>
		</div>
	</c:if>
 -->