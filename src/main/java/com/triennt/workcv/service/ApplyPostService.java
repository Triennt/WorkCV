package com.triennt.workcv.service;

import java.util.List;

import com.triennt.workcv.entity.ApplyPost;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;

public interface ApplyPostService {

	Long getNumberOfCandidates();

	void addApplyPost(ApplyPost applyPost);

	boolean hasApplied(User sessionUser, int recruitmentId);
	
	List<ApplyPost> getApplyPostByUser(User user);

	List<Recruitment> getAppliedRecruitments(User sessionUser);

	boolean cancelApplication(User sessionUser, int idRe);

	List<ApplyPost> getApplyPostByAdmin(User sessionUser);

	List<ApplyPost> getApplyPostByRecruitment(int recruitmentId);

}
