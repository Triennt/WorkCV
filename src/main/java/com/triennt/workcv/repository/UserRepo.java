package com.triennt.workcv.repository;

import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepo extends JpaRepository<User, Integer> {

	User findByEmail(String email);

	@Query("select A.user from ApplyPost A "
			+ "join Recruitment R on A.recruitment = R "
			+ "join Company C on R.company = C "
			+ "where R.company =: currentCompany")
	List<User> getCandidatesOfCompany(Company currentCompany);

	@Query("select U from User U "
			+ "join ApplyPost A on A.user = U "
			+ "join Recruitment R on A.recruitment = R "
			+ "where R.id =: recruitmentId")
	List<User> getCandidatesOfRecruitment(int recruitmentId);

}
