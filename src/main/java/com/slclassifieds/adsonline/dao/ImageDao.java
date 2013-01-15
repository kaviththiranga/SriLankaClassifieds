package com.slclassifieds.adsonline.dao;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Image;

@Repository
@Transactional
public class ImageDao {

	private HibernateTemplate hibernateTemplate;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) 
    {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
	}
	

	public Image getImgById(String id){
		Image img = (Image) hibernateTemplate.get(Image.class, id);
		
		return img;
	}
	public void save(Image img) {
		hibernateTemplate.saveOrUpdate(img);
		
	}


	public void update(Image img) {
		hibernateTemplate.update(img);
		
	}


	public void delete(Image img) {
		hibernateTemplate.delete(img);
		
	}

}
