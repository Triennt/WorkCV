package com.triennt.workcv.service;

import java.util.List;
import java.util.Map;

import com.triennt.workcv.entity.Category;

public interface CategoryService {

	Map<Category, Long> getTopCategories();
	
	List<Category> getCategories();

	Category getCategoryById(int id);

	void save(Category category);

	Category getCategoryByRecruitmentId(int id);
}
