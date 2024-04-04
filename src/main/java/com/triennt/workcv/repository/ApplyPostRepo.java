package com.triennt.workcv.repository;

import com.triennt.workcv.entity.ApplyPost;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface ApplyPostRepo extends JpaRepository<ApplyPost, Integer> {

	@Query("select count(distinct A.user) from ApplyPost A")
	Long getNumberOfCandidates();

	@Query("select A from ApplyPost A "
			+ "join User U on A.user = U "
			+ "join Recruitment R on A.recruitment = R "
			+ "where A.user = :sessionUser and R.id = :recruitmentId")
	ApplyPost getApplyPostByUserAndRecruitment(User sessionUser, int recruitmentId);

	@Query("from ApplyPost where user = :user")
	List<ApplyPost> getApplyPostByUser(User user);

	@Query("select A.recruitment from ApplyPost A where A.user = :user")
	List<Recruitment> getAppliedRecruitments(User user);

	void deleteByUserAndRecruitment_Id(User sessionUser, int idRe);

	@Query("select A from ApplyPost A "
			+ "join Recruitment R on A.recruitment = R "
			+ "join Company C on R.company = C "
			+ "join User U on C.user = U "
			+ "where U = :admin")
	List<ApplyPost> getApplyPostByAdmin(User admin);

	@Query("select A from ApplyPost A "
			+ "join Recruitment R on A.recruitment = R "
			+ "where R.id = :recruitmentId")
	List<ApplyPost> getApplyPostByRecruitment(int recruitmentId);

}
