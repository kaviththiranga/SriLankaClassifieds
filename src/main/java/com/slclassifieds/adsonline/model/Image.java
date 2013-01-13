package com.slclassifieds.adsonline.model;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.servlet.ServletContext;

@Entity
@Table(name="images")
public class Image implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	@Column(name = "IMG_ID")
	private String imgID;
	
	@Column(name="IMG_NAME")
	private String name;
	
	@Transient
	private Integer size;
	
	@Column(name = "URL")
	private String url;
	
	@Column(name = "THUMB_URL")
	private String thumbnail_url;
	
	@Transient
	private String delete_url;
	
	@Transient
	private String delete_type;
	
	public Image() {
		super();
	}
	
	
	public Image(String name, Integer size, String url) {
		super();
		this.name = name;
		this.size = size;
		this.url = url;
	
	}
	
	public Image(String name, Integer size, String url,
			String thumbnail_url, String delete_url, String delete_type) {
		super();
		this.name = name;
		this.size = size;
		this.url = url;
		this.thumbnail_url = thumbnail_url;
		this.delete_url = delete_url;
		this.delete_type = delete_type;
	}
	
	

	public String getImgID() {
		return imgID;
	}


	public void setImgID(String imgID) {
		this.imgID = imgID;
	}


	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Integer getSize() {
		return size;
	}

	public void setSize(Integer size) {
		this.size = size;
	}

	public String getUrl() {
		
		
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getThumbnail_url() {
		return thumbnail_url;
	}

	public void setThumbnail_url(String thumbnail_url) {
		this.thumbnail_url = thumbnail_url;
	}

	public String getDelete_url() {
		return delete_url;
	}

	public void setDelete_url(String delete_url) {
		this.delete_url = delete_url;
	}

	public String getDelete_type() {
		return delete_type;
	}

	public void setDelete_type(String delete_type) {
		this.delete_type = delete_type;
	}
	
}
