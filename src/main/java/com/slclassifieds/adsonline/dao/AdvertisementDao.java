package com.slclassifieds.adsonline.dao;

import java.util.List;

import com.slclassifieds.adsonline.model.Advertisement;

public interface AdvertisementDao {
	
	public void save(Advertisement ad);
	public void update(Advertisement ad);
	public void delete(Advertisement ad);
	
	public Advertisement getAdById(String adId);
	public List<Advertisement> getAdsByUserId(String userId);

}
