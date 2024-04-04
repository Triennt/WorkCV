package com.triennt.workcv.service.Impl;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import com.triennt.workcv.repository.CategoryRepo;
import com.triennt.workcv.service.CategoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.triennt.workcv.entity.Category;

@Service
public class CategoryServiceImpl implements CategoryService {
	
	@Autowired
	CategoryRepo categoryRepo;

	@Override
	@Transactional
	public Map<Category, Long> getTopCategories() {
		Pageable pageable = PageRequest.of(0,4);

		List<Object[]> categoriesAndNumber= categoryRepo.getCategoriesAndNumber(pageable);
		Map<Category, Long> topCategories = new LinkedHashMap<>();
		for (Object[] row : categoriesAndNumber) {
		    if (row.length == 2 && row[0] instanceof Category && row[1] instanceof Long) {
		    	Category category = (Category) row[0];
		        Long recruitmentCount = (Long) row[1];
		        topCategories.put(category, recruitmentCount);
		    }
		}
		
		return topCategories;
	}

	@Override
	@Transactional
	public List<Category> getCategories() {
		
		return categoryRepo.findAll();
	}

	@Override
	@Transactional
	public Category getCategoryById(int id) {
		
		return categoryRepo.getCategoryById(id);
	}

	@Override
	@Transactional
	public void save(Category category) {

		categoryRepo.save(category);
		
	}

	@Override
	@Transactional
	public Category getCategoryByRecruitmentId(int id) {
		
		return categoryRepo.getCategoryByRecruitmentId(id);
	}

	
	
}
