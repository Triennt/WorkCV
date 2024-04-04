package com.triennt.workcv.service;

public interface VerificationService {
	void sendVerificationEmail(String to, String subject, String content);

	boolean verify(String email, String code);

	void saveVerificationCode(String email, String verificationCode);
}
