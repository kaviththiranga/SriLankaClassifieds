package com.slclassifieds.adsonline.dao;

import java.util.List;

import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Bid;
import com.slclassifieds.adsonline.model.Comment;
import com.slclassifieds.adsonline.model.Image;

public interface AdvertisementDao {
	
	public void save(Advertisement ad);
	public void update(Advertisement ad);
	public void delete(Advertisement ad);
	public Advertisement getAdById(String adId);
	public List<Advertisement> getAdsByUserId(String userId);
	public List<Advertisement> getAllAds();
	public void save(Comment comment);
	public void save(Bid bid);

}
