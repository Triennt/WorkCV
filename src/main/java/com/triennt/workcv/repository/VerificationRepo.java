package com.triennt.workcv.repository;

import com.triennt.workcv.entity.Verification;
import org.springframework.data.jpa.repository.JpaRepository;

public interface VerificationRepo extends JpaRepository<Verification, Integer> {

	void deleteByEmail(String email);

	Verification findByEmailAndCode(String email, String code);

}
