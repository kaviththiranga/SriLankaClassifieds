package com.slclassifieds.adsonline.web.validate;


import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;
import com.slclassifieds.adsonline.model.Advertisement;

public class AdvertisementValidator implements Validator {

	
	public boolean supports(Class clazz) {
		//just validate the Customer instances
		return Advertisement.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
 
		Advertisement ad = (Advertisement)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "title",
			"", "Title cannot be empty.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "desc",
				"", "description cannot be empty.");	
	
		
		if(ad.getPrice()<=0){
			
			errors.rejectValue("price","", "Price cannot be zero or negative");
		}
			
	}

  
}
