package com.slclassifieds.adsonline.model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

@Entity
@Table(name="ads")
public class Advertisement implements Serializable {

	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name = "AD_ID")
	private String adId;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="CAT_ID" )
	private Category category;
	   
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="USER_ID" )
	private User user;
	
	@Column(name = "TITLE")
	private String title;
	
	@Column(name = "DESCRIPTION", nullable = true)
	private String desc;

	@Column(name = "PRICE")
	private double price;
	
	@Column(name ="IMG1" , nullable = true)
	private String imageOne;
	
	@Column(name ="IMG2" , nullable = true)
	private String imageTwo;
	
	@Column(name ="IMG3" , nullable = true)
	private String imageThree;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name ="CREATED")
	private Date createdOn;
	
	@OneToMany(mappedBy="ad")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<Bid> allBids;
	
	@OneToMany(mappedBy="ad")
	@LazyCollection(LazyCollectionOption.FALSE)
	private List<Comment> allComments;
	
	public Advertisement(){}

	public String getAdId() {
		return adId;
	}

	public void setAdId(String adId) {
		this.adId = adId;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}
	

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getImageOne() {
		return imageOne;
	}

	public void setImageOne(String imageOne) {
		this.imageOne = imageOne;
	}

	public String getImageTwo() {
		return imageTwo;
	}

	public void setImageTwo(String imageTwo) {
		this.imageTwo = imageTwo;
	}

	public String getImageThree() {
		return imageThree;
	}

	public void setImageThree(String imageThree) {
		this.imageThree = imageThree;
	}

	public Date getCreatedOn() {
		return createdOn;
	}

	public void setCreatedOn(Date createdOn) {
		this.createdOn = createdOn;
	}

	public List<Bid> getAllBids() {
		return allBids;
	}

	public void setAllBids(List<Bid> allBids) {
		this.allBids = allBids;
	}

	public List<Comment> getAllComments() {
		return allComments;
	}

	public void setAllComments(List<Comment> allComments) {
		this.allComments = allComments;
	}
		
	
}
