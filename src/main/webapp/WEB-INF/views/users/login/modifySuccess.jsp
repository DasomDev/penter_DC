<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css"/>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>

<!DOCTYPE html>
<html>
<head>
	<c:import url='/WEB-INF/views/include/common_head.jsp'/>
	<title>비밀번호수정</title>

</head>
<style>
	#findPass input[type=text]{width:100%;}
	.desc{text-align:center; margin-bottom:45px;}
	.find_id{width:120px !important; text-align:center;}
	.flex_between{flex-wrap:nowrap}
	.submit_btn{position: relative; top:150px; width:200px;}
	.flex_col {position:absolute; top:42%; left:42%;}
</style>
<body>
  <div id="wrapper">
    <!-- HEADER BASIC -->
    <c:import url='/WEB-INF/views/include/header.jsp'/>
    <!-- CONTAINER -->

		<div class="container">
			<div class="w45">
				
				<h3 class="form_title">비밀번호 수정완료</h3>
				<div class="desc">
					<p class="mb10" style="color: #AD19EC;">&#127881 비밀번호가 성공적으로 수정되었습니다. &#127881 </p>
					<p class="mb10" style="color: #FF88A7;">&#128571 새로운 비밀번호로 로그인 해주세요. &#128571</p>
					
					</div>
						
			
			</div>
		</div>



		<!-- FOOTER BASIC -->
    <c:import url='/WEB-INF/views/include/footer.jsp'/>
    
  </div>
</body>
</html>