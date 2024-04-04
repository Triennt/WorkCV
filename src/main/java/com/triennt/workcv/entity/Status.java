package com.triennt.workcv.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

@Entity
@Table(name="user_status")
public class Status {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column(name="verified")
	private boolean verified;
	
	@Column(name="updated")
	private boolean updated;
	
	@Column(name="created_company")
	private boolean createdCompany;

	public Status() {
	}

	public Status(boolean verified, boolean updated, boolean createdCompany) {
		this.verified = verified;
		this.updated = updated;
		this.createdCompany = createdCompany;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public boolean isVerified() {
		return verified;
	}

	public void setVerified(boolean verified) {
		this.verified = verified;
	}

	public boolean isUpdated() {
		return updated;
	}

	public void setUpdated(boolean updated) {
		this.updated = updated;
	}

	public boolean isCreatedCompany() {
		return createdCompany;
	}

	public void setCreatedCompany(boolean createdCompany) {
		this.createdCompany = createdCompany;
	}
	
	
}
