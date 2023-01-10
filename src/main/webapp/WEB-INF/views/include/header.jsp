<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css"/>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>
<script>
// common js 로 분리할 부분
$(document).ready(function(){

  $(document)
  .on("click", ".login_menu .mypage", function(){
    $(".float_mymenu").css({        
      "left" : $(".login_menu").offset().left + 10 + "px",
      "top":$(this).offset().top + $(this).height()+ 16 + "px",
      "transform" : "translateX(-50%)"
    })
    $(".float_mymenu").fadeToggle("200");
  })

	/*  //채팅방 띄우기 2022.11.30 최동인  
  	$("#chat").on('click',function(e){
		e.preventDefault();
		window.open("${pageContext.request.contextPath}/chat","chat","width=500, height=800, top=200, left=200");
        // 경로, 파일, 너비, 높이, 위치 지정
	}) */
 
   
   
  }) // jquery ENDS
  
  // resize
  $(window).resize(function(){
    $(".float_mymenu").hide();
  })
</script>


<!-- HEADER BASIC -->
<header id="header">
  <div class="header_inner">
    <h1><a href="/petner"><img src="${imgPath}/header_logo.png" alt="logo"></a></h1>
    <nav id="gnb">
      <ul>
        <li><a href="${pageContext.request.contextPath}/findSitter">펫시터 찾기</a></li>
        <li><a href="${pageContext.request.contextPath}/findPet">돌봐줄 동물 찾기</a></li>
        <li><a href="${pageContext.request.contextPath}/list_notice">공지사항</a></li>
      </ul>
    </nav>
    <div class="login_menu">
      <ul>
      <!-- 관리자 페이지 이동 버튼 -->
      <c:if test="${authUser.user_type >= 9}">
      	<button class="admin_btn">
      		<a href="${pageContext.request.contextPath}/admin">admin</a>
      	</button>
      </c:if>
      <!-- 세션있을때  -->
      <c:if test="${not empty authUser}">
        <li class="in_session"><a class="heart transition02" href="${pageContext.request.contextPath}/chat" id = "chat"><i class="fa-solid fa-comment-dots"></i></a></li>
        <li class="in_session"><a class="alert transition02" href="#"><i class="fa-solid fa-bell"></i></a></li>
        <li class="in_session mypage"><a a class="my transition02" href="#"><i class="fa-solid fa-user"></i> </a></li>
			</c:if>
      <!-- 세션없을때 로그인 -->
      <c:if test="${empty authUser}">
        <li><a class="login" href="${pageContext.request.contextPath}/gologin">로그인</a></li> 
      </c:if>
      </ul>
    </div>
    <!-- 마이페이지 플로트메뉴 / 로그아웃 -->
    <div class="float_mymenu">
      <div>
        <p class="pb10"><b >${authUser.id}</b></p>
        <p class="flex_between">
          <span class="second">${authUser.email}</span>
          <a style="font-weight: 300;" class="second" href="${pageContext.request.contextPath}/mypage">마이페이지</a>
        </p>
      </div>

      <div class="flex_between">
        <div>
          <p class="second pb4">닉네임</p>
          <p>${authUser.nickname}</p>
        </div>
        <div>
          <p class="second pb4">등급</p>
          <p>${authUser.user_level}</p>
        </div>
      </div>
     
      <div><a href="${pageContext.request.contextPath}/logout">로그아웃</a></div>


    </div>      
     
	</div>  
</header>