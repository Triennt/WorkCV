package com.triennt.workcv.entity;

import java.util.Collection;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Pattern;

import com.triennt.workcv.validation.ValidEmail;

@Entity
@Table(name="user")
public class User {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@NotBlank(message = "Địa chỉ không được để trống", groups = UpdateUser.class)
	@Column(name="address")
	private String address;
	
	@NotBlank(message = "Mô tả không được để trống",groups = UpdateUser.class)
	@Column(name="description")
	private String description;
	
	@ValidEmail(message = "Email không hợp lệ", groups = {CreateUser.class, UpdateUser.class})
	@Column(name="email")
	private String email;
	
	@NotBlank(message = "Tên không được để trống", groups = {CreateUser.class, UpdateUser.class})
	@Column(name="full_name")
	private String fullName;
	
	@Column(name="image")
	private String image;
	
	@Column(name="password")
	private String password;
	
	@NotBlank(message = "Số điện thoại không được để trống", groups = UpdateUser.class)
	@Pattern(regexp = "\\d{10,11}", message = "Số điện thoại không hợp lệ", groups = UpdateUser.class)
	@Column(name="phone_number")
	private String phoneNumber;
	
	@OneToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="status_id")
	private Status status;
	
	@ManyToOne(cascade = CascadeType.ALL)
	@JoinColumn(name="role_id")
	private Role role;
	
	@ManyToMany(fetch=FetchType.LAZY, cascade=CascadeType.ALL)
	@JoinTable(name="follow_company", 
				joinColumns=@JoinColumn(name="user_id"), 
				inverseJoinColumns=@JoinColumn(name="company_id"))
	private Collection<Company> followCompanies;
	

	public User() {
	}

	public User(String address, String description, String email, String fullName, String image, String password,
			String phoneNumber, Status status, Collection<Company> followCompanies) {
		this.address = address;
		this.description = description;
		this.email = email;
		this.fullName = fullName;
		this.image = image;
		this.password = password;
		this.phoneNumber = phoneNumber;
		this.status = status;
		this.followCompanies = followCompanies;
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

	public String getFullName() {
		return fullName;
	}

	public void setFullName(String fullName) {
		this.fullName = fullName;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getPhoneNumber() {
		return phoneNumber;
	}

	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public Role getRole() {
		return role;
	}

	public void setRole(Role role) {
		this.role = role;
	}
	
	

	public Collection<Company> getFollowCompanies() {
		return followCompanies;
	}

	public void setFollowCompanies(Collection<Company> followCompanies) {
		this.followCompanies = followCompanies;
	}

	@Override
	public String toString() {
		return "User [id=" + id + ", address=" + address + ", description=" + description + ", email=" + email
				+ ", fullName=" + fullName + ", image=" + image + ", password=" + password + ", phoneNumber="
				+ phoneNumber + ", status=" + status + ", role=" + role + "]";
	}
	
	
}
