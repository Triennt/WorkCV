/* Kiểm tra có phải đúng USER đang clcik Apply */
function clickApply(id) {
	var roleUser = $('#roleUser').val();
		if (roleUser) {
		$('#applyModal' + id).modal('show');
	} else {
		swal({
			title: 'Đăng nhập tài khoản USER để thực hiện chức năng!',
			icon: 'error',
			timer: 3000,
			buttons: true,
			type: 'error'
		})
	}
	
}

/* Cách nộp CV */
function selected(id) {
	var option1 = 'option1' + id;
	var option2  = 'option2' + id;
	var button1 = 'button1' + id;
	var button2 = 'button2' + id;
	var select = $('#select' + id).val();
	if (select == 1) {
		document.getElementById(option1).style.display = 'block'
		document.getElementById(option2).style.display = 'none'
		document.getElementById(button1).style.display = 'block'
		document.getElementById(button2).style.display = 'none'
	} else {
		document.getElementById(option2).style.display = 'block'
		document.getElementById(option1).style.display = 'none'
		document.getElementById(button2).style.display = 'block'
		document.getElementById(button1).style.display = 'none'
	}

}

/* Apply với CV đã có sẵn */
function applyJobAvailableCv(id) {
	var roleUser = $('#roleUser').val();
	var recruitmentId = $("#idRe" + id).val();
	var applyModal = "#applyModal" + id;
//	var fileUpload = "#fileUpload" + id;
	var text =$("#text1" + id).val(); 
	var formData = new FormData();
	formData.append('idRe', recruitmentId);
	formData.append('text', text);
	if (roleUser) {
		$.ajax(
			{
				type: 'POST',
				url: contextPath + '/user/applyJobAvailableCv',
				contentType: false,
				processData: false,
				data: formData,
				success: function(data) {
					console.log(data);
					if (data == "notLogin") {
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
						$(applyModal).modal('hide');
					}

					if (data == "Ok") {
						swal({
							title: 'Ứng tuyển thành công!',
							/* text: 'Redirecting...', */
							icon: 'success',
							timer: 3000,
							buttons: true,
							type: 'success'
						})
						$(applyModal).modal('hide');
					}

					if (data == "noCv") {
						swal({
							title: 'Bạn chưa có CV. ',
							/* text: 'Redirecting...', */
							icon: 'error',
							timer: 3000,
							buttons: true,
							type: 'error'
						})
						$(applyModal).modal('hide');
					}

					if (data == "hasApplied") {
						swal({
							title: 'Bạn đã ứng tuyển công việc này!',
							/* text: 'Redirecting...', */
							icon: 'error',
							timer: 3000,
							buttons: true,
							type: 'error'
						})
						$(applyModal).modal('hide');
					}
				},
				error: function(err) {
					alert(err);
				}
			}
		)
	} else {
		swal({
			title: 'Đăng nhập tài khoản USER để thực hiện chức năng!',
			/* text: 'Redirecting...', */
			icon: 'error',
			timer: 3000,
			buttons: true,
			type: 'error'
		})
	}
}

/* Apply với CV tải lên */
function applyJobNewCv(id) {
	var roleUser = $('#roleUser').val();
	var applyModal = "#applyModal" + id;
	var idRe = $("#idRe" + id).val();
	var textvalue = $("#text2" + id).val();
	var fileUpload = $("#fileUpload" + id).get(0);
	var files = fileUpload.files;
	var formData = new FormData();
	formData.append('file', files[0]);
	formData.append('idRe', idRe);
	formData.append('text', textvalue);
	if (files[0] == null) {
		swal({
			title: 'Bạn cần phải chọn cv!',
			/* text: 'Redirecting...', */
			icon: 'error',
			timer: 3000,
			buttons: true,
			type: 'error'
		})
	} else {
		if (roleUser) {
			$.ajax(
				{
					type: 'POST',
					url: contextPath + '/user/applyJobNewCv',
					contentType: false,
					processData: false,
					data: formData,
					success: function(data) {
						if (data == "notLogin") {
							swal({
								title: 'Bạn cần phải đăng nhập!',
								/* text: 'Redirecting...', */
								icon: 'error',
								timer: 3000,
								buttons: true,
								type: 'error'
							})
						}

						if (data == "Ok") {
							swal({
								title: 'Ứng tuyển thành công!',
								/* text: 'Redirecting...', */
								icon: 'success',
								timer: 3000,
								buttons: true,
								type: 'success'
							})
							$(applyModal).modal('hide');
							$('#fileUpload').val("");
						}

						if (data == "hasApplied") {
							swal({
								title: 'Bạn đã ứng tuyển công việc này!',
								/* text: 'Redirecting...', */
								icon: 'error',
								timer: 3000,
								buttons: true,
								type: 'error'
							})
							$(applyModal).modal('hide');
							$('#fileUpload').val("");
						}
					},
					error: function(err) {
						alert(err);
					}
				}
			)
		} else {
			swal({
				title: 'Đăng nhập tài khoản USER để thực hiện chức năng!',
				/* text: 'Redirecting...', */
				icon: 'error',
				timer: 3000,
				buttons: true,
				type: 'error'
			})
		}

	}

}

/* lưu công việc */
function save(id) {
	var roleUser = $('#roleUser').val();
	var idRe = $("#idRe" + id).val();
	var formData = new FormData();
	formData.append('idRe', idRe);
	if (roleUser) {
		$.ajax(
			{
				type: 'POST',
				url: contextPath + '/user/saveJob',
				contentType: false,
				processData: false,
				data: formData,
				success: function(data) {
					console.log(data);
					if (data == "notLogin") {
						swal({
							title: 'Bạn cần phải đăng nhập!',
							/* text: 'Redirecting...', */
							icon: 'error',
							timer: 3000,
							buttons: true,
							type: 'error'
						})
					}

					if (data == "Ok") {
						swal({
							title: 'Lưu thành công!',
							/* text: 'Redirecting...', */
							icon: 'success',
							timer: 3000,
							buttons: true,
							type: 'success'
						})
						$('#saved').show();
						$('#notSave').hide();
					}

					if (data == "unSave") {
						swal({
							title: 'Bỏ lưu thành công',
							/* text: 'Redirecting...', */
							icon: 'success',
							timer: 3000,
							buttons: true,
							type: 'success'
						})
						$('#saved').hide();
						$('#notSave').show();
					}
				},
				error: function(err) {
					alert(err);
				}
			}
		)
	} else {
		swal({
			title: 'Đăng nhập tài khoản USER để thực hiện chức năng!',
			/* text: 'Redirecting...', */
			icon: 'error',
			timer: 3000,
			buttons: true,
			type: 'error'
		})
	}

}
  /** upload logo công ty */  
  $(function () {
        $('#uploadLogo').change(function () {
            if (window.FormData !== undefined) {
                var fileUpload = $('#uploadLogo').get(0);
                var files = fileUpload.files;
                var formData = new FormData();
                formData.append('logo', files[0]);
                if(files[0] == null){
                    $(".toast").toast("show");
                } else {
                    $.ajax(
                        {
                            type: 'POST',
                            url: contextPath + '/admin/uploadLogo',
                            contentType: false,
                            processData: false,
                            data: formData,  
                            success: function (urlImage) {
                                console.log(urlImage)
                                if(urlImage == "Error"){
                                    document.getElementById("change").style.backgroundColor = 'red';
                                    swal({
                                        title: 'Cập nhật logo thất bại!',
                                        /* text: 'Redirecting...', */
                                        icon: 'error',
                                        timer: 3000,
                                        buttons: true,
                                        type: 'error'
                                    })
                                    $("#divImage").css("display","block")
                                }else if(urlImage == "notCompany"){
									swal({
                                        title: 'Bạn cần tạo hồ sơ công ty!',
                                        /* text: 'Redirecting...', */
                                        icon: 'error',
                                        timer: 3000,
                                        buttons: true,
                                        type: 'error'
                                    })
								}else{
									$('#logo').attr('src', contextPath + '/' + urlImage)
									document.getElementById('inputLogo').value = urlImage;
                                }

                            },
                            error: function (err) {
                                alert(err);
                            }
                        }
                    )
                }

            }
        })
    })
    
/** upload avatar User */
$(function () {
        $('#uploadAvatar').change(function () {
            if (window.FormData !== undefined) {
                var fileUpload = $('#uploadAvatar').get(0);
                var files = fileUpload.files;
                var email = $("#email").val();
                var formData = new FormData();
                formData.append('avatar', files[0]);
                formData.append('email', email);
                if(files[0] == null){
                    $(".toast").toast("show");
                } else {
                    $.ajax(
                        {
                            type: 'POST',
                            url: contextPath + '/uploadAvatar',
                            contentType: false,
                            processData: false,
                            data: formData,
                            success: function (urlImage) {
                                console.log(urlImage)
                                if(urlImage == "Error"){
                                    document.getElementById("change").style.backgroundColor = 'red';
                                    swal({
                                        title: 'Cập nhật ảnh đại diện thất bại!',
                                        /* text: 'Redirecting...', */
                                        icon: 'error',
                                        timer: 3000,
                                        buttons: true,
                                        type: 'error'
                                    })
                                    $("#divImage").css("display","block")
                                }else{
									$('#avatar').attr('src', contextPath + '/' + urlImage)
                                    swal({
                                        title: 'Cập nhật ảnh đại diện thành công!',
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

            }
        })
    })
    
    /** upload CV User */
    $(function () {
        $('#uploadCv').change(function () {
            if (window.FormData !== undefined) {
                var fileUpload = $('#uploadCv').get(0);   
                var files = fileUpload.files;
                var fileName = files[0].name;
                var email = $("#email").val();
                var formData = new FormData();
                formData.append('cv', files[0]);
                formData.append('email', email);
                if(files[0] == null){
                    $(".toast").toast("show");
                } else {
                    $.ajax(
                        {
                            type: 'POST',
                            url: contextPath + '/user/uploadCv',
                            contentType: false,
                            processData: false,
                            data: formData,
                            success: function (urlCv) {
                                console.log(urlCv)
                                if(urlCv == "Error"){
                                    swal({
                                        title: 'Có lỗi xảy ra',
                                        /* text: 'Redirecting...', */
                                        icon: 'error',
                                        timer: 3000,
                                        buttons: true,
                                        type: 'error'
                                    })
                                }else{
                                    document.getElementById('cvName').innerHTML = fileName;
                                    document.getElementById('cvName').href = contextPath + '/' + urlCv ; 
                                    document.getElementById('cvName').target = '_blank';
                                    document.getElementById('buttonDelete').innerHTML = 'Xóa CV';
                                    document.getElementById('cvDelete').innerHTML = fileName;
                                    document.getElementById('filePathCv').innerHTML = filePathCv;

                                    swal({
                                        title: 'Cập nhật CV thành công!',
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

            }
        })
    })
    
    /**
	 * delete CV
	 */
    $(function () {
        $('#deleteCvButton').click(function () {
            var filePathCv = $('#filePathCv').val();

            $.ajax({
                type: 'POST',
                url: contextPath + '/user/deleteCv',
                data: { filePathCv: filePathCv },
                success: function (response) {
					console.log(response)
                    if(response === 'Ok'){
                    	document.getElementById('cvName').innerHTML = 'Chưa có CV';
                        document.getElementById('cvName').href = '#' ;
                        document.getElementById('cvName').target = '';
                        document.getElementById('buttonDelete').innerHTML = '';
                        document.getElementById('cvDelete').innerHTML = '';
					} else{
						swal({
                            title: 'Lỗi',
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
        });
    });
    
    /**
	 * Gửi Email xác thực
	 */
    $(function () {
        $('.sendEmail').click(function () {
        	
        	$('#btnSend').hide();
       	 	$('.sending').show();
       	 	$('.inputCode').hide();
            $.ajax({
                type: 'GET',
                url: contextPath + '/register/verifyEmail', 
                success: function (response) {
                    if(response == 'sentEmail'){
                    	 $('#notVerify').hide();
                    	 $('.sending').hide();
                    	 $('#sentEmail').show();
                    	 $('.inputCode').show();
                    	
					} else {
						swal({
                            title: 'Gửi mail thất bại!',
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
        });
    });
    
    /**
	 * Xác thực code
	 */
    $(function () {
        $('.verify').click(function () {
        	var code = $('#code').val(); 
        	swal({
        	      title: 'Đang xác thực...',
        	      allowEscapeKey: false,
        	      allowOutsideClick: false,
        	      onOpen: () => {
        	        swal.showLoading();
        	      }
        	});
        	
            $.ajax({
                type: 'GET',
                url: contextPath + '/register/verifyCode',
                data: {code: code},
                success: function (response) {
					console.log(response)
                    if(response == 'verifySuccess'){
                    	 $('#verifyEmail').hide();
                    	swal({
                            title: 'Xác thực thành công!',
                            /* text: 'Redirecting...', */
                            icon: 'success',
                            timer: 3000,
                            buttons: true,
                            type: 'success'
                        })
                    	
					} else {
						swal({
                            title: 'Xác thực thất bại!',
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
        });
    });