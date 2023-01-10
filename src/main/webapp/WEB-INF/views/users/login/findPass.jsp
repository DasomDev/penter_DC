<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css"/>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>

<!DOCTYPE html>
<html>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script>


	$(function(){
		$("#findBtn").click(function(){
			
			$("#close_btn").click(function(){
				$(".modal").hide();
			})
			$("#x_button").click(function(){
				$(".modal").hide();
			})
			
			$.ajax({
				url : "http://localhost:8088/petner/findPass",
				type : "POST",
				data : {
					id : $("#id").val(),
					email : $("#email").val()
				},
				success : function(message) {
					
					$(".modal").show();
					$("#modal_msg").text(message);
				},
			})
		});
	});
</script>

<head>
<style>
	#findId input[type=text] {
		width: 100%;
	}
	
	.desc {
		text-align: center;
		margin-bottom: 35px;
	}
	
	.find_id {
		width: 120px !important;
		text-align: center;
	}
	
	.flex_between {
		flex-wrap: nowrap
	}
	
	.two_btn {
		padding: 20px;
		width: 200px;
		line-height: 20px;
		margin: auto;
	}
	.id_email{
	    width: 260px;
    	margin: 0 auto;
    }
	
	.modal {
		position: absolute;
		top: 0;
		left: 0;
		display: none;
		width: 100%;
		height: 100%;
		background-color: rgba(0, 0, 0, .5);
	}
	
	.modal.show {
		display: block;
	}
	
	.modal_body {
		position: absolute;
		top: 30%;
		left: 50%;
		width: 280px;
		height: 100px;
		padding: 40px;
		background-color: rgb(255, 255, 255);
		border-radius: 10px;
		box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);
		transform: translateX(-50%) translateY(-50%);
	}
	
	.modal_btn {
		position: absolute;
		top: 50%;
		left: 70%;
		width: 280px;
		height: 100px;
		padding: 40px;
	}
</style>
<c:import url='/WEB-INF/views/include/common_head.jsp'/>
	<title>비밀번호 찾기</title>
</head>
<body>
  <div id="wrapper">
    <!-- HEADER BASIC -->
    <c:import url='/WEB-INF/views/include/header.jsp'/>
    <!-- CONTAINER -->
    
    <div class="container">
			<div class="w45">
				<h3 class="form_title">비밀번호 찾기</h3>
				<div class="desc">
					<p class="mb10">가입한 아이디와 이메일로 임시비밀번호를 받을 수 있습니다.</p>
					<p class="tip">아이디와 이메일 정보를 입력해주세요.</p>
				</div>
				<div class="id_email">
					<div class="f_row">
						<p class="fc_title">아이디</p>
						<input type="text" placeholder="아이디" name="id" id="id" />
					</div>					
					<div class="f_row">
						<p class="fc_title">이메일</p>
						<div class="flex_between">
							<input type="text" placeholder="E-mail" name="email" id="email" class="mr12"/>
						</div>
					</div>
				</div>
				
				<div class=two_btn>
				<div class="f_row" style="text-align:center;">
					<button type="button" id="findBtn" class="pet_btn submit_btn transition02">이메일 전송</button>
					
				</div>		
				
				<div class="f_row" style="text-align:center;">
					<a href="${pageContext.request.contextPath}/checkPass" class="pet_btn submit_btn transition02" style= "background-color:#A0A0C8;">비밀번호변경</a> 
					
				</div>						
				</div>

			</div>

	</div>
	
	  <div class="modal">
				<div class="modal_body">
						<button class="" id="x_button" style= "color: black; cursor:pointer; background-color:white; margin: -35px 50px 0px 300px; position:absolute ">❌</button>
							<p style="color: #FF9614; ">Petner &#128062</p>
						
							<p id="modal_msg" style="padding: 15px 0px 0px 15px;"> </p>
						
						<div class="modal_btn">
							<button class="pet_btn" id="close_btn" style= "background-color:#FF9614;">닫기</button>
						</div>
				</div>				
   		  </div>
	

		
	
		<!-- FOOTER BASIC -->
    <c:import url='/WEB-INF/views/include/footer.jsp'/>
    
  </div>
</body>
</html>