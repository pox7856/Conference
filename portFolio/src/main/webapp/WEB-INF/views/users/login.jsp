<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="keyword" content="정재관,jjk">
<meta name="description" content="">
<meta name="author" content="pox">
<meta name="reply-to" content="pox7856@gmail.com">
<meta name="content-language" content="kr">
<meta name="format-detection" content="telephone=no">

<title>POX web's LOGIN!</title>

<link
	href="${pageContext.request.contextPath}/resources/template/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<!-- Font Awesome -->
<link
	href="${pageContext.request.contextPath}/resources/template/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<!-- NProgress -->
<link
	href="${pageContext.request.contextPath}/resources/template/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<!-- Animate.css -->
<link
	href="${pageContext.request.contextPath}/resources/template/vendors/animate.css/animate.min.css"
	rel="stylesheet">
<!-- Custom Theme Style -->
<link
	href="${pageContext.request.contextPath}/resources/template/build/css/custom.min.css"
	rel="stylesheet">
</head>
<body class="login">
	<div>
		<a class="hiddenanchor" id="signup"></a> <a class="hiddenanchor"
			id="signin"></a>

		<div class="login_wrapper">
			<div class="animate form login_form">
				<section class="login_content">
				<form role="form" name="loginForm" method="post"
					action="<c:url value='/users/loginProcess?${_csrf.parameterName}=${_csrf.token}'/>">
					<h1>로 그 인</h1>
					<div>
						<input type="text" class="form-control" placeholder="Username...."
							name="username" required="" />
					</div>
					<div>
						<input type="password" class="form-control"
							placeholder="Password....." name="password" required="" />
					</div>
					<div>
						<button type="submit" class="btn btn-default submit">Log
							in</button>
						<a class="reset_pass" href="#">Lost your password?</a>
					</div>

					<div class="checkbox">
						<label> <input name="_spring_security_remember_me"
							type="checkbox" value="Remember_Me" id="remember_me">
							Remember Me
						</label>
					</div>

					<div class="clearfix"></div>

					<div class="separator">
						<p class="change_link">
							사이트에 처음오셨습니까?? <strong><a
								href="<c:url value='/member/register'/>" class="to_register">회원가입</a></strong>
						</p>
						<div class="clearfix"></div>
						<br />

						<div>
							<h1>
								<i class="fa fa-paw"></i> JJK's Portfolio project!
							</h1>
							<p>©2016 All Rights Reserved. JJK's Portfolio project! is a
								Bootstrap 3 template. Privacy and Terms</p>
						</div>
					</div>
				</form>
				</section>
			</div>

			<div id="register" class="animate form registration_form">
				<section class="login_content">
				<form>
					<h1>Create Account</h1>
					<div>
						<input type="text" class="form-control" placeholder="Username"
							name='username' required="" />
					</div>
					<div>
						<input type="email" class="form-control" placeholder="Email"
							required="" />
					</div>
					<div>
						<input type="password" class="form-control" placeholder="Password"
							required="" />
					</div>
					<div>
						<a class="btn btn-default submit" href="index.html">Submit</a>
					</div>

					<div class="clearfix"></div>

					<div class="separator">
						<p class="change_link">
							Already a member ? <a href="#signin" class="to_register"> Log
								in </a>
						</p>

						<div class="clearfix"></div>
						<br />

						<div>
							<h1>
								<i class="fa fa-paw"></i> Gentelella Alela!
							</h1>
							<p>©2016 All Rights Reserved. Gentelella Alela! is a
								Bootstrap 3 template. Privacy and Terms</p>
						</div>
					</div>
				</form>
				</section>
			</div>
		</div>
	</div>
	<script>
		var result = '${msg}';

		if (result == 'REGISTSUCCESS') {
			alert('회원가입에 성공하셨습니다!');
		} else if (result == 'loginFail') {
			alert('로그인에 실패하였습니다.. 다시 로그인해주세요!');
		}
	</script>
</body>
</html>
