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
		style="background-image: url('${pageContext.request.contextPath}/resources/assets/images/bg_2.png');"
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
					<h1 class="mb-3 bread">Danh sách công việc đã ứng tuyển</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="ftco-section bg-light">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 pr-lg-5">
					<div class="row">
						<c:if test="${appliedRecruitments.size() == 0}">
							<div class="col-lg-12 pr-lg-5" style="text-align: center">
								<p style="color: red">Không có kết quả nào</p>
							</div>
						</c:if>
						<c:if test="${appliedRecruitments.size() != 0}">
							<div class="col-lg-12 pr-lg-5" id="pagination-pajinate">
								<ul class="row content">
									<c:forEach var="recruitment" items="${appliedRecruitments}">
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
															<span class="icon-layers"></span> 
															<a href="${pageContext.request.contextPath}/detailCompany?idCompany=${recruitment.company.id}">${recruitment.company.nameCompany}</a>
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

													<a data-toggle="modal"
														data-target="#cancelModal${recruitment.id}"
														class="btn btn-danger py-2">Hủy</a>
												</div>
											</div> <!-- Modal Apply -->
											<div class="modal fade" id="cancelModal${recruitment.id}"
												tabindex="-1" role="dialog"
												aria-labelledby="cancelModalLabel" aria-hidden="true">
												<div class="modal-dialog" role="document">
													<div class="modal-content">
														<div class="modal-header">
															<h5 class="modal-title" id="cancelModalLabel">
																Bạn chắc chắn muốn hủy ứng tuyển: <span>${recruitment.title}</span>
															</h5>
															<button type="button" class="close" data-dismiss="modal"
																aria-label="Close">
																<span aria-hidden="true">&times;</span>
															</button>
														</div>
														<div class="modal-footer">
															<button type="button" class="btn btn-secondary"
																data-dismiss="modal">Đóng</button>
															<button type="button" id="cancel${recruitment.id}"
																onclick="cancel(${recruitment.id})"
																class="btn btn-primary">Đồng ý</button>

														</div>
													</div>
												</div>
											</div> <!--End Modal Apply -->
										</li>

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
	<script>
    function cancel(id){
        var name = "#idRe" +id;
        var idRe = $(name).val();
        var formData = new FormData();
        formData.append('idRe', idRe);
        $.ajax(
            {
                type: 'POST',
                url: '${pageContext.request.contextPath}/user/cancelApplication',
                contentType: false,
                processData: false,
                data: formData,
                success: function (data) {
                    if(data == "Ok"){
                    	 $('#cancelModal'+id).modal('hide');
                        swal({
                            title: 'Hủy thành công!',
                            /* text: 'Redirecting...', */
                            icon: 'success',
                            timer: 3000,
                            buttons: true,
                            type: 'success'
                        }).then(function() {
                            
                        	$('#recruitment'+id).remove();
                        });           
                       
                        
                    }else{
                        swal({
                            title: 'Hủy thất bại',
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
            }
        )
    }
</script>

	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->

</body>
</html>