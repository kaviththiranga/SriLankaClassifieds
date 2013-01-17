package com.slclassifieds.adsonline.dao;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Bid;
import com.slclassifieds.adsonline.model.Comment;
import com.slclassifieds.adsonline.model.Image;
import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.model.UserRole;
import com.slclassifieds.adsonline.service.UserService;

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
	public void save(Advertisement ad) 
	{	
		
		hibernateTemplate.saveOrUpdate(ad);
	}
	
	public void save(Comment ad) 
	{		
		ad.setAd((Advertisement) hibernateTemplate.getSessionFactory().getCurrentSession().merge(ad.getAd()));
		ad.setUser( (User) hibernateTemplate.getSessionFactory().getCurrentSession().merge(ad.getUser()));
		
		hibernateTemplate.saveOrUpdate(ad);
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

	
	@SuppressWarnings("unchecked")
	@Override
	public List<Advertisement> getAdsByUserId(String userId) {

		String sql = "SELECT * FROM ads WHERE USER_ID=:uID";
		
		List <Advertisement> adList= new ArrayList<Advertisement>();
	
	    Query qry = hibernateTemplate.getSessionFactory().getCurrentSession().
	    			createSQLQuery(sql)
	    			.addEntity(Advertisement.class)
	    			.setInteger("uID", Integer.parseInt(userId));
	    
	    adList = ( List <Advertisement> ) qry.list();
	   
	    return adList;
	}


	@Override
	public List<Advertisement> getAllAds() {
		String sql = "SELECT * FROM ads ORDER BY CREATED DESC";
		
		List <Advertisement> adList= new ArrayList<Advertisement>();
	
	    Query qry = hibernateTemplate.getSessionFactory().getCurrentSession().
	    			createSQLQuery(sql)
	    			.addEntity(Advertisement.class);
	    
	    adList = ( List <Advertisement> ) qry.list();
	   
	    return adList;
	}

	@Override
	public void save(Bid bid) {
		bid.setAd((Advertisement) hibernateTemplate.getSessionFactory().getCurrentSession().merge(bid.getAd()));
		bid.setUser( (User) hibernateTemplate.getSessionFactory().getCurrentSession().merge(bid.getUser()));
		
		hibernateTemplate.saveOrUpdate(bid);
		
	}

	@Override
	public List<Advertisement> getAdsByCurrentUser() {
		
		return getAdsByUserId(UserService.getCurrentUser().getUserId());
	}

}
