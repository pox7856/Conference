<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- footer content -->
<footer> 
	<form id='globalForm'>
		<input type="hidden" name="username" value="${username}">
	</form> 
	<div class="pull-right"> 
		<a href="https://colorlib.com"> JJK's - Bootstrap Admin Page!!</a>
	</div>

	<div class="clearfix"></div>
</footer>
<!-- /footer content -->
<script src="${contextPath}/resources/template/vendors/jquery/dist/jquery.min.js"></script>
<script src="${contextPath}/resources/template/vendors/iCheck/icheck.min.js"></script>
<script src="${contextPath}/resources/template/vendors/bootstrap/dist/js/bootstrap.min.js"></script>
<script src="${contextPath}/resources/template/vendors/fastclick/lib/fastclick.js"></script>
<script src="${contextPath}/resources/template/vendors/nprogress/nprogress.js"></script>
<script src="${contextPath}/resources/template/build/js/custom.min.js"></script>
<!-- 공통스크립트... 잡동사니... -->
<script src="${contextPath}/resources/myCustom/global.js"></script>
<script>
$(document).ready(function() {
	var result = '${msg}';
	var globalForm = $('#globalForm');

	if (result == 'SUCCESS') {
		alert("처리가 완료되었습니다.");
		};
	$('#viewBtn').on("click",function() {
		globalForm.attr('action',"${contextPath}/member/view");
		globalForm.attr('method', 'get');
		globalForm.submit();
		return false;
	});
	$('#modifyBtn').on("click",function() {
		globalForm.attr('action','${contextPath}/member/modify');
		globalForm.attr('method', 'get');
		globalForm.submit();
		return false;
	});
	$('#logoutBtn').on("click",function() {
		globalForm.attr('action','${contextPath}/users/logout?${_csrf.parameterName}=${_csrf.token}');
		globalForm.attr('method', 'post');
		globalForm.submit();
		return false;
	});
	$('#loginBtn').on("click", function(event) {
		self.location = '/users/login';
	});
});
</script>
</body>
</html>