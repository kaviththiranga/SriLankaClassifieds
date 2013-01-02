package com.slclassifieds.adsonline.web;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.slclassifieds.adsonline.dao.AdvertisementDao;
import com.slclassifieds.adsonline.dao.CategoryDao;
import com.slclassifieds.adsonline.dao.UserDao;
import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Category;
import com.slclassifieds.adsonline.service.UserService;

@Controller
public class AdController {

	private static final Logger logger = LoggerFactory.getLogger(AdController.class);
	
	@Autowired
	private AdvertisementDao advertisementDao;
	
	@Autowired
	private CategoryDao catDao;
	
	

	
	public void setCategoryDao(CategoryDao catDao) {
		this.catDao = catDao;
	}




	@RequestMapping(value="/ads/viewAd", method= RequestMethod.GET)
	public String viewAdDetails(Model model){

		Advertisement ad = advertisementDao.getAdById("1");
		Advertisement ad2 = advertisementDao.getAdById("2");
		model.addAttribute("ad", ad);
		model.addAttribute("ad2", ad2);
		
		
		/*Advertisement ad2= new Advertisement();
		
		ad2.setCategory(catDao.getAllCategories().get(2));
		
		ad2.setUser(UserService.getCurrentUser());
		ad2.setImageOne(null);
		ad2.setImageTwo(null);
		ad2.setImageThree(null);
		
		ad2.setCreatedOn(new Date());
		
		ad2.setPrice(102.0);
		
		ad2.setTitle("New Ad");
		
		ad2.setDesc("description");
	
		advertisementDao.save(ad2);*/
		
		return "viewAd";
	}
	
}
