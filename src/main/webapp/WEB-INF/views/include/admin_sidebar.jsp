<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />


		<!-- ********** side bar menu ********** -->
		<nav id="sidebarMenu"
			class="col-md-3 col-lg-2 d-md-block bg-light sidebar collapse">
			<div class="flex-shrink-0 p-3">

				<div class="admin_header d-md-none">
					<!-- 세션있을때  -->
					<c:if test="${not empty authUser}">
						<!-- 관리자 일때 -->
						<c:if test="${authUser.user_type >= 9}">
						<div>관리자 <span>${authUser.name}</span> 님 환영합니다.</div>
						</c:if>
						<div class="sidebar_btn">
							<button class="header_btn"><a class="nav-link px-3" href="${pageContext.request.contextPath}/">서비스 메인</a></button>
							<button class="header_btn"><a class="nav-link px-3" href="${pageContext.request.contextPath}/logout">Sign out</a></button>
			      		</div>
			      	</c:if>
			      	
					<!-- 세션없을때 로그인 -->
			      	<c:if test="${empty authUser}">
			        	<li><a class="login" href="${pageContext.request.contextPath}/gologin">로그인</a></li> 
			      	</c:if>
			      	<hr>
      			</div>
      			

				<ul class="list-unstyled ps-0">
					<li class="mb-2">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#home-collapse"
							aria-expanded="false">
							<span data-feather="home" class="align-text-bottom"></span> Home
						</button>
					</li>
					<li class="mb-2">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#user-collapse"
							aria-expanded="false">
							<span data-feather="layers" class="align-text-bottom"></span>
							회원정보관리
						</button>
						<div class="collapse" id="user-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="./admin_user"
									class="link-dark d-inline-flex text-decoration-none rounded">회원정보관리</a></li>
								<li><a href="./black_user"
									class="link-dark d-inline-flex text-decoration-none rounded">블랙리스트</a></li>
							</ul>
						</div>
					</li>

					<!-- <li class="border-top my-3"></li> -->
					<li class="mb-2">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#table-collapse"
							aria-expanded="false">
							<span data-feather="layers" class="align-text-bottom"></span>
							게시판관리
						</button>
						<div class="collapse" id="table-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="./ad_list_notice"
									class="link-dark d-inline-flex text-decoration-none rounded">공지사항 관리</a></li>
									<li><a href="./ad_list_board"
									class="link-dark d-inline-flex text-decoration-none rounded">이벤트 관리</a></li>
									<li><a href="./ad_list_qna"
									class="link-dark d-inline-flex text-decoration-none rounded">QNA 관리</a></li>
								
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</nav>
		<!-- --------- side bar menu --------- -->