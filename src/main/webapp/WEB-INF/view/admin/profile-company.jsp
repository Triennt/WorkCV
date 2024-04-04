<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<!-- <head> -->
<jsp:include page="/WEB-INF/view/parts/head.jsp" />
<!-- </head> -->

<body>

	<!-- navbar -->
	<jsp:include page="/WEB-INF/view/parts/navbar.jsp" />
	<!-- end navbar -->

	<div class="hero-wrap hero-wrap-2"
		style="background-image: url('${pageContext.request.contextPath}/resources/assets/images/Company_profile.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row no-gutters slider-text align-items-end justify-content-start">
				<div class="col-md-12 text-center mb-5">
					<h1 class="mb-3 bread">${company != null ? company.nameCompany : 'Company'}</h1>
					<div class="form-group">
						<label class="btn btn-primary btn-md btn-file"> Chọn ảnh<input
							type="file" name="logo" id="uploadLogo" accept="image/*" hidden>
						</label>
					</div>
					<div style="margin-left: 0px" id="divImage">
						<img id="logo" height="100" width="100"
							style="border-radius: 50px"
							src="${pageContext.request.contextPath}/${company.logo != null ? company.logo : 'resources/assets/images/default_logo.jpg'}">
					</div>
				</div>
			</div>
		</div>
	</div>
	
	<section class="site-section" style="margin-top: 10px">
		<div class="container">
			<div class="row mb-5">
				<!-- Thông tin công ty -->
				<security:authorize access="hasRole('ADMIN')">
					
					<c:if test="${sessionScope.company == null}">
					<div class="col-lg-12">
						<div class="p-4 p-md-5 border rounded">
							<h3 class="text-black mb-5 border-bottom pb-2">Thông tin
								công ty</h3>
							<p>Bạn chưa tạo hồ sơ công ty.</p>	
							<button type="button" class="btn btn-primary  mt-1" onclick="createProfileCompany()">
								Tạo hồ sơ</button>
						</div>
					</div>
					</c:if>			
					<c:if test="${company != null}">
					
					<div class="col-lg-12">
					<form:form action="updateProfileCompany" modelAttribute="companyEdit"
										method="post">
						<div class="p-4 p-md-5 border rounded">
							<h3 class="text-black mb-5 border-bottom pb-2">Thông tin
								công ty</h3>
							<div class="form-group">
								
								<label for="email">Email</label> 
								<span class="error"> ${emailError}</span>
								<input type="email"
									class="form-control inputField" id="email" name="email"
									value="${company.email}"  readonly>
							</div>
							<div class="form-group">
								<label for="job-title">Tên công ty</label> 
								<span class="error"> ${nameCompanyError}</span>
								<input type="text"
									class="form-control inputField" name="nameCompany"
									value="${company.nameCompany}" readonly id="job-title">
							</div>
							<div class="form-group">
								<label for="job-location">Địa chỉ</label> 
								<span class="error"> ${addressError}</span>
								<input type="text"
									name="address" value="${company.address}" class="form-control inputField"
									id="job-location" readonly>
							</div>
							<div class="form-group">
								<label for="job-location">Số điện thoại công ty</label>
								<span class="error"> ${phoneCompanyError}</span>
								<input
									type="text" name="phoneCompany" value="${company.phoneCompany}"
									class="form-control inputField" id="job-location" readonly>
							</div>
							<div class="form-group">
								<label for="job-location">Mô tả công ty</label>
								<span class="error"> ${descriptionError}</span>
								<p style="text-align: justify;">${company.description}</p>
							</div>
							<button id="buttonUpdate" type="button" class="btn btn-primary  mt-1"
								data-toggle="modal" data-target="#updateCompanyModal">
								Cập nhật</button>
							<a id="buttonCancel" type="button" class="btn btn-primary  mt-1" style="display: none"
								href="${pageContext.request.contextPath}/admin/showProfileCompany">
								Hủy</a>
						</div>
						</form:form>
					</div>
				 	
					</c:if>
				</security:authorize>
				<!-- Kết thúc thông tin công ty -->
				
				<!-- Create Company Modal -->
					<div class="modal fade" id="createCompanyModal" tabindex="-1"
						aria-labelledby="createCompanyModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg ">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="createCompanyModalLabel">Tạo hồ sơ công ty</h5>
									<button type="button" class="btn-close" data-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form:form action="createProfileCompany" modelAttribute="companyEdit"
										method="post">
										
										<div class="row">
											<div class="col-6">
												<label for="addcost" class="col-form-label">Email:</label> 
												<span class="error"> ${emailError}</span>
												<input type="email" class="form-control" id="addcost" name="email" required
												value="${company != null ? company.email : null}">
											</div>

											<div class="col-6">
												<label for="addname" class="col-form-label">Tên công
													ty:</label> 
												<span class="error"> ${nameCompanyError}</span>
												<input type="text" class="form-control" id="addname"
													name="nameCompany" required
													value="${company != null ? company.nameCompany : null}">
											</div>

										</div>
										<div class="row">

											<div class="col-6">
												<label for="addcost" class="col-form-label">Địa chỉ:</label>
												<span class="error"> ${addressError}</span>
												<input type="text" class="form-control" id="addcost"
													name="address" required
													value="${company != null ? company.address : null}">
											</div>
											<div class="col-6">
												<label for="addname" class="col-form-label">Số điện
													thoại:</label>
													<span class="error"> ${phoneCompanyError}</span> 
													<input type="number" class="form-control"
													id="addname" name="phoneCompany" required
													value="${company != null ? company.phoneCompany : null}">
											</div>
										</div>
										<div class="row">
											<div class="col-12">
												<label for="ct_id" class="col-form-label">Mô tả:</label>
												<span class="error"> ${descriptionError}</span>
												<textarea name="description" class="form-control" cols="50"
													rows="5" id="createDescription">${company != null ? company.description : null}</textarea>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">Đóng</button>
											<button type="submit" class="btn btn-primary">Lưu</button>
										</div>
									</form:form>
								</div>

							</div>
						</div>
					</div>
					<!-- End Create Company Modal -->
				
				<!-- Update Company Modal -->
					<div class="modal fade" id="updateCompanyModal" tabindex="-1"
						aria-labelledby="updateCompanyModalLabel" aria-hidden="true">
						<div class="modal-dialog modal-lg ">
							<div class="modal-content">
								<div class="modal-header">
									<h5 class="modal-title" id="updateCompanyModalLabel">Cập
										nhật thông tin công ty</h5>
									<button type="button" class="btn-close" data-dismiss="modal"
										aria-label="Close"></button>
								</div>
								<div class="modal-body">
									<form:form action="updateProfileCompany" modelAttribute="companyEdit"
										method="post">
										
										<input type="hidden" name="id" value="${company.id}">
										
										<input id ="inputLogo" type="hidden" name="logo" value="${company.logo}">
										<div class="row">
											<div class="col-6">
												<label for="addcost" class="col-form-label">Email:</label> 
												<span class="error"> ${emailError}</span>
												<input type="email" class="form-control" id="addcost" name="email"
													value="${company.email}" required>
											</div>

											<div class="col-6">
												<label for="addname" class="col-form-label">Tên công
													ty:</label> 
													<span class="error"> ${nameCompanyError}</span>
													<input type="text" class="form-control" id="addname"
													name="nameCompany" value="${company.nameCompany}" required>
											</div>

										</div>
										<div class="row">

											<div class="col-6">
												<label for="addcost" class="col-form-label">Địa chỉ:</label>
												<span class="error"> ${addressError}</span>
												<input type="text" class="form-control" id="addcost"
													name="address" value="${company.address}" required>
											</div>
											<div class="col-6">
												<label for="addname" class="col-form-label">Số điện
													thoại:</label> 
													<span class="error"> ${phoneCompanyError}</span>
													<input type="number" class="form-control"
													id="addname" name="phoneCompany"
													value="${company.phoneCompany}" required>
											</div>
										</div>
										<div class="row">
											<div class="col-12">
												<label for="ct_id" class="col-form-label">Mô tả:</label>
												<span class="error"> ${descriptionError}</span>
												<textarea name="description" class="form-control" cols="50"
													rows="5" id="updateDescription">${company.description} </textarea>
											</div>
										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-dismiss="modal">Đóng</button>
											<button type="submit" class="btn btn-primary">Lưu</button>
										</div>
									</form:form>
								</div>

							</div>
						</div>
					</div>
					<!-- End Update Company Modal -->
			</div>

		</div>
	</section>
	
	<script>
        // Khởi tạo CKEditor trên đối tượng textarea với id="editor"
        ClassicEditor
            .create(document.querySelector('#createDescription'))
            .catch(error => {
                console.error(error);
            });
        
        ClassicEditor
            .create(document.querySelector('#updateDescription'))
            .catch(error => {
                console.error(error);
            });
    </script>
	
	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->

	<script type="text/javascript">
		if (${updateSuccess == false}) {
	        $('#updateCompanyModal').modal('show');
	        $('#buttonCancel').show();
	    } 
		if (${updateSuccess == true}){
	    	swal({
				title: 'Cập nhật thành công!',
				icon: 'success',
				timer: 3000,
				buttons: true,
				type: 'success'
			})
	    }
		
		if (${createSuccess == false}) {
	        $('#createCompanyModal').modal('show');
	        $('#buttonCancel').show();
	        $('#buttonUpdate').hide();
	    }
		if (${createSuccess == true}){
	    	swal({
				title: 'Tạo hồ sơ thành công!',
				icon: 'success',
				timer: 3000,
				buttons: true,
				type: 'success'
			})
	    }
	</script>

	
	
	
	<script type="text/javascript">
	function createProfileCompany() {
		var verified = ${sessionScope.user.status.verified};
		var updated = ${sessionScope.user.status.updated};
		if(verified == false){
				swal({
	                title: 'Bạn cần phải xác minh Email đăng nhập',
	                text: 'Nhấn Ok để chuyển hướng đến trang xác minh',
	                icon: 'error',
	                /* timer: 3000, */
	                buttons: true,
	                type: 'error'
	            }).then((ok) => {
						 if (ok) {
	 					window.location.href = contextPath + '/admin/showProfile'; 
						 }
				})
				return;
			}
		
		
		if(updated == false){
				swal({
	                title: 'Bạn cần phải cập nhật thông tin cá nhân',
	                text: 'Nhấn Ok để chuyển hướng đến trang cá nhân',
	                icon: 'error',
	                /* timer: 3000, */
	                buttons: true,
	                type: 'error'
	            }).then((ok) => {
						 if (ok) {
	 					window.location.href = contextPath + '/admin/showProfile'; 
						 }
				})
				return;
			}
		
		
		$('#createCompanyModal').modal('show');
		
	}
	
	</script>
	
	<script>
		var contextPath = "${pageContext.request.contextPath}";	
	</script>
	<!-- các hàm js apply, save, follow, recruit ... -->
	<script src="${pageContext.request.contextPath}/resources/assets/js/functions.js"></script>
	
</body>


</html>