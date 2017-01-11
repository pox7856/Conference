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
				<h3> 일반게시판
					<sec:authorize access="isAuthenticated()">
						<small>${username} 님! 환영합니다!</small>
						<button type="button" class="btn btn-primary" id='regBtn'>글등록하기</button>
					</sec:authorize>
				</h3>
			</div>

			<div class="title_right">
				<div
					class="col-md-5 col-sm-5 col-xs-12 form-group pull-right top_search">
					<select name="searchType" class="form-control">
						<option value="t"
							<c:out value="${cri.searchType eq 't'?'selected':''}"/>>Title</option>
						<option value="c"
							<c:out value="${cri.searchType eq 'c'?'selected':''}"/>>Content</option>
						<option value="w"
							<c:out value="${cri.searchType eq 'w'?'selected':''}"/>>Writer</option>
						<option value="tc"
							<c:out value="${cri.searchType eq 'tc'?'selected':''}"/>>Title
							OR Content</option>
						<option value="cw"
							<c:out value="${cri.searchType eq 'cw'?'selected':''}"/>>Content
							OR Writer</option>
						<option value="tcw"
							<c:out value="${cri.searchType eq 'tcw'?'selected':''}"/>>TCW</option>
					</select>
					<div class="input-group">
						<input type="text" class="form-control" placeholder="검색하기..."
							value='${cri.keyword}' id='keywordInput'> <span
							class="input-group-btn">
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
				<h2>일반게시판</h2>
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
								<th class="column-title">글번호</th>
								<th class="column-title">제목</th>
								<th class="column-title">작성자</th>
								<th class="column-title">작성시간</th>
								<th class="column-title">조회수</th>
								<th class="column-title">첨부파일갯수</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${list}" var="boardVO">
								<tr class="even pointer">
									<td class="a-center"><input type="checkbox" class="flat" name="table_records"></td>
									<td class="a-center">${boardVO.bno}</td> 
									<td class="a-center"><a href='/board/view${pageMaker.makeSearch(pageMaker.cri.page)} &bno=${boardVO.bno}'>${boardVO.title}<strong> [ ${boardVO.replycnt} ] </strong></a></td>
									<td class="a-center">${boardVO.username}</td>
									<td><fmt:formatDate pattern="yyyy-MM-dd HH:mm" value="${boardVO.regdate}" /></td>
									<td class="a-center">${boardVO.viewcnt }</td>
									<td class="a-center">${boardVO.filecnt }</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<ul class="pagination">
						<c:if test="${pageMaker.prev}">
							<li><a href="list${pageMaker.makeSearch(pageMaker.startPage - 1) }">&laquo;</a></li>
						</c:if>
						<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage }" var="idx">
							<li <c:out value="${pageMaker.cri.page == idx?'class =active':''}" />>
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

<script>
$(document).ready(function() {

	$('#regBtn').on("click", function(event) {
		self.location = "register";
	});

	$('#searchBtn').on("click",function(event) {
		self.location = "list" + '${pageMaker.makeQuery(1)}'
					  + "&searchType=" + $("select option:selected").val()
					  + "&keyword=" + $('#keywordInput').val();
	});
});
</script>
<c:import url="../include/footer.jsp" />