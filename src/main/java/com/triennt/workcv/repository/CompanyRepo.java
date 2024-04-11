package com.triennt.workcv.repository;

import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.FollowCompany;
import com.triennt.workcv.entity.User;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CompanyRepo extends JpaRepository<Company, Integer> {

	@Query("select C, count(distinct(R)) "+
			"from Company C " +
			"join Recruitment R on R.company = C " +
			"left join ApplyPost A on A.recruitment = R " +
			"group by C " +
			"order by count(R) desc, count(A) desc")
	List<Object[]> getTopCompanies(Pageable pageable);

	Company getCompanyByUser(User user);


	@Query("select count(id) from Company")
	Long getNumberOfCompanies();

	@Query("select F.company from FollowCompany F where F.user = :sessionUser")
	List<Company> getFollowedCompanies(User sessionUser);

	Company getCompanyById(int idCompany);


}
