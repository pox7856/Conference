<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%> 
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<c:import url="../include/header.jsp" />
<!-- page content -->
<div class="right_col" role="main">
	<div class="">
		<div class="page-title">
			<div class="title_left">
				<h3>회원관리전용 게시판</h3>
			</div>

			<div class="title_right"> 
				<div class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
					<div class="input-group">
						<select name="searchType">
							<option value='u'<c:out value="${cri.searchType eq 'u'?'selected':''}"/>>아이디</option>
							<option value='r'<c:out value="${cri.searchType eq 'r'?'selected':''}"/>>가입일</option>
							<option value='n'<c:out value="${cri.searchType eq 'n'?'selected':''}"/>>이름</option>
							<option value='e'<c:out value="${cri.searchType eq 'e'?'selected':''}"/>>이메일</option>
							<option value="ur"<c:out value="${cri.searchType eq 'ur'?'selected':''}"/>>아이디 OR 가입일</option>
							<option value="rn"<c:out value="${cri.searchType eq 'rn'?'selected':''}"/>>가입일 OR 이름</option>
							<option value="urne"<c:out value="${cri.searchType eq 'urne'?'selected':''}"/>>아이디 OR 가입일 OR 이름 OR 이메일</option>
						</select> 
						 <input type="text" class="form-control" placeholder="검색하기..." value='${cri.keyword}' id='keywordInput'> <span class="input-group-btn">
							<button class="btn btn-default" type="button" id='searchBtn'>검색</button>
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearfix"></div>

	<div class="col-md-12 col-sm-12 col-xs-12">
		<div class="x_panel">
			<div class="x_title">
				<h2>회원관리게시판</h2>
				<ul class="nav navbar-right panel_toolbox">
					<li><a class="collapse-link"><i class="fa fa-chevron-up"></i></a></li>
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-expanded="false"><i
							class="fa fa-wrench"></i></a>
						<ul class="dropdown-menu" role="menu">
							<li><a href="#">Settings 1</a></li>
							<li><a href="#">Settings 2</a></li>
						</ul></li>
					<li><a class="close-link"><i class="fa fa-close"></i></a></li>
				</ul>
				<div class="clearfix"></div>
			</div>

			<div class="x_content">

				<div class="table-responsive">
					<table class="table table-striped jambo_table bulk_action">
						<thead>
							<tr class="headings"> 
								<th><input type="checkbox" id="check-all" class="flat"></th>
								<th class="column-title">username</th>
								<th class="column-title">password</th>
								<th class="column-title">name</th>
								<th class="column-title">email</th>
								<th class="column-title">gender</th>
								<th class="column-title">regdate</th>
								<th class="column-title">modidate</th>
								<th class="column-title">enabled</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="MemberVO">
								<tr class="even pointer">
									<td class="a-center "><input type="checkbox" class="flat" name="table_records"></td>
									<td class=" last"><a href='/member/view${pageMaker.makeSearch(pageMaker.cri.page) }&username=${MemberVO.username}'>${MemberVO.username}</a></td>
									<td class=" ">${MemberVO.password}</td>
									<td class=" ">${MemberVO.name}</td>
									<td class=" ">${MemberVO.email}</td>
									<td class=" ">${MemberVO.gender}</td> 
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${MemberVO.regdate}" /></td>
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${MemberVO.modidate}" /></td>
									<td class="a-right a-right ">${MemberVO.enabled }</td> 
								</tr> 
							</c:forEach>
						</tbody>
					</table>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li><a
								href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage }"
							end="${pageMaker.endPage }" var="idx">
							<li
								<c:out value="${pageMaker.cri.page == idx?'class =active':''}"/>>
								<a href="list${pageMaker.makeSearch(idx)}">${idx}</a>
							</li>
						</c:forEach>
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li><a href="list${pageMaker.makeSearch(pageMaker.endPage +1) }">&raquo;</a></li>
						</c:if>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- page content -->
<c:import url="../include/footer.jsp" />