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
@Table(name="comments")
public class Comment implements Serializable {

	private static final long serialVersionUID = 1L;


	@Id
	@GeneratedValue
	@Column(name = "CMT_ID")
	private String cmtId;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="AD_ID" )
	private Advertisement ad;
	
	@ManyToOne(cascade = CascadeType.ALL)
    @JoinColumn(name="USER_ID" )
	private User user;
	
	@Column(name = "COMMENT")
	private String comment;
	
	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "COMMENTED_ON")
	private Date commentedOn;

	public String getCmtId() {
		return cmtId;
	}

	public void setCmtId(String cmtId) {
		this.cmtId = cmtId;
	}

	public Advertisement getAd() {
		return ad;
	}

	public void setAd(Advertisement ad) {
		this.ad = ad;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Date getCommentedOn() {
		return commentedOn;
	}

	public void setCommentedOn(Date commentedOn) {
		this.commentedOn = commentedOn;
	}

}
