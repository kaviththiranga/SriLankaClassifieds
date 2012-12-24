package com.slclassifieds.adsonline.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.support.SessionStatus;

import com.slclassifieds.adsonline.model.User;
import com.slclassifieds.adsonline.web.validate.UserValidator;

/**
 * Handles requests for the register page.
 */
@Controller
@RequestMapping("/register")
public class RegisterController {
	
	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	UserValidator userValidator;
	
	@Autowired
	public RegisterController(UserValidator userValidator){
		this.userValidator = userValidator;
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String processSubmit(
		@ModelAttribute("user") User user,
		BindingResult result, SessionStatus status) {
 
		userValidator.validate(user, result);
 
		if (result.hasErrors()) {
			//if validator failed
			user.setPassword("");
			user.setConfirmPassword("");
			return "register";
		} else {
			status.setComplete();
			//form success
			return "registerSuccess";
		}
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String initForm(ModelMap model){
 
		User user= new User();
		
		model.addAttribute("user", user);
		return "register";
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
		districts.add("Matara");		districts.add("Moneragala");
		districts.add("Mullativu");		districts.add("Nuwara Eliya");
		districts.add("Polonnaruwa");	districts.add("Puttalam");
		districts.add("Ratnapura");		districts.add("Trincomalee");
		districts.add("Vavuniya");
		
		return districts;
		
	}
	
	
	
}