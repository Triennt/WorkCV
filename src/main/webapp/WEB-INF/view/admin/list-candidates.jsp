<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
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
					<p class="breadcrumbs mb-0">
						<span class="mr-3"><a
							href="${pageContext.request.contextPath}/">Trang chủ <i
								class="ion-ios-arrow-forward"></i></a></span>Ứng cử viên <span></span>
					</p>
					<h1 class="mb-3 bread">Danh sách ứng cử viên</h1>
				</div>
			</div>
		</div>
	</div>

	<!-- Danh sách ứng cử viên -->
	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row justify-conten-center">
				<c:if test="${applyPosts.size() == 0}">
					<div class="col-lg-12 pr-lg-5" style="text-align: center">
						<p style="color: red">Không có kết quả nào</p>
					</div>
				</c:if>
				<c:if test="${applyPosts.size() != 0}">
					<div class="col-lg-12 pr-lg-5 " id="pagination-pajinate">
							<ul class="content">
								<c:forEach var="applyPost" items="${applyPosts}">

									<li class="col-md-12 ">
										<div
											class="job-post-item p-4 d-block d-lg-flex align-items-start">
											<div class="border p-2 d-inline-block mr-3 rounded">
												<img width="100" height="100"
													src="${applyPost.user.image}"
													alt="Image">
											</div>
											<div class="one-third mb-4 mb-md-0">
												<div class="job-post-item-header align-items-center">
													<a
														href="${pageContext.request.contextPath}/admin/showDeatailRecruitment?id=${applyPost.recruitment.id}">
														<span class="subadge">${applyPost.recruitment.title}</span>
													</a>
													<h2 class="mr-3 text-black">
														<a href="#" data-toggle="modal"
															data-target="#detailUserModal${applyPost.id}">${applyPost.user.fullName}</a>
													</h2>
												</div>
												<div class="job-post-item-body d-block d-md-flex">
													<div class="mr-3">
														<a class="icon-my_location"> ${applyPost.user.email}</a>
													</div>
													<div class="mr-3">
														<a style="color: #17a2b8;"
															href="${applyPost.nameCv}"
															target="_blank" class="icon-layers"> Xem CV</a>
													</div>
												</div>
												<div class="job-post-item-body d-block d-md-flex">
													<p class="mb-4 text-justify" style="width: 700px;">${applyPost.text}</p>
												</div>
											</div>
										</div> 
										
										<!-- Detail user modal  -->
										<div class="modal fade" id="detailUserModal${applyPost.id}"
											tabindex="-1" aria-labelledby="detailUserModalLabel"
											aria-hidden="true">
											<div class="modal-dialog modal-lg ">
												<div class="modal-content">
													<div
														class="modal-header modal-header hero-wrap hero-wrap-2"
														style="background-image: url('${pageContext.request.contextPath}/resources/assets/images/bg_1.jpg');"
														data-stellar-background-ratio="0.5">
														<div class="overlay"></div>
														<div class="container">
															<div
																class="row no-gutters slider-text align-items-end justify-content-start">
																<div class="col-md-12 text-center mb-5">
																	<h1 class="mb-3 bread">${applyPost.user.fullName != null ? applyPost.user.fullName : 'Hồ sơ'}</h1>
																	<div style="margin-left: 0px" id="divImage">
																		<img id="avatar" height="100" width="100"
																			style="border-radius: 50px"
																			src="${applyPost.user.image}">
																	</div>
																</div>
															</div>
														</div>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														<section class="site-section" style="margin-top: 10px">
															<div class="container">
																<div class="row mb-5">
																	<div class="col-lg-12">
																		<div class="p-4 p-md-5 border rounded">
																			<h3 class="text-black mb-5 border-bottom pb-2">Thông
																				tin cá nhân</h3>
																			<div class="form-group">
																				<label for="email">Email</label> <input type="email"
																					class="form-control" id="email" name="email"
																					value="${applyPost.user.email}" readonly>
																			</div>
																			<div class="form-group">
																				<label for="job-title">Full name</label> <input
																					type="text" class="form-control" name="fullName"
																					value="${applyPost.user.fullName}" readonly
																					id="job-title">
																			</div>
																			<div class="form-group">
																				<label for="job-location">Địa chỉ</label> <input
																					type="text" name="address"
																					value="${applyPost.user.address}"
																					class="form-control" id="job-location" readonly>
																			</div>
																			<div class="form-group">
																				<label for="job-location">Số điện thoại</label> <input
																					type="text" name="phoneNumber"
																					value="${applyPost.user.phoneNumber}"
																					class="form-control" id="job-location" readonly>
																			</div>
																			<div class="form-group">
																				<label for="job-location">Mô tả bản thân</label>
																				<p>${applyPost.user.description}</p>
																			</div>
																			<div class="modal-footer">
																				<button type="button" class="btn btn-secondary"
																					data-dismiss="modal">Đóng</button>
																			</div>
																		</div>
																	</div>
																</div>
															</div>
														</section>
													</div>
												</div>
											</div>
										</div> <!-- End detail user modal  -->
									</li>
								</c:forEach>

							</ul>
							<div class="page_navigation col-md-12 justify-content-center"></div>
					</div>
				</c:if>
			</div>
		</div>
	</section><!-- Kết thúc danh sách ứng cử viên -->
	
	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->

	<script>
	var contextPath = "${pageContext.request.contextPath}";
	var userStatus = ${sessionScope.user.status};
	</script>
	<!-- các hàm js apply, save, follow, recruit ... -->
	<script src="${pageContext.request.contextPath}/resources/assets/js/apply-and-save.js"></script>
	
</body>

</html>