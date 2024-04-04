package com.triennt.workcv.service.Impl;

import java.util.List;

import com.triennt.workcv.repository.RoleRepo;
import com.triennt.workcv.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.triennt.workcv.entity.Role;

@Service
public class RoleServiceImpl implements RoleService {

	@Autowired
	private RoleRepo roleRepo;
	
	@Override
	@Transactional
	public List<Role> getRoles() {
		return roleRepo.findAll();
	}


}
