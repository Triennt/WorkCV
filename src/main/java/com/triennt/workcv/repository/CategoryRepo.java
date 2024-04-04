package com.triennt.workcv.repository;

import com.triennt.workcv.entity.Category;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface CategoryRepo extends JpaRepository<Category, Integer> {

	Category getCategoryById(int id);

	@Query("select C from Category C "
			+ "join Recruitment R on C = R.category "
			+ "where R.id = :id")
	Category getCategoryByRecruitmentId(int id);

	@Query("select C, count(R) "+
			"from Category C " +
			"join Recruitment R on R.category = C " +
			"group by C " +
			"order by count(R) desc")
	List<Object[]> getCategoriesAndNumber(Pageable pageable);

}
