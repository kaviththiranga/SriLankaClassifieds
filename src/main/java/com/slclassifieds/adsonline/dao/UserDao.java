package com.slclassifieds.adsonline.dao;


import java.util.List;

import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Category;
import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.model.UserRole;


public interface UserDao {
	
	void save(User user);
	void update(User user);
	void delete(User user);
	User findByUserId(String userId);
	User findByUsername(String username);
	public boolean isUserNameAvailable(String username);
	public UserRole getUserRoleByName(String roleName);
	public List<UserRole> getUserRolesByUserId(String userId);
	public void addNewUserRole(UserRole uR);
	public List<Advertisement> getFavAdsByUserId(String userId);

}
