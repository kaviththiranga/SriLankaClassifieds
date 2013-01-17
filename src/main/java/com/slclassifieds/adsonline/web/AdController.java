package com.slclassifieds.adsonline.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.support.PagedListHolder;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.ServletRequestUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.context.support.WebApplicationContextUtils;
import org.springframework.web.multipart.MultipartFile;

import com.slclassifieds.adsonline.dao.AdvertisementDao;
import com.slclassifieds.adsonline.dao.CategoryDao;
import com.slclassifieds.adsonline.dao.ImageDao;
import com.slclassifieds.adsonline.dao.UserDao;
import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.Bid;
import com.slclassifieds.adsonline.model.Category;
import com.slclassifieds.adsonline.model.Comment;
import com.slclassifieds.adsonline.model.FavItem;
import com.slclassifieds.adsonline.model.Image;
import com.slclassifieds.adsonline.model.Message;
import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.service.UserService;
import com.slclassifieds.adsonline.web.support.CategoryEditor;
import com.slclassifieds.adsonline.web.validate.AdvertisementValidator;

@Controller
public class AdController {

	private static final Logger logger = LoggerFactory.getLogger(AdController.class);
	
	@Autowired
	private AdvertisementDao advertisementDao;

	
	@Autowired	
	private ImageDao imgDao; 
	
	public void setAdvertisementDao(AdvertisementDao advertisementDao) {
		this.advertisementDao = advertisementDao;
	}

	@Autowired
	private CategoryDao catDao;
		
	public void setCategoryDao(CategoryDao catDao) {
		this.catDao = catDao;
	}

	@RequestMapping(value="/ads/viewAd", method= RequestMethod.GET)
	public String viewAdDetails(Model model, @RequestParam("adId")String adId){

		
		Advertisement ad = advertisementDao.getAdById(adId);
		model.addAttribute("ad", ad);
		model.addAttribute("currentUser", UserService.getCurrentUser());
		
		return "viewAd";
	}
	
	@RequestMapping(value="/ads/viewAllAds", method= RequestMethod.GET)
	public String viewAllAds(HttpServletRequest request,Model model){
		
		

		List ads =advertisementDao.getAllAds();
		model.addAttribute("ads", ads);
		
		return "viewAllAds";
	}
	
	@RequestMapping(value="/ads/myAds", method= RequestMethod.GET)
	public String viewMyAds(HttpServletRequest request,Model model){
		
		if(UserService.isUserLoggedIn())
		{
		
			List<Advertisement> ads =advertisementDao.getAdsByCurrentUser();
			model.addAttribute("ads", ads);
			return "adsByMe";
		}
		else{

			model.addAttribute("mainmsg", "Please login first");
			model.addAttribute("mainmsgclass", "alert-error");
			return "login";
		}
		
		
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/ads/wishList", method= RequestMethod.GET)
	public String viewMyFavAds(HttpServletRequest request,Model model){
		
		if(UserService.isUserLoggedIn())
		{
		
			List<FavItem> fis =UserService.getCurrentUser().getAllFavItems();
			List<Advertisement> ads = new ArrayList<Advertisement>();
			for(int i=0;i<fis.size();i++){
				
				ads.add(fis.get(i).getAd());
			}
			
			model.addAttribute("ads", ads);
			return "myFavAds";
		}
		else{

			model.addAttribute("mainmsg", "Please login first");
			model.addAttribute("mainmsgclass", "alert-error");
			return "login";
		}
	}
	
	@RequestMapping(value="/ads/new", method= RequestMethod.GET)
	public String viewCreateAdForm(Model model){
		
		Advertisement ad = new Advertisement();
		model.addAttribute("ad", ad);
		
		return "createAd";
	}
	
	@RequestMapping(value="/ads/new", method= RequestMethod.POST)
	public String submitCreateAdForm(
			@ModelAttribute("ad") Advertisement ad, HttpServletRequest request,
			BindingResult result, SessionStatus status,Model model) {
		
		ad.setUser(UserService.getCurrentUser());
		ad.setCreatedOn(new Date());
		
		new AdvertisementValidator().validate(ad, result);
		
		String msg="";
		
		List<Image> imgs = new ArrayList<Image>();
		
		for(int i=0;i<5;i++){
			String field = "img"+i;
			
			String id = (String) request.getParameter(field);
			logger.info(field+" "+id);
			if(id!=null){
				imgs.add(imgDao.getImgById(id));
			}
			
		}
		ad.setImages(imgs);
 
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
	
	@RequestMapping(value="/ads/addComment", method = RequestMethod.POST )
	public @ResponseBody HashMap<String,String> submitComment( @RequestParam("comment")String cmt,
			
			@RequestParam("adId")String adId
			
			){
		
		 	HashMap<String,String> map = new HashMap<String, String>();
		 
		 	// I am using a thread.sleep here because I want to see wether
			// the loading animations on client side is working.
			// Since I am testing the site in a local server, response is received very quickly.
			// So we didn't get enough time to see loading animations
			// Remove this try catch block when deploying in actual server
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// END TRY CATCH : NOTE REMOVE THIS BEFORE DEPLOYING
			
			if(UserService.isUserLoggedIn()){
				User user = UserService.getCurrentUser();	
				
				Comment comment = new Comment();
				comment.setAd(advertisementDao.getAdById(adId));
				comment.setComment(cmt);
				comment.setUser(user);
				comment.setCommentedOn(new Date());
				
				advertisementDao.save(comment);
				
				map.put("status", "OK");
				map.put("comment", cmt);
				map.put("username", user.getUsername());
				map.put("userid", user.getUserId());
				
				
			}
			else{
				map.put("status", "NOT_OK");
				map.put("error", "Please Login First.");
			}
		 
		 return map;
		
		
	}
	
	@RequestMapping(value="/ads/addBid", method = RequestMethod.POST )
	public @ResponseBody HashMap<String,String> submitBid( @RequestParam("amount")String bid,
			
			@RequestParam("adId")String adId
			
			){
		
		 	HashMap<String,String> map = new HashMap<String, String>();
		 
		 	// I am using a thread.sleep here because I want to see wether
			// the loading animations on client side is working.
			// Since I am testing the site in a local server, response is received very quickly.
			// So we didn't get enough time to see loading animations
			// Remove this try catch block when deploying in actual server
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			// END TRY CATCH : NOTE REMOVE THIS BEFORE DEPLOYING
			
			if(UserService.isUserLoggedIn()){
				User user = UserService.getCurrentUser();	
				
				Bid bd = new Bid();
				
				try{
					bd.setAmount(Double.parseDouble(bid));
					bd.setAd(advertisementDao.getAdById(adId));
					bd.setPlacedOn(new Date());
					bd.setUser(user);
					
					advertisementDao.save(bd);
					
					map.put("status", "OK");
					map.put("bidAmount", bd.getAmount()+"");
					map.put("username", user.getUsername());
					map.put("userid", user.getUserId());
					map.put("msg", "Offer has been placed successfully.");
				}
				catch(Exception exception){
					
					map.put("status", "NOT_OK");
					map.put("msg", "Oops! error happened. Did you enter text for amount?");
					exception.printStackTrace();
				}
						
			}
			else{
				map.put("status", "NOT_OK");
				map.put("msg", "Please Login First.");
			}
		 
		 return map;
		
		
	}
	
	@RequestMapping(value="/sendOwnerEmail", method = RequestMethod.POST )
	public @ResponseBody HashMap<String,String> sendOwnerEmail( @RequestParam("msg")String msg,
			
			@RequestParam("username")String username, @RequestParam("adId")String adId
			,@RequestParam("userId")String userId
			
			){
		
		 	HashMap<String,String> map = new HashMap<String, String>();
		 	
		 	return map;
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
