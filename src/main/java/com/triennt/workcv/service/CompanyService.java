package com.triennt.workcv.service;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.http.ResponseEntity;
import org.springframework.web.multipart.MultipartFile;

import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.User;

public interface CompanyService {

	Map<Company, Long> getTopCompanies();

	Company getCompanyByUser(User user);

	Long getNumberOfCompanies();

	void updateCompany(Company sessionCompany, Company companyEdit);

	ResponseEntity<String> updateLogo(Company sessionCompany, MultipartFile fileUpload, HttpServletRequest request);

	List<Company> getFollowedCompanies(User sessionUser);

	boolean unfollow(User sessionUser, int idCompany);

	Company getCompanyById(int idCompany);

	boolean hasFollowed(User sessionUser, int idCompany);

	void followCompany(User sessionUser, int idCompany);

	void createCompany(Company companyEdit); 

}
