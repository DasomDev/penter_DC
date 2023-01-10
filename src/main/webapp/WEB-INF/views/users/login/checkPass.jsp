<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<!DOCTYPE html>
<html>
<head>
<c:import url='/WEB-INF/views/include/common_head.jsp' />
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>


	$(function() {

		$('#checkPass').submit(function() {

		});

	});//function ready 끝
</script>
</head>
<style>
	#findId input[type=text]{width:100%;}
	.desc{text-align:center; margin-bottom:35px;}
	.find_id{width:120px !important; text-align:center;}
	.flex_between{flex-wrap:nowrap}
	.submit_btn{	
		width: 200px;
		line-height: 30px;
		margin: auto; }
	.id_pass {    
		width: 260px;
    	margin: 0 auto;
    	}
</style>
<body>
	<div id="wrapper">
		<!-- HEADER BASIC -->
		<c:import url='/WEB-INF/views/include/header.jsp' />
		<!-- CONTAINER -->

		<div class="container">
			<div class="w45">
				<h3 class="form_title">비밀번호변경</h3>
				<form action="./checkPass" id="checkPass" method="POST">
				<div class="desc">
					<p class="mb10">현재 비밀번호를 새 비밀번호로 변경합니다.</p>
					<p class="tip">아이디와 기존 비밀번호를 입력해주세요.</p>
				</div>
				
				<div class="id_pass">
				<div class="f_row" style="width:20px;">
					<p class="fc_title">아이디</p>
					<input type="text" placeholder="아이디" name="id" id="id" />
				</div>
				<div class="f_row">
					<p class="fc_title">비밀번호</p>
					<div class="flex_between">
						<input type="password" placeholder="" name="password" id="password" class="mr12"/>
					</div>
				</div>
				</div>
				<div class="f_row" style="text-align:center; margin-top:20px">
					<input type="submit" class="pet_btn submit_btn transition02" value="비밀번호 변경"/>
				</div>				
			</form>
			
			</div>
			
			

		</div>



		<!-- FOOTER BASIC -->
		<c:import url='/WEB-INF/views/include/footer.jsp' />

	</div>
</body>
</html>