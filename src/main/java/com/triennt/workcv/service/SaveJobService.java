package com.triennt.workcv.service;

import java.util.List;

import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;

public interface SaveJobService {

	boolean hasSaved(User sessionUser, int recruitmentId);

	void unSave(User sessionUser, int recruitmentId);

	void saveJob(User sessionUser, int recruitmentId);

	List<Recruitment> getSavedRecruitments(User sessionUser);

}
