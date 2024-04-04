package com.triennt.workcv.service.Impl;

import com.triennt.workcv.repository.VerificationRepo;
import com.triennt.workcv.service.VerificationService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.triennt.workcv.entity.Verification;

@Service
public class VerificationServiceImpl implements VerificationService {
	
	@Autowired
    private JavaMailSender mailSender;
	
	@Autowired
	private VerificationRepo verificationRepo;

	@Override
	public void sendVerificationEmail(String to, String subject, String content) {
		
		SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject(subject);
        message.setText(content);
        mailSender.send(message);

	}
	

	@Override
	public void saveVerificationCode(String email, String verificationCode) {
		
		verificationRepo.deleteByEmail(email);
	
		verificationRepo.save(new Verification(email, verificationCode));
	}


	@Override
	public boolean verify(String email, String code) {
		
		if(verificationRepo.findByEmailAndCode(email, code) == null)
			return false;
		else return true;
	}

}
