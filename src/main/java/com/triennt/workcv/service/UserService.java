package com.triennt.workcv.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import com.triennt.workcv.user.CrmUser;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.web.multipart.MultipartFile;

import com.triennt.workcv.entity.Cv;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;

public interface UserService extends UserDetailsService {
	
	User findByEmail(String email);

	void updateUser(User sessionUser, User userEdit);
	
	ResponseEntity<String> updateUserAvatar(User sessionUser, MultipartFile fileUpload, HttpServletRequest request);
	
	List<User> getCandidates(HttpSession currentSession);
	
	List<User> getCandidatesOfRecruitment(int recruitmentId);

	List<Recruitment> getRelatedJobs(Recruitment recruitment);

	ResponseEntity<String> addCv(String uploadsDir, String absolutePath, MultipartFile fileUpload, User sessionUser);

	Cv getCv(User sessionUser);

	ResponseEntity<String> deleteCv(HttpServletRequest request, String filePathCv);

	void updateUser(User user);

	void create(@Valid CrmUser createUser);
}
