package com.triennt.workcv.service.Impl;

import java.io.File;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import com.triennt.workcv.repository.CvRepo;
import com.triennt.workcv.repository.RecruitmentRepo;
import com.triennt.workcv.repository.RoleRepo;
import com.triennt.workcv.repository.UserRepo;
import com.triennt.workcv.service.CompanyService;
import com.triennt.workcv.service.UserService;
import com.triennt.workcv.user.CrmUser;
import org.springframework.beans.factory.annotation.Autowired;
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
		user.setImage("resources/assets/images/default_avatar.jpg");
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
			
			String uploadsDir = "resources/user/"+ sessionUser.getEmail() +"/avatar/";
		    String absolutePath =  request.getServletContext().getRealPath(uploadsDir);
		    String oldFileName = sessionUser.getImage();
		    
		    System.out.println("oldFileName: "+oldFileName);

			File dir = new File(absolutePath);
		    if(! dir.exists())
		    {
				System.out.println("create mkdir: "+ dir.mkdirs());
		    } 

        	String fileName = fileUpload.getOriginalFilename();
			File newFile = new File(absolutePath, fileName);
			fileUpload.transferTo(newFile);
			
			 System.out.println("New fileName: "+fileName);
			 
			if(oldFileName != null && !oldFileName.equals("resources/assets/images/default_avatar.jpg") ) {
		    	File oldFile = new File(request.getServletContext().getRealPath(oldFileName));
			    if (oldFile.exists())
			    	oldFile.delete();
		    }
			
			String filePath = uploadsDir + fileName;
			sessionUser.setImage(filePath);
			userRepo.save(sessionUser);

            return new ResponseEntity<>(filePath, HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("Error", HttpStatus.INTERNAL_SERVER_ERROR);
        }

		
	}
	
	@Override
	@Transactional
	public ResponseEntity<String> addCv(String uploadsDir, String absolutePath, MultipartFile fileUpload, User sessionUser) {
		try {
			
		    Cv oldCv = cvRepo.getByUser(sessionUser);

			File dir = new File(absolutePath);
			if(! dir.exists())
			{
				System.out.println("create mkdir: "+ dir.mkdirs());
			}

        	String fileName = fileUpload.getOriginalFilename();
			File newFile = new File(absolutePath, fileName);
			fileUpload.transferTo(newFile);
			
			
		    if(oldCv != null) {
		    	String oldFileName = oldCv.getFileName();
		    	File oldFile = new File(absolutePath, oldFileName);
			    if (oldFile.exists())
			    	oldFile.delete();
		    }
			
			String filePath = uploadsDir + fileName;
			Cv cv = cvRepo.getByUser(sessionUser);
			if(cv == null)
				cv = new Cv(fileName, filePath, sessionUser);
			else {
				cv.setFileName(fileName);
				cv.setFilePath(filePath);
				cv.setUser(sessionUser);
			}
			cvRepo.save(cv);
			System.out.println(filePath);
			
			return new ResponseEntity<>(filePath, HttpStatus.OK);
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
			String absolutePath =  request.getServletContext().getRealPath(filePathCv);

			File oldFile = new File(absolutePath);
		    if (oldFile.exists())
		    	oldFile.delete();

			cvRepo.deleteByFilePath(filePathCv);
			return new ResponseEntity<>("Ok", HttpStatus.OK);
		} catch(Exception e) {
			return new ResponseEntity<>("Error", HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	
}
