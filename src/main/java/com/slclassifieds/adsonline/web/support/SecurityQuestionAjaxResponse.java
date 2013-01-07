package com.slclassifieds.adsonline.web.support;

public class SecurityQuestionAjaxResponse {

	private String status;

	private String question;
	
	private String username;
	
	private String name;

	


	public SecurityQuestionAjaxResponse(){}
	
	
	public SecurityQuestionAjaxResponse(String question, String username) {
		super();
		this.question = question;
		this.username = username;
	}

	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
	
	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = name;
	}
	
	
	
}
