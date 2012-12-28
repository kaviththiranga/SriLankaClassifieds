package com.slclassifieds.adsonline.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.dao.UserDao;
import com.slclassifieds.adsonline.model.User;

@Service
@Transactional
public class UserService implements UserDetailsService {

	private UserDao userDao;
	
	@Autowired
	public void setUserDao(UserDao userDaoImpl) {
		this.userDao = userDaoImpl;
	}
	@Override
	public UserDetails loadUserByUsername(String username)
			throws UsernameNotFoundException {
		
		UserDetails user = userDao.findByUsername(username);
		
		if(user!=null){
			
			return user;
		}
		
		throw new UsernameNotFoundException(username);
	}
	
	public static boolean isUserLoggedIn(){
		
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
		
		return (principal instanceof UserDetails) ? true : false;
	}
	
	public static User getCurrentUser(){
		
		return (User)SecurityContextHolder.getContext().getAuthentication().getPrincipal();
	}

}
