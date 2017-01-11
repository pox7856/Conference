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
<meta name="author" content="pox">
<meta name="reply-to" content="pox7856@gmail.com">
<meta name="content-language" content="kr">
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />
<c:set var="contextPath" scope="session"
	value="${pageContext.request.contextPath}" />
<title>JJK's Portfolio project!</title>
<link
	href="${contextPath}/resources/template/vendors/bootstrap/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/template/vendors/font-awesome/css/font-awesome.min.css"
	rel="stylesheet">
<link
	href="${contextPath}/resources/template/vendors/nprogress/nprogress.css"
	rel="stylesheet">
<link href="${contextPath}/resources/template/build/css/custom.min.css"
	rel="stylesheet">
<script src="https://code.jquery.com/jquery-2.2.4.js"></script>
</head>
<body class="nav-md">
	<div class="container body">
		<div class="main_container">
			<div class="col-md-3 left_col">
				<div class="left_col scroll-view">
					<div class="navbar nav_title" style="border: 0;">
						<a href="<c:url value='/index'/>" class="site_title"><i
							class="fa fa-paw"></i> <span>개인프로젝트</span></a>
					</div>
					<div class="clearfix"></div>
					<!-- menu profile quick info -->

					<div class="profile clearfix">
						<sec:authorize access="isAuthenticated()">
							<div class="profile_pic">
								<img
									src="${contextPath}/resources/template/production/images/img.jpg"
									alt="..." class="img-circle profile_img">
							</div>
							<div class="profile_info">
								<span>환영합니다! ${auth}</span>
								<h2>${username}</h2>
							</div>
						</sec:authorize>
						<sec:authorize access="isAnonymous()">
							<div class="profile_info">
								<h2>
									<strong><a href="<c:url value='/member/register'/>"
										class="to_register">회원가입하러가기</a></strong>
								</h2>
							</div>
						</sec:authorize>
					</div>
					<!-- /menu profile quick info -->
					<br />
					<!-- sidebar menu -->
					<div id="sidebar-menu"
						class="main_menu_side hidden-print main_menu">
						<div class="menu_section">
							<h3>General</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-home"></i> Home <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="<c:url value='/index'/>">HOME</a></li>
									</ul></li>
								<li><a><i class="fa fa-table"></i>게시판<span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<sec:authorize access="hasRole('ROLE_ADMIN')">
											<li><a href="<c:url value='/member/list'/>">회원관리게시판[관리자]</a></li>
										</sec:authorize>
										<li><a href="<c:url value='/board/list'/>">일반게시판</a></li>
									</ul></li>
							</ul>
						</div>
						<div class="menu_section">
							<h3>메뉴구성요소</h3>
							<ul class="nav side-menu">
								<li><a><i class="fa fa-bug"></i> Additional Pages <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="e_commerce">E-commerce</a></li>
										<li><a href="projects">Projects</a></li>
										<li><a href="project_detail">Project Detail</a></li>
										<li><a href="contacts">Contacts</a></li>
										<li><a href="profile">Profile</a></li>
									</ul></li>
								<li><a><i class="fa fa-windows"></i> Extras <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="plain_page">Plain Page</a></li>
										<li><a href="login">Login Page</a></li>
										<li><a href="pricing_tables">Pricing Tables</a></li>
									</ul></li>
								<li><a><i class="fa fa-sitemap"></i> Multilevel Menu <span
										class="fa fa-chevron-down"></span></a>
									<ul class="nav child_menu">
										<li><a href="#level1_1">Level One</a>
										<li><a>Level One<span class="fa fa-chevron-down"></span></a>
											<ul class="nav child_menu">
												<li class="sub_menu"><a href="level2">Level Two</a></li>
												<li><a href="#level2_1">Level Two</a></li>
												<li><a href="#level2_2">Level Two</a></li>
											</ul></li>
										<li><a href="#level1_2">Level One</a></li>
									</ul></li>
							</ul>
						</div>
					</div>
					<!-- /sidebar menu -->
				</div>
			</div>
			<!-- top navigation -->
			<div class="top_nav">
				<div class="nav_menu">
					<nav>
					<div class="nav toggle">
						<a id="menu_toggle"><i class="fa fa-bars"></i></a>
					</div>
					<ul class="nav navbar-nav navbar-right">
						<sec:authorize access="isAnonymous()">
							<li class=""><button type="button" class="btn btn-success"
									id='loginBtn'>로그인</button></li>
						</sec:authorize>

						<sec:authorize access="isAuthenticated()">
							<li class=""><a href="javascript:;"
								class="user-profile dropdown-toggle" data-toggle="dropdown"
								aria-expanded="false"> 
								<img src="${contextPath}/resources/template/production/images/img.jpg" alt="">${username} 님 <span class=" fa fa-angle-down"></span></a>
								<ul class="dropdown-menu dropdown-usermenu pull-right">
								<sec:authorize access="hasAnyRole('ROLE_MEMBER','ROLE_MANAGER')">
									<li><a id="viewBtn"> 
									<span class="badge bg-red pull-right">프로필보기</span> <span>Profile</span>
									</a></li>
									<li><a id="modifyBtn"> 
									<span class="badge bg-red pull-right">수정하기</span> <span>Settings</span>
									</a></li>
								</sec:authorize>
									<li><a id="logoutBtn">
									<span class="badge bg-red pull-right">LOG OUT</span> <span>LOG OUT</span>
								</ul></li>
						</sec:authorize>
					</ul>
					</nav>
				</div>
			</div>
			<!-- /top navigation -->