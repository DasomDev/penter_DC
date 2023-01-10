<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>

<style>
    .intro{
	    max-width: 620px;
	    word-break: break-all;
	    line-height: 24px;
    }
</style>

<div class="content">
  
  <c:if test="${empty data}"> 
  	<div>
  		<p class="mb25">등록된 펫시터 정보가 없어요.</p>
  		<a href="${pageContext.request.contextPath}/sitterForm" class="pet_btn">펫시터 정보 등록하기</a>
  	</div>
  	
	</c:if>
	
	<c:if test="${not empty data}"> 
		<p class="menu_title">
	  	나의 펫시터 정보
	  	<a href="${pageContext.request.contextPath}/mypage/mySitterInfoEdit" class="icon"><i class="fa-solid fa-pen-to-square"></i></a>
	  </p>
	  <div class="data">
	    <p><span class="key">돌봄가능동물</span><span class="value">${data.pet_kind}</span></p>
	    <p><span class="key">돌봄가능요일</span><span class="value">${data.work_day}</span></p>
	    <p><span class="key">활동가능지역</span><span class="value">${data.addr} ${data.addr_detail} [${data.zipcode}]</span></p>
	    <p><span class="key">돌봄가능서비스</span><span class="value">${data.service}</span></p>
	    <p class="flex_col">
	    	<span class="key" style="padding-bottom:6px;">나의소개</span>
	    	<span class="value intro">${data.sitter_info}</span>
	    </p>
	  </div>   
	</c:if>
	
  
</div>