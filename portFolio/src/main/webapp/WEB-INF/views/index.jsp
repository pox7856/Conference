<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:import url="include/header.jsp" />
<!-- page content -->
<div class="right_col" role="main">
	<div class="">
		<div class="clearfix"></div>
		<div class="row">
			<div class="col-md-12 col-sm-12 col-xs-12">
				<div class="x_panel">
					<div class="x_title">
						<h2>미니 채팅방</h2>
						<div class="clearfix"></div>
					</div>
					<div class="x_content">
						<div class="bs-callout" id="messages">
						
							<p>&nbsp;</p>
						</div>
						<div class="bs-callout">
							<form>
								<div class="form-group">
									<input class="form-control" id="userName" placeholder="이름"
										type="text">
								</div>
								<div class="form-group">
									<textarea class="form-control" id="message" placeholder="메시지"
										rows="3"></textarea>
								</div>
								<div class="form-group">
									<button class="btn btn-primary btn-lg btn-block"
										id="sendMessage" type="button">메시지 전송</button>
								</div>
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script src="${contextPath}/resources/js/sockjs-1.1.1.min.js"></script>  
<script src="${contextPath}/resources/js/json2.js"></script>   
<script type="text/javascript"> 
    $(document).ready(function () {
        
    	var chatSock = null;
        // 페이지가 시작됨과 동시에 소켓 서버 주소로 접속한다.
        chatSock = new SockJS("/echo");
        chatSock.onopen = function () {
             
            message = {};
            message.message = "반갑습니다~";
            message.type = "all";
            message.to = "all";
             
            chatSock.send( JSON.stringify(message) );
        };
         
        chatSock.onmessage = function (evt) {
            $("#messages").append(evt.data + "<br/>");
            $("#messages").scrollTop(99999999);
        };
         
        chatSock.onclose = function () {
            //chatSock.send("10.225.152.164 퇴장합니다");
        };
         
        $("#message").keydown(function (key) {
            if (key.keyCode == 13) {
                $("#sendMessage").click();
            }
        });
         
        $("#sendMessage").click(function () {
            if ( $("#message").val() != "") {
                message = {};
                message.message = $("#message").val();
                message.type = "all";
                message.to = "all"
                 
                var to = $("#to").val();
                if (to != "" ) {
                    message.type = "one";
                    message.to = to;
                } 
                
                chatSock.send( JSON.stringify(message) );
                $("#messages").append("user : "+$('#userName').val() + "<p>&nbsp;&nbsp;" +  $('#message').val() + "</p>");
                $("#messages").scrollTop(99999999);
                $("#message").val("");
            }
        });
    });
</script>
<!-- /page content -->
<c:import url="include/footer.jsp" />