<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />


<header class="navbar navbar-bark sticky-top bg-white p-0 border-bottom">
	<a class="navbar-brand col-md-3 col-lg-2 me-0 px-3 fs-6" href="${pageContext.request.contextPath}/admin">
	</a>
	<button class="navbar-toggler position-absolute d-md-none collapsed"
		type="button" data-bs-toggle="collapse" data-bs-target="#sidebarMenu"
		aria-controls="sidebarMenu" aria-expanded="false"
		aria-label="Toggle navigation">
		<span class="navbar-toggler-icon"></span>
	</button>
	<!-- <input class="form-control form-control-dark w-100 rounded-0 border-0" type="text" placeholder="Search" aria-label="Search"> -->
	<div class="navbar-nav">
	
		<div class="admin_header d-md-flex d-none">
			<!-- 세션있을때  -->
			<c:if test="${not empty authUser}">
				<!-- 관리자 일때 -->
				<c:if test="${authUser.user_type >= 9}">
				<div>관리자 <span>${authUser.name}</span> 님 환영합니다.</div>
				</c:if>
					<button class="header_btn"><a class="nav-link px-3" href="${pageContext.request.contextPath}/">서비스 메인</a></button>
					<button class="header_btn"><a class="nav-link px-3" href="${pageContext.request.contextPath}/logout">Sign out</a></button>
	      	</c:if>
	      	
			<!-- 세션없을때 로그인 -->
	      	<c:if test="${empty authUser}">
	        	<li><a class="login" href="${pageContext.request.contextPath}/gologin">로그인</a></li> 
	      	</c:if>
      	</div>
      	
	</div>
</header>