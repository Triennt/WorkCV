package com.triennt.workcv.controller;

import java.util.logging.Logger;

import javax.validation.Valid;

import com.triennt.workcv.user.CrmUser;
import com.triennt.workcv.util.RandomCode;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.triennt.workcv.entity.User;
import com.triennt.workcv.service.RoleService;
import com.triennt.workcv.service.UserService;
import com.triennt.workcv.service.VerificationService;

@Controller
@RequestMapping("/register")
public class RegistrationController {
	
    @Autowired
    private UserService userService;
    
    @Autowired
    private RoleService roleService;
    
    @Autowired
    private VerificationService verificationService;
	
    private Logger logger = Logger.getLogger(getClass().getName());
    
    /**
     * Phương thức này được sử dụng để thiết lập một WebDataBinder 
     * để xử lý dữ liệu trước khi nó được chuyển đến các phương thức điều khiển.
     *
     * @param dataBinder Đối tượng WebDataBinder để thiết lập trình biên dịch dữ liệu.
     */
	@InitBinder
	public void initBinder(WebDataBinder dataBinder) {
		
		// Tạo một StringTrimmerEditor để loại bỏ khoảng trắng thừa từ các trường String
		StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
		
		// Đăng ký StringTrimmerEditor cho kiểu dữ liệu String
		dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
	}	
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị trang đăng ký người dùng.
	 *
	 * @param theModel Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang đăng ký người dùng ("public/registration").
	 */
	@GetMapping("/showRegistrationForm")
	public String showRegistrationForm(Model theModel) {
		
		theModel.addAttribute("crmUser", new CrmUser());
		theModel.addAttribute("roles",roleService.getRoles());
		
		return "public/registration";
	}

	/**
	 * Phương thức này xử lý yêu cầu xử lý thông tin đăng ký người dùng từ form.
	 *
	 * @param createUser Đối tượng CrmUser chứa thông tin người dùng từ form.
	 * @param theBindingResult Đối tượng BindingResult chứa thông tin về lỗi sau khi kiểm tra hợp lệ (validation).
	 * @param theModel Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị kết quả đăng ký ("public/login" nếu thành công, ngược lại là "public/registration").
	 */
	@PostMapping("/processRegistrationForm")
	public String processRegistrationForm(	 	 
			@Valid @ModelAttribute("createUser")  CrmUser createUser, 
				BindingResult theBindingResult, 
				Model theModel) {
		
		String email = createUser.getEmail();
		logger.info("Processing registration form for: " + email);
		
		// form validation
		 if (theBindingResult.hasErrors()){
			 theModel.addAttribute("createUser",createUser);
			 theModel.addAttribute("roles",roleService.getRoles());
			 return "public/registration";
	        }

		// check the database if user already exists
        User existing = userService.findByEmail(email);
        if (existing != null){
			theModel.addAttribute("registrationError", "Email already exists.");
			theModel.addAttribute("createUser",createUser);
			theModel.addAttribute("roles",roleService.getRoles());

			logger.warning("Email already exists.");
        	return "public/registration";
        }
				
        userService.create(createUser);
	
        logger.info("Successfully created user: " + email);
        
        theModel.addAttribute("signUpSuccess", true);
        return "public/login";		
	}
	
	/**
	 * Phương thức này xử lý yêu cầu gửi mã xác nhận đến email người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình gửi mã xác nhận.
	 */
	@GetMapping("/verifyEmail")
	public ResponseEntity<String> verifyEmail(@SessionAttribute("user") User sessionUser) {
		
		String verificationCode = RandomCode.getCode(6);
		String email = sessionUser.getEmail();
		verificationService.saveVerificationCode(email, verificationCode);

		String subject = "Please verify your registration";
		String content = "Your verification code is: " + verificationCode;

		verificationService.sendVerificationEmail(email, subject, content);
		
		return new ResponseEntity<>("sentEmail", HttpStatus.OK);
	}
	
	/**
	 * Phương thức này xử lý yêu cầu xác nhận mã từ người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param code Mã xác nhận nhập từ người dùng.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình xác nhận mã.
	 */
	@GetMapping("/verifyCode")
	public ResponseEntity<String> verifyCode(@SessionAttribute("user") User sessionUser, 
											@RequestParam("code") String code,
											Model model) {
		
		if(verificationService.verify(sessionUser.getEmail(), code)) {
			sessionUser.getStatus().setVerified(true);
			userService.updateUser(sessionUser);
			return new ResponseEntity<>("verifySuccess", HttpStatus.OK);
		} else 
			return new ResponseEntity<>("verifyFailed", HttpStatus.OK);
				
	}
	
}
