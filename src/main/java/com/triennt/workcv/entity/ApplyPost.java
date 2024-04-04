package com.triennt.workcv.entity;

import java.time.LocalDate;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;


@Entity
@Table(name="applypost")
public class ApplyPost {
	
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@Column(name="created_at")
	private LocalDate created;
	
	@Column(name="name_cv")
	private String nameCv;
	
	@Column(name="status")
	private int status;
	
	@Column(name="text")
	private String text;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;
	
	@ManyToOne
	@JoinColumn(name="recruitment_id")
	private Recruitment recruitment;

	public ApplyPost() {
	}

	public ApplyPost(LocalDate created, String nameCv, int status, String text) {
		this.created = created;
		this.nameCv = nameCv;
		this.status = status;
		this.text = text;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public LocalDate getCreated() {
		return created;
	}

	public void setCreated(LocalDate created) {
		this.created = created;
	}

	public String getNameCv() {
		return nameCv;
	}

	public void setNameCv(String nameCv) {
		this.nameCv = nameCv;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Recruitment getRecruitment() {
		return recruitment;
	}

	public void setRecruitment(Recruitment recruitment) {
		this.recruitment = recruitment;
	}

	@Override
	public String toString() {
		return "ApplyPost [id=" + id + ", created=" + created + ", nameCv=" + nameCv + ", status=" + status + ", text="
				+ text + ", userId=" + user + ", recruitmentId=" + recruitment + "]";
	}
	
	
	
	
}
