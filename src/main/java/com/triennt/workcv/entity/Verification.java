package com.triennt.workcv.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="verification")
public class Verification {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column(name="email")
	private String email;
	
	@Column(name="verify_code")
	private String code;

	public Verification() {
	}

	public Verification(String email, String verifyCode) {
		this.email = email;
		this.code = verifyCode;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getVerifyCode() {
		return code;
	}

	public void setVerifyCode(String verifyCode) {
		this.code = verifyCode;
	}

	@Override
	public String toString() {
		return "Verification [id=" + id + ", email=" + email + ", verifyCode=" + code + "]";
	}

	
	
}
