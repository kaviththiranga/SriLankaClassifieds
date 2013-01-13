package com.slclassifieds.adsonline.dao;

import java.util.List;

import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Image;

public interface AdvertisementDao {
	
	public void save(Advertisement ad);
	public void update(Advertisement ad);
	public void delete(Advertisement ad);
	public void save(Image img);
	public void update(Image img);
	public void delete(Image img);
	public Advertisement getAdById(String adId);
	public List<Advertisement> getAdsByUserId(String userId);

}
