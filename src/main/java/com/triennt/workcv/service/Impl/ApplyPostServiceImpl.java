package com.triennt.workcv.service.Impl;

import java.time.LocalDate;
import java.util.List;

import com.triennt.workcv.repository.ApplyPostRepo;
import com.triennt.workcv.service.ApplyPostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.triennt.workcv.entity.ApplyPost;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;

@Service
public class ApplyPostServiceImpl implements ApplyPostService {
	
	@Autowired
	ApplyPostRepo applyPostRepo;

	@Override
	@Transactional
	public Long getNumberOfCandidates() {
		
		return applyPostRepo.getNumberOfCandidates();
	}

	@Override
	@Transactional
	public void addApplyPost(ApplyPost applyPost) {
		applyPost.setCreated(LocalDate.now());
		applyPostRepo.save(applyPost);
		
	}

	@Override
	@Transactional
	public boolean hasApplied(User sessionUser, int recruitmentId) {
		
		if(applyPostRepo.getApplyPostByUserAndRecruitment(sessionUser, recruitmentId) == null)
			return false;
		else
			return true;
	}

	@Override
	@Transactional
	public List<ApplyPost> getApplyPostByUser(User user) {
		
		return applyPostRepo.getApplyPostByUser(user);
	}


	@Override
	@Transactional
	public List<ApplyPost> getApplyPostByAdmin(User sessionUser) {
		
		return applyPostRepo.getApplyPostByAdmin(sessionUser);
	}

	@Override
	@Transactional
	public List<ApplyPost> getApplyPostByRecruitment(int recruitmentId) {
		
		return applyPostRepo.getApplyPostByRecruitment(recruitmentId);
	}

	@Override
	@Transactional
	public List<Recruitment> getAppliedRecruitments(User sessionUser) {
		
		return applyPostRepo.getAppliedRecruitments(sessionUser);
	}

	@Override
	@Transactional
	public boolean cancelApplication(User sessionUser, int idRe) {
		try {
			applyPostRepo.deleteByUserAndRecruitment_Id(sessionUser, idRe);
			return true;
		} catch (Exception e) {
			System.out.println(e);
			return false;
		}
	
	}



	
	
	

}
