<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:import url="../include/header.jsp" />
<!-- 페이지세팅... -->
<c:set value="${view.bno}" var="bno" />
<sec:authentication var="currentUserName" property="principal.username" />
<script type="text/javascript" src="/resources/js/upload.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- 페이지세팅... -->
<!-- page content -->
<div class="right_col" role="main">
	<div class="clearfix"></div>
	<div class="row">
		<div class="col-md-12">
			<div class="x_panel">
				<div class="x_title">
					<h1>${view.title}&nbsp;&nbsp;[${view.viewcnt}]</h1>
					<div class="clearfix"></div>
				</div>
				<div class="x_content">
					<div class="row">
						<!-- /MAIL LIST -->
						<!-- CONTENT MAIL -->
						<div class="col-sm-12 mail_view">
							<div class="inbox-body">
								<div class="mail_heading row">
									<div class="col-md-8">
										<div class="btn-group btn-group-sm">
											<button id='listBtn' class="btn btn-default" type="button"
												data-toggle="tooltip" data-original-title="목록가기">목록가기</button>
											<sec:authorize access="isAuthenticated()">

												<c:if
													test="${currentUserName == view.username || currentUserName == 'admin'}">
													<button id='bdelBtn' class="btn btn-default" type="button"
														data-toggle="tooltip" data-original-title="삭제하기">삭제</button>
													<button id='buptBtn' class="btn btn-default" type="button"
														data-toggle="tooltip" data-original-title="수정하기">수정</button>
												</c:if>
											</sec:authorize>
										</div>
									</div>
									<div class="col-md-4 text-right">
										<p class="date">작성자 - ${view.username}
										<p class="date">
											등록시간 -
											<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${view.regdate}" />
										</p>
										<p class="date">
											수정시간 -
											<fmt:formatDate pattern="yyyy-MM-dd HH:mm"
												value="${view.modidate}" />
										</p>
										<span><i class="fa fa-paperclip"></i> attachments — </span>
										<p class="date" id='fileList'></p>

									</div>
								</div>
								<div class="view-mail">
									<p>${view.content}</p>
								</div>

								<div class="x_content">

									<ul class="list-unstyled msg_list">
										<h2>
											댓글개수 :<small id='replyCount'>[ ${view.replycnt} ]</small>
										</h2>

										<ul id="repliesDiv"></ul>
									</ul>

									<sec:authorize access="isAnonymous()">
										<input class="form-control" type="text"
											placeholder="회원가입이필요한서비스입니다.." readonly="readonly">
										<button type="submit" class="btn btn-primary">ADD
											REPLY</button>
									</sec:authorize>
									<sec:authorize access="isAuthenticated()">
										<input class="form-control" type="text" placeholder="댓글쓰기...."
											id="newReplyText">
										<button type="submit" class="btn btn-primary" id="replyAddBtn">ADD
											REPLY</button>
									</sec:authorize>
								</div>
								<form role="form">
									<input type='hidden' name='bno' value="${view.bno}"> <input
										type='hidden' name='page' value="${param.page}"> <input
										type='hidden' name='perPageNum' value="${param.perPageNum}">
									<input type='hidden' name='searchType'
										value="${param.searchType}"> <input type='hidden'
										name='keyword' value="${param.keyword}"> <input
										type="hidden" name="${_csrf.parameterName}"
										value="${_csrf.token}" id='Fcsrf'>
								</form>

							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
<div id="modifyModal" class="modal modal-primary fade" role="dialog">
	<div class="modal-dialog">
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">댓글수정</h4>
			</div>
			<div class="modal-body" data-rno>
				<p>
					<input type="text" id="replytext" class="form-control">
				</p>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-info" id="replyModBtn">Modify</button>
				<button type="button" class="btn btn-danger" id="replyDelBtn">DELETE</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
<!-- Modal -->
<!-- /page content -->

<script id="getFile" type="text/x-handlebars-template">
 <img src="{{imgsrc}}" alt="fileAttachment..">
 <a href="{{getLink}}">{{fileName}}</a>
</script>

<script id="template" type="text/x-handlebars-template">
{{#each .}}
<li class="replyLi" data-rno={{rno}}>
<a>
<span class="image"> <img src="${pageContext.request.contextPath}/resources/template/production/images/img.jpg" alt="img" /> </span>
<span class='rno'>{{rno}}</span><span> - {{replyer}}</span>
<span class="time">
{{#eqReplyer replyer}}
<div class="btn-group  btn-group-sm"> 
<button class="btn btn-default" data-toggle="modal" data-target="#modifyModal" type="button" >수정</button>
</div> 
{{/eqReplyer}} 
<strong> &nbsp;&nbsp;{{prettifyDate regdate}} </strong> 
</span>
<span class="message">{{replytext}}</span>
</a>
</li>
{{/each}}
</script>

<script>
	/* 이거좀어렵다..;; */
	Handlebars.registerHelper("eqReplyer", function(replyer, block) {
		var accum = '';
		if (replyer == '${username}') {
			accum += block.fn();
		}
		return accum;
	});

	Handlebars.registerHelper("prettifyDate", function(timeValue) {
		var dateObj = new Date(timeValue);
		var year = dateObj.getFullYear();
		var month = dateObj.getMonth() + 1;
		var date = dateObj.getDate();
		return year + "/" + month + "/" + date;
	});

	var printData = function(replyArr, target, templateObject) {

		var template = Handlebars.compile(templateObject.html());

		var html = template(replyArr);
		$(".replyLi").remove();
		target.after(html);

	}

	function getPage(pageInfo) {

		$.getJSON(pageInfo, function(data) {
			printData(data.list, $("#repliesDiv"), $('#template'));
			printPaging(data.pageMaker, $(".pagination"));

			$("#modifyModal").modal('hide');
			$("#replycntSmall").html("[ " + data.pageMaker.totalCount + " ]");

		});
	}

	var printPaging = function(pageMaker, target) {

		var str = "";

		if (pageMaker.prev) {
			str += "<li><a href='" + (pageMaker.startPage - 1)
					+ "'> << </a></li>";
		}

		for (var i = pageMaker.startPage, len = pageMaker.endPage; i <= len; i++) {
			var strClass = pageMaker.cri.page == i ? 'class=active' : '';
			str += "<li " + strClass + "><a href='" + i + "'>" + i
					+ "</a></li>";
		}

		if (pageMaker.next) {
			str += "<li><a href='" + (pageMaker.endPage + 1)
					+ "'> >> </a></li>";
		}

		target.html(str);
	}
</script>

<script>
	$(document).ready(
			function() {

				var form = $("form[role='form']");
				var replyPage = 1;
				var bno = '<c:out value="${view.bno}"/>';
				var replyer = '<c:out value="${username}"/>';
				var header = $('meta[name="_csrf_header"]').attr('content');
				var token = $('meta[name="_csrf"]').attr('content');

				$('#bdelBtn').on(
						"click",
						function(event) {
							form.attr("action", "/board/remove").attr("method",
									"POST").submit();
						});

				$('#buptBtn').on(
						"click",
						function(event) {
							form.attr("action", "/board/modify").attr("method",
									"get").submit();
						});

				$('#listBtn').on(
						"click",
						function(event) {
							form.attr("action", "/board/list").attr("method",
									"get").submit();
						});

				$.getJSON("/board/getFile/" + bno, function(list) {

					var template = Handlebars.compile($("#getFile").html());

					$(list).each(function() {
						console.log(list);
						var fileInfo = getFileInfo(this);
						var html = template(fileInfo);
						$("#fileList").append(html);

					});
				});

				/* 댓글관련.. */
				getPage("/replies/" + bno + "/" + replyPage);
				
				$(".msg_list").on("click", ".replyLi", function(event) {
					var reply = $(this); 
					$("#replytext").val(reply.find('.message').text());
					$(".modal-title").html(reply.attr("data-rno")); 
				});
				
				$("#replyAddBtn").on("click", function() {
					var replytext = $("#newReplyText").val();
					
					$.ajax({
						type : 'post',
						url : '/replies/',
						beforeSend : function(xhr) {
							xhr.setRequestHeader(header, token);
						},
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "POST"
						},
						dataType : 'text',
						data : JSON.stringify({
							bno : bno,
							replyer : replyer,
							replytext : replytext
						}),
						success : function(result) {
							console.log("result: " + result);
							if (result == 'SUCCESS') {
								alert("등록 되었습니다.");
								replyPage = 1;
								getPage("/replies/" + bno + "/" + replyPage);
								$("#newReplyText").val("");
								window.location.reload();
							}
						}
					});
				});
				
				$("#replyModBtn").on("click", function() {
					
					var rno = $(".modal-title").html();
					var replytext = $("#replytext").val();
					console.log(rno);
					console.log(replytext);
					$.ajax({
						type : 'put',
						url : '/replies/' + rno,
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "PUT"
						},
						data : JSON.stringify({
							replytext : replytext
						}),
						dataType : 'text',
						success : function(result) {
							console.log("result: " + result);
							if (result == 'SUCCESS') {
								alert("수정 되었습니다.");
								getPage("/replies/" + bno + "/" + replyPage);
							}
						}
					});
				});

				$("#replyDelBtn").on("click", function() {

					var rno = $(".modal-title").html(); 
 					 $.ajax({
						type : 'delete',
						url : '/replies/' + rno,
						headers : {
							"Content-Type" : "application/json",
							"X-HTTP-Method-Override" : "DELETE"
						},
						dataType : 'text',
						success : function(result) {
							console.log("result: " + result);
							if (result == 'SUCCESS') {
								alert("삭제 되었습니다.");
								getPage("/replies/" + bno + "/" + replyPage);
							}
						}
					});  
				});
			});
</script>

<c:import url="../include/footer.jsp" />