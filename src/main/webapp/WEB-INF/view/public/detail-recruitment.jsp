<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
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
						<span class="mr-3"><a href="index.html">Trang chủ <i
								class="ion-ios-arrow-forward"></i></a></span>Chi tiết <span></span>
					</p>
					<h1 class="mb-3 bread">Chi tiết công việc</h1>
				</div>
			</div>
		</div>
	</div>

	<section style="margin-top: 10px" class="site-section">
		<div class="container">
			<div class="row align-items-center mb-5">
				<div class="col-lg-8 mb-4 mb-lg-0">
					<div class="d-flex align-items-center">
						<div class="border p-2 d-inline-block mr-3 rounded">
							<img width="100" height="100"
								src="${pageContext.request.contextPath}/${recruitment.company.logo}"
								alt="Image">
						</div>
						<div>
							<h2>${recruitment.title}</h2>
							<div>
								<span class="icon-briefcase mr-2"></span><a
									class="ml-0 mr-2 mb-2">${recruitment.company.nameCompany}</a> <span
									class="icon-room mr-2"></span><span class="m-2">${recruitment.address}</span>
								<span class="icon-clock-o mr-2"></span><span class="m-2">${recruitment.type}</span>
							</div>

						</div>
					</div>
				</div>
				<div class="col-lg-4">
					<div class="row">
						<input type="hidden" id="idRe${recruitment.id}"
							value="${recruitment.id}">

						<c:if test="${hasSaved == true}">
							<div class="col-6">
								<a id="saved" onclick="save(${recruitment.id})"
									class="btn btn-block btn-light btn-md"><span
									class="icon-heart mr-2 text-danger"></span>Đã lưu</a> <a
									id="notSave" onclick="save(${recruitment.id})"
									style="display: none" class="btn btn-block btn-light btn-md"><span
									class="icon-heart-o mr-2 text-danger"></span>Lưu</a>
							</div>
						</c:if>
						<c:if test="${hasSaved == false}">
							<div class="col-6">
								<a id="saved" onclick="save(${recruitment.id})"
									style="display: none" class="btn btn-block btn-light btn-md"><span
									class="icon-heart mr-2 text-danger"></span>Đã lưu</a> <a
									id="notSave" onclick="save(${recruitment.id})"
									class="btn btn-block btn-light btn-md"><span
									class="icon-heart-o mr-2 text-danger"></span>Lưu</a>
							</div>
						</c:if>

						<c:if test="${hasApplied == true}">
							<div class="col-6">
								<a class="btn btn-block btn-primary btn-md">Đã ứng tuyển</a>
							</div>
						</c:if>
						<c:if test="${hasApplied == false}">
							<div class="col-6">
								<a data-toggle="modal" onclick="clickApply(${recruitment.id})"
									class="btn btn-block btn-primary btn-md">Ứng tuyển</a>
							</div>
						</c:if>

					</div>
				</div>
				
				<!-- Apply Modal id="applyModal${recruitment.id}" -->  
				<jsp:include page="/WEB-INF/view/parts/apply-modal.jsp" /> 
				<!-- End apply Modal id="applyModal${recruitment.id}" -->
				
				<%-- <!-- Modal Apply -->
				<div class="modal fade" id="applyModal${recruitment.id}"
					tabindex="-1" role="dialog" aria-labelledby="applyModalLabel"
					aria-hidden="true">
					<div class="modal-dialog" role="document">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="applyleModalLabel">
									Ứng tuyển: <span>${recruitment.title}</span>
								</h5>
								<button type="button" class="close" data-dismiss="modal"
									aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<form method="post" action="/user/apply-job">
								<div class="modal-body">
									<div class="row">
										<div class="col-12">
											<select id="choose${recruitment.id}"
												onchange="choosed(${recruitment.id})" class="form-control"
												aria-label="Default select example">
												<option selected>Chọn phương thức nộp</option>
												<option value="1">Dùng cv đã cập nhật</option>
												<option value="2">Nộp cv mới</option>
											</select>
										</div>
										<div id="loai1${recruitment.id}" style="display: none"
											class="col-12">
											<label for="fileUpload" class="col-form-label">Giới
												thiệu:</label>
											<textarea rows="10" cols="3" class="form-control"
												id="text${recruitment.id}">

                                                    </textarea>
										</div>
										<div id="loai2${recruitment.id}" style="display: none"
											class="col-12">

											<label for="fileUpload" class="col-form-label">Chọn
												cv:</label> <input type="file" class="form-control"
												id="fileUpload${recruitment.id}" name="file" required>
											<label for="fileUpload" class="col-form-label">Giới
												thiệu:</label>
											<textarea rows="10" cols="3" class="form-control"
												id="text${recruitment.id}">

                                                    </textarea>
										</div>

									</div>
									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-dismiss="modal">Đóng</button>
										<button type="button" id="button1${recruitment.id}"
											style="display: none" onclick="apply1(${recruitment.id})"
											class="btn btn-primary">Nộp</button>
										<button type="button" id="button2${recruitment.id}"
											style="display: none" onclick="apply(${recruitment.id})"
											class="btn btn-primary">Nộp</button>
									</div>
								</div>
							</form>


						</div>
					</div>
				</div> --%>
			</div>
			<div class="row">
				<div class="col-lg-8">
					<div class="mb-5">

						<h3 class="h5 d-flex align-items-center mb-4 text-primary">
							<span class="icon-align-left mr-3"></span>Mô tả công việc
						</h3>
						<p>${recruitment.description}</p>
					</div>

				</div>
				<div class="col-lg-4">
					<div class="bg-light p-3 border rounded mb-4">
						<h3 class="text-primary  mt-3 h5 pl-3 mb-3 ">Tóm tắt công
							việc</h3>
						<ul class="list-unstyled pl-3 mb-0">

							<fmt:parseDate var="parsedDate" value="${recruitment.created}"
								pattern="yyyy-MM-dd" />
							<fmt:formatDate var="formattedDate" value="${parsedDate}"
								pattern="MM/dd/yyyy" />
							<li class="mb-2"><strong class="text-black">Ngày
									tạo: </strong> <span>${formattedDate}</span></li>

							<li class="mb-2"><strong class="text-black">Kiểu
									công việc: </strong> <span>${recruitment.type}</span></li>
							<li class="mb-2"><strong class="text-black">Loại
									công việc: </strong> <span>${recruitment.category.name}</span></li>
							<li class="mb-2"><strong class="text-black">Kinh
									nghiệm: </strong> <span>${recruitment.experience}</span></li>
							<li class="mb-2"><strong class="text-black">Địa
									chỉ: </strong> <span>${recruitment.address}</span></li>
							<li class="mb-2"><strong class="text-black">Lương:
							</strong> <span>${recruitment.salary}</span></li>
							<li class="mb-2"><strong class="text-black">Số
									lượng: </strong><span>${recruitment.quantity}</span></li>

							<fmt:parseDate var="parsedDate" value="${recruitment.deadline}"
								pattern="yyyy-MM-dd" />
							<fmt:formatDate var="formattedDate" value="${parsedDate}"
								pattern="MM/dd/yyyy" />
							<li class="mb-2"><strong class="text-black">Hạn nộp
									cv: </strong><span>${formattedDate}</span></li>
						</ul>
					</div>

					<div class="bg-light p-3 border rounded">
						<h3 class="text-primary  mt-3 h5 pl-3 mb-3 ">Share</h3>
						<div class="px-3">
							<a href="#" class="pt-3 pb-3 pr-3 pl-0"><span
								class="icon-facebook"></span></a> <a href="#"
								class="pt-3 pb-3 pr-3 pl-0"><span class="icon-twitter"></span></a>
							<a href="#" class="pt-3 pb-3 pr-3 pl-0"><span
								class="icon-linkedin"></span></a> <a href="#"
								class="pt-3 pb-3 pr-3 pl-0"><span class="icon-pinterest"></span></a>
						</div>
					</div>

				</div>
			</div>
		</div>
	</section>

	<!-- Danh sách ứng viên ứng tuyển -->
	<security:authorize access="hasRole('ADMIN')">
		<c:if test="${applyPosts != null }">
			<section class="site-section" id="next">

				<div class="container">
					<div class="row mb-5 justify-content-center">
						<div class="col-md-7 text-center">
							<h2 class="section-title mb-2">Danh sách ứng viên ứng tuyển</h2>
						</div>
					</div>

					<div class="row">
						<div class="col-lg-12 pr-lg-4">

							<div class="row">
								<c:if test="${applyPosts.size() == 0}">
									<div class="col-lg-12 pr-lg-5" style="text-align: center">
										<p style="color: red">Không có kết quả nào</p>
									</div>
								</c:if>
								<c:if test="${applyPosts.size() != 0}">
									<div class="col-lg-12 pr-lg-5">
										<div class="row container-pajinate" id="pagination-pajinate">
											<ul class="content">
												<c:forEach var="applyPost" items="${applyPosts}">

													<li class="col-md-12 ">
														<div
															class="job-post-item p-4 d-block d-lg-flex align-items-start">
															<div class="border p-2 d-inline-block mr-3 rounded">
																<img width="100" height="100"
																	src="${pageContext.request.contextPath}/${applyPost.user.image}"
																	alt="Image">
															</div>
															<div class="one-third mb-4 mb-md-0">
																<div class="job-post-item-header align-items-center">
																	<a
																		href="${pageContext.request.contextPath}/showDeatailRecruitment?id=${applyPost.recruitment.id}">
																		<span class="subadge">${applyPost.recruitment.title}</span>
																	</a>
																	<h2 class="mr-3 text-black">
																		<a href="#" data-toggle="modal"
																			data-target="#detailUserModal${applyPost.id}">${applyPost.user.fullName}</a>
																	</h2>
																</div>
																<div class="job-post-item-body d-block d-md-flex">
																	<div class="mr-3">
																		<a class="icon-my_location">
																			${applyPost.user.email}</a>
																	</div>
																	<div class="mr-3">
																		<a style="color: #17a2b8;"
																			href="${pageContext.request.contextPath}/${applyPost.nameCv}"
																			target="_blank" class="icon-layers"> Xem CV</a>
																	</div>
																</div>
																<div class="job-post-item-body d-block d-md-flex">
																	<p class="mb-4" style="width: 700px">${applyPost.text}</p>
																</div>
															</div>
														</div> <!-- Detail user modal  -->
														<div class="modal fade"
															id="detailUserModal${applyPost.id}" tabindex="-1"
															aria-labelledby="detailUserModalLabel" aria-hidden="true">
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
																							src="${pageContext.request.contextPath}/${applyPost.user.image != null ? applyPost.user.image : 'resources/assets/images/default_avatar.jpg'}">
																					</div>
																				</div>
																			</div>
																		</div>
																		<button type="button" class="close"
																			data-dismiss="modal" aria-label="Close">
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
																								<label for="email">Email</label> <input
																									type="email" class="form-control" id="email"
																									name="email" value="${applyPost.user.email}"
																									readonly>
																							</div>
																							<div class="form-group">
																								<label for="job-title">Full name</label> <input
																									type="text" class="form-control"
																									name="fullName"
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
																								<label for="job-location">Số điện thoại</label>
																								<input type="text" name="phoneNumber"
																									value="${applyPost.user.phoneNumber}"
																									class="form-control" id="job-location" readonly>
																							</div>
																							<div class="form-group">
																								<label for="job-location">Mô tả bản thân</label>
																								<textarea name="description"
																									class="form-control" readonly>${applyPost.user.description}</textarea>
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
									</div>
								</c:if>
							</div>


						</div>


					</div>
				</div>
			</section>
		</c:if>
	</security:authorize>

	<!-- Những công việc liên quan -->
	<c:if test="${relatedJobs != null }">
		<section class="site-section" id="next">
			<div class="container">

				<div class="row mb-5 justify-content-center">
					<div class="col-md-7 text-center">
						<h2 class="section-title mb-2">Danh sách công việc liên quan</h2>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12 pr-lg-4">

						<div class="row">
							<!-- List Recruitment -->
							<c:set var="recruitments" value="${relatedJobs}" scope="request" />
							<jsp:include page="/WEB-INF/view/parts/list-recruitments.jsp" />
							<!-- End List Recruitment -->
						</div>
					</div>
				</div>

			</div>
		</section>
	</c:if>

	<!-- footer -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- End footer -->

	<script>
		var contextPath = "${pageContext.request.contextPath}";
	</script>
	<!-- các hàm js apply, save, follow, recruit ... -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/functions.js">
	</script>

</body>



</html>