package com.slclassifieds.adsonline.dao;

import com.slclassifieds.adsonline.model.User;

public interface UserDao {
	
	void save(User user);
	void update(User user);
	void delete(User user);
	User findByUserId(String userId);
	public boolean isUserNameAvailable(String username);

}
