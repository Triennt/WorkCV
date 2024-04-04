package com.triennt.workcv.repository;

import com.triennt.workcv.entity.FollowCompany;
import com.triennt.workcv.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;

public interface FollowCompanyRepo extends JpaRepository<FollowCompany, Integer> {
    void deleteByUserAndCompany_Id(User user, int id);
    FollowCompany getByUserAndCompany_Id(User user, int id);
}
