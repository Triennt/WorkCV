package com.triennt.workcv.config;

import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.User;
import com.triennt.workcv.service.CompanyService;
import com.triennt.workcv.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@Component
public class CustomAuthenticationSuccessHandler implements AuthenticationSuccessHandler {
	
	@Autowired
    private UserService userService;
	
	@Autowired
	private CompanyService companyService;

	/*
	 * Thực hiện các bước xử lý sau khi xác thực thành công.
	 */
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws IOException, ServletException {

		System.out.println("\n\nIn customAuthenticationSuccessHandler\n\n");

		// Lấy email(userName) từ thông tin xác thực
		String email = authentication.getName();
		
		System.out.println("email=" + email);

		User theUser = userService.findByEmail(email);
		
		Company theCompany = companyService.getCompanyByUser(theUser);
		
		// now place in the session
		HttpSession session = request.getSession();
		session.setAttribute("user", theUser);
		session.setAttribute("company", theCompany); 
		
		// Kiểm tra xác minh đối với ROLE_ADMIN
		if(theUser.getRole().getRoleName().equals("ROLE_ADMIN") && theUser.getStatus().isVerified()== false)
			response.sendRedirect(request.getContextPath() + "/admin/showProfile");
		else
			response.sendRedirect(request.getContextPath() + "/");

	}

}
