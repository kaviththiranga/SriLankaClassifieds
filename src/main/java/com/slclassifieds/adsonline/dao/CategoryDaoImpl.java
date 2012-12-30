package com.slclassifieds.adsonline.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.model.Category;
import com.slclassifieds.adsonline.model.User;

@Repository
@Transactional
public class CategoryDaoImpl implements CategoryDao {
	
	private HibernateTemplate hibernateTemplate;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) 
    {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
	}

	@Override
	public List<Category> getAllCategories() {
		
	    String hql = "from Category";
	    @SuppressWarnings("unchecked")
		List <Category> catList = (List<Category>)hibernateTemplate.find(hql);
		return catList;
	}

	@Override
	public void save(Category cat) {
		
		hibernateTemplate.save(cat);
	}

	@Override
	public void update(Category cat) {
		hibernateTemplate.update(cat);

	}

	@Override
	public void delete(Category cat) {
		
		hibernateTemplate.delete(cat);

	}

	@Override
	public Category getCategoryByName(String catName) {
		
		Object [] params = new Object [] {catName};
		
	    String hql = "from Category as c where c.catName = ?";

	    @SuppressWarnings("unchecked")
		List <Category> catList = (List<Category>)hibernateTemplate.find(hql, params);
	    
	    if(!catList.isEmpty()){
	    	
	    	return catList.get(0);
	    }
		return null;
	}


}
