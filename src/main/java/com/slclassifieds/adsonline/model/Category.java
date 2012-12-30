package com.slclassifieds.adsonline.model;

import java.io.Serializable;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="categories")
public class Category implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name = "CAT_ID")
	private String catId;
	
	@Column(name = "CAT_NAME", unique=true)
	private String catName;
	
	@Column(name ="DESC" , nullable = true)
	private String desc;
	
	@OneToMany(mappedBy="category")
	private List<Advertisement> allAds;
	
	public Category(){}

	public String getCatId() {
		return catId;
	}

	public void setCatId(String catId) {
		this.catId = catId;
	}

	public String getCatName() {
		return catName;
	}

	public void setCatName(String catName) {
		this.catName = catName;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public List<Advertisement> getAllAds() {
		return allAds;
	}

	public void setAllAds(List<Advertisement> allAds) {
		this.allAds = allAds;
	}
	

}
