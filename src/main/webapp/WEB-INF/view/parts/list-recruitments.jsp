<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security"
	uri="http://www.springframework.org/security/tags"%>


<c:if test="${recruitments.size() == 0}">
	<div class="col-lg-12 pr-lg-5" style="text-align: center">
		<p style="color: red">Không có kết quả nào</p>
	</div>
</c:if>
<c:if test="${recruitments.size() != 0}">
	<div class="col-lg-12 pr-lg-5" id="pagination-pajinate">
		<ul class="row content">
			<c:forEach var="recruitment" items="${recruitments}">
				<li class="col-md-12 ">
					<div class="job-post-item p-4 d-block d-lg-flex align-items-center">
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
									<span class="icon-layers"></span> <a
										href="${pageContext.request.contextPath}/detailCompany?idCompany=${recruitment.company.id}">${recruitment.company.nameCompany}</a>
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
								<a onclick="save(${recruitment.id})"
									class="icon text-center d-flex justify-content-center align-items-center icon mr-2">
									<span class="icon-heart"></span>
								</a>
							</div>

							<a data-toggle="modal" onclick="clickApply(${recruitment.id})"
								class="btn btn-primary py-2">Apply Job</a>
						</div>
					</div> 
					<!-- Apply Modal id="applyModal${recruitment.id}" --> 
					<c:set
						var="recruitment" value="${recruitment}" scope="request" /> 
						<jsp:include page="/WEB-INF/view/parts/apply-modal.jsp" /> 
						<!-- End apply Modal id="applyModal${recruitment.id}" -->
				</li>
				<!-- end -->
			</c:forEach>
		</ul>
		<div class="page_navigation col-md-12"></div>
	</div>
</c:if>