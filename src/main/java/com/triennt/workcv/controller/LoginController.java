package com.triennt.workcv.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class LoginController {

	/**
	 * Phương thức này xử lý yêu cầu hiển thị trang đăng nhập.
	 *
	 * @return Tên của view hiển thị trang đăng nhập ("public/login").
	 */
	@GetMapping("/showMyLoginPage")
	public String showMyLoginPage() {
		
		return "public/login";
		
	}
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị trang thông báo truy cập bị từ chối.
	 *
	 * @return Tên của view hiển thị trang thông báo truy cập bị từ chối ("public/access-denied").
	 */
	@GetMapping("/accessDenied")
	public String showAccessDenied() {
		
		return "public/access-denied";
		
	}

}









