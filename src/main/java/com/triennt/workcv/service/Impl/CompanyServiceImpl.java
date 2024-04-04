package com.triennt.workcv.service.Impl;

import java.io.File;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import com.triennt.workcv.repository.CompanyRepo;
import com.triennt.workcv.repository.FollowCompanyRepo;
import com.triennt.workcv.service.CompanyService;
import com.triennt.workcv.util.SaveFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.FollowCompany;
import com.triennt.workcv.entity.User;

@Service
public class CompanyServiceImpl implements CompanyService {
	
	@Autowired
	CompanyRepo companyRepo;

	@Autowired
	FollowCompanyRepo followCompanyRepo;

	@Override
	@Transactional
	public Map<Company, Long> getTopCompanies() {

		Pageable pageable = PageRequest.of(0,4);
		List<Object[]> topCompanies = companyRepo.getTopCompanies(pageable);

		Map<Company, Long> topCompanyAndRecruitmentCount = new LinkedHashMap<>();
		for (Object[] row : topCompanies) {
		    if (row.length == 2 && row[0] instanceof Company && row[1] instanceof Long) {
		        Company company = (Company) row[0];
		        Long recruitmentCount = (Long) row[1];
		        topCompanyAndRecruitmentCount.put(company, recruitmentCount);
		    }
		}
		
		return topCompanyAndRecruitmentCount;
	}
	

	@Override
	@Transactional
	public Long getNumberOfCompanies() {
		
		return companyRepo.getNumberOfCompanies();
	}


	@Override
	@Transactional
	public Company getCompanyByUser(User user) {
		
		return companyRepo.getCompanyByUser(user);
	}
	
	@Override
	@Transactional
	public void createCompany(Company companyEdit) {
		companyRepo.save(companyEdit);
		
	}
	
	@Override
	@Transactional
	public void updateCompany(Company sessionCompany,Company companyEdit) {
		
		sessionCompany.setEmail(companyEdit.getEmail());
		sessionCompany.setNameCompany(companyEdit.getNameCompany());
		sessionCompany.setAddress(companyEdit.getAddress());
		sessionCompany.setPhoneCompany(companyEdit.getPhoneCompany());
		sessionCompany.setDescription(companyEdit.getDescription());
		companyRepo.save(sessionCompany);
	}

	@Override
	@Transactional
	public ResponseEntity<String> updateLogo(Company sessionCompany, MultipartFile fileUpload, HttpServletRequest request) {
		
		try {
			
			if(sessionCompany != null) { 
			String uploadsDir = "resources/user/"+ sessionCompany.getUser().getEmail() +"/logo/";
			String fileName = fileUpload.getOriginalFilename();
			String filePath = uploadsDir + fileName;
		    String absolutePath =  request.getServletContext().getRealPath(uploadsDir);		    
		    	
		    SaveFile.saveFileOnServer(absolutePath, fileUpload);
	    	String oldFileName = sessionCompany.getLogo();
	    	
			if(oldFileName != null && !oldFileName.equals("resources/assets/images/default_logo.jpg")) {
		    	File oldFile = new File(request.getServletContext().getRealPath(oldFileName));
			    if (oldFile.exists())
			    	oldFile.delete();
		    }
			
			sessionCompany.setLogo(filePath);
			companyRepo.save(sessionCompany);
			return new ResponseEntity<>(filePath, HttpStatus.OK);
			}else {
				return new ResponseEntity<>("notCompany", HttpStatus.OK);
			}
			
            
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error", HttpStatus.OK);
        }

		
	}


	@Override
	@Transactional
	public List<Company> getFollowedCompanies(User sessionUser) {
		
		return companyRepo.getFollowedCompanies(sessionUser);
	}


	@Override
	@Transactional
	public boolean unfollow(User sessionUser, int idCompany) {
		try {
			followCompanyRepo.deleteByUserAndCompany_Id(sessionUser, idCompany);
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}
		return true;
	}


	@Override
	@Transactional
	public Company getCompanyById(int idCompany) {
		
		return companyRepo.getCompanyById(idCompany);
	}


	@Override
	@Transactional
	public boolean hasFollowed(User sessionUser, int idCompany) {
		if(followCompanyRepo.getByUserAndCompany_Id(sessionUser, idCompany) == null) {
			return false;
		} else {
			return true;
		}
		
	}


	@Override
	@Transactional
	public void followCompany(User sessionUser, int idCompany) {
		
		Company tempCompany = getCompanyById(idCompany);
		FollowCompany newFollowCompany = new FollowCompany(tempCompany, sessionUser);
		
		followCompanyRepo.save(newFollowCompany);
	}
	
	

}
