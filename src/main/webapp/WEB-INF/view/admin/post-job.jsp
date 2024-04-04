<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="vi">

<!-- <head> -->
<jsp:include page="/WEB-INF/view/parts/head.jsp" />
<!-- </head> -->

<body>
	
	<c:if test="${postSuccess == false}">
	<script type="text/javascript">
		swal({
				title: 'Đăng bài không thành công!',
				icon: 'error',
				timer: 3000,
				buttons: true,
				type: 'postSuccess'
		})
	</script>
	</c:if>
	
	<!-- navbar -->
	<jsp:include page="/WEB-INF/view/parts/navbar.jsp" />
	<!-- end navbar -->

	<div class="hero-wrap hero-wrap-2"
		style="background-image: url('${pageContext.request.contextPath}/resources/assets/images/image_4.jpg');"
		data-stellar-background-ratio="0.5">
		<div class="overlay"></div>
		<div class="container">
			<div
				class="row no-gutters slider-text align-items-end justify-content-start">
				<div class="col-md-12 text-center mb-5">
					<p class="breadcrumbs mb-0">
						<span class="mr-3"><a href="${pageContext.request.contextPath}/">Trang chủ <i
								class="ion-ios-arrow-forward"></i></a></span> Đăng bài<span></span>
					</p>
					<h1 class="mb-3 bread">Đăng bài tuyển dụng</h1>
				</div>
			</div>
		</div>
	</div>

	<section class="site-section">
		<div class="container">
			<form:form action="addRecruitment" modelAttribute="recruitment"
				method="post">
				<div class="row align-items-center mb-5">
					<div class="col-lg-8 mb-4 mb-lg-0">
						<div class="d-flex align-items-center">
							<div>
								<h2>Đăng bài</h2>
							</div>
						</div>
					</div>
					<div class="col-lg-4">
						<div class="row">
							<div class="col-6">
								<a href="#" class="btn btn-block btn-light btn-md"></a>
							</div>
							<div class="col-6">
								<button type="submit" class="btn btn-block btn-primary btn-md">Đăng</button>
							</div>
						</div>
					</div>
				</div>
				<div class="row mb-5">
					<div class="col-lg-12">
						<div class="p-4 p-md-5 border rounded">
							<h3 class="text-black mb-5 border-bottom pb-2">Chi tiết bài
								tuyển dụng</h3>

							<div class="form-group">
								<label for="title">Tiêu đề</label> 
								<form:errors path="title" class="error"/>
								<input type="text"
									class="form-control" id="title" name="title" required
									placeholder="Tiêu đề" value="${recruitment.title }">
							<div class="form-group">
								<label for="job-location">Mô tả công việc</label>
								<form:errors path="description" class="error"/>
								<textarea name="description" class="form-control"
									placeholder="Mô tả" id="editor">${recruitment.description }</textarea>
							</div>
							<div class="form-group">
								<label for="job-title">Kinh nghiệm</label> 
								<form:errors path="experience" class="error"/>
								<input type="text"
									class="form-control" id="job-title" name="experience"
									placeholder="Kinh nghiệm" required value="${recruitment.experience }">
							</div>
							<div class="form-group">
								<label for="job-title">Số người cần tuyển</label> 
								<form:errors path="quantity" class="error"/>
								<input
									type="number" class="form-control" id="job-title"
									name="quantity" placeholder="Số người cần tuyển" required value="${recruitment.quantity }">
							</div>
							<div class="form-group">
								<label for="job-location">Địa chỉ</label> 
								<form:errors path="address" class="error"/>
								<input type="text"
									class="form-control" id="job-location" name="address"
									placeholder="Địa chỉ công ty" required value="${recruitment.address }">
							</div>
							<div class="form-group">
								<label for="job-location">Hạn ứng tuyển</label> 
								<form:errors path="deadline" class="error"/>
								<input
									type="date" class="form-control" id="job-location"
									name="deadline" required value="${recruitment.deadline }">
							</div>
							<div class="form-group">
								<label for="job-location">Lương</label> 
								<form:errors path="salary" class="error"/>
								<input type="text"
									class="form-control" id="job-location" name="salary"
									placeholder="Mức lương" required value="${recruitment.salary }">
							</div>

							<div class="form-group">
								<label for="job-region">Loại công việc</label> 
								<form:errors path="type" class="error"/>
								<select
									class="form-control" name="type"
									aria-label="Default select example" required>
									<option value="" selected>Chọn loại công việc</option>
									<option value="Part time">Part time</option>
									<option value="Full time">Full time</option>
									<option value="Freelancer">Freelancer</option>
								</select>

							</div>
							<div class="form-group">
								<label for="job-region">Danh mục công việc</label> 
								<select
									class="form-control" name="categoryId"
									aria-label="Default select example" required>
									<option value="" selected>Chọn danh mục công việc</option>
									<c:forEach var="category" items="${categories}">
										<option value="${category.id}">${category.name}</option>
									</c:forEach>

								</select>

							</div>
						</div>
					</div>
					</div>
				</div>
				<div class="row align-items-center mb-5">

					<div class="col-lg-4 ml-auto">
						<div class="row">
							<div class="col-6">
								<a href="#" class="btn btn-block btn-light btn-md"></a>
							</div>
							<div class="col-6">
								<button type="submit" class="btn btn-block btn-primary btn-md">Đăng
									tuyển</button>
							</div>
						</div>
					</div>
				</div>
			</form:form>
		</div>
	</section>
	
	<script>
        // Khởi tạo CKEditor trên đối tượng textarea với id="editor"
        ClassicEditor
            .create(document.querySelector('#editor'))
            .catch(error => {
                console.error(error);
            });
    </script>
	
	<!-- <footer> -->
	<jsp:include page="/WEB-INF/view/parts/footer.jsp" />
	<!-- </footer> -->
	
</body>



</html>