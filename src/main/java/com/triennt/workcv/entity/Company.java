package com.triennt.workcv.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import com.triennt.workcv.validation.ValidEmail;

@Entity
@Table(name="company")
public class Company {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@NotBlank(message = "Địa chỉ không được để trống")
	@Column(name="address")
	private String address;
	
	@NotBlank(message = "Mô tả không được để trống")
	@Column(name="description")
	private String description;
	
	@ValidEmail(message="Email không hợp lệ. Ví dụ: example@example.com")
	@Column(name="email")
	private String email;
	
	@Column(name="logo")
	private String logo;
	
	@NotBlank(message = "Tên công ty không được để trống")
	@Column(name="name_company")
	private String nameCompany;
	
	@NotBlank(message = "Số điện thoại công ty không được để trống")
	@Pattern(regexp = "\\d{10,11}", message = "Số điện thoại không hợp lệ")
	@Column(name="phone_company")
	private String phoneCompany;
	
	@Column(name="status")
	private int status;
	
	@OneToOne
	@JoinColumn(name="user_id")
	private User user;

	public Company() {
	}

	public Company(String address, String description, String email, String logo, String nameCompany,
			String phoneCompany, int status) {
		this.address = address;
		this.description = description;
		this.email = email;
		this.logo = logo;
		this.nameCompany = nameCompany;
		this.phoneCompany = phoneCompany;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getLogo() {
		return logo;
	}

	public void setLogo(String logo) {
		this.logo = logo;
	}

	public String getNameCompany() {
		return nameCompany;
	}

	public void setNameCompany(String nameCompany) {
		this.nameCompany = nameCompany;
	}

	public String getPhoneCompany() {
		return phoneCompany;
	}

	public void setPhoneCompany(String phoneCompany) {
		this.phoneCompany = phoneCompany;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	@Override
	public String toString() {
		return "Company [id=" + id + ", address=" + address + ", description=" + description + ", email=" + email
				+ ", logo=" + logo + ", nameCompany=" + nameCompany + ", phoneCompany=" + phoneCompany + ", status="
				+ status + ", user=" + user + ", usersFollow=" + "]";
	}
	
	
}
