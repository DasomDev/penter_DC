<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<head>
<!-- font-awesome -->
<link rel="stylesheet" href="${pluginsPath}/font-awesome/all.min.css">
<script src="${pluginsPath}/font-awesome/all.min.js"></script>
<link rel="stylesheet" href="${cssPath}/table.css">
<meta charset="UTF-8">
</head>

<!-- 세션있을때  -->
<c:if test="${not empty authUser}">
	<!-- 관리자 일때 -->
	<c:if test="${authUser.user_type >= 9}">

		<!-- 공지사항 리스트 -->
		<div class="card ad_card mb-4">
			<div class="card-body">
				<h2 class="card-title">신규 공지 글</h2>
				
				<div class="formbox">
<!-- - 파일 첨부 시 form 반드시 갖고 있어야 할 속성 
	1. 반드시 method는 post이어야만 한다.
	2. enctype을 지정한다. ▶ enctype='multipart/form-data' -->
					<form action="ad_reply_insert_notice" method="post" class="pn_write" enctype="multipart/form-data">
						<input type="hidden" name="root" value="${vo.root }" /> <input
							type="hidden" name="step" value="${vo.step }" /> <input
							type="hidden" name="indent" value="${vo.indent }" />

						
						<div class="pn_view">
							<div class="row user_id">
								<div>
									<span class="by">by</span>
									<div>${authUser.name }</div>
								</div>
							</div>
							<hr class="hr">
							<!-- title 제목 -->
							<div class="title">
								<input type="text" name="title" class="need" title="제목"
									placeholder="제목을 입력하세요." />
							</div>
							<hr class="hr">
							<div class="content">
								<!-- 사진영역 -->
								<div id="image_preview">
									<span id="preview"></span>
								</div>
								<div>
									<textarea class="fcc_textarea" name="content" class="need"
										title="내용" placeholder="내용을 입력하세요"></textarea>
								</div>

								<!-- 첨부 파일 영역 -->
								<div class="file_box">
									<p>첨부 파일</p>
									<div>
										<label> <input type="file" name="file"
											id="attach-file" /> <img src="${imgPath}/select.png"
											class="file-img" />
										</label> <span id="file-name"></span>
										<!-- 첨부파일 이미지 영역 -->
										<span id="preview"></span> <span id="delete-file"
											style="color: red; margin-left: 20px;"> <i
											class="fas fa-times font-img"></i>
										</span>
									</div>
								</div>
							</div>
							<hr class="hr">
							<div class="btnSet">
								<a class="btn" onclick="if(necessary()) $('form').submit()">저장</a>
								<a class="btn" href="list_notice">취소</a>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	<!-- 관리자 일때.end -->
	</c:if>

	<!-- 관리자 아닐때 -->
	<c:if test="${authUser.user_type < 9}">
		<c:import url='/WEB-INF/views/include/not_admin.jsp' />
	</c:if>
</c:if>

<!-- 세션없을때 -->
<c:if test="${empty authUser}">
	<c:import url='/WEB-INF/views/include/not_users.jsp' />
</c:if>
	<!-- 실시간 갱신을 위해 getTime을 붙여준다 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/need_check.js?v=<%=new java.util.Date().getTime() %>"></script>
	<script type="text/javascript" src="js/file_attach.js"></script>
</body>
</html>

