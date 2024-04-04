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
								class="ion-ios-arrow-forward"></i></a></span>Công việc <span></span>
					</p>
					<h1 class="mb-3 bread">Danh sách công việc đã lưu</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 pr-lg-5">
					<div class="row">
						<c:if test="${savedRecruitments.size() == 0}">
							<div class="col-lg-12 pr-lg-5" style="text-align: center">
								<p style="color: red">Không có kết quả nào</p>
							</div>
						</c:if>
						<c:if test="${savedRecruitments.size() != 0}">
							<div class="col-lg-12 pr-lg-5" id="pagination-pajinate">
								<ul class="row content">
									<c:forEach var="recruitment" items="${recruitments}">
										<li id="recruitment${recruitment.id}" class="col-md-12 ">
											<div
												class="job-post-item p-4 d-block d-lg-flex align-items-center">
												<div class="one-third mb-4 mb-md-0">
													<div class="job-post-item-header align-items-center">
														<span class="subadge">${recruitment.type}</span>
														<h2 class="mr-3 text-black">
															<a
																href="${pageContext.request.contextPath}/showDeatailRecruitment?id=${recruitment.id}">${recruitment.title}</a>
														</h2>
													</div>
													<div class="job-post-item-body d-block d-md-flex">
														<div class="mr-3">
															<span class="icon-layers"></span> <a href="${pageContext.request.contextPath}/detailCompany?idCompany=${recruitment.company.id}">${recruitment.company.nameCompany}</a>
														</div>
														<div>
															<span class="icon-my_location"></span> <span>${recruitment.address}</span>
														</div>
													</div>
												</div>
												<input type="hidden" id="idRe${recruitment.id}"
													value="${recruitment.id}">
												<div
													class="one-forth ml-auto d-flex align-items-center mt-4 md-md-0">
													<div>
														<a onclick="unSave(${recruitment.id})"
															class="icon text-center d-flex justify-content-center align-items-center icon mr-2">
															<span class="bi bi-trash3"></span>
														</a>
													</div>

													<a data-toggle="modal"
														data-target="#applyModal${recruitment.id}"
														class="btn btn-primary py-2">Apply Job</a>
												</div>
											</div> 
											
											<!-- Apply Modal id="applyModal${recruitment.id}" --> 
											<c:set	var="recruitment" value="${recruitment}" scope="request" /> 
											<jsp:include page="/WEB-INF/view/parts/apply-modal.jsp" /> 
											<!-- End apply Modal id="applyModal${recruitment.id}" -->									
										</li>
										<!-- end -->

									</c:forEach>

								</ul>
								<div class="page_navigation col-md-12"></div>
							</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</section>

	<script>var contextPath = "${pageContext.request.contextPath}";</script>
	<script
		src="${pageContext.request.contextPath}/resources/assets/js/functions.js"></script>

	<script type="text/javascript">
	function unSave(id){
        var name = "#idRe" +id;
        var idRe = $(name).val();
        var formData = new FormData();
        formData.append('idRe', idRe);
        $.ajax(
            {
                type: 'POST',
                url: '${pageContext.request.contextPath}/user/saveJob',
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    console.log(data);
                    if(data == "notLogin"){
                        swal({
                            title: 'Bạn cần phải đăng nhập!',
                            /* text: 'Redirecting...', */
                            icon: 'error',
                            timer: 3000,
                            buttons: true,
                            type: 'error'
                        })
                    }else if(data == "Ok"){
                        swal({
                            title: 'Lưu thành công!',
                            /* text: 'Redirecting...', */
                            icon: 'success',
                            timer: 3000,
                            buttons: true,
                            type: 'success'
                        })
                    }else{
						$('#recruitment'+id).remove();
                        swal({
                            title: 'Bỏ lưu thành công',
                            /* text: 'Redirecting...', */
                            icon: 'success',
                            timer: 3000,
                            buttons: true,
                            type: 'success'
                        })
                    }
                },
                error: function (err) {
                    alert(err);
                }
            }
        )
    }
	</script>

	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->

</body>
</html>