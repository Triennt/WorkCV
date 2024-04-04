package com.triennt.workcv.entity;

import java.time.LocalDate;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Positive;

@Entity
@Table(name="recruitment")
public class Recruitment {

	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="id")
	private int id;
	
	@NotBlank(message="Địa chỉ không được để trống.")
	@Column(name="address")
	private String address;
	
	@Column(name="created_at")
	private LocalDate created;
	
	@NotBlank(message="Mô tả không được để trống.")
	@Column(name="description")
	private String description;
	
	@NotBlank(message="Kinh nghiệm không được để trống.")
	@Column(name="experience")
	private String experience;
	
	@Positive(message = "Số lượng là số nguyên dương > 0.")
	@Column(name="quantity")
	private int quantity;
	
	@Column(name="recruitment_rank")
	private String recruitmentRank;
	
	@Column(name="status")
	private int status;
	
	@NotBlank(message="Lương không được để trống.")
	@Column(name="salary")
	private String salary;
	
	@NotBlank(message="Tiêu đề không được để trống.")
	@Column(name="title")
	private String title;
	
	@NotBlank(message="Loại công việc không được để trống.")
	@Column(name="type")
	private String type;
	
	@Column(name="view")
	private int view;
	
	@NotBlank(message="Hạn ứng tuyển không được để trống.")
	@Column(name="deadline")
	private String deadline;
	
	@ManyToOne
	@JoinColumn(name="category_id")
	private Category category;
	
	@OneToOne
	@JoinColumn(name="company_id")
	private Company company;

	public Recruitment() {
	}

	public Recruitment(String address, LocalDate created, String description, String experience, int quantity, String recruitmentRank,
			int status, String salary, String title, String type, int view, String deadline) {
		this.address = address;
		this.created = created;
		this.description = description;
		this.experience = experience;
		this.quantity = quantity;
		this.recruitmentRank = recruitmentRank;
		this.status = status;
		this.salary = salary;
		this.title = title;
		this.type = type;
		this.view = view;
		this.deadline = deadline;
		
		System.out.println("called Recruitment with param");
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

	public LocalDate getCreated() {
		return created;
	}

	public void setCreated(LocalDate created) {
		this.created = created;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getExperience() {
		return experience;
	}

	public void setExperience(String experience) {
		this.experience = experience;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public String getRank() {
		return recruitmentRank;
	}

	public void setRank(String rank) {
		this.recruitmentRank = rank;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public String getSalary() {
		return salary;
	}

	public void setSalary(String salary) {
		this.salary = salary;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getView() {
		return view;
	}

	public void setView(int view) {
		this.view = view;
	}

	public String getDeadline() {

		return deadline;
	}

	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}

	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Company getCompany() {
		return company;
	}

	public void setCompany(Company company) {
		this.company = company;
	}

	@Override
	public String toString() {
		return "Recruitment [id=" + id + ", address=" + address + ", created=" + created + ", description="
				+ description + ", experience=" + experience + ", quanity=" + quantity + ", rank=" + recruitmentRank + ", status="
				+ status + ", salary=" + salary + ", title=" + title + ", type=" + type + ", view=" + view
				+ ", deadline=" + deadline + ", category=" + category + ", company=" + company + "]";
	}


}
