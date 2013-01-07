package com.slclassifieds.adsonline.model;

public class Message {

	private String fieldName;
	private String message;
	
	public Message(String fieldName, String message) {
		this.fieldName = fieldName;
		this.message = message;
	}
	public String getFieldName() {
		return fieldName;
	}
	public String getMessage() {
		return message;
	}
	
}