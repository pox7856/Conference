<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:import url="../include/header.jsp" />
<!-- 임시 이미지 테스트 스타일... -->
<!-- Dropzone.js -->
<link href="${contextPath}/resources/template/vendors/dropzone/dist/min/dropzone.min.css" rel="stylesheet">
<!-- 임시 이미지 테스트 스타일... -->
<!-- page content -->
<div class="right_col" role="main">
	<div class="">
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_content">
						<form class="form-horizontal form-label-left " id='register-form'
							action="/member/registerPOST?${_csrf.parameterName}=${_csrf.token}"
							enctype="multipart/form-data" method="POST">
							<span class="section">회원 가입 페이지</span>
							<div class="item form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="username">아이디 <span class="required">:</span></label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input name="username" class="form-control col-md-7 col-xs-12"
										id='username' placeholder="id.." required="required">
									<span id="dupleResult"></span>
								</div>
								<button id="dupleCheck" class="btn btn-success">중복체크</button>
							</div>
							<div class="item form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="password">비밀번호 <span class="required">:</span>
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input name="password" id="password"
										class="form-control col-md-7 col-xs-12" required="required" />
								</div>
							</div>
							<div class="item form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="name">이름 <span class="required">:</span>
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input name="name" class="form-control col-md-7 col-xs-12" />
								</div>
							</div>
							<div class="item form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="email">이메일 <span class="required">:</span>
								</label>
								<div class="col-md-6 col-sm-6 col-xs-12">
									<input name="email" required="required"
										placeholder="test@naver.com"
										class="form-control col-md-7 col-xs-12" />
								</div>
							</div>
							<div class="item form-group">
								<label class="control-label col-md-3 col-sm-3 col-xs-12"
									for="gender">성별 <span class="required">:</span>
								</label>
								<div id="gender" class="btn-group" data-toggle="buttons">
									<label class="btn btn-default" data-toggle-class="btn-primary"
										data-toggle-passive-class="btn-default"> <input
										type="radio" name="gender" value="male"
										data-parsley-multiple="gender"> &nbsp; Male &nbsp;
									</label> <label class="btn btn-primary" data-toggle-class="btn-primary"
										data-toggle-passive-class="btn-default"> <input
										type="radio" name="gender" value="female" rw
										data-parsley-multiple="gender"> Female
									</label>
								</div>
							</div>

							<div class="item form-group">
								<div class="col-md-6 col-sm-6 col-xs-12"></div>
							</div>
							<div class="ln_solid"></div>
							<div class="item form-group">
								<div class="col-md-6 col-md-offset-3">
									<button id="regBtn" class="btn btn-success">회원가입</button>
									<button type="reset" class="btn btn-primary">리셋버튼</button>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script>
	$(document).ready(function() {
	    var regForm = $("#register-form"); 

	    $('#regBtn').on("click", function(event) {
	        event.preventDefault();   
	        regForm.submit();
	    }); 
		
		$("#dupleCheck").click(function() { 
			event.preventDefault();
			var username = $('#username').val(); 
			$.ajax({
				type : "POST",
				url : "id_check", 
				data : {username},
				cache : false,
				success : function(data) { 
					if(data == true){
						$("#dupleResult").html('<strong>중복되는 아이디가 있습니다..!</strong>'); 
						$('#regBtn').attr('disabled',true);
					}else if(data == false){
						$("#dupleResult").html('<strong>사용가능한 아이디입니다..!</strong>'); 
						$('#regBtn').attr('disabled',false);
					}
				}
			});
		});
	});
</script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="${contextPath}/resources/template/vendors/dropzone/dist/min/dropzone.min.js"></script>
<c:import url="../include/footer.jsp" />