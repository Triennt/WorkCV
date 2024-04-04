package com.triennt.workcv.service;

import java.util.List;

import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;

public interface RecruitmentService {

	List<Recruitment> getTopRecruitment();

	Long getNumberOfRecruitments();

	List<Recruitment> getRecruitmentsByUser(User currentUser);

	void addRecruitment(User sessionUser, Recruitment newRecruitment, int categoryId);

	void updateRecruitment(User currentUser, Recruitment editRecruitment, int categoryId);

	void deleteRecruitmentById(int recruitmentId);

	Recruitment getRecruitmentById(int recruitmentId);

	List<Recruitment> getRecruitmentsByKey(String keySearch,String typeSearch);

	List<Recruitment> getRecruitmentsOfCompany(int idCompany);

	List<Recruitment> getRecruitmentsOfCategory(int idCategory);

	 
	
}
