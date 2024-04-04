package com.triennt.workcv.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.triennt.workcv.entity.Category;
import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.User;
import com.triennt.workcv.service.ApplyPostService;
import com.triennt.workcv.service.CategoryService;
import com.triennt.workcv.service.CompanyService;
import com.triennt.workcv.service.RecruitmentService;
import com.triennt.workcv.service.SaveJobService;
import com.triennt.workcv.service.UserService;

@Controller
public class HomeController {
	@Autowired
	CompanyService companyService;
	
	@Autowired
	RecruitmentService recruitmentService;
	
	@Autowired
	CategoryService categoryService;
	
	@Autowired
	ApplyPostService applyPostService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	SaveJobService saveJobService;
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị trang chủ.
	 *
	 * @param theModel Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang chủ ("public/home").
	 */
	@GetMapping("/")
	public String showHome(Model theModel) {
		
		//lấy top 4 công ty tương ứng với số lượng bài tuyển dụng nhiều nhất, có nhiều ứng viên 
		Map<Company, Long> topCompanies = companyService.getTopCompanies();
		
		//lấy top 10 công việc mới nhất
		List<Recruitment> topRecruitments = recruitmentService.getTopRecruitment();
		
		//lấy top 4 danh mục có số bài tuyển dụng nhiều nhất
		Map<Category, Long> topCategories = categoryService.getTopCategories();
		
		Long numberOfCandidates = applyPostService.getNumberOfCandidates();
		Long numberOfCompanies = companyService.getNumberOfCompanies();
		Long numberOfRecruitments = recruitmentService.getNumberOfRecruitments();
		
		theModel.addAttribute("recruitments", topRecruitments);
		theModel.addAttribute("topCompanies",topCompanies);	
		theModel.addAttribute("categories", topCategories);
		theModel.addAttribute("numberOfCandidates",numberOfCandidates);
		theModel.addAttribute("numberOfCompanies",numberOfCompanies);
		theModel.addAttribute("numberOfRecruitments",numberOfRecruitments);
		
		return "public/home";
	}
	
	/**
	 * Xử lý yêu cầu tìm kiếm việc làm.
	 *
	 * @param keySearch Từ khóa tìm kiếm.
	 * @param typeSearch Loại tìm kiếm.
	 * @param redirectAttributes Đối tượng để chuyển hướng và truyền dữ liệu giữa các phương thức.
	 * @return Đường dẫn chuyển hướng đến trang kết quả tìm kiếm.
	 */
	@PostMapping("/searchJob")
	public String searchJob(@RequestParam("keySearch") String keySearch, 
							@RequestParam("typeSearch") String typeSearch, 
							RedirectAttributes redirectAttributes) {
		
		List<Recruitment> recruitments = recruitmentService.getRecruitmentsByKey(keySearch, typeSearch);
		redirectAttributes.addFlashAttribute("recruitments",recruitments);
		redirectAttributes.addFlashAttribute("keySearch",keySearch);
		redirectAttributes.addFlashAttribute("typeSearch",typeSearch);
		
		return "redirect:/resultSearch";
	}
	
	/**
	 * Hiển thị trang kết quả tìm kiếm việc làm.
	 *
	 * @param model Model Spring để truyền dữ liệu đến view.
	 * @return Đường dẫn đến trang kết quả tìm kiếm.
	 */
	@GetMapping("/resultSearch")
	public String resultSearch(Model model) {
		
		model.asMap().get("recruitments");
		model.asMap().get("keySearch");
		model.asMap().get("typeSearch");
		
		return "public/result-search";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị chi tiết công việc tuyển dụng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @param recruitmentId ID của công việc tuyển dụng cần hiển thị chi tiết.
	 * @return Tên của view hiển thị chi tiết công việc tuyển dụng ("public/detail-recruitment").
	 */
	@GetMapping("/showDeatailRecruitment")
	  public String showDeatailRecruitment(@SessionAttribute(name="user", required=false) User sessionUser,
			  								Model model, 
			  								@RequestParam("id") int recruitmentId) {
		  
		  Recruitment recruitment = recruitmentService.getRecruitmentById(recruitmentId);
		  model.addAttribute("recruitment", recruitment);
		  
		  List<User> candidatesOfRecruitment = userService.getCandidatesOfRecruitment(recruitmentId);
		  model.addAttribute("candidates", candidatesOfRecruitment);
		  
		  List<Recruitment> relatedJobs = userService.getRelatedJobs(recruitment);
		  model.addAttribute("relatedJobs",relatedJobs);
		  
		  if(sessionUser != null) {
				model.addAttribute("hasSaved", saveJobService.hasSaved(sessionUser, recruitmentId));
				model.addAttribute("hasApplied", applyPostService.hasApplied(sessionUser, recruitmentId));
			} else {
				model.addAttribute("hasSaved", false);
				model.addAttribute("hasApplied", false);
			}
	  
		  return "public/detail-recruitment";
	  }
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị chi tiết công ty.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param idCompany ID của công ty cần hiển thị chi tiết.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị chi tiết công ty ("public/detail-company").
	 */
	@GetMapping("/detailCompany")
	public String detailCompany(@SessionAttribute(name="user", required=false) User sessionUser, 
								@RequestParam("idCompany") int idCompany, 
								Model model) {
		
		Company company = companyService.getCompanyById(idCompany);
		if(sessionUser != null) {
			model.addAttribute("hasFollowed", companyService.hasFollowed(sessionUser, idCompany));
		} else
			model.addAttribute("hasFollowed", false);
		
		List<Recruitment> recruitments = recruitmentService.getRecruitmentsOfCompany(idCompany);
		
		model.addAttribute("recruitments",recruitments);
		model.addAttribute("company",company);
		
		return "public/detail-company";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị danh sách công việc tuyển dụng của một công ty.
	 *
	 * @param idCompany ID của công ty cần hiển thị danh sách công việc tuyển dụng.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị danh sách công việc tuyển dụng của một công ty ("public/recruitments").
	 */
	@GetMapping("/recruitmentsOfCompany")
	public String getRecruitmentsOfCompany(@RequestParam("idCompany") int idCompany, Model model) {
		
		List<Recruitment> recruitments = recruitmentService.getRecruitmentsOfCompany(idCompany);
		model.addAttribute("recruitments",recruitments);
		
		return "public/recruitments-of-company";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị danh sách công việc tuyển dụng theo một danh mục.
	 *
	 * @param idCategory ID của danh mục cần hiển thị danh sách công việc tuyển dụng.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị danh sách công việc tuyển dụng theo một danh mục ("public/recruitments-of-category").
	 */
	@GetMapping("/recruitmentsOfCategory")
	public String getRecruitmentsOfCategory(@RequestParam("idCategory") int idCategory, Model model) {
		
		Category category = categoryService.getCategoryById(idCategory);
		model.addAttribute("category",category);
		
		List<Recruitment> recruitments = recruitmentService.getRecruitmentsOfCategory(idCategory);
		model.addAttribute("recruitments",recruitments);
		
		return "public/recruitments-of-category";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu tải lên (upload) ảnh đại diện cho người dùng.
	 *
	 * @param fileUpload Đối tượng MultipartFile chứa ảnh đại diện được tải lên.
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param request Đối tượng HttpServletRequest để có thể lấy thông tin từ request nếu cần.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình tải lên ảnh đại diện.
	 */
	@PostMapping("/uploadAvatar")
    public ResponseEntity<String> uploadAvatar(
    		@RequestParam("avatar") MultipartFile fileUpload,
            @SessionAttribute("user") User sessionUser,
            HttpServletRequest request) {

		ResponseEntity<String> response = userService.updateUserAvatar(sessionUser, fileUpload, request);
		
        return response;
        
    }
}










