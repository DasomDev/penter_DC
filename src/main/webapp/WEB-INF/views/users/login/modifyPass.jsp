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
	.submit_btn{
		width: 200px;
		line-height: 30px;
		margin: auto;
		}
	.flex_col { 
		width: 260px;
    	margin: 0 auto;
    	}
</style>
  <script src= "https://code.jquery.com/jquery-3.4.1.js"></script>
  <script>
  function checkPass() {
	//비밀번호 유효성검사
	  var password =$("#password").val();          //비밀번호 입력값
	  var ck_password = $("#ck_password").val();   //비밀번호 체크 입력값
	  var acceptPass = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/; 
	  
	  if(!password){
	  	$('#checkpass-msg').text("비밀번호를 입력해주세요").css("color", "red");
	    $("#password").focus();
	    return false;
	    
	  }if(!acceptPass.test(password)){
			$('#checkpass-msg').text("비밀번호는 영어+숫자+특수문자를 조합해야 합니다(8자 이상)").css("color", "red");
		    $("#password").focus();
		  return false;
		  
	  }if(!ck_password){
	  	$('#checkpass-msg').text("비밀번호 확인을 입력해주세요").css("color", "red");
	    $("#ck_password").focus();
	    return false;
	    
	  }if(password !== ck_password){
	  	$('#checkpass-msg').text("비밀번호가 일치하지 않습니다").css("color", "red");
	      $("#password").focus();
	      return false;
 	  }else{
		$('#checkpass-msg').text("사용가능한 비밀번호입니다.").css("color", "green");
		return true;
	  }
  }
  
  $(function () {
	   $('#updateForm').submit(function() {
		
			  });
  });
  
	  
	  
 </script>

<body>
  <div id="wrapper">
    <!-- HEADER BASIC -->
    <c:import url='/WEB-INF/views/include/header.jsp'/>
    <!-- CONTAINER -->

		<div class="container">
			<div class="w45">
				<c:choose>
				<c:when test="${empty searchPass}">
				<h3 class="form_title">회원정보조회 실패</h3>
				<div class="desc">
					<p class="mb10" style="color: #FFA6CF;">🤔 아이디와 비밀번호를 다시 확인해주세요! 🤔</p>
					<a href="${pageContext.request.contextPath}/checkPass"><p style="margin: 180px;">&#8592 돌아가기</p></a>
					</div>
					</c:when>
					<c:otherwise>
					<h3 class="form_title">회원정보조회 성공</h3>
					<form action= "${pageContext.request.contextPath}/modifyPass" method="POST" id="updateForm" onsubmit="return checkPass()" >
					<div class="desc">
					<p class="mb10" style="color:#C4B4E1;">&#128568 새로운 비밀번호를 입력해주세요! &#128568
					</p>
							<div class="f_row flex_col mb20" style= "width:200px; text-align:center;" >
								<p class="fc_title" style= "text-align: left; color:#646496;">새 비밀번호</p>
								<input type="hidden" name="id" value="${searchPass.id}">
								<input class="mb10" type="password" name="password" id="password" placeholder="비밀번호입력" /> 
							    <input type="password" name="ck_password" id="ck_password" placeholder="비밀번호확인" />
							    <p><small id="checkpass-msg" class="form-error"></small></p>
							</div>
							</div>
						<div class="f_row" style="text-align:center;">
						<input type="submit" class="pet_btn submit_btn transition02" value="비밀번호 변경"/>
						</div>		
						</form>		
					</c:otherwise>
				</c:choose>
					
				
				
			
			</div>
		</div>



		<!-- FOOTER BASIC -->
    <c:import url='/WEB-INF/views/include/footer.jsp'/>
    
  </div>
</body>
</html>