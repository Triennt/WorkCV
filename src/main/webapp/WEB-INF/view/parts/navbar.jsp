<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<div class="container-fluid px-md-4	">
		<a class="navbar-brand">Work CV</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#ftco-nav" aria-controls="ftco-nav"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="oi oi-menu"></span> Menu
		</button>

		<div class="collapse navbar-collapse" id="ftco-nav">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a
					href="${pageContext.request.contextPath}/" class="nav-link">Trang
						chủ</a></li>
				<li class="nav-item"><a
					href="${pageContext.request.contextPath}/#search" class="nav-link">Tìm
						kiếm</a></li>
				<security:authorize access="hasRole('ADMIN')">
					<li class="nav-item"><a
						href="${pageContext.request.contextPath}/admin/listCandidates"
						class="nav-link">Ứng cử viên</a></li>
					<li class="nav-item cta mr-md-1"><a onclick="recruit()"
						class="nav-link">Đăng tuyển</a></li>
					<c:if test="${sessionScope.company != null}">
						<li class="nav-item cta mr-md-1"><a class="nav-link"
							href="${pageContext.request.contextPath}/detailCompany?idCompany=${sessionScope.company.id}"
							style="color: #17a2b8;">${sessionScope.company.nameCompany}</a></li>
					</c:if>
					<c:if test="${sessionScope.user != null}">
						<li class="nav-item"><a class="nav-link dropdown-toggle"
							href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"> <img
								src="${sessionScope.user.image}"
								alt="User Avatar" class="rounded-circle" width="30" height="30">
						</a>

							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<h5 class="dropdown-item">${sessionScope.user.fullName}</h5>
								<input type="hidden" id="sessionUser"
									value="${sessionScope.user.email}">
								<div class="dropdown-divider"></div>
								<a class="dropdown-item"
									href="${pageContext.request.contextPath}/admin/showProfile">Thông
									tin cá nhân</a> <a class="dropdown-item"
									href="${pageContext.request.contextPath}/admin/showProfileCompany">Thông
									tin công ty</a> <a class="dropdown-item"
									href="${pageContext.request.contextPath}/admin/listRecruitments">Quản lý bài đăng</a>
									<a	href="${pageContext.request.contextPath}/admin/listCandidates"
										class="dropdown-item">Danh sách ứng viên</a>

								<div class="dropdown-divider"></div>
								<a class="dropdown-item"
									href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
							</div></li>
					</c:if>
				</security:authorize>

				<security:authorize access="hasRole('USER')">

					<c:if test="${sessionScope.user != null}">
						<input type="hidden" id="roleUser" value=true>
						<input type="hidden" id="userStatus"
							value="${sessionScope.user.status}">
						<li class="nav-item"><a
							href="${pageContext.request.contextPath}/user/appliedJob"
							class="nav-link">Việc của tôi</a></li>
						<li class="nav-item"><a class="nav-link dropdown-toggle"
							href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
							aria-haspopup="true" aria-expanded="false"> <img
								src="${sessionScope.user.image}"
								alt="User Avatar" class="rounded-circle" width="30" height="30">
						</a>

							<div class="dropdown-menu" aria-labelledby="navbarDropdown">
								<h5 class="dropdown-item">${sessionScope.user.fullName}</h5>
								<div class="dropdown-divider"></div>
								<a class="dropdown-item"
									href="${pageContext.request.contextPath}/user/showProfile">Thông
									tin cá nhân</a> <a class="dropdown-item"
									href="${pageContext.request.contextPath}/user/savedJob">Công
									việc đã lưu</a> <a class="dropdown-item"
									href="${pageContext.request.contextPath}/user/appliedJob">Công
									việc đã ứng tuyển</a> <a class="dropdown-item"
									href="${pageContext.request.contextPath}/user/followedCompany">Công
									ty đã theo dõi</a>

								<div class="dropdown-divider"></div>
								<a class="dropdown-item"
									href="${pageContext.request.contextPath}/logout">Đăng xuất</a>
							</div></li>
					</c:if>
				</security:authorize>

				<c:if test="${sessionScope.user == null}">
					<li class="nav-item cta cta-colored"><a
						href="${pageContext.request.contextPath}/showMyLoginPage"
						class="nav-link btn btn-warning">Đăng nhập</a></li>
				</c:if>
			</ul>
		</div>
	</div>
</nav>

<script>
	function recruit(){
		
		var contextPath = "${pageContext.request.contextPath}";
		var verified = ${sessionScope.user.status.verified};
		var updated = ${sessionScope.user.status.updated};
		var createdCompany = ${sessionScope.user.status.createdCompany};
		
		if(createdCompany == false){
			swal({
                title: 'Bạn cần phải tạo hồ sơ công ty',
                text: 'Nhấn Ok để chuyển hướng đến trang tạo hồ sơ',
                icon: 'error',
                /* timer: 3000, */
                buttons: true,
                type: 'error'
            }).then((ok) => {
					 if (ok) {
 					window.location.href = contextPath + '/admin/showProfileCompany'; 
					 }
			})
			return;
		}	

		window.location.href = contextPath + '/admin/recruit';	
       
    }
</script>