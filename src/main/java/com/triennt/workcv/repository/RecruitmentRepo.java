package com.triennt.workcv.repository;

import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface RecruitmentRepo extends JpaRepository<Recruitment, Integer> {

	@Query("from Recruitment order by created desc, id desc")
	List<Recruitment> getTopRecruitment(Pageable pageable);

	@Query("select r from Recruitment r "+
			"join Company c on r.company = c "+
			"where c.user = :currentUser ")
	List<Recruitment> getRecruitmentsByUser(User currentUser);

	@Query("select count(id) from Recruitment")
	Long getNumberOfRecruitments();

	@Query("select distinct R from Recruitment R "
			+ "join Category C on R.category = C "
			+ "where C.name like %:keySearch% or R.title like %:keySearch%")
	List<Recruitment> searchRecruitmentsByRecruitment(String keySearch);

	@Query("select distinct R from Recruitment R "
			+ "join Company C on R.company = C "
			+ "where C.nameCompany like %:keySearch% ")
	List<Recruitment> searchRecruitmentsByCompany(String keySearch);

	@Query("from Recruitment where address like %:keySearch%")
	List<Recruitment> searchRecruitmentsByAddress(String keySearch);

	@Query("select R from Recruitment R "
			+ "where R.category = :#{#recruitment.category} or R.company = :#{#recruitment.company} or R.address = :#{#recruitment.address} "
			+ "order by "
			+ "case when R.category = :#{#recruitment.category} then 1 "
			+ "when R.company = :#{#recruitment.company} then 2 "
			+ "when R.address = :#{#recruitment.address} then 3 else 4 end")
	List<Recruitment> getRelatedJobs(Recruitment recruitment);

	@Query("from Recruitment where company.id = :idCompany")
	List<Recruitment> getRecruitmentsOfCompany(int idCompany);

	@Query("from Recruitment where category.id = :idCategory")
	List<Recruitment> getRecruitmentsOfCategory(int idCategory);

	

}
