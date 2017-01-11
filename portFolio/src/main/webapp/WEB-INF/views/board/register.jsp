<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="../include/header.jsp" />
<link href="${contextPath}/resources/template/vendors/dropzone/dist/min/dropzone.min.css" rel="stylesheet">
<!-- page content -->
<div class="right_col" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>등록페이지</h3>
			</div>
		</div>
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_content">

						<form id='regForm'
							action="/board/register?${_csrf.parameterName}=${_csrf.token}"
							method="post" enctype="multipart/form-data">
							<input type="hidden" name="username" value='${username}'
								id='username'>
							<div>
								<strong> 제목 :</strong> <input type='text' name='title'
									id='title'>
							</div>

							<div>
								<textarea name="content" id="ir1" rows="10" cols="100"
									style="width: 766px; height: 412px;"></textarea>
							</div>

							<button id='submitBtn' type='submit'>Save</button>
							<input type="file" id='inputFile' name="file" class='inputFile'
								value="파일첨부" multiple="multiple" />
						</form> 
						<%-- <form action="../uploadAjax?${_csrf.parameterName}=${_csrf.token}" class="dropzone"></form> --%>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>

<!-- /page content -->
<script type="text/javascript" src="${contextPath}/resources/editor/js/HuskyEZCreator.js" charset="utf-8"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="${contextPath}/resources/editor/js/bundle.js" charset="utf-8"></script> 
<script src="${contextPath}/resources/template/vendors/dropzone/dist/min/dropzone.min.js"></script>
<c:import url="../include/footer.jsp" />