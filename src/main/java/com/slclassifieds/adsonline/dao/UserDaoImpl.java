package com.slclassifieds.adsonline.dao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import javax.sql.DataSource;


import org.hibernate.Hibernate;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Category;
import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.model.UserRole;


@Repository
@Transactional
public class UserDaoImpl implements UserDao  {

	private HibernateTemplate hibernateTemplate;
	
	@Autowired
	private DataSource dataSource;
	
	@Autowired
	private AdvertisementDao advertisementDao;


	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) 
    {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
	}

	@Override
	public void save(User user) {
		hibernateTemplate.save(user);
	}


	@Override
	public void update(User user) {
		
			hibernateTemplate.saveOrUpdate(user);
			
				for(int i=0;i<user.getAllFavItems().size();i++){
					hibernateTemplate.saveOrUpdate(user.getAllFavItems().get(i));
				}
	}

	@Override
	public void delete(User user) {
		hibernateTemplate.delete(user);	
	}

	@Override
	public User findByUserId(String userId) {
		
		User user = (User) hibernateTemplate.get(User.class, userId);
		//user.setUserRoles(getUserRolesByUserId(user.getUserId()));
		return user;
	}

	@Override
	public User findByUsername(String username) {
		
		Object [] params = new Object [] {username};
	    String hql = "from User as u where u.username = ?";

	    @SuppressWarnings("unchecked")
		List <User> userList = (List<User>)hibernateTemplate.find(hql, params);
	    
	    if(!userList.isEmpty()){
	    	
	    	//userList.get(0).setUserRoles(getUserRolesByUserId(userList.get(0).getUserId()));
	    	//userList.get(0).setAllAds(advertisementDao.getAdsByUserId(userList.get(0).getUserId()));
	    	
	    	return userList.get(0);
	    }
		return null;
	}

	
	@Override
	public boolean isUserNameAvailable(String username) {
		
		return (findByUsername(username) == null)?true:false;
	}
	
	@Override
	public UserRole getUserRoleByName(String roleName){
		
		Object [] params = new Object [] {roleName};
	    String hql = "from UserRole as u where u.role = ?";

	    @SuppressWarnings("unchecked")
		List <UserRole> roleList = (List<UserRole>)hibernateTemplate.find(hql, params);
	    
	    return ( !roleList.isEmpty() ) ? roleList.get(0) : null;
	}


	@SuppressWarnings("unchecked")
	public List<UserRole> getUserRolesByUserId(String userId){
		
		String sql = "SELECT * FROM roles as u, user_role as ur" +
	    		" WHERE ur.USER_ROLE_ID=u.USER_ROLE_ID AND ur.USER_ID = :uID";
		
		List <UserRole> roleList= new ArrayList<UserRole>();
	
	    Query qry = hibernateTemplate.getSessionFactory().getCurrentSession().
	    			createSQLQuery(sql)
	    			.addEntity(UserRole.class)
	    			.setParameter("uID", userId);
	    
	    roleList = ( List <UserRole> ) qry.list();
	   
	    return roleList;
	}
	
	@Override
	public void addNewUserRole(UserRole uR){
		
		hibernateTemplate.save(uR);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Advertisement> getFavAdsByUserId(String userId) {
		
		String sql = "SELECT * FROM ads AS ad, favs as fav WHERE fav.USER_ID = :uID AND fav.AD_ID = ad.AD_ID";
		
		List <Advertisement> adList= new ArrayList<Advertisement>();
	
	    Query qry = hibernateTemplate.getSessionFactory().getCurrentSession().
	    			createSQLQuery(sql)
	    			.addEntity(Advertisement.class)
	    			.setParameter("uID", userId);
	    
	    adList = ( List <Advertisement> ) qry.list();
	   
	    return adList;
	}
	
	

	
	
}
