package com.slclassifieds.adsonline.dao;

import java.util.List;

import com.slclassifieds.adsonline.model.Category;

public interface CategoryDao {

	public List<Category> getAllCategories();
	public void save(Category cat);
	public void update(Category cat);
	public void delete(Category cat);
	public Category getCategoryByName(String catName);
}
