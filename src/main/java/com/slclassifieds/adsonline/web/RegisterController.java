package com.slclassifieds.adsonline.web;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

/**
 * Handles requests for the register page.
 */
@Controller
@RequestMapping("/register")
public class RegisterController {
	
	private static final Logger logger = LoggerFactory.getLogger(RegisterController.class);
	
	/**
	 * Simply selects the registration form page view to render by returning its name.
	 */
	@RequestMapping(method = RequestMethod.GET)
	public String getRegisterForm(Locale locale, Model model) {
	
		return "register";
	}
	
	@RequestMapping(method = RequestMethod.POST)
	public String register(Locale locale, Model model) {
	
		return "home";
	}
	
}