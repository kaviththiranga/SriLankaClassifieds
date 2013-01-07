package com.slclassifieds.adsonline.model;
import java.util.List;

public class ValidationResponse {
	private String status;
	private List<Message> errorMessageList;
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public List<Message> getErrorMessageList() {
		return this.errorMessageList;
	}
	public void setErrorMessageList(List<Message> errorMessageList) {
		this.errorMessageList = errorMessageList;
	}
	
}