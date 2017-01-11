<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../include/header.jsp" />
<!-- 페이지세팅... -->
<sec:authentication var="user" property="principal" />
<script type="text/javascript" src="/resources/js/upload.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- 페이지세팅... -->
<!-- page content -->
<!-- page content -->
<div class="right_col" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>뷰페이지</h3>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12">
				<div class="x_panel">
					<div class="x_content">
						<div class="row">
							<div class="clearfix"></div>

							<div class="col-md-12 col-sm-12 col-xs-12 profile_details">
								<div class="well profile_view">
									<div class="col-sm-12">
										<h4 class="brief">
											<i>이름 : ${view.name}</i>
										</h4>
										<div class="left col-xs-7">
											<h2>아이디 : ${view.username}</h2>
											<h2>비밀번호 : ${view.password}</h2>
											<h2>이메일 : ${view.email}</h2>
											<h2>성별 : ${view.gender}</h2>
											<h2>계정잠금 : ${view.enabled}</h2>
											<ul class="list-unstyled">
												<li><i class="fa fa-building"></i>등록시간 : <fmt:formatDate
														pattern="yyyy-MM-dd HH:mm" value="${view.regdate}" /></li>
												<li><i class="fa fa-phone"></i>수정시간 : <fmt:formatDate
														pattern="yyyy-MM-dd HH:mm" value="${view.modidate}" /></li>
											</ul>
										</div>
									</div>
									<div class="col-xs-12 bottom text-center">

										<div class="col-xs-12 col-sm-6 emphasis">
											<button type="button" class="btn btn-info" id="memberList">리스트</button>
											<button type="button" class="btn btn-danger" id="memberDelBtn">삭제</button>
											<button type="button" class="btn btn-default" id="memberUptBtn">수정</button>
										</div>
									</div>
								</div>
							</div>
							<form id='f1'>
								<input type='hidden' name='username' value="${view.username}">
								<input type='hidden' name='page' value="${param.page}">
								<input type='hidden' name='perPageNum'
									value="${param.perPageNum}"> <input type='hidden'
									name='searchType' value="${param.searchType}"> <input
									type='hidden' name='keyword' value="${param.keyword}">
								<input type="hidden" name="${_csrf.parameterName}"
									value="${_csrf.token}" id='Fcsrf'>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- /page content -->
<script>
$(document).ready(function() {

	var form = $("#f1");

	$('#memberList').on("click",function(event) {
		form.attr("action", "/member/list").attr("method","get").submit();
	});
	$('#memberDelBtn').on("click",function(event) {
		form.attr("action", "/member/remove").attr("method", "POST").submit();
	});
	$('#memberUptBtn').on("click",function(event) {
		form.attr("action", "/member/modify").attr("method", "get").submit();
	});
});
</script>
<c:import url="../include/footer.jsp" />