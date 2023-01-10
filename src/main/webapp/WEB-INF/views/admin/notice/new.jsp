<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<!-- 세션있을때  -->
<c:if test="${not empty authUser}">
	<!-- 관리자 일때 -->
	<c:if test="${authUser.user_type >= 9}">

		<!-- 공지사항 리스트 -->
		<div class="card ad_card mb-4">
			<div class="card-body">
				<h2 class="card-title">공지사항 글쓰기</h2>
				<div class="formbox">
					<form action="ad_insert_notice" method="post" class="pn_write"
						enctype="multipart/form-data">
						<div class="pn_view">
							<div class="title">
								<h1>
									<input type="text" name="title" class="need" title="제목"
										placeholder="제목을 입력하세요." />
								</h1>
							</div>
							<div class="source">
								<div>
									<span>by</span>${authUser.name }
								</div>
							</div>
							<hr class="hr">
							<span id="preview"></span>
							<div class="content">
								<!-- 사진영역 -->
								<div id="image_preview">
									<span id="preview"></span>
								</div>
								<div>
									<textarea class="fcc_textarea" name="content" class="need"
										title="내용" placeholder="내용을 입력하세요"></textarea>
								</div>

								<div class="file_box">
									<p>첨부 파일</p>
									<div>
										<label> <input type="file" name="file"
											id="attach-file" /> <i class="fa-solid fa-file"></i>
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
								<a class="btn btn-outline-secondary" onclick="if(necessary()) $('form').submit()">저장</a>
								<a class="btn btn-outline-secondary" href="list_notice">취소</a>
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
<!-- 실시간 갱신을 위해 getTime을 붙여준다 -->
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
<script type="text/javascript"
	src="js/need_check.js?v=<%=new java.util.Date().getTime()%>"></script>
<script type="text/javascript" src="js/file_attach.js"></script>
</body>
</html>