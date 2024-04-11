package com.triennt.workcv.service.Impl;

import java.io.File;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.google.cloud.storage.Blob;
import com.google.cloud.storage.BlobId;
import com.google.cloud.storage.BlobInfo;
import com.google.cloud.storage.Storage;
import com.triennt.workcv.repository.CvRepo;
import com.triennt.workcv.repository.RecruitmentRepo;
import com.triennt.workcv.repository.RoleRepo;
import com.triennt.workcv.repository.UserRepo;
import com.triennt.workcv.service.CompanyService;
import com.triennt.workcv.service.UserService;
import com.triennt.workcv.user.CrmUser;
import com.triennt.workcv.util.SaveFile;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import com.triennt.workcv.entity.Company;
import com.triennt.workcv.entity.Cv;
import com.triennt.workcv.entity.Recruitment;
import com.triennt.workcv.entity.Role;
import com.triennt.workcv.entity.Status;
import com.triennt.workcv.entity.User;

@Service
public class UserServiceImpl implements UserService {

	// need to inject user dao
	@Autowired
	private UserRepo userRepo;
	
	@Autowired
	private RoleRepo roleRepo;

	@Autowired
	private CvRepo cvRepo;
	
	@Autowired
	private BCryptPasswordEncoder passwordEncoder;

	@Autowired
	private CompanyService companyService;

	@Autowired
	private RecruitmentRepo recruitmentRepo;

	@Autowired
	private SaveFile saveFile;
	
	@Override
	@Transactional
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {
		User user = userRepo.findByEmail(email);
		if (user == null) {
			throw new UsernameNotFoundException("Invalid username or password.");
		}
		
		// Trả về một đối tượng UserDetails được tạo từ thông tin người dùng
		return new org.springframework.security.core.userdetails.User(
				user.getEmail(), // Username (trong trường hợp này là email)
				user.getPassword(), // Mật khẩu
				mapRolesToAuthorities(user.getRole())); // Danh sách quyền được chuyển đổi thành danh sách GrantedAuthority
	}

	private Collection<? extends GrantedAuthority> mapRolesToAuthorities(Role role) {
		
		// Chuyển đổi danh sách quyền của người dùng thành danh sách GrantedAuthority
		return Collections.singletonList( new SimpleGrantedAuthority(role.getRoleName()));
	
	}

	@Override
	@Transactional
	public User findByEmail(String email) {
		// check the database if the user already exists
		return userRepo.findByEmail(email);
	}

	@Override
	@Transactional
	public void create(CrmUser crmUser) {
		
		User user = new User();
		 // assign user details to the user object
		user.setEmail(crmUser.getEmail());
		user.setPassword(passwordEncoder.encode(crmUser.getPassword()));
		user.setFullName(crmUser.getFullName());
		user.setRole(roleRepo.findRoleByRoleName(crmUser.getRoleName()));
		user.setImage("https://storage.googleapis.com/workcv-data/resources/assets/images/default_avatar.jpg");
		user.setStatus(new Status(false, false, false));

		userRepo.save(user);

	}

	@Override
	@Transactional
	public void updateUser(User sessionUser, User userEdit) {
		
		sessionUser.setAddress(userEdit.getAddress());
		sessionUser.setDescription(userEdit.getDescription());
		sessionUser.setFullName(userEdit.getFullName());
		sessionUser.setPhoneNumber(userEdit.getPhoneNumber());
		sessionUser.getStatus().setUpdated(true);
		
		userRepo.save(sessionUser);
		
	}
	
	
	@Override
	public void updateUser(User user) {

		userRepo.save(user);
		
	}

	@Override
	@Transactional
	public ResponseEntity<String> updateUserAvatar(User sessionUser, MultipartFile fileUpload, HttpServletRequest request) {
		
		try {

			String folderPath = "user/" + sessionUser.getEmail() +"/avatar/";

			String fileUrl = saveFile.saveFileOnCloud(fileUpload, folderPath);
			sessionUser.setImage(fileUrl);
			userRepo.save(sessionUser);

            return new ResponseEntity<>(fileUrl, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error", HttpStatus.INTERNAL_SERVER_ERROR);
        }

	}
	
	@Override
	@Transactional
	public ResponseEntity<String> addCv(String uploadsDir, String absolutePath, MultipartFile fileUpload, User sessionUser) {
		try {
			String fileName = fileUpload.getOriginalFilename();
			String folderPath = "user/" + sessionUser.getEmail() + "/cv/";
			String fileUrl = saveFile.saveFileOnCloud(fileUpload, folderPath);

			Cv cv = cvRepo.getByUser(sessionUser);
			if(cv == null)
				cv = new Cv(fileName, fileUrl, sessionUser);
			else {
				cv.setFileName(fileName);
				cv.setFilePath(fileUrl);
				cv.setUser(sessionUser);
			}
			cvRepo.save(cv);
			System.out.println(fileUrl);

			return new ResponseEntity<>(fileUrl, HttpStatus.OK);
		} catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error", HttpStatus.INTERNAL_SERVER_ERROR);
        }
		
	}

	@Override
	@Transactional
	public List<User> getCandidates(HttpSession currentSession) {

		User currentUser = (User) currentSession.getAttribute("user");
		Company currentCompany = companyService.getCompanyByUser(currentUser);		
		List<User> candidates = userRepo.getCandidatesOfCompany(currentCompany);
		
		return candidates;
		
	}
	
	@Override
	@Transactional
	public List<User> getCandidatesOfRecruitment(int recruitmentId) {
		
		return userRepo.getCandidatesOfRecruitment(recruitmentId);
	}

	@Override
	@Transactional
	public List<Recruitment> getRelatedJobs(Recruitment recruitment) {
		
		return recruitmentRepo.getRelatedJobs(recruitment);
	}

	@Override
	@Transactional
	public Cv getCv(User sessionUser) {
		
		return cvRepo.getByUser(sessionUser);
	}

	@Override
	@Transactional
	public ResponseEntity<String> deleteCv(HttpServletRequest request, String filePathCv) {
		try {

			System.out.println("find cv to delete: "+cvRepo.getByFilePath(filePathCv).getFilePath());
			cvRepo.deleteByFilePath(filePathCv);

			return new ResponseEntity<>("Ok", HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>("Error", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	
}
