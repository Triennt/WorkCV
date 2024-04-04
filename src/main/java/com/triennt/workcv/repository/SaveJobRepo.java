package com.triennt.workcv.repository;

import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.SaveJob;
import com.triennt.workcv.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface SaveJobRepo extends JpaRepository<SaveJob, Integer> {

	SaveJob getByUserAndRecruitment_Id(User sessionUser, int recruitmentId);

	void deleteByUserAndRecruitment_Id(User sessionUser, int recruitmentId);

	@Query("select S.recruitment from SaveJob S "
			+ "where S.user = :sessionUser")
	List<Recruitment> getSavedRecruitments(User sessionUser);

}
