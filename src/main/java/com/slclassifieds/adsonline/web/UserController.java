package com.slclassifieds.adsonline.web;

import java.security.Principal;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ValidationUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.slclassifieds.adsonline.dao.UserDao;
import com.slclassifieds.adsonline.dao.UserDaoImpl;
import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.model.UserRole;
import com.slclassifieds.adsonline.service.UserService;
import com.slclassifieds.adsonline.web.validate.UserValidator;

/**
 * Handles requests for the register page.
 */
@Controller
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(UserController.class);
	
	private UserValidator userValidator;
	
	private UserDao userDao;
	
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
		model.addAttribute("user", user);
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