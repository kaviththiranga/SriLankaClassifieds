package com.slclassifieds.adsonline.model;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="bids")
public class Bid implements Serializable {

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	@Column(name = "BID_ID")
	private String bidId;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="AD_ID" )
	private Advertisement ad;
	
	@Column(name = "AMOUNT")
	private double amount;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="USER_ID" )
	private User user;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "PLACED_ON")
	private Date placedOn;
	
	public String getBidId() {
		return bidId;
	}

	public void setBidId(String bidId) {
		this.bidId = bidId;
	}

	public Advertisement getAd() {
		return ad;
	}

	public void setAd(Advertisement ad) {
		this.ad = ad;
	}

	public double getAmount() {
		return amount;
	}

	public void setAmount(double amount) {
		this.amount = amount;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Date getPlacedOn() {
		return placedOn;
	}

	public void setPlacedOn(Date placedOn) {
		this.placedOn = placedOn;
	}

}
