package com.triennt.workcv.repository;

import com.triennt.workcv.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;

public interface RoleRepo extends JpaRepository<Role, Integer> {
	
	Role findRoleByRoleName(String theRoleName);
	
}
