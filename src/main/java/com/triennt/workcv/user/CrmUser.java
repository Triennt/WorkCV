package com.triennt.workcv.user;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.Size;

import com.triennt.workcv.validation.FieldMatch;
import com.triennt.workcv.validation.ValidEmail;
import com.triennt.workcv.validation.ValidPassword;

@FieldMatch.List({
    @FieldMatch(first = "password", second = "matchingPassword", message = "The password fields must match")
})
public class CrmUser {
	
	@ValidEmail
	@NotBlank(message = "is required")
	@Size(min = 1, message = "is required")
	private String email;

	@NotBlank(message = "is required")
	@Size(min = 1, message = "is required")
	private String fullName;
	
	@ValidPassword
	@NotBlank(message = "is required")
	@Size(min = 1, message = "is required")
	private String password;
	
	@NotBlank(message = "is required")
	@Size(min = 1, message = "is required")
	private String matchingPassword;
	
	
	private String roleName;

	public CrmUser() {
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

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getMatchingPassword() {
		return matchingPassword;
	}

	public void setMatchingPassword(String matchingPassword) {
		this.matchingPassword = matchingPassword;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}
	
	
}
