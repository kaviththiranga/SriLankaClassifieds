package com.slclassifieds.adsonline.web.validate;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import com.slclassifieds.adsonline.model.User;

public class UserValidator implements Validator {

	private HibernateTemplate hibernateTemplate;

	@Autowired
	public void setSessionFactory(SessionFactory sessionFactory) 
    {
		this.hibernateTemplate = new HibernateTemplate(sessionFactory);
	}
	
	
	public boolean supports(Class clazz) {
		//just validate the Customer instances
		return User.class.isAssignableFrom(clazz);
	}

	@Override
	public void validate(Object target, Errors errors) {
 
		User user = (User)target;
		
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "username",
			"", "username is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "name",
				"", "name is required.");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email",
				"", "Email is required.");
		
		
		{
			/*String hql = "select com.slclassifieds.adsonline.model.User where USERNAME = :un";
			Query query = hibernateTemplate..createQuery(hql);	
			
			query.setParameter("un", user.getUsername());
			User c = (User) query.uniqueResult();	
			if (c != null) {
			    
			}*/
			
			/*List<User> users = hibernateTemplate.find("from com.slclassifieds.adsonline.model.User where USERNAME = :un",user.getUsername());
		
			if (users.size()>0) {
			    errors.rejectValue("username", "Username is not available");
			}*/
			
		}		
		
		if(user.getPassword().length() < 6){
			
			errors.rejectValue("password","", "Password shoud be at least 6 chars");
		}

		if(!(user.getPassword().equals(user.getConfirmPassword()))){
			errors.rejectValue("confirmPassword","", "Passwords do not match");
			errors.rejectValue("password","", "Passwords do not match");
		}
	}

  
}
