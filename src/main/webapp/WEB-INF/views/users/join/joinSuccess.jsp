<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css"/>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>

<!DOCTYPE html>
<html>
<head>
	<c:import url='/WEB-INF/views/include/common_head.jsp'/>
	<title>회원가입 성공!</title>

</head>
<style>
	#findId input[type=text]{width:100%;}
	.desc{text-align:center; margin-bottom:35px;}
	.find_id{width:120px !important; text-align:center;}
	.flex_between{flex-wrap:nowrap}
	.submit_btn{position: relative; top:180px;}
</style>
<body>
  <div id="wrapper">
    <!-- HEADER BASIC -->
    <c:import url='/WEB-INF/views/include/header.jsp'/>
    <!-- CONTAINER -->

		<div class="container">
			<div class="w45">
				<h3 class="form_title">회원가입 성공</h3>
				<div class="desc">	
				<c:choose>
				<c:when test="${users.user_type ==2}">
					<p class="mb10" style="color:#ADD8E6;">[💁🏻‍♂️ 보호자]</p>
					<p class="mb10" style="color: orange;">&#128054 ${users.id}님의 가입을 축하드립니다! &#128049</p>
					</c:when>
					<c:otherwise>
					<p class="mb10"style="color:#ADD8E6;">[🙋 펫시터]<p>
					<p class="mb10" style="color: orange;">&#128054 ${users.id}님의 가입을 축하드립니다! &#128049</p>
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