package com.slclassifieds.adsonline.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.slclassifieds.adsonline.dao.AdvertisementDao;
import com.slclassifieds.adsonline.model.Advertisement;

@Controller
public class AdController {

	private static final Logger logger = LoggerFactory.getLogger(AdController.class);
	
	@Autowired
	private AdvertisementDao advertisementDao;
	
	@RequestMapping(value="/ads/viewAd", method= RequestMethod.GET)
	public String viewAdDetails(Model model){
		
		Advertisement ad = advertisementDao.getAdById("1");
		
		model.addAttribute("ad", ad);
		
		return "viewAd";
	}
	
}
