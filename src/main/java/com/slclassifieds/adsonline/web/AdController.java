package com.slclassifieds.adsonline.web;

import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.slclassifieds.adsonline.dao.AdvertisementDao;
import com.slclassifieds.adsonline.dao.CategoryDao;
import com.slclassifieds.adsonline.dao.UserDao;
import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Category;
import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.service.UserService;
import com.slclassifieds.adsonline.web.support.CategoryEditor;
import com.slclassifieds.adsonline.web.validate.AdvertisementValidator;

@Controller
public class AdController {

	private static final Logger logger = LoggerFactory.getLogger(AdController.class);
	
	@Autowired
	private AdvertisementDao advertisementDao;
	
	public void setAdvertisementDao(AdvertisementDao advertisementDao) {
		this.advertisementDao = advertisementDao;
	}

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
		
		return "viewAd";
	}
	
	@RequestMapping(value="/ads/new", method= RequestMethod.GET)
	public String viewCreateAdForm(Model model){
		
		Advertisement ad = new Advertisement();
		model.addAttribute("ad", ad);
		
		return "createAd";
	}
	
	@RequestMapping(value="/ads/new", method= RequestMethod.POST)
	public String submitCreateAdForm(
			@ModelAttribute("ad") Advertisement ad,
			BindingResult result, SessionStatus status,Model model) {
		
		ad.setUser(UserService.getCurrentUser());
		ad.setCreatedOn(new Date());
		
		new AdvertisementValidator().validate(ad, result);
		
		String msg="";
 
		if (result.hasErrors()) {
			//if validator failed
			msg = "Some Errors Found. Please Check Again";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-error");
			return "createAd";
		} else {
			
			try {				
				
				advertisementDao.save(ad);			
				status.setComplete();
				
				logger.info("New ad Created. Ad id:"+ad.getAdId());
				
				msg = "Hi "+UserService.getCurrentUser().getName()+", Your new ad is created";
				model.addAttribute("mainmsg", msg);
				model.addAttribute("mainmsgclass", "alert-success");
				ad= new Advertisement();
				return "createAd";
				
			} catch (Exception e) {
				
				logger.info("New Ad Creation Failed."+e.getStackTrace());
				
				msg = "Oops! Something went wrong in the Server. Please Try again later.";
				model.addAttribute("mainmsg", msg);	
				model.addAttribute("mainmsgclass", "alert-error");			
				return "createAd";
			}
		}			
	}
	
	@ModelAttribute("cats")
	public List<Category> getCategories(){
		
		return catDao.getAllCategories();
	}
	
	@InitBinder
    public void initBinder(WebDataBinder binder) {
		
		CategoryEditor catEd= new CategoryEditor();
		catEd.setCatDao(catDao);
        binder.registerCustomEditor(Category.class,catEd);
    }
	
}
