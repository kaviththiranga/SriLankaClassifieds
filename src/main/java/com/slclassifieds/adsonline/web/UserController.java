package com.slclassifieds.adsonline.web;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.hibernate.Hibernate;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.support.SessionStatus;

import com.slclassifieds.adsonline.dao.AdvertisementDao;
import com.slclassifieds.adsonline.dao.UserDao;
import com.slclassifieds.adsonline.dao.UserDaoImpl;
import com.slclassifieds.adsonline.model.Advertisement;
import com.slclassifieds.adsonline.model.FavItem;
import com.slclassifieds.adsonline.model.Message;
import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.model.UserRole;
import com.slclassifieds.adsonline.model.ValidationResponse;
import com.slclassifieds.adsonline.service.UserService;
import com.slclassifieds.adsonline.web.support.SecurityQuestionAjaxResponse;
import com.slclassifieds.adsonline.web.validate.UserValidator;

/**
 * Handles requests for the register page.
 */
@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	private UserValidator userValidator;
	
	private UserDao userDao;
	
	private AdvertisementDao adDao;
	
	@Autowired
	public void setAdDao(AdvertisementDao adDao) {
		this.adDao = adDao;
	}

	@Autowired
	public UserController(UserValidator userValidator){
		this.userValidator = userValidator;
	}
	
	@Autowired
	public void setUserDao(UserDao userDaoImpl) {
		this.userDao = userDaoImpl;
	}
	@RequestMapping(value="/register",method = RequestMethod.GET)
	public String initSignupForm(ModelMap model, Principal pl){
		
		if(UserService.isUserLoggedIn())
		{			
			String msg = "Oops! You are already a registered user.";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-info");
			model.addAttribute("user", UserService.getCurrentUser());
		    return "profile";
		}
		User user= new User();
		user.setQuestion("What is your best friend's first name?");
		model.addAttribute("user", user);
		return "register";
	}
	
	@RequestMapping(value="/register",method = RequestMethod.POST)
	public String processSignupFormSubmit(
		@ModelAttribute("user") User user,
		BindingResult result, SessionStatus status,Model model) {
 
		userValidator.validate(user, result);
		
		String msg="";
 
		if (result.hasErrors()) {
			//if validator failed
			msg = "Some Errors Found. Please Check Again";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-error");
			user.setPassword("");
			user.setConfirmPassword("");
			return "register";
		} else {
			
			// Add default user roles
			user.addUserRole(userDao.getUserRoleByName("ROLE_USER"));	
			try {				
				
				userDao.save(user);				
				status.setComplete();
				
				logger.info("New User Created. Username:"+user.getUsername());
				
				msg = "Hi "+user.getName()+", Welcome to SLClassifieds.\nPlease Login Using" +
						" your username and password to continue.";
				
				model.addAttribute("mainmsg", msg);
				model.addAttribute("mainmsgclass", "alert-success");
				return "login";
				
			} catch (Exception e) {
				
				logger.info("User Account Creation Failed."+e.getStackTrace());
				
				msg = "Oops! Something went wrong in the Server. Please Try again later.";
				model.addAttribute("mainmsg", msg);	
				model.addAttribute("mainmsgclass", "alert-error");			
				return "register";
			}
			
		}
	}
	
	@RequestMapping(value="/register.json",method=RequestMethod.POST)
	public @ResponseBody ValidationResponse processFormAjaxJson(Model model, @ModelAttribute(value="user")User user, BindingResult result ){
		ValidationResponse res = new ValidationResponse();
		userValidator.validate(user, result);
		if(result.hasErrors()){
			res.setStatus("FAIL");
			
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
			
			List<FieldError> allErrors = result.getFieldErrors();
			List<Message> errorMesages = new ArrayList<Message>();
			for (FieldError objectError : allErrors) {
				errorMesages.add(new Message(objectError.getField(), objectError.getDefaultMessage()));
			}
			
			res.setErrorMessageList(errorMesages);

		}else{
			res.setStatus("SUCCESS");
		}

		return res;
	}
	
	@RequestMapping(value="/profile/edit",method = RequestMethod.GET)
	public String initProfileEditForm(ModelMap model){
		
		if(!UserService.isUserLoggedIn())
		{	
			String msg = "Oops! You are not logged in. Please Log in first.";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-error");
			return "login";
		}
 
		User user= UserService.getCurrentUser();
	
		model.addAttribute("user", user);
		return "editProfile";
	}
	
	@RequestMapping(value="/profile/edit",method = RequestMethod.POST)
	public String processProfileEditFormSubmit(
		@ModelAttribute("user") User user,
		BindingResult result, SessionStatus status, ModelMap model) {
 
		if(!UserService.isUserLoggedIn())
		{	
			String msg = "Oops! You are not logged in. Please Log in first.";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-error");
			return "login";
		}
		
		User oldUsr= userDao.findByUsername(user.getUsername());
		
		ValidationUtils.rejectIfEmptyOrWhitespace(result, "name",
				"", "name is required.");
		
		if(user.getContactNo().length()!=10){
			
			result.rejectValue("contactNo","", "Contact No is 10 digit. Eg- 077 XXX XXXX");
		}
		
		
		if(user.getPassword().length()!=0 && user.getPassword().length() < 6){
			
			result.rejectValue("password","", "New Password shoud be at least 6 chars");
		}

		if(user.getPassword().length()!=0 && !(user.getPassword().equals(user.getConfirmPassword()))){
			result.rejectValue("confirmPassword","", "Passwords do not match");
			result.rejectValue("password","", "Passwords do not match");
		}
		
		if(user.getPassword().length()==0){
			user.setPassword(oldUsr.getPassword());
			user.setConfirmPassword(oldUsr.getPassword());			
		}
		
		if(!(user.getQuestion().length()>0)){
			
			result.rejectValue("question","", "question is required.");
		}
		
		if(!(user.getAnswer().length()>0)){
			
			result.rejectValue("answer","", "answer is required.");
		}
		
 
		
		if (result.hasErrors()) {
			//if validator failed
			
			user.setPassword(oldUsr.getPassword());
			user.setConfirmPassword(oldUsr.getPassword());
			
			String msg = "Oops! Some errors were found.";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-error");
			
			return "editProfile";
		} else {
			status.setComplete();
			user.setUserRoles(oldUsr.getUserRoles());
			user.setUserId(oldUsr.getUserId());
			userDao.update(user);
			// Reload updated User object to current pricipal
			Authentication authentication = 
					new UsernamePasswordAuthenticationToken
					(user, user.getPassword(), user.getAuthorities());
			
	        SecurityContextHolder.getContext().setAuthentication(authentication);
			
			String msg = "Account has been successfully saved.";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-success");
			//form success
			return "profile";
		}
	}
	
	@RequestMapping(value="/profile/passwordReset.json",method = RequestMethod.POST)
	public @ResponseBody ValidationResponse initResetForm(ModelMap model,
				
			@RequestParam("password") String pw,@RequestParam("confirmPassword") String pwC,
			@RequestParam("j_username") String un
			){
		
		ValidationResponse response= new ValidationResponse();
		List<Message> errorMessageList= new ArrayList<Message>();
		
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
		
		if(pw.length() < 6){
			
			response.setStatus("ERROR");
			errorMessageList.add(new Message("password", "Password should at least be six chars"));
			
		}

		if(!(pw.equals(pwC))){
			response.setStatus("ERROR");
			errorMessageList.add(new Message("confirmPassword", "Passwords should Match"));
		}
		
		if(errorMessageList.size()==0){
			
			response.setStatus("SUCCESS");
			User user=  userDao.findByUsername(un);
			
			user.setPassword(pw);
			userDao.update(user);
		}

		response.setErrorMessageList(errorMessageList);
		
		return response;
	}
	
	
	@RequestMapping(value="/profile/passwordReset",method = RequestMethod.GET)
	public String submitResetForm(ModelMap model){
		
		return "reset";
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value="/ads/addToFavs",method = RequestMethod.POST)
	public @ResponseBody Message addToFavs(@RequestParam("adId") String adId){
		
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
		
		Message response;
		
		if(UserService.isUserLoggedIn()){
			User user = UserService.getCurrentUser();
			
			FavItem favItem = new FavItem(user,adDao.getAdById(adId));
			
			//user = userDao.fi
			
			boolean found = false;
			
			for(int i=0;i<user.getAllFavItems().size();i++){
				if(user.getAllFavItems().get(i).getAd().getAdId().equals(favItem.getAd().getAdId())){
					
					found = true;
				}
			}

			if(!found){
				user.getAllFavItems().add(favItem);
				userDao.save(favItem);
				response = new Message("adSummaryMsg", "This Ad is added to your wish list.","text-success");
			}
			else{
				
				response = new Message("adSummaryMsg", "This Ad is already in your wish list.","text-info");
			}	
		}
		else{

			response = new Message("adSummaryMsg", "Sorry You are not logged in.","text-error");
		}
		
		return response; 
		
	}
	
	@SuppressWarnings("unused")
	@RequestMapping(value="/profile/confirmAnswer.json",method = RequestMethod.POST)
	public @ResponseBody SecurityQuestionAjaxResponse validateAnswer(
			
			@RequestParam("j_username") String un, @RequestParam("answer") String an
			
			){
		
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
		
		User user=  userDao.findByUsername(un);
		
		SecurityQuestionAjaxResponse response = new SecurityQuestionAjaxResponse();
		logger.info("Username is "+un);
		logger.info("answer is "+an+" sdsd "+user.getAnswer());
		if(user.getAnswer().equals(an) ){
			response.setStatus("CORRECT");
			response.setQuestion(user.getQuestion());
			response.setUsername(user.getUsername());
			response.setName(user.getName());
		}
		else{

			response.setStatus("INCORRECT");
			response.setQuestion(user.getQuestion());
			response.setUsername(user.getUsername());
			response.setName(user.getName());

		}
		
		return response; 
		
	}
	@SuppressWarnings("unused")
	@RequestMapping(value="/profile/securityQuestion.json",method = RequestMethod.POST)
	public @ResponseBody SecurityQuestionAjaxResponse sendSecurityQuestion(@RequestParam("j_username") String un){
		
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
		
		User user=  userDao.findByUsername(un);
		
		SecurityQuestionAjaxResponse response = new SecurityQuestionAjaxResponse();
		
		if(user != null){
			response.setStatus("OK");
			response.setQuestion(user.getQuestion());
			response.setUsername(user.getUsername());
			response.setName(user.getName());
		}
		else{

			response.setStatus("NOT FOUND");

		}
		
		return response; 
		
	}
	
	@RequestMapping(value="/profile",method = RequestMethod.GET)
	public String initProfileView(ModelMap model){

		if(!UserService.isUserLoggedIn())
		{	
			String msg = "Oops! You are not logged in. Please Log in first.";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-error");
			return "login";
		}
		
		User user = UserService.getCurrentUser();
		Integer size = user.getAllFavItems().size();
		
		model.addAttribute("user", user);
		model.addAttribute("fav", size );
		return "profile";
	}
	
	@RequestMapping(value="/viewProfile",method = RequestMethod.GET)
	public String initUserProfileView(ModelMap model, HttpServletRequest request){

		if(!UserService.isUserLoggedIn())
		{	
			String msg = "Oops! You are not logged in. Please Log in first.";
			model.addAttribute("mainmsg", msg);	
			model.addAttribute("mainmsgclass", "alert-error");
			return "login";
		}
		
		User user = userDao.findByUserId(request.getParameter("userId"));
		model.addAttribute("user", user);
		return "profile";
	}
	
	@RequestMapping(value="/login", method = RequestMethod.GET)
	public String login(ModelMap model) {
 
		return "login";
 
	}
	
	@RequestMapping(value="/loginfailed", method = RequestMethod.GET)
	public String loginerror(ModelMap model) {
 
		model.addAttribute("error", "true");
		return "login";
 
	}
	
	@RequestMapping(value="/logout", method = RequestMethod.GET)
	public String logout(ModelMap model) {
 
		return "home";
 
	}
	
	
	@ModelAttribute("districts")
	public List<String> populateDistrictsList(){
		
		List<String> districts= new ArrayList<String>();
		
		districts.add("Colombo");		districts.add("Kandy");
		districts.add("Galle");			districts.add("Ampara");
		districts.add("Anuradhapura");	districts.add("Badulla");
		districts.add("Batticaloa");	districts.add("Gampaha");
		districts.add("Hambantota");	districts.add("Jaffna");
		districts.add("Kalutara");		districts.add("Kegalle");
		districts.add("Kilinochchi");	districts.add("Kurunegala");
		districts.add("Mannar");		districts.add("Matale");
		districts.add("Matara");		districts.add("Monaragala");
		districts.add("Mullativu");		districts.add("Nuwara Eliya");
		districts.add("Polonnaruwa");	districts.add("Puttalam");
		districts.add("Ratnapura");		districts.add("Trincomalee");
		districts.add("Vavuniya");
		
		return districts;
		
	}
	
	
	
}