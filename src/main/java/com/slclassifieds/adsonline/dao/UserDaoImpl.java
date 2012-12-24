package com.slclassifieds.adsonline.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.model.User;

@Repository
public class UserDaoImpl implements UserDao  {

	private HibernateTemplate hibernateTemplate;

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
		hibernateTemplate.update(user);	
	}

	@Override
	public void delete(User user) {
		hibernateTemplate.delete(user);	
	}

	@Override
	public User findByUserId(String userId) {
		
		return (User) hibernateTemplate.get(User.class, userId);
		
	}

	
}