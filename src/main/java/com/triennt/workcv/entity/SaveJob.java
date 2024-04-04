package com.triennt.workcv.entity;

import javax.persistence.*;

@Entity
@Table(name="save_job")
public class SaveJob {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@ManyToOne
	@JoinColumn(name="recruitment_id")
	private Recruitment recruitment;
	
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;

	public SaveJob() {
	}

	public SaveJob(User user, Recruitment recruitment) {
		this.recruitment = recruitment;
		this.user = user;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public Recruitment getRecruitment() {
		return recruitment;
	}

	public void setRecruitment(Recruitment recruitment) {
		this.recruitment = recruitment;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "SaveJob [id=" + id + ", recruitment=" + recruitment + ", user=" + user + "]";
	}
	
	
}
