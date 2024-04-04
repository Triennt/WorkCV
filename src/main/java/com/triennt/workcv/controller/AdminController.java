package com.triennt.workcv.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.triennt.workcv.entity.ApplyPost;
import com.triennt.workcv.entity.Category;
import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.UpdateUser;
import com.triennt.workcv.entity.User;
import com.triennt.workcv.service.ApplyPostService;
import com.triennt.workcv.service.CategoryService;
import com.triennt.workcv.service.CompanyService;
import com.triennt.workcv.service.RecruitmentService;
import com.triennt.workcv.service.UserService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	private CompanyService companyService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private RecruitmentService recruitmentService;
	
	@Autowired
	private CategoryService categoryService;

	
	@Autowired
	private ApplyPostService applyPostService;
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị trang hồ sơ người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang hồ sơ người dùng ("public/profile-user").
	 */
	@GetMapping("/showProfile")
	public String showProfile(@SessionAttribute("user") User sessionUser, Model model) {
		
		model.addAttribute("user",sessionUser);
		
		return "public/profile-user";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị trang chi tiết thông tin công ty.
	 *
	 * @param sessionCompany Đối tượng Company được lấy từ session, là công ty thuộc người dùng hiện đang đăng nhập.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang chi tiết công ty ("admin/profile-company").
	 */
	@GetMapping("/showProfileCompany")
	public String showCompanyDetail(@SessionAttribute(name="company", required = false) Company sessionCompany, Model model) {
		
		model.addAttribute("company",sessionCompany);
		
		return "admin/profile-company";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu cập nhật thông tin người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param userEdit Đối tượng User được chuyển đến từ form và chứa thông tin được người dùng chỉnh sửa.
	 * @param theBindingResult Đối tượng BindingResult chứa thông tin về lỗi sau khi kiểm tra hợp lệ (validation).
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang thông tin người dùng ("public/profile-user").
	 */
	@PostMapping("/updateProfile")
	public String updateUser(@SessionAttribute("user") User sessionUser, 
							@ModelAttribute("userEdited") @Validated({UpdateUser.class}) User userEdit,
							BindingResult theBindingResult,
							Model model) {
		

		if(theBindingResult.hasErrors()) {
			// Lấy danh sách lỗi từ BindingResult
		    List<FieldError> errors = theBindingResult.getFieldErrors();
		    
		    // Duyệt qua danh sách lỗi và chuyển chúng sang model
		    for (FieldError error : errors) {
		        model.addAttribute(error.getField() + "Error", error.getDefaultMessage());
		    }
			model.addAttribute("user",userEdit);
			model.addAttribute("updateSuccess",false);
			
			
			return "public/profile-user";
		}

		userService.updateUser(sessionUser, userEdit); 
		model.addAttribute("user",sessionUser);
		model.addAttribute("updateSuccess",true);
	    return "public/profile-user";
	}

	/**
	 * Phương thức này xử lý yêu cầu tạo hồ sơ công ty.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param companyEdit Đối tượng Company được chuyển đến từ form và chứa thông tin công ty mới được tạo.
	 * @param theBindingResult Đối tượng BindingResult chứa thông tin về lỗi sau khi kiểm tra hợp lệ (validation).
	 * @param session Đối tượng HttpSession để quản lý session.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang thông tin công ty ("admin/profile-company").
	 */
	@PostMapping("/createProfileCompany")
	public String createProfileCompany(@SessionAttribute("user") User sessionUser, 
										@Valid @ModelAttribute("companyEdit") Company companyEdit,
										BindingResult theBindingResult,
										HttpSession session,
										Model model) {
		
		if(companyService.getCompanyByUser(sessionUser) != null)
			return "redirect:/admin/showProfileCompany";
		
		if(theBindingResult.hasErrors()) {
			// Lấy danh sách lỗi từ BindingResult
		    List<FieldError> errors = theBindingResult.getFieldErrors();
		    
		    // Duyệt qua danh sách lỗi và chuyển chúng sang model
		    for (FieldError error : errors) {
		        model.addAttribute(error.getField() + "Error", error.getDefaultMessage());
		    }
			model.addAttribute("company",companyEdit);
			model.addAttribute("createSuccess",false);
			
			
			return "admin/profile-company";
		}

		companyEdit.setLogo("resources/assets/images/default_logo.jpg");	
		companyEdit.setUser(sessionUser);
		sessionUser.getStatus().setCreatedCompany(true);
		
		companyService.createCompany(companyEdit);
		userService.updateUser(sessionUser);
		
		model.addAttribute("createSuccess",true);
		Company company = companyService.getCompanyByUser(sessionUser);
		model.addAttribute("company",company);
		session.setAttribute("company", company);
		
	    return "admin/profile-company";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu tải lên (upload) logo cho công ty.
	 *
	 * @param sessionCompany Đối tượng Company được lấy từ session, đại diện cho công ty hiện đang đăng nhập.
	 * @param fileUpload Đối tượng MultipartFile chứa dữ liệu file logo được tải lên từ form.
	 * @param request Đối tượng HttpServletRequest để có thể lấy thông tin từ request nếu cần.
	 * @return ResponseEntity<String> Chứa thông điệp kết quả của quá trình tải lên logo.
	 */
	@PostMapping("/uploadLogo")
    public ResponseEntity<String> uploadLogo(@SessionAttribute(name="company", required = false) Company sessionCompany,
								    		@RequestParam("logo") MultipartFile fileUpload,							            
								            HttpServletRequest request) {

		System.out.println("called uploadLogo");
		ResponseEntity<String> response =companyService.updateLogo(sessionCompany, fileUpload, request);	
	
        return response;
        
    }
	
	/**
	 * Phương thức này xử lý yêu cầu cập nhật thông tin công ty.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param sessionCompany Đối tượng Company được lấy từ session, đại diện cho công ty hiện đang cần chỉnh sửa.
	 * @param companyEdit Đối tượng Company được chuyển đến từ form và chứa thông tin công ty được chỉnh sửa.
	 * @param theBindingResult Đối tượng BindingResult chứa thông tin về lỗi sau khi kiểm tra hợp lệ (validation).
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang thông tin công ty ("admin/profile-company").
	 */
	@PostMapping("/updateProfileCompany")
	public String updateCompany(@SessionAttribute("user") User sessionUser, 
								@SessionAttribute("company") Company sessionCompany,
								@Valid @ModelAttribute("companyEdit") Company companyEdit, 
								BindingResult theBindingResult,
								Model model) {
		
		System.out.println("Company: "+companyEdit.getNameCompany());
		
		if(theBindingResult.hasErrors()) {
			// Lấy danh sách lỗi từ BindingResult
		    List<FieldError> errors = theBindingResult.getFieldErrors();
		    
		    // Duyệt qua danh sách lỗi và chuyển chúng sang model
		    for (FieldError error : errors) {
		        model.addAttribute(error.getField() + "Error", error.getDefaultMessage());
		    }
			model.addAttribute("company",companyEdit);
			model.addAttribute("updateSuccess",false);
			
			return "admin/profile-company";
		}

		companyService.updateCompany(sessionCompany, companyEdit);
		
		model.addAttribute("company",sessionCompany);
		model.addAttribute("updateSuccess",true);

	    return "admin/profile-company";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị danh sách tất cả các công việc tuyển dụng của người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị danh sách công việc tuyển dụng ("admin/recruitments").
	 */
	@GetMapping("/listRecruitments")
	public String listRecruitments(@SessionAttribute("user") User sessionUser,
									Model model) {
		
		List<Recruitment> listRecruitments =recruitmentService.getRecruitmentsByUser(sessionUser);
		model.addAttribute("recruitments",listRecruitments);
		List<Category> listCategories = categoryService.getCategories();
		model.addAttribute("categories",listCategories);
		
		BindingResult theBindingResult = (BindingResult) model.asMap().get("theBindingResult");
		if(theBindingResult != null) {
			if(theBindingResult.hasErrors()) {
				  
			  	// Lấy danh sách lỗi từ BindingResult
			    List<FieldError> errors = theBindingResult.getFieldErrors();
			    
			    // Duyệt qua danh sách lỗi và chuyển chúng sang model
			    for (FieldError error : errors) {
			    	model.addAttribute(error.getField() + "Error", error.getDefaultMessage());
			    }
			}
		
		}
		
		model.addAttribute("postSuccess", model.asMap().get("postSuccess"));
		model.addAttribute("updateSuccess", model.asMap().get("updateSuccess"));
		model.addAttribute("recruitment", model.asMap().get("recruitment"));
		return "admin/recruitments";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị trang đăng công việc tuyển dụng.
	 *
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang đăng công việc tuyển dụng ("admin/post-job").
	 */
	@GetMapping("/recruit")
	public String recruit(Model model) {	

		model.addAttribute("categories", categoryService.getCategories());
		model.addAttribute("recruitment", new Recruitment());
		
		return "admin/post-job";
	}
	
	
	/**
	 * Xử lý thêm một tuyển dụng mới.
	 * 
	 * @param sessionUser            Người dùng hiện tại lấy từ session.
	 * @param categoryId            ID của danh mục cho tuyển dụng mới.
	 * @param newRecruitment        Đối tượng tuyển dụng mới được nhập từ form.
	 * @param theBindingResult      Kết quả của việc validate dữ liệu nhập từ form.
	 * @param redirectAttributes    Đối tượng để chuyển dẫn thông báo thành công qua các request.
	 * @param model                 Đối tượng Model để truyền dữ liệu đến view khi có lỗi.
	 * @return                      Chuyển hướng đến trang danh sách tuyển dụng nếu thành công, ngược lại là trang thêm tuyển dụng.
	 */
	@PostMapping("/addRecruitment")
	public String addRecruitment(@SessionAttribute("user") User sessionUser, 
								@RequestParam("categoryId") int categoryId,
								@Valid @ModelAttribute("recruitment") Recruitment newRecruitment, 
								BindingResult theBindingResult,
								RedirectAttributes redirectAttributes,
								Model model) {

		if (theBindingResult.hasErrors()) {
			model.addAttribute("categories", categoryService.getCategories());
			model.addAttribute("recruitment", newRecruitment);
			return "admin/post-job";
		}

		recruitmentService.addRecruitment(sessionUser, newRecruitment, categoryId);
		redirectAttributes.addFlashAttribute("postSuccess", true);

		return "redirect:/admin/listRecruitments";
	}
	
	/**
	 * Xử lý cập nhật thông tin một tuyển dụng.
	 * 
	 * @param sessionUser            Người dùng hiện tại lấy từ session.
	 * @param categoryId            ID của danh mục cho tuyển dụng cần cập nhật.
	 * @param editRecruitment       Đối tượng tuyển dụng cần cập nhật được nhập từ form.
	 * @param theBindingResult      Kết quả của việc validate dữ liệu nhập từ form.
	 * @param redirectAttributes    Đối tượng để chuyển dẫn thông báo thành công hoặc lỗi qua các request.
	 * @return                      Chuyển hướng đến trang danh sách tuyển dụng sau khi cập nhật hoặc có lỗi, ngược lại là trang danh sách tuyển dụng.
	 */
	  @PostMapping("/updateRecruitment") 
	  public String updateRecruitment(	@SessionAttribute("user") User sessionUser, 
			  							@RequestParam("categoryId") int categoryId, 
			  							@Valid @ModelAttribute("editRecruitment") Recruitment editRecruitment,
			  							BindingResult theBindingResult,
			  							RedirectAttributes redirectAttributes) {
		  
		  if(theBindingResult.hasErrors()) {
			  
			  	editRecruitment.setCategory(categoryService.getCategoryById(categoryId));
			  	
			  	redirectAttributes.addFlashAttribute("theBindingResult",theBindingResult);
			  	redirectAttributes.addFlashAttribute("recruitment",editRecruitment);
			  	redirectAttributes.addFlashAttribute("updateSuccess",false);

				return "redirect:/admin/listRecruitments";
			}
		  
		  recruitmentService.updateRecruitment(sessionUser, editRecruitment, categoryId);
		  
		  redirectAttributes.addFlashAttribute("updateSuccess",true);
		  return "redirect:/admin/listRecruitments";
	  }
	  
	  /**
	   * Phương thức này xử lý yêu cầu xóa công việc tuyển dụng.
	   *
	   * @param recruitmentId ID của công việc tuyển dụng cần xóa.
	   * @param request Đối tượng HttpServletRequest để có thể lấy thông tin từ request nếu cần.
	   * @return Chuỗi chứa đường dẫn chuyển hướng sau khi xóa công việc tuyển dụng ("redirect:" + referer).
	   */
	  @PostMapping("/deleteRecruitment")
	  public String deleteRecruitment(@RequestParam("recruitmentId") int recruitmentId, HttpServletRequest request) {
		  
		  recruitmentService.deleteRecruitmentById(recruitmentId); 
		  
		  String referer = request.getHeader("Referer");
		  return "redirect:" + referer;
	  }
	 
	  @GetMapping("/listCandidates")
	  public String listCandidates(@SessionAttribute("user") User sessionUser, Model model) {
		  
		  List<ApplyPost> applyPosts = applyPostService.getApplyPostByAdmin(sessionUser);
		  
		  model.addAttribute("applyPosts",applyPosts);
		  
		  return "admin/list-candidates";
	  }
	  
	  /**
	   * Phương thức này xử lý yêu cầu hiển thị danh sách ứng viên đăng ký công việc tuyển dụng.
	   *
	   * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	   * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	   * @return Tên của view hiển thị danh sách ứng viên đăng ký công việc tuyển dụng ("admin/list-candidates").
	   */
	  @GetMapping("/showDeatailRecruitment")
	  public String showDeatailRecruitment(Model model, @RequestParam("id") int recruitmentId) {
		  
		  Recruitment recruitment = recruitmentService.getRecruitmentById(recruitmentId);
		  model.addAttribute("recruitment", recruitment);
		  
		  List<ApplyPost> applyPosts = applyPostService.getApplyPostByRecruitment(recruitmentId);	  
		  model.addAttribute("applyPosts",applyPosts);
		  
		  return "public/detail-recruitment";
	  }
	
	
	
	
	
	
}
