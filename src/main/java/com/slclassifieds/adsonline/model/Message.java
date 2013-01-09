package com.slclassifieds.adsonline.model;

public class Message {

	private String fieldName;
	private String message;
	private String style;
	
	public Message(String fieldName, String message) {
		this.fieldName = fieldName;
		this.message = message;
	}
	
	public Message(String fieldName, String message, String style) {
		super();
		this.fieldName = fieldName;
		this.message = message;
		this.style = style;
	}

	public String getFieldName() {
		return fieldName;
	}
	public String getMessage() {
		return message;
	}
	public String getStyle() {
		return style;
	}
	public void setStyle(String style) {
		this.style = style;
	}
	
	
}