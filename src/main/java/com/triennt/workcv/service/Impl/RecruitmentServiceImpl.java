package com.triennt.workcv.service.Impl;

import java.time.LocalDate;
import java.util.List;

import com.triennt.workcv.repository.RecruitmentRepo;
import com.triennt.workcv.service.CategoryService;
import com.triennt.workcv.service.CompanyService;
import com.triennt.workcv.service.RecruitmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.triennt.workcv.entity.Category;
import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;

@Service
public class RecruitmentServiceImpl implements RecruitmentService {

	@Autowired
	RecruitmentRepo recruitmentRepo;
	
	@Autowired
    CategoryService categoryService;

	@Autowired
    CompanyService companyService;
	
	@Override
	@Transactional
	public List<Recruitment> getTopRecruitment() {
		Pageable pageable = PageRequest.of(0,10);
		return recruitmentRepo.getTopRecruitment(pageable);
	}

	@Override
	@Transactional
	public Long getNumberOfRecruitments() {
		
		return recruitmentRepo.getNumberOfRecruitments();
	}

	@Override
	@Transactional
	public List<Recruitment> getRecruitmentsByUser(User currentUser) {
		
		return recruitmentRepo.getRecruitmentsByUser(currentUser);
	}


	@Override
	@Transactional
	public void addRecruitment(User sessionUser, Recruitment newRecruitment, int categoryId) {

		Company currentCompany = companyService.getCompanyByUser(sessionUser);
		Category tempCategory = categoryService.getCategoryById(categoryId);
		
		newRecruitment.setCategory(tempCategory);
		newRecruitment.setCompany(currentCompany);
		newRecruitment.setCreated(LocalDate.now());
		
		recruitmentRepo.save(newRecruitment);

	}

	@Override
	@Transactional
	public void updateRecruitment(User currentUser, Recruitment editRecruitment, int categoryId) {
		
		Category newCategory = categoryService.getCategoryById(categoryId);	
		Company tempCompany = companyService.getCompanyByUser(currentUser);
		
		editRecruitment.setCategory(newCategory);	
		editRecruitment.setCompany(tempCompany);
		
		recruitmentRepo.save(editRecruitment);
	}

	@Override
	@Transactional
	public void deleteRecruitmentById(int recruitmentId) {
		
		recruitmentRepo.deleteById(recruitmentId);
		
	}

	@Override
	@Transactional
	public Recruitment getRecruitmentById(int recruitmentId) {
		
		return recruitmentRepo.getById(recruitmentId);
	}

	@Override
	@Transactional
	public List<Recruitment> getRecruitmentsByKey(String keySearch, String typeSearch) {

		if(typeSearch.equals("recruitment"))
			return recruitmentRepo.searchRecruitmentsByRecruitment(keySearch);
		if(typeSearch.equals("company"))
			return recruitmentRepo.searchRecruitmentsByCompany(keySearch);
		if(typeSearch.equals("address"))
			return recruitmentRepo.searchRecruitmentsByAddress(keySearch);

		return null;
	}

	@Override
	@Transactional
	public List<Recruitment> getRecruitmentsOfCompany(int idCompany) {
		
		return recruitmentRepo.getRecruitmentsOfCompany(idCompany);
	}

	@Override
	@Transactional
	public List<Recruitment> getRecruitmentsOfCategory(int idCategory) {
		
		return recruitmentRepo.getRecruitmentsOfCategory(idCategory);
	}

	

	
	
	
}
