package com.slclassifieds.adsonline.dao;

import java.util.List;

import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.User;

@Repository
@Transactional
public class AdvertisementDaoImpl implements AdvertisementDao {
	
	private HibernateTemplate hibernateTemplate;
	
	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) 
    {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
	}

	@Override
	public void save(Advertisement ad) {
		hibernateTemplate.save(ad);
	}

	@Override
	public void update(Advertisement ad) {
		hibernateTemplate.update(ad);

	}

	@Override
	public void delete(Advertisement ad) {
	  hibernateTemplate.delete(ad);

	}

	@Override
	public Advertisement getAdById(String adId) {
		
		Advertisement ad = (Advertisement) hibernateTemplate.get(Advertisement.class, adId);
		
		return ad;
	}

	@Override
	public List<Advertisement> getAdsByUserId() {
		// TODO Auto-generated method stub
		return null;
	}

}
