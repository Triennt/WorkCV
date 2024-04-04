package com.triennt.workcv.service.Impl;

import java.util.List;

import com.triennt.workcv.repository.SaveJobRepo;
import com.triennt.workcv.service.RecruitmentService;
import com.triennt.workcv.service.SaveJobService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.SaveJob;
import com.triennt.workcv.entity.User;

@Service
public class SaveJobServiceImpl implements SaveJobService {
	
	@Autowired
	SaveJobRepo saveJobRepo;
	
	@Autowired
    RecruitmentService recruitmentService;

	@Override
	@Transactional
	public boolean hasSaved(User sessionUser, int recruitmentId) {
		System.out.println("called hasSaved");
		if(saveJobRepo.getByUserAndRecruitment_Id(sessionUser, recruitmentId) == null)
			return false;
		else
			return true;
	}

	@Override
	@Transactional
	public void unSave(User sessionUser, int recruitmentId) {
		System.out.println("called unSave");
		saveJobRepo.deleteByUserAndRecruitment_Id(sessionUser, recruitmentId);
		
	}

	@Override
	@Transactional
	public void saveJob(User sessionUser, int recruitmentId) {
		Recruitment tempRecruitment = recruitmentService.getRecruitmentById(recruitmentId);
		SaveJob newSaveJob = new SaveJob(sessionUser, tempRecruitment);
		saveJobRepo.save(newSaveJob);
	}

	@Override
	@Transactional
	public List<Recruitment> getSavedRecruitments(User sessionUser) {
		
		return saveJobRepo.getSavedRecruitments(sessionUser);
	}

}
