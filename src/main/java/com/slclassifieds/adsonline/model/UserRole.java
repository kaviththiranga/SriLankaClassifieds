package com.slclassifieds.adsonline.model;

import java.io.Serializable;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import org.springframework.security.core.GrantedAuthority;


@Entity
@Table(name="roles")
public class UserRole implements Serializable,GrantedAuthority{

	private static final long serialVersionUID = 1L;

	@Id
	@GeneratedValue
	@Column(name="USER_ROLE_ID")
	private String roleId;
	
	@Column(name="ROLE")
	private String role;
	
	public UserRole(){}
	
	public UserRole(String role){
		this.role = role;
	}

	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@Override
	public String getAuthority() {
		
		return role;
	}
	
	
}
