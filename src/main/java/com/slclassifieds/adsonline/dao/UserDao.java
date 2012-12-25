package com.slclassifieds.adsonline.dao;


import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.model.UserRole;

@Transactional
public interface UserDao {
	
	void save(User user);
	void update(User user);
	void delete(User user);
	User findByUserId(String userId);
	public boolean isUserNameAvailable(String username);
	public UserRole getUserRoleByName(String roleName);
	public void addNewUserRole(UserRole uR);

}
