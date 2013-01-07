package com.slclassifieds.adsonline.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="favs")
public class FavItem implements Serializable{

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name = "FAV_ID")
	private String favItemId;
	
	@ManyToOne
    @JoinColumn(name="USER_ID" )
	private User user;
	
	@ManyToOne
    @JoinColumn(name="AD_ID" )
	private Advertisement ad;
	
	

	public FavItem() {
		
	}	

	public FavItem(User user, Advertisement ad) {
		super();
		this.user = user;
		this.ad = ad;
	}



	public String getFavItemId() {
		return favItemId;
	}

	public void setFavItemId(String favItemId) {
		this.favItemId = favItemId;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Advertisement getAd() {
		return ad;
	}

	public void setAd(Advertisement ad) {
		this.ad = ad;
	}

}
