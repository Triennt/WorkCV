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

	<div class="hero-wrap img"
		style="background-image: url(${pageContext.request.contextPath}/resources/assets/images/job-search-5.jpg);">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row d-md-flex no-gutters slider-text align-items-center justify-content-center">
				<div class="col-md-10 d-flex align-items-center ">
					<div class="text text-center pt-5 mt-md-5">
						<p class="mb-4">Tìm việc làm, Cơ hội việc làm và Nghề nghiệp</p>
						<h1 class="mb-5">Cách dễ dàng nhất để có được công việc mới
							của bạn</h1>
						<div class="ftco-counter ftco-no-pt ftco-no-pb">
							<div class="row">
								<div
									class="col-md-4 d-flex justify-content-center counter-wrap ">
									<div class="block-18">
										<div class="text d-flex">
											<div class="icon mr-2">
												<span class="flaticon-visitor"></span>
											</div>
											<div class="desc text-left">
												<strong class="number" data-number="46">${numberOfCandidates}</strong>
												<span>Ứng cử viên</span>
											</div>
										</div>
									</div>
								</div>
								<div
									class="col-md-4 d-flex justify-content-center counter-wrap ">
									<div class="block-18 text-center">
										<div class="text d-flex">
											<div class="icon mr-2">
												<span class="flaticon-visitor"></span>
											</div>
											<div class="desc text-left">
												<strong class="number" data-number="450">${numberOfCompanies}</strong>
												<span>Công ty</span>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-4 d-flex justify-content-center counter-wrap">
									<div class="block-18 text-center">
										<div class="text d-flex">
											<div class="icon mr-2">
												<span class="flaticon-resume"></span>
											</div>
											<div class="desc text-left">
												<strong class="number" data-number="80000">${numberOfRecruitments}</strong>
												<span>Tuyển dụng</span>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div id="search" class="ftco-search my-md-5">
							<div class="row">
								<div class="col-md-12 nav-link-wrap">
									<div class="nav nav-pills text-center" id="v-pills-tab"
										role="tablist" aria-orientation="vertical">
										<a class="nav-link active" id="v-pills-1-tab"
											data-toggle="pill" href="#v-pills-1" role="tab"
											aria-controls="v-pills-1" aria-selected="true">Tìm công
											việc</a> <a class="nav-link" id="v-pills-2-tab"
											data-toggle="pill" href="#v-pills-2" role="tab"
											aria-controls="v-pills-2" aria-selected="false">Tìm theo
											công ty</a> <a class="nav-link" id="v-pills-3-tab"
											data-toggle="pill" href="#v-pills-3" role="tab"
											aria-controls="v-pills-3" aria-selected="false">Tìm theo
											địa điểm</a>

									</div>
								</div>
								<div class="col-md-12 tab-wrap">

									<div class="tab-content p-4" id="v-pills-tabContent">

										<div class="tab-pane fade show active" id="v-pills-1"
											role="tabpanel" aria-labelledby="v-pills-nextgen-tab">
											<form:form action="searchJob" method="post"
												class="search-job">
												<div class="row no-gutters">

													<div class="col-md-10 mr-md-2">
														<div class="form-group">
															<div class="form-field">
																<div class="icon">
																	<span class="icon-map-marker"></span>
																</div>
																<input type="text" name="keySearch" class="form-control"
																	placeholder="Tìm kiếm công việc"> <input
																	type="hidden" name="typeSearch" class="form-control"
																	value="recruitment">
															</div>
														</div>
													</div>
													<div class="col-md">
														<div class="form-group">
															<div class="form-field">
																<button type="submit"
																	class="form-control btn btn-primary">Tìm kiếm</button>
															</div>
														</div>
													</div>
												</div>
											</form:form>
										</div>

										<div class="tab-pane fade" id="v-pills-2" role="tabpanel"
											aria-labelledby="v-pills-performance-tab">
											<form:form action="searchJob" method="post"
												class="search-job">
												<div class="row no-gutters">

													<div class="col-md-10 mr-md-2">
														<div class="form-group">
															<div class="form-field">
																<div class="icon">
																	<span class="icon-map-marker"></span>
																</div>
																<input type="text" name="keySearch" class="form-control"
																	placeholder="Tìm theo công ty"> <input
																	type="hidden" name="typeSearch" class="form-control"
																	value="company">
															</div>
														</div>
													</div>
													<div class="col-md">
														<div class="form-group">
															<div class="form-field">
																<button type="submit"
																	class="form-control btn btn-primary">Tìm kiếm</button>
															</div>
														</div>
													</div>
												</div>
											</form:form>
										</div>
										<div class="tab-pane fade" id="v-pills-3" role="tabpanel"
											aria-labelledby="v-pills-performance-tab">
											<form:form action="searchJob" method="post"
												class="search-job">
												<div class="row no-gutters">

													<div class="col-md-10 mr-md-2">
														<div class="form-group">
															<div class="form-field">
																<div class="icon">
																	<span class="icon-map-marker"></span>
																</div>
																<input type="text" name="keySearch" class="form-control"
																	placeholder="Tìm kiếm theo địa điểm"> <input
																	type="hidden" name="typeSearch" class="form-control"
																	value="address">
															</div>
														</div>
													</div>
													<div class="col-md">
														<div class="form-group">
															<div class="form-field">
																<button type="submit"
																	class="form-control btn btn-primary">Tìm kiếm</button>
															</div>
														</div>
													</div>
												</div>
											</form:form>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section">
		<div class="container">
			<div class="row justify-content-center mb-5">

				<div style="display: block"
					class="col-md-7 heading-section text-center">
					<span class="subheading">Danh mục công việc</span>
					<h2 class="mb-0">Top Danh Mục</h2>
				</div>
			</div>
			<div class="row">
				<c:if test="${categories.size() == 0}">
					<div class="col-lg-12 pr-lg-5" style="text-align: center">
						<p style="color: red">Không có kết quả nào</p>
					</div>
				</c:if>
				<c:if test="${categories.size() != 0}">
					<c:forEach var="category" items="${categories}">
						<div class="col-md-3 ">
							<ul class="category text-center">

								<li><a style="text-decoration: none !important;"
									href="${pageContext.request.contextPath}/recruitmentsOfCategory?idCategory=${category.key.id}">
										<p>${category.key.name}</p> <span class="number">${category.value}</span>
										<span> Vị trí</span><i class="ion-ios-arrow-forward"></i>
								</a></li>
							</ul>
						</div>
					</c:forEach>
				</c:if>
			</div>
		</div>
	</section>

	<section class="ftco-section services-section">
		<div class="container">
			<div class="row d-flex">
				<div class="col-md-3 d-flex align-self-stretch ">
					<div class="media block-6 services d-block">
						<div class="icon">
							<span class="flaticon-resume"></span>
						</div>
						<div class="media-body">
							<h3 class="heading mb-3">Tìm kiếm hàng triệu việc làm</h3>
							<p class="text-justify">Khám phá nguồn tài năng đa dạng và
								hàng triệu cơ hội việc làm hấp dẫn, hỗ trợ sự phát triển nghề
								nghiệp của bạn ngay hôm nay.</p>
						</div>
					</div>
				</div>
				<div class="col-md-3 d-flex align-self-stretch ">
					<div class="media block-6 services d-block">
						<div class="icon">
							<span class="flaticon-team"></span>
						</div>
						<div class="media-body">
							<h3 class="heading mb-3">Dễ dàng quản lý công việc</h3>
							<p class="text-justify">Trải nghiệm quản lý công việc mượt mà
								và hiệu quả với công cụ tìm việc hàng đầu. Dễ dàng tìm kiếm, ứng
								tuyển và theo dõi tiến trình ứng tuyển để đảm bảo bạn không bỏ
								lỡ bất kỳ cơ hội nghề nghiệp nào quan trọng</p>
						</div>
					</div>
				</div>
				<div class="col-md-3 d-flex align-self-stretch ">
					<div class="media block-6 services d-block">
						<div class="icon">
							<span class="flaticon-career"></span>
						</div>
						<div class="media-body">
							<h3 class="heading mb-3">Top Nghề nghiệp</h3>
							<p class="text-justify">Khám phá các ngành nghề hàng đầu với
								danh sách 'Top Nghề Nghiệp', nơi bạn có thể tìm thấy những cơ
								hội việc làm nổi bật và phù hợp với sở thích và kỹ năng của bạn.</p>
						</div>
					</div>
				</div>
				<div class="col-md-3 d-flex align-self-stretch ">
					<div class="media block-6 services d-block">
						<div class="icon">
							<span class="flaticon-employees"></span>
						</div>
						<div class="media-body">
							<h3 class="heading mb-3">Ứng viên Chuyên gia Tìm kiếm</h3>
							<p class="text-justify">Đặt bước chân đầu tiên vào sự nghiệp
								của bạn với tư cách là 'Ứng viên Chuyên gia Tìm kiếm'. Khám phá
								những cơ hội việc làm tốt nhất và tận dụng công cụ tìm kiếm tiên
								tiến để định hình tương lai nghề nghiệp của bạn.</p>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<section id="job" class="ftco-section bg-light">
		<div class="container">
			<div class="row">
				<div class="col-lg-9 pr-lg-5">
					<div class="row justify-content-center pb-3">
						<div class="col-md-12 heading-section ">
							<span class="subheading">CÔNG VIỆC ĐỀ XUẤT CHO BẠN</span>
							<h2 class="mb-4">Các bài đăng về việc mới nhất</h2>

						</div>
					</div>
					<div class="row">
						<!-- List Recruitment -->
						<jsp:include page="/WEB-INF/view/parts/list-recruitments.jsp" />
						<!-- End List Recruitment -->
					</div>
				</div>
				<div class="col-lg-3 sidebar">
					<div class="row justify-content-center pb-3">
						<div class="col-md-12 heading-section ">
							<h2 class="mb-4">Công ty nổi bật</h2>
						</div>
					</div>
					<div>
						<c:if test="${topCompanies.size() == 0}">
							<div class="col-lg-12 pr-lg-5" style="text-align: center">
								<p style="color: red">Không có kết quả nào</p>
							</div>
						</c:if>
						<c:if test="${topCompanies.size() != 0}">
							<c:forEach var="company" items="${topCompanies}">
								<div class="sidebar-box">
									<div class="border p-2 d-inline-block mr-3 rounded">
										<img width="100" height="100"
											src="${company.key.logo}"
											alt="Image">
									</div>
									<div class="text p-3">
										<h3>
											<a
												href="${pageContext.request.contextPath}/detailCompany?idCompany=${company.key.id}">${company.key.nameCompany}</a>
										</h3>
										<p>
											<span class="number" style="color: black">${company.value}</span><span>Đã đăng tuyển</span>
										</p>
									</div>
								</div>
							</c:forEach>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->

	<script>
		var contextPath = "${pageContext.request.contextPath}";
	</script>
	<!-- các hàm js apply, save, follow, recruit ... -->
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/functions.js"></script>

</body>

</html>