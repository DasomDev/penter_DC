<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css"/>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>

<!DOCTYPE html>
<html>
<head>
	<c:import url='/WEB-INF/views/include/common_head.jsp'/>
	<title>아이디 찾기</title>

</head>
<style>
	#findId input[type=text]{width:100%;}
	.desc{text-align:center; margin-bottom:35px;}
	.find_id{width:120px !important; text-align:center;}
	.flex_between{flex-wrap:nowrap}
	.submit_btn{	
		width: 200px;
		line-height: 30px;
		margin-top: 150px;
	}
</style>
<body>
  <div id="wrapper">
    <!-- HEADER BASIC -->
    <c:import url='/WEB-INF/views/include/header.jsp'/>
    <!-- CONTAINER -->

		<div class="container">
			<div class="w45">
				<h3 class="form_title">아이디찾기</h3>
				<div class="desc">
				<c:choose>
					<c:when test="${empty searchId}">
					<p class="mb10" style="color: red;">&#x1F645! 이름과 이메일을 다시 확인해주세요! &#x1F645</p>
					<a href="./findId"><p style="margin: 180px;">&#8592 돌아가기</p></a>
					</c:when>
					<c:otherwise>
					<p class="mb10"style="color: green;">&#x1F646 회원님의 ID는 ${searchId.id} 입니다. &#x1F646<p>
					<p></p>
					<a href="./findPass" class="pet_btn submit_btn transition02">비밀번호 찾기</a>
					</c:otherwise>
				</c:choose>
					
				</div>
				
			
			</div>
		</div>



		<!-- FOOTER BASIC -->
    <c:import url='/WEB-INF/views/include/footer.jsp'/>
    
  </div>
</body>
</html>