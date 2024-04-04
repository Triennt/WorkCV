package com.triennt.workcv.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.triennt.workcv.util.SaveFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
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

import com.triennt.workcv.entity.ApplyPost;
import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.Cv;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.UpdateUser;
import com.triennt.workcv.entity.User;
import com.triennt.workcv.service.ApplyPostService;
import com.triennt.workcv.service.CompanyService;
import com.triennt.workcv.service.RecruitmentService;
import com.triennt.workcv.service.SaveJobService;
import com.triennt.workcv.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	CompanyService companyService;
	
	@Autowired
	UserService userService;
	
	@Autowired
	RecruitmentService recruitmentService;
	
	@Autowired
	ApplyPostService applyPostService;
	
	@Autowired
	SaveJobService saveJobService;
	
	/**
	 * Phương thức này xử lý yêu cầu hiển thị trang hồ sơ người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang hồ sơ người dùng ("public/profile-user").
	 */
	@GetMapping("/showProfile")
	public String showProfile(@SessionAttribute("user") User sessionUser, Model model) {
		
		Cv cv = userService.getCv(sessionUser);
		if(cv != null)
			model.addAttribute("Cv", cv);
		
		model.addAttribute("user", sessionUser);
		return "public/profile-user";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu cập nhật thông tin người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param userEdit Đối tượng User chứa thông tin cập nhật từ form.
	 * @param theBindingResult Đối tượng BindingResult chứa thông tin về lỗi sau khi kiểm tra hợp lệ (validation).
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị trang hồ sơ người dùng ("public/profile-user").
	 */
	@PostMapping("/updateProfile")
	public String updateUser( @SessionAttribute("user") User sessionUser,
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
			model.addAttribute("updateSuccess",false);
			
			
			return showProfile(userEdit, model);
		}
		userService.updateUser(sessionUser, userEdit);
		model.addAttribute("updateSuccess",true);

		return showProfile(sessionUser, model);
	}
	
	/**
	 * Phương thức này xử lý yêu cầu tải lên CV cho người dùng.
	 *
	 * @param fileUpload Đối tượng MultipartFile chứa CV được tải lên.
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param request Đối tượng HttpServletRequest để có thể lấy thông tin từ request nếu cần.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình tải lên CV.
	 */
	@PostMapping("/uploadCv")
    public ResponseEntity<String> uploadCv(
    		@RequestParam("cv") MultipartFile fileUpload,
            @SessionAttribute("user") User sessionUser,
            HttpServletRequest request) {
		
		String uploadsDir = "resources/user/"+ sessionUser.getEmail() +"/cv/";
	    String absolutePath =  request.getServletContext().getRealPath(uploadsDir);

		ResponseEntity<String> response = userService.addCv(uploadsDir, absolutePath, fileUpload, sessionUser);
		
		return response;

    }
	
	/**
	 * Phương thức này xử lý yêu cầu xóa CV của người dùng.
	 *
	 * @param filePathCv Đường dẫn tới file CV cần xóa.
	 * @param request Đối tượng HttpServletRequest để có thể lấy thông tin từ request nếu cần.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình xóa CV.
	 */
	@PostMapping("/deleteCv")
	public ResponseEntity<String> deleteCv(@RequestParam("filePathCv") String filePathCv,
											HttpServletRequest request){
		
		ResponseEntity<String> response = userService.deleteCv(request, filePathCv);

        return response;
	}
	
	/**
	 * Phương thức này xử lý yêu cầu ứng tuyển công việc sử dụng CV hiện tại của người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param recruitmentId ID của công việc cần ứng tuyển.
	 * @param description Nội dung mô tả khi ứng tuyển.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình ứng tuyển.
	 */
	@PostMapping("/applyJobAvailableCv")
	public ResponseEntity<String> applyJobAvailableCv(@SessionAttribute(name="user", required=false) User sessionUser, 
											@RequestParam("idRe") int recruitmentId,
											@RequestParam("text") String description){
		
		if(sessionUser == null)
			return new ResponseEntity<>("notLogin",HttpStatus.OK);
		if(applyPostService.hasApplied(sessionUser, recruitmentId))
			return new ResponseEntity<>("hasApplied",HttpStatus.OK);
			
		Cv cv = userService.getCv(sessionUser);
		if(cv == null)
			return new ResponseEntity<>("noCv",HttpStatus.OK);
		
		String filePathCv = cv.getFilePath();
		Recruitment recruitmentApply = recruitmentService.getRecruitmentById(recruitmentId);
		ApplyPost applyPost = new ApplyPost();
		applyPost.setNameCv(filePathCv);
		applyPost.setRecruitment(recruitmentApply);
		applyPost.setUser(sessionUser);
		applyPost.setText(description);
		applyPostService.addApplyPost(applyPost);
	
		return new ResponseEntity<>("Ok",HttpStatus.OK);

	}
	
	/**
	 * Phương thức này xử lý yêu cầu ứng tuyển công việc sử dụng CV mới tải lên khi ứng tuyển.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param fileUpload Đối tượng MultipartFile chứa CV mới được tải lên.
	 * @param recruitmentId ID của công việc cần ứng tuyển.
	 * @param description Nội dung mô tả khi ứng tuyển.
	 * @param request Đối tượng HttpServletRequest để có thể lấy thông tin từ request nếu cần.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình ứng tuyển.
	 */
	@PostMapping("/applyJobNewCv")
	public ResponseEntity<String> applyJobNewCv(@SessionAttribute(name="user", required=false) User sessionUser,
												@RequestParam("file") MultipartFile fileUpload,
												@RequestParam("idRe") int recruitmentId,
												@RequestParam("text") String description,
												HttpServletRequest request){
		
		if(sessionUser == null)
			return new ResponseEntity<>("notLogin",HttpStatus.OK);
		if(applyPostService.hasApplied(sessionUser, recruitmentId))
			return new ResponseEntity<>("hasApplied",HttpStatus.OK);
		if(fileUpload == null)
			return new ResponseEntity<>("noCv",HttpStatus.OK);

		String uploadsDir = "resources/applyPost/" + sessionUser.getEmail() + "/recruitment_"+recruitmentId + "/cv/";
	    String absolutePath =  request.getServletContext().getRealPath(uploadsDir);
	    String fileNameCv="";
	    
	    try {
	    	
	    	fileNameCv = SaveFile.saveFileOnServer(absolutePath, fileUpload);
	    	System.out.println(fileNameCv);
	    	
	    	Recruitment recruitmentApply = recruitmentService.getRecruitmentById(recruitmentId);
			ApplyPost applyPost = new ApplyPost();
			applyPost.setNameCv(uploadsDir + fileNameCv);
			applyPost.setRecruitment(recruitmentApply);
			applyPost.setUser(sessionUser);
			applyPost.setText(description);
			
			applyPostService.addApplyPost(applyPost);
			
			return new ResponseEntity<>("Ok",HttpStatus.OK);
				
	    } catch (Exception e){
	    	System.out.println(e);
	    	return new ResponseEntity<>(e.toString(),HttpStatus.INTERNAL_SERVER_ERROR);
	    }
	}
	
	/**
	 * Phương thức này xử lý yêu cầu lưu công việc cho người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param recruitmentId ID của công việc cần được lưu.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình lưu công việc.
	 */
	@PostMapping("/saveJob")
	public ResponseEntity<String> saveJob(@SessionAttribute(name="user", required=false) User sessionUser,
											@RequestParam("idRe") int recruitmentId){
		
		if(sessionUser == null) {		
			return new ResponseEntity<>("notLogin",HttpStatus.OK);
		}
		if(saveJobService.hasSaved(sessionUser, recruitmentId)) {
			saveJobService.unSave(sessionUser, recruitmentId);
			return new ResponseEntity<>("unSave",HttpStatus.OK);
		}
		
		saveJobService.saveJob(sessionUser, recruitmentId);
		return new ResponseEntity<>("Ok",HttpStatus.OK);
	}
	
	/**
	 * Phương thức này hiển thị trang danh sách công việc đã được lưu của người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị danh sách công việc đã được lưu ("public/list-save-job").
	 */
	@GetMapping("/savedJob")
	public String savedJob(@SessionAttribute("user") User sessionUser, Model model) {
		
		List<Recruitment> savedRecruitments = saveJobService.getSavedRecruitments(sessionUser);
		model.addAttribute("recruitments", savedRecruitments);
		
		return "public/list-save-job";
	}
	
	/**
	 * Phương thức này hiển thị trang danh sách công việc đã ứng tuyển của người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị danh sách công việc đã ứng tuyển ("public/list-apply-job").
	 */
	@GetMapping("/appliedJob")
	public String appliedJob(@SessionAttribute("user") User sessionUser,Model model) {
		
		List<Recruitment> appliedRecruitments = applyPostService.getAppliedRecruitments(sessionUser);
		model.addAttribute("appliedRecruitments", appliedRecruitments);
		
		return "public/list-apply-job";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu theo dõi công ty cho người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param idCompany ID của công ty cần được theo dõi.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình theo dõi công ty.
	 */
	@PostMapping("/followCompany")
	public ResponseEntity<String> followCompany(@SessionAttribute("user") User sessionUser, 
												@RequestParam("idCompany") int idCompany){
		if(sessionUser == null)
			return new ResponseEntity<>("notLogin",HttpStatus.OK);
		if(companyService.hasFollowed(sessionUser, idCompany)) {
			companyService.unfollow(sessionUser, idCompany);
			return new ResponseEntity<>("unfollow",HttpStatus.OK);
		}
		
		companyService.followCompany(sessionUser, idCompany);
		return new ResponseEntity<>("Ok",HttpStatus.OK);
	}
	
	/**
	 * Phương thức này hiển thị trang danh sách công ty đã theo dõi của người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param model Đối tượng Model được sử dụng để chuyển dữ liệu đến view.
	 * @return Tên của view hiển thị danh sách công ty đã theo dõi ("public/list-follow-company").
	 */
	@GetMapping("/followedCompany")
	public String followedCompany(@SessionAttribute("user") User sessionUser,Model model) {
		
		List<Company> followedCompanies = companyService.getFollowedCompanies(sessionUser);
		model.addAttribute("followedCompanies", followedCompanies);
		
		return "public/list-follow-company";
	}
	
	/**
	 * Phương thức này xử lý yêu cầu hủy ứng tuyển công việc đã ứng tuyển trước đó của người dùng.
	 *
	 * @param sessionUser Đối tượng User được lấy từ session, đại diện cho người dùng hiện đang đăng nhập.
	 * @param idRe ID của công việc cần hủy ứng tuyển.
	 * @return Đối tượng ResponseEntity<String> chứa thông báo kết quả của quá trình hủy ứng tuyển.
	 */
	@PostMapping("/cancelApplication")
	public ResponseEntity<String> cancelApplication(@SessionAttribute("user") User sessionUser,
													@RequestParam("idRe") int idRe){
		if(applyPostService.cancelApplication(sessionUser, idRe)) {
			return new ResponseEntity<>("Ok",HttpStatus.OK);
		} else {
			return new ResponseEntity<>("failed",HttpStatus.OK);
		}
	}
	
}
