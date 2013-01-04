package com.slclassifieds.adsonline.web.support;

import java.beans.PropertyEditorSupport;

import org.springframework.beans.factory.annotation.Autowired;

import com.slclassifieds.adsonline.dao.CategoryDao;
import com.slclassifieds.adsonline.model.Category;

public class CategoryEditor extends PropertyEditorSupport {

	@Autowired
	private CategoryDao catDao;
	
    public void setCatDao(CategoryDao catDao) {
		this.catDao = catDao;
	}

	// Converts a String to a Category (when submitting form)
    @Override
    public void setAsText(String text) {
        Category c = catDao.getCategoryByName(text);
        this.setValue(c);
    }

    /*// Converts a Category to a String (when displaying form)
    @Override
    public String getAsText() {
        Category c = (Category) this.getValue();
        return c.getCatName();
    }*/

}