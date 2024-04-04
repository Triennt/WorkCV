<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!-- Modal Apply -->
<div class="modal fade" id="applyModal${recruitment.id}" tabindex="-1"
	role="dialog" aria-labelledby="applyModalLabel${recruitment.id}"
	aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="applyleModalLabel${recruitment.id}">
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
							<select id="select${recruitment.id}"
								onchange="selected(${recruitment.id})" class="form-control"
								aria-label="Default select example">
								<option selected>Chọn phương thức nộp</option>
								<option value="1">Dùng cv đã cập nhật</option>
								<option value="2">Nộp cv mới</option>
							</select>
						</div>
						<div id="option1${recruitment.id}" style="display: none"
							class="col-12">
							<label for="text${recruitment.id}" class="col-form-label">Giới
								thiệu ngắn:</label>
							<textarea rows="10" cols="3" class="form-control" placeholder="Giới thiệu"
								id="text1${recruitment.id}">
							</textarea>
                                                
						</div>
						<div id="option2${recruitment.id}" style="display: none"
							class="col-12">

							<label for="fileUpload${recruitment.id}" class="col-form-label">Chọn
								cv:</label> <input type="file" accept="application/pdf"
								class="form-control" id="fileUpload${recruitment.id}"
								name="file" required> <label for="text${recruitment.id}"
								class="col-form-label">Giới thiệu ngắn:</label>
							<textarea rows="10" cols="3" class="form-control"
								id="text2${recruitment.id}">
							</textarea>
						</div>

					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-dismiss="modal">Đóng</button>
						<button type="button" id="button1${recruitment.id}"
							style="display: none"
							onclick="applyJobAvailableCv(${recruitment.id})"
							class="btn btn-primary">Nộp</button>
						<button type="button" id="button2${recruitment.id}"
							style="display: none" onclick="applyJobNewCv(${recruitment.id})"
							class="btn btn-primary">Nộp</button>
					</div>
				</div>
			</form>


		</div>
	</div>
</div>
<!--End Modal Apply -->