<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
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
								class="ion-ios-arrow-forward"></i></a></span>Danh sách <span></span>
					</p>
					<h1 class="mb-3 bread">Danh sách bài đăng</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row">

				<c:if test="${recruitments.size() == 0}">
					<div class="col-lg-12 pr-lg-5" style="text-align: center">
						<p style="color: red">Không có kết quả nào</p>
						<a href="recruit" class="btn px-4 btn-primary text-white">Đăng
							tuyển</a>
					</div>

				</c:if>

				<c:if test="${recruitments.size() > 0}">
					<div class="col-lg-12 pr-lg-4">
						<div class="row" id="pagination-pajinate">
							<ul class="content" style="width: 100%">

								<c:forEach var="recruitment" items="${recruitments}">
									<li class="col-md-12 ">
										<div
											class="job-post-item p-4 d-block d-lg-flex align-items-center">
											<div class="one-third mb-4 mb-md-0">
												<div class="job-post-item-header align-items-center">
													<span class="subadge">${recruitment.type}</span>
													<h2 class="mr-3 text-black">
														<a
															href="${pageContext.request.contextPath}/admin/showDeatailRecruitment?id=${recruitment.id}">${recruitment.title}</a>
													</h2>
												</div>
												<div class="job-post-item-body d-block d-md-flex">
													<div class="mr-3">
														<span class="icon-layers"></span> <a href="#">${recruitment.company.nameCompany}</a>
													</div>
													<div>
														<span class="icon-my_location"></span> <span>${recruitment.address}</span>
													</div>
												</div>
											</div>

											<div
												class="one-forth ml-auto d-flex align-items-center mt-4 md-md-0"
												style="width: 330px !important;">
												<button type="button" class="btn btn-primary  py-2 ml-2"
													data-toggle="modal"
													data-target="#detailRecruitmentModal${recruitment.id}">
													Xem nhanh</button>
												<button type="button" class="btn btn-warning  py-2 ml-2"
													data-toggle="modal"
													data-target="#updateRecruitmentModal${recruitment.id}">
													Cập nhật</button>
												<button type="button" class="btn btn-danger  py-2 ml-2"
													data-toggle="modal"
													data-target="#deleteRecruitmentModal${recruitment.id}">
													Xóa</button>
											</div>
										</div> <!-- Detail Recruitment Modal -->
										<div class="modal fade"
											id="detailRecruitmentModal${recruitment.id}" tabindex="-1"
											aria-labelledby="detailRecruitmentModalLabel"
											aria-hidden="true">
											<div class="modal-dialog modal-lg ">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="detailRecruitmentModalLabel">Chi
															tiết bài đăng</h5>
													</div>
													<div class="modal-body">
														<div class="row">
															<div class="col-6">
																<label for="addcost" class="col-form-label">Tiêu
																	đề:</label> <input type="text" class="form-control"
																	id="addcost" name="title" value="${recruitment.title}"
																	readonly>
															</div>

															<div class="col-6">
																<label for="addname" class="col-form-label">Địa
																	chỉ:</label> <input type="text" class="form-control"
																	id="addname" name="address"
																	value="${recruitment.address}" readonly>
															</div>

														</div>
														<div class="row">

															<div class="col-6">
																<label for="addcost" class="col-form-label">Loại
																	công việc:</label> <input type="text" class="form-control"
																	id="addcost" name="type" value="${recruitment.type}"
																	readonly>
															</div>
															<div class="col-6">
																<label for="addname" class="col-form-label">Danh
																	mục công việc:</label> <input type="text" class="form-control"
																	id="addname" name="categoryName"
																	value="${recruitment.category.name}" readonly>
															</div>
														</div>
														<div class="row">

															<div class="col-6">
																<label for="addcost" class="col-form-label">Kinh
																	nghiệm:</label> <input type="text" class="form-control"
																	id="addcost" name="experience"
																	value="${recruitment.experience}" readonly>
															</div>
															<div class="col-6">
																<label for="addname" class="col-form-label">Lương:</label>
																<input type="text" class="form-control" id="addname"
																	name="experience" value="${recruitment.salary}"
																	readonly>
															</div>
														</div>
														<div class="row">

															<div class="col-6">
																<label for="addcost" class="col-form-label">Hạn
																	ứng tuyển:</label> <input type="text" class="form-control"
																	id="addcost" name="deadline"
																	value="${recruitment.deadline}" readonly>
															</div>
															<div class="col-6">
																<label for="addname" class="col-form-label">Số
																	người cần tuyển:</label> <input type="number"
																	class="form-control" id="addname" name="quantity"
																	value="${recruitment.quantity}" readonly>
															</div>
														</div>
														<div class="row">
															<div class="col-12">
																<label for="ct_id" class="col-form-label">Mô tả:</label>
																<p >${recruitment.description}</p>
															</div>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-secondary"
																data-dismiss="modal">Đóng</button>
															<button type="button" class="btn btn-warning"
																data-toggle="modal"
																data-target="#updateRecruitmentModal${recruitment.id}">
																Cập nhật</button>
														</div>
													</div>

												</div>
											</div>
										</div> <!-- End Detail Recruitment Modal --> 
										
										<!-- Update Recruitment Modal -->
										<div class="modal fade"
											id="updateRecruitmentModal${recruitment.id}" tabindex="-1"
											aria-labelledby="updateRecruitmentModalLabel"
											aria-hidden="true">
											<div class="modal-dialog modal-lg ">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="updateRecruitmentModalLabel">Chỉnh
															sửa bài đăng</h5>
													</div>
													<div class="modal-body">
														<form:form action="updateRecruitment"
															modelAttribute="editRecruitment" method="post">
															<input type="hidden" name="id" value="${recruitment.id}">
															<input type="hidden" name="companyId"
																value="${recruitment.company.id}">
															<div class="row">
																<div class="col-6">
																	<label for="addcost" class="col-form-label">Tiêu
																		đề:</label> <input type="text" class="form-control"
																		id="addcost" name="title" value="${recruitment.title}"
																		required>
																</div>

																<div class="col-6">
																	<label for="addname" class="col-form-label">Địa
																		chỉ:</label> <input type="text" class="form-control"
																		id="addname" name="address"
																		value="${recruitment.address}" required>
																</div>

															</div>
															<div class="row">
																<div class="col-6">
																	<label for="job-region">Loại công việc</label> <select
																		class="form-control" name="type"
																		aria-label="Default select example" required>
																		<option value="${recruitment.type}" selected>${recruitment.type}</option>
																		<option value="Part time">Part time</option>
																		<option value="Full time">Full time</option>
																		<option value="Freelancer">Freelancer</option>
																	</select>
																</div>
																<div class="col-6">
																	<label for="addname" class="col-form-label">Danh
																		mục công việc:</label> <select class="form-control"
																		name="categoryId" aria-label="Default select example"
																		required>
																		<option value="${recruitment.category.id}" selected>${recruitment.category.name}</option>
																		<c:forEach var="category" items="${categories}">
																			<option value="${category.id}">${category.name}</option>
																		</c:forEach>

																	</select>
																</div>

															</div>
															<div class="row">

																<div class="col-6">
																	<label for="addcost" class="col-form-label">Kinh
																		nghiệm:</label> <input type="text" class="form-control"
																		id="addcost" name="experience"
																		value="${recruitment.experience}" required>
																</div>
																<div class="col-6">
																	<label for="addname" class="col-form-label">Lương:</label>
																	<input type="text" class="form-control" id="addname"
																		name="salary" value="${recruitment.salary}" required>
																</div>
															</div>
															<div class="row">

																<div class="col-6">
																	<label for="addDate" class="col-form-label">Hạn
																		ứng tuyển:</label> <input type="date" class="form-control"
																		id="addDate" name="deadline"
																		value="${recruitment.deadline}" required>
																</div>
																<div class="col-6">
																	<label for="addname" class="col-form-label">Số
																		người cần tuyển:</label> <input type="number"
																		class="form-control" id="addname" name="quantity"
																		value="${recruitment.quantity}" required>
																</div>
															</div>
															<div class="row">
																<div class="col-12">
																	<label for="ct_id" class="col-form-label">Mô
																		tả:</label>
																	<textarea required name="description"
																		class="form-control" cols="50" rows="5" id="description${recruitment.id}">${recruitment.description}
																		
																	</textarea>
																	<script type="text/javascript">
																		ClassicEditor
																	    .create(document.querySelector('#description${recruitment.id}'))
																	    .catch(error => {
																	        console.error(error);
																	    });
																	</script>
																</div>
															</div>
															<div class="modal-footer">
																<button type="button" class="btn btn-secondary"
																	data-dismiss="modal">Đóng</button>
																<button type="submit" class="btn btn-primary">Lưu
																</button>
															</div>
														</form:form>
													</div>

												</div>
											</div>
										</div> <!-- End Update Recruitment Modal --> 
										<!-- Delete Recruitment Modal-->
										<div class="modal fade"
											id="deleteRecruitmentModal${recruitment.id}" tabindex="-1"
											role="dialog" aria-labelledby="deleteRecruitmentModalLabel"
											aria-hidden="true">
											<div class="modal-dialog" role="document">
												<div class="modal-content">
													<div class="modal-header">
														<h5 class="modal-title" id="deleteRecruitmentModalLabel">Bạn
															có chắc chắn muốn xóa ?</h5>
														<button type="button" class="close" data-dismiss="modal"
															aria-label="Close">
															<span aria-hidden="true">&times;</span>
														</button>
													</div>
													<div class="modal-body">
														Bài đăng : <span>${recruitment.title}</span>
														<form:form action="deleteRecruitment" method="post">
															<input type="hidden" class="form-control" id="id"
																name="recruitmentId" value="${recruitment.id}">
															<div class="modal-footer mt-1">
																<button type="button" class="btn btn-secondary"
																	data-dismiss="modal">Đóng</button>
																<button type="submit" class="btn btn-danger">Xóa</button>
															</div>
														</form:form>
													</div>

												</div>
											</div>
										</div> <!-- End Modal Delete-->

									</li>
									<!-- end -->

								</c:forEach>
							</ul>

							<div class="page_navigation col-md-12"></div>
						</div>
					</div>
				</c:if>
			</div>
		</div>

		<!-- Errors Update Recruitment Modal -->
		<div class="modal fade" id="errorsUrpdateModal" tabindex="-1"
			aria-labelledby="errorsUrpdateModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-lg ">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="errorsUrpdateModalLabel">Chỉnh
							sửa bài đăng</h5>
					</div>
					<div class="modal-body">
						<form:form action="updateRecruitment"
							modelAttribute="editRecruitment" method="post">
							<input type="hidden" name="id" value="${recruitment.id}">
							<input type="hidden" name="companyId"
								value="${recruitment.company.id}">
							<div class="row">
								<div class="col-6">
									<label for="addcost" class="col-form-label">Tiêu đề:</label>
									<span class="error">${titleError}</span>
									<input type="text" class="form-control" id="addcost"
										name="title" value="${recruitment.title}" required>
								</div>

								<div class="col-6">
									<label for="addname" class="col-form-label">Địa chỉ:</label>
									<span class="error">${addressError}</span>
									<input type="text" class="form-control" id="addname"
										name="address" value="${recruitment.address}" required>
								</div>

							</div>
							<div class="row">
								<div class="col-6">
									<label for="job-region">Loại công việc</label> <select
										class="form-control" name="type"
										aria-label="Default select example" required>
										<option value="${recruitment.type}" selected>${recruitment.type}</option>
										<option value="Part time">Part time</option>
										<option value="Full time">Full time</option>
										<option value="Freelancer">Freelancer</option>
									</select>
								</div>
								<div class="col-6">
									<label for="addname" class="col-form-label">Danh mục
										công việc:</label> <select class="form-control" name="categoryId"
										aria-label="Default select example" required>
										<option value="${recruitment.category.id}" selected>${recruitment.category.name}</option>
										<c:forEach var="category" items="${categories}">
											<option value="${category.id}">${category.name}</option>
										</c:forEach>

									</select>
								</div>

							</div>
							<div class="row">

								<div class="col-6">
									<label for="addcost" class="col-form-label">Kinh
										nghiệm:</label>
									<span class="error">${experienceError}</span>
									<input type="text" class="form-control" id="addcost"
										name="experience" value="${recruitment.experience}" required>
								</div>
								<div class="col-6">
									<label for="addname" class="col-form-label">Lương:</label>
									<span class="error">${salaryError}</span>
									<input type="text" class="form-control" id="addname"
										name="salary" value="${recruitment.salary}" required>
								</div>
							</div>
							<div class="row">

								<div class="col-6">
									<label for="addDate" class="col-form-label">Hạn ứng
										tuyển:</label>
									<span class="error">${deadlineError}</span>
									<input type="date" class="form-control" id="addDate"
										name="deadline" value="${recruitment.deadline}" required>
								</div>
								<div class="col-6">
									<label for="addname" class="col-form-label">Số người
										cần tuyển:</label>
									<span class="error">${quantityError}</span>
									<input type="number" class="form-control" id="addname"
										name="quantity" value="${recruitment.quantity}" required>
								</div>
							</div>
							<div class="row">
								<div class="col-12">
									<label for="ct_id" class="col-form-label">Mô tả:</label>
									<span class="error">${descriptionError}</span>
									<textarea name="description" class="form-control" id="description"
										cols="50" rows="5">${recruitment.description}</textarea>
									<script type="text/javascript">
										ClassicEditor
									    .create(document.querySelector('#description'))
									    .catch(error => {
									        console.error(error);
									    });
									</script>
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
		<!-- End Errors Update Recruitment Modal -->
	</section>

	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->

	<script type="text/javascript">
		if(${postSuccess == true}){
			swal({
				title: 'Đăng bài thành công!',
				icon: 'success',
				timer: 3000,
				buttons: true,
				type: 'success'
			})
		}
		if(${updateSuccess == true}){
			swal({
				title: 'Cập nhật thành công!',
				icon: 'success',
				timer: 3000,
				buttons: true,
				type: 'success'
			})
		}
		if(${updateSuccess == false}){
			$('#errorsUrpdateModal').modal('show');
		}
			
	</script>


	<script>
		var contextPath = "${pageContext.request.contextPath}";
	</script>
	<!-- các hàm js apply, save, follow, recruit ... -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/functions.js"></script>
</body>

</html>