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
						<span class="mr-3"><a href="/">Trang chủ <i
								class="ion-ios-arrow-forward"></i></a></span>Công ty <span></span>
					</p>
					<h1 class="mb-3 bread">Danh sách công ty đã theo dõi</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section bg-light">
		<div class="container">
			
			
			<div class="row">
				<c:if test="${followedCompanies.size() == 0}">
					<div class="col-lg-12 pr-lg-5" style="text-align: center">
						<p style="color: red">Không có kết quả nào</p>
					</div>
				</c:if>
				<c:if test="${followedCompanies.size() != 0}">
					<div class="col-lg-12 pr-lg-5" id="pagination-pajinate">
						<ul class="content">
							<c:forEach var="company" items="${followedCompanies}">
								<li id="companyItem${company.id}" class="col-md-12 ">
									<div
										class="job-post-item p-4 d-block d-lg-flex align-items-center">
										<input type="hidden" id="companyId${company.id}"
											value="${company.id}">
										<div class="border p-2 d-inline-block mr-3 rounded">
												<img width="100" height="100"
													src="${company.logo}"
													alt="Image">
											</div>
										<div class="one-third mb-4 mb-md-0">
											<div class="job-post-item-header align-items-center">
												<h2 class="mr-3 text-black">
													<a
														href="${pageContext.request.contextPath}/detailCompany?idCompany=${company.id}">${company.nameCompany}</a>
												</h2>
											</div>
											<div class="job-post-item-body d-block d-md-flex">
												<div class="mr-3">
													<span class="icon-layers"></span> <a>${company.email}</a>
												</div>
												<div class="mr-3">
													<span class="icon-my_location"></span> <span>${company.address}</span>
												</div>
												<div style="margin-left: 10">
													<span class="icon-my_location"></span> <span>${company.phoneCompany}</span>
												</div>
											</div>
										</div>
										<div
											class="one-forth ml-auto d-flex align-items-center mt-4 md-md-0"
											style="width: 370px !important;">
											<div>
												<a id="unfollow${company.id}"
													onclick="unfollow(${company.id})"
													class="icon text-center d-flex justify-content-center align-items-center icon mr-2">
													<span class="icon-delete"></span>
												</a>
											</div>
											<a
												href="${pageContext.request.contextPath}/recruitmentsOfCompany?idCompany=${company.id}"
												class="btn btn-warning py-2 ml-1">Danh sách bài đăng</a>
										</div>
									</div>
								</li>
								<!-- end -->
							</c:forEach>

						</ul>
						<div class="page_navigation col-md-12 justify-content-center"></div>
						
						
					</div>
				</c:if>
			</div>
		</div>
	</section>
	<script>
    function unfollow(id) {
            var idCompany = id;

            $.ajax({
                type: 'POST',
                url: '${pageContext.request.contextPath}/user/followCompany',
                data: { idCompany: idCompany },
                success: function (response) {
					console.log(response)
					if(response == "unfollow"){
                       swal({
                           title: 'Hủy theo dõi thành công!',
                           /* text: 'Redirecting...', */
                           icon: 'success',
                           timer: 3000,
                           buttons: true,
                           type: 'success'
                       }).then(function() {
                           
                       	$('#companyItem'+id).remove();
                       });           
                      
                       
                   }else{
                       swal({
                           title: 'Hủy theo dõi thất bại',
                           /* text: 'Redirecting...', */
                           icon: 'error',
                           timer: 3000,
                           buttons: true,
                           type: 'error'
                       })
                   }
               },
                error: function (err) {
                	alert(err);
                }
            });
        }
</script>

	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->

</body>
</html>