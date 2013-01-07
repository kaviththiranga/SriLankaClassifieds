package com.slclassifieds.adsonline.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.JoinColumn;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;


@Entity
@Table(name = "users")
public class User implements Serializable, UserDetails {
	
	private static final long serialVersionUID = 1L;
	
	@Id
	@GeneratedValue
	@Column(name = "USER_ID")
	private String userId;
	
	@Column(name = "USERNAME")
	private String username;
	
	@Column(name = "PASSWORD")
	private String password;
	
	@Column(name="SECURITY_QUESTION")
	private String question;
	
	@Column(name="ANSWER")
	private String answer;
	
	@Transient
	private String confirmPassword;
	
	@Column(name = "ENABLED")
	private Short enabled;
	
	@Column(name = "NAME")
	private String name;
	
	@Column(name = "EMAIL")
	private String email;
	
	@Column(name = "CONTACT_NO")
	private String contactNo;

	@Column(name = "DISTRICT")
	private String district;
	
	@OneToMany(cascade = CascadeType.ALL)
	@JoinTable(name = "user_role", 
				joinColumns = { @JoinColumn(name = "USER_ID") }, 
				inverseJoinColumns = { @JoinColumn(name = "USER_ROLE_ID") })
	private List<UserRole> userRoles;
	
	@OneToMany(mappedBy="user", fetch=FetchType.LAZY)
	private List<Advertisement> allAds;
	
	@OneToMany(mappedBy="user", fetch=FetchType.LAZY)
	private List<Bid> allBids;
	
	@OneToMany(mappedBy="user", fetch=FetchType.LAZY)
	private List<Comment> allComments;
	
	public User(){
		this.enabled = 1;
		this.userRoles = new ArrayList<UserRole>();
	}
	
	public User(String userID, String username){
		
		this.userId = userID;
		this.username = username;
		this.enabled = 1;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	

	public String getQuestion() {
		return question;
	}

	public void setQuestion(String question) {
		this.question = question;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public String getConfirmPassword() {
		return confirmPassword;
	}

	public void setConfirmPassword(String confirmPassword) {
		this.confirmPassword = confirmPassword;
	}

	public Short getEnabled() {
		return enabled;
	}

	public void setEnabled(Short enabled) {
		this.enabled = enabled;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}
	
	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public List<UserRole> getUserRoles() {
		return userRoles;
	}

	public void setUserRoles(List<UserRole> userRoles) {
		this.userRoles = userRoles;
	}
	
	public void addUserRole(UserRole role){
		this.userRoles.add(role);
	}

	@Override
	public Collection<UserRole> getAuthorities() {

		return userRoles;
	}

	@Override
	public boolean isAccountNonExpired() {
		
		return (enabled==0)?false:true;
	}

	@Override
	public boolean isAccountNonLocked() {
		
		return (enabled==0)?false:true;
	}

	@Override
	public boolean isCredentialsNonExpired() {
		
		return (enabled==0)?false:true;
	}

	@Override
	public boolean isEnabled() {
	
		return (enabled==0)?false:true;
	}

	public List<Advertisement> getAllAds() {
		return allAds;
	}

	public void setAllAds(List<Advertisement> allAds) {
		this.allAds = allAds;
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
