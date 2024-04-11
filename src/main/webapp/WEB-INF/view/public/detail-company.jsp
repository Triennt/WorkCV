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
		style="background-image: url('${pageContext.request.contextPath}/resources/assets/images/image_2.jpg');"
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
					<h1 class="mb-3 bread">Chi tiết công ty</h1>
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
								src="${company.logo}"
								alt="Image">
						</div>
						<div>
							<h2>${company.nameCompany}</h2>
							<div>
								<span class="icon-briefcase mr-2"></span><span
									class="ml-0 mr-2 mb-2">${company.email}</span> <span
									class="icon-room mr-2"></span><span class="m-2">${company.address}</span>

							</div>
							<input type="hidden" id="idCompany" value="${company.id}">
						</div>
					</div>
				</div>
				<div class="col-lg-4">
					<security:authorize access="hasRole('USER')">
					<div class="row">
						<c:if test="${hasFollowed == false}">
							<div class="col-6">
								<a onclick="follow()" id="followButton"
									class="btn btn-block btn-light btn-md"><span
									class="icon-heart-o mr-2 text-danger"></span>Theo dõi</a> <a
									onclick="follow()" id="unfollowButton" style="display: none"
									class="btn btn-block btn-light btn-md"><span
									class="icon-heart mr-2 text-danger"></span>Đã theo dõi</a>
							</div>
						</c:if>
						<c:if test="${hasFollowed == true}">
							<div class="col-6">
								<a onclick="follow()" id="unfollowButton"
									class="btn btn-block btn-light btn-md"><span
									class="icon-heart mr-2 text-danger"></span>Đã theo dõi</a> <a
									onclick="follow()" id="followButton" style="display: none"
									class="btn btn-block btn-light btn-md"><span
									class="icon-heart-o mr-2 text-danger"></span>Theo dõi</a>
							</div>
						</c:if>
					</div>
					</security:authorize>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-8">
					<div class="mb-5">

						<h3 class="h5 d-flex align-items-center mb-4 text-primary">
							<span class="icon-align-left mr-3"></span>Mô tả công ty
						</h3>
						<p>${company.description}</p>
					</div>

				</div>
				<div class="col-lg-4">
					<div class="bg-light p-3 border rounded mb-4">
						<h3 class="text-primary  mt-3 h5 pl-3 mb-3 ">Thông tin liên
							hệ</h3>
						<ul class="list-unstyled pl-3 mb-0">

							<li class="mb-2"><strong class="text-black">Email
									công ty: </strong> <span>${company.email}</span></li>
							<li class="mb-2"><strong class="text-black">Số điện
									thoại: </strong> <span>${company.phoneCompany}</span></li>
							<li class="mb-2"><strong class="text-black">Đại
									chỉ: </strong> <span>${company.address}</span></li>
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
	
	<!-- Những công thuộc công ty -->
	<c:if test="${recruitments.size() != 0 }">
		<section class="site-section" id="next">
			<div class="container">

				<div class="row mb-5 justify-content-center">
					<div class="col-md-7 text-center">
						<h2 class="section-title mb-2">Các công việc của ${company.nameCompany }</h2>
					</div>
				</div>

				<div class="row">
					<div class="col-lg-12 pr-lg-4">

						<div class="row">
							<!-- List Recruitment -->
<%-- 							<c:set var="recruitments" value="${relatedJobs}" scope="request" /> --%>
							<jsp:include page="/WEB-INF/view/parts/list-recruitments.jsp" />
							<!-- End List Recruitment -->
						</div>
					</div>
				</div>

			</div>
		</section>
	</c:if>
	
	<script>
	        function follow(){
	            var name = "#idCompany";
	            var idCompany = $(name).val();
	            var formData = new FormData();
	            formData.append('idCompany', idCompany);
	            $.ajax(
	                {
	                    type: 'POST',
	                    url: '${pageContext.request.contextPath}/user/followCompany/',
	                    contentType: false,
	                    processData: false,
	                    data: formData,
	                    success: function (data) {
	                        if(data == "notLogin"){
	                            swal({
	                                title: 'Bạn cần phải đăng nhập!',
	                                /* text: 'Redirecting...', */
	                                icon: 'error',
	                                timer: 3000,
	                                buttons: true,
	                                type: 'error'
	                            })
	                        } 
	                        if (data == "notVerify") {
	    						swal({
	    							title: 'Bạn cần xác minh tài khoản.',
	    							text: 'Nhấn OK để chuyển hướng đến trang xác minh.',
	    							/* text: 'Redirecting...', */
	    							icon: 'error',
	    							/*timer: 3000,*/
	    							buttons: true,
	    							dangerMode: true,
	    							type: 'error'
	    						}).then((willVerify) => {
	           						 if (willVerify) {
	                					window.location.href = contextPath + '/user/showProfile'; 
	           						 }
	           					});
	
	    					}
	                        if(data == "Ok"){
	                            swal({
	                                title: 'Theo dõi thành công!',
	                                /* text: 'Redirecting...', */
	                                icon: 'success',
	                                timer: 3000,
	                                buttons: true,
	                                type: 'success'
	                            })
	                            $('#followButton').hide();
	                            $('#unfollowButton').show();
	                        } 
	                        if(data == "unfollow"){
	                            swal({
	                                title: 'Bạn đã bỏ theo dõi công ty này!',
	                                /* text: 'Redirecting...', */
	                                icon: 'success',
	                                timer: 3000,
	                                buttons: true,
	                                type: 'success'
	                            })
	                            $('#followButton').show();
	                            $('#unfollowButton').hide();
	                        }
	                    },
	                    error: function (err) {
	                        alert(err);
	                    }
	                }
	            )
	        }
    </script>
    
    <script>
		var contextPath = "${pageContext.request.contextPath}";
	</script>
	<!-- các hàm js apply, save, follow, recruit ... -->
	<script src="${pageContext.request.contextPath}/resources/assets/js/functions.js"></script>
	
	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->

</body>
</html>