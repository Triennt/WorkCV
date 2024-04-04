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
		style="background-image: url('${pageContext.request.contextPath}/resources/assets/images/bg_1.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row no-gutters slider-text align-items-end justify-content-start">
				<div class="col-md-12 text-center mb-5">
					<h1 class="mb-3 bread">${sessionScope.user.fullName != null ? sessionScope.user.fullName : 'Hồ sơ'}</h1>
					<div class="form-group">
						<label class="btn btn-primary btn-md btn-file"> Chọn ảnh<input
							type="file" name="avatar" id="uploadAvatar" accept="image/*"
							hidden>
						</label>
					</div>
					<div style="margin-left: 0px" id="divImage">
						<img id="avatar" height="100" width="100"
							style="border-radius: 50px"
							src="${pageContext.request.contextPath}/${sessionScope.user.image != null ? sessionScope.user.image : 'resources/assets/images/default_avatar.jpg'}">
					</div>
				</div>
			</div>
		</div>
	</div>

	<c:if test="${message == 'verifySuccess'}">
		<div class="toast" data-delay="2000"
			style="position: fixed; top: 100PX; right: 10PX; z-index: 2000; width: 300px">
			<script>
        swal({
            title: 'Xác minh thành công!',
            /* text: 'Redirecting...', */
            icon: 'success',
            timer: 3000,
            buttons: true,
            type: 'success'
        })
    </script>
		</div>
	</c:if>

	<security:authorize access="hasRole('ADMIN')">
		<c:if test="${sessionScope.user.status.verified == false}">
			<div id="verifyEmail" class="container-fluid"
				style="text-align: center">
				<p
					style="font-size: 20px; font-weight: bold; color: #aaa; margin-top: 10px">Xác
					thực email đăng nhập</p>
				<div id="notVerify"
					style="width: 600px; height: 400px; border-radius: 5px; box-shadow: rgba(0, 0, 0, 0.4) 0px 0px 10px; margin: 20px auto; padding: 15px">
					<p style="line-height: 35px; font-size: 16px">
						Xin chào, <span>${sessionScope.user.fullName}</span>. Tài khoản
						của bạn cần phải được xác minh. Bạn vui lòng bấm nút Nhận email
						xác thực dưới đây để nhận mã xác thực.
					</p>
					<div class="row form-group">
						<div class="col-md-12">
							<button id="btnSend"
								class="sendEmail btn px-4 btn-primary text-white">Nhận
								email xác thực</button>
							<p class="sending" style="display: none">Đang gửi email...</p>
						</div>
					</div>
					<p>
						Mọi thắc mắc vui lòng liên hệ bộ phận CSKH của WorkCV:<br>
					</p>
					- Điện thoại:<span style="color: #5f80ec">(+84) 3571 73793</span><br>
					- Email: <a href="#" style="color: #5f80ec">
						workcv.fx21143@gmail.com</a>
				</div>
				<div id="sentEmail"
					style="width: 600px; height: 400px; border-radius: 5px; box-shadow: rgba(0, 0, 0, 0.4) 0px 0px 10px; margin: 20px auto; padding: 15px; display: none">
					<p style="line-height: 35px; font-size: 16px">
						Xin chào, <span>${sessionScope.user.fullName}</span>. Chúng tôi đã
						gửi mã xác thực đến <strong>${sessionScope.user.email}</strong>,
						vui lòng kiểm tra mail và nhập mã xác thực vào ô bên dưới.
					</p>

					<div class="inputCode d-flex justify-content-center">
						<input id="code" type="text" class="form-control col-md-4"
							name="code" placeholder="Nhập mã xác thực">
						<button
							class="verify btn btn-primary text-white form-control col-md-2">Submit</button>
					</div>
					<p id="sending" class="sending" style="display: none">Đang gửi email...</p>

					<p>
						Nếu bạn chưa nhận được Email hãy nhấn <a href="#" class="sendEmail">gửi lại</a>
					</p>
					<p>
						Mọi thắc mắc vui lòng liên hệ bộ phận CSKH của WorkCV:<br>
					</p>
					- Điện thoại:<span style="color: #5f80ec">(024) 6680 5588</span><br>
					- Email: <a href="#" style="color: #5f80ec"> hotro@workcv.vn</a>
				</div>
			</div>
		</c:if>
	</security:authorize>

	<section class="site-section" style="margin-top: 10px">
		<div class="container">

			<security:authorize access="hasRole('USER')">
				<div class="row align-items-center mb-5">
					<div class="col-lg-8 ">
						<div class="d-flex align-items-center">
							<div class="form-group" style="margin-top: 15px">
								<label class="btn btn-primary btn-md btn-file"> Chọn CV
									(pdf)<input type="file" name="cv" id="uploadCv"
									accept="application/pdf" required hidden>
								</label>
							</div>
						</div>
						<c:if test="${Cv == null}">

							<a id="cvName" href="#" target=""> Chưa có CV </a>
							<a style="color: red; margin-left: 20px" href="#"
								id="buttonDelete" data-toggle="modal"
								data-target="#exampleModal"></a>
						</c:if>

						<c:if test="${Cv != null}">

							<a id="cvName"
								href="${pageContext.request.contextPath}/${Cv.filePath}"
								target="_blank"> ${Cv.fileName} </a>
							<a id="buttonDelete" href="#"
								style="color: red; margin-left: 20px" data-toggle="modal"
								data-target="#exampleModal">Xóa CV</a>
						</c:if>
					</div>
				</div>
			</security:authorize>

			<div class="row mb-5">
				<div class="col-lg-12">
					<div class="p-4 p-md-5 border rounded">
						<c:if test="${sessionScope.user.status.updated == false}">

							<div class="alert alert-danger col-xs-offset-1 col-xs-10">
								Thông tin cá nhân chưa được cập nhật</div>

						</c:if>
						<h3 class="text-black mb-5 border-bottom pb-2">Thông tin cá
							nhân</h3>
						<div class="form-group">
							<label for="email">Email</label> 
							<span class="error"> ${emailError}</span>
							<input type="email"
								class="form-control" id="email" name="email"
								value="${user.email}" readonly>
						</div>
						<div class="form-group">
							<label for="job-title">Full name</label> 
							<span class="error"> ${fullNameError}</span>
							<input type="text"
								class="form-control" name="fullName" value="${user.fullName}"
								readonly id="job-title">
						</div>
						<div class="form-group">
							<label for="job-location">Địa chỉ</label> 
							<span class="error"> ${addressError}</span>
							<input type="text"
								name="address" value="${user.address}" class="form-control"
								id="job-location" readonly>
						</div>
						<div class="form-group">
							<label for="job-location">Số điện thoại</label> 
							<span class="error"> ${phoneNumberError}</span><input
								type="text" name="phoneNumber" value="${user.phoneNumber}"
								class="form-control" id="job-location" readonly>
						</div>
						<div class="form-group">
							<label for="job-location">Mô tả bản thân</label>
							<span class="error"> ${descriptionError}</span>
							<p>${user.description}</p>
						</div>

						<button type="button" class="btn btn-primary  mt-1"
							data-toggle="modal" data-target="#updateUserModal">Cập
							nhật</button>
						<a id="buttonCancel" type="button" class="btn btn-primary  mt-1"
							style="display: none" href="showProfile"> Hủy</a>
					</div>
				</div>

				<!-- Update User Modal -->
				<div class="modal fade" id="updateUserModal" tabindex="-1"
					aria-labelledby="updateUserModalLabel" aria-hidden="true">
					<div class="modal-dialog modal-lg ">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="updateUserModalLabel">Cập nhật
									thông tin cá nhân</h5>
								<button type="button" class="btn-close" data-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<form:form action="updateProfile" modelAttribute="userEdited"
									method="post">
									<input type="hidden" name="id" value="${user.id}">
									<div class="row">
										<div class="col-6">
											<label for="addcost" class="col-form-label">Email:</label> <span
												class="error"> ${emailError}</span> <input type="email"
												class="form-control" id="addcost" name="email"
												value="${user.email}" readonly>
										</div>

										<div class="col-6">
											<label for="addname" class="col-form-label">Họ và
												tên:</label> <span class="error"> ${fullNameError}</span> <input
												type="text" class="form-control" id="addname"
												name="fullName" value="${user.fullName}" required>
										</div>

									</div>
									<div class="row">

										<div class="col-6">
											<label for="addcost" class="col-form-label">Địa chỉ:</label>
											<span class="error"> ${addressError}</span> <input
												type="text" class="form-control" id="addcost" name="address"
												value="${user.address}" required>
										</div>
										<div class="col-6">
											<label for="addname" class="col-form-label">Số điện
												thoại:</label> <span class="error"> ${phoneNumberError}</span> <input
												type="number" class="form-control" id="addname"
												name="phoneNumber" value="${user.phoneNumber}" required>
										</div>
									</div>
									<div class="row">
										<div class="col-12">
											<label for="ct_id" class="col-form-label">Mô tả:</label> <span
												class="error"> ${descriptionError}</span>
											<textarea name="description" class="form-control" cols="50"
												rows="5" id="description">${user.description}</textarea>
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
				<!-- End Update User Modal -->
				<!-- Modal delete CV-->
				<div class="modal fade" id="exampleModal" tabindex="-1"
					role="dialog" aria-labelledby="exampleModalLabel"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="exampleModalLabel">Bạn có chắc
									chắn muốn xóa ?</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<c:if test="${Cv != null}">
						CV : <span id="cvDelete">${Cv.fileName}</span>
								</c:if>
								<c:if test="${Cv == null}">
						CV : <span id="cvDelete"></span>
								</c:if>
								<div class="modal-footer mt-1">
									<input id="filePathCv" type="hidden" name="fileName"
										value="${Cv.filePath}">
									<button type="button" class="btn btn-secondary"
										data-dismiss="modal">Đóng</button>
									<button id="deleteCvButton" type="button"
										class="btn btn-danger" data-dismiss="modal">Xóa</button>
								</div>
							</div>

						</div>
					</div>
				</div>
				<!-- End modal delete CV-->
			</div>
		</div>
	</section>

	<script type="text/javascript">
		ClassicEditor
	    .create(document.querySelector('#description'))
	    .catch(error => {
	        console.error(error);
	    });
	</script>
		
	<script type="text/javascript">
		if (${updateSuccess == false}) {
	        $('#updateUserModal').modal('show');
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
		
	</script>

	<script>
		var contextPath = "${pageContext.request.contextPath}";
	</script>
	<!-- các hàm js apply, save, follow, recruit ... -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/functions.js"></script>

	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->
</body>

</html>