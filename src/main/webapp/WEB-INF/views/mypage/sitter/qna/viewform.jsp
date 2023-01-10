<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<c:import url='/WEB-INF/views/include/common_head.jsp' />
<link rel="stylesheet" href="${cssPath}/table.css">
<title>${title}</title>
</head>
<body>
	<div id="wrapper">
		<!-- CONTAINER -->
		<div class="container w90">
			<div class="">
				<p class="list_title">QNA</p>
				<div class="pn_view">
					<div class="title">
						<h1>${article.qna_title }</h1>
					</div>
					<div class="source">
						<div>
							<span>by</span>${article.user_id }
						</div>
						<div class="data_box d-flex">
							<div>
								<c:if test="${article.file_no!=null }">
									<!-- 첨부파일 다운로드 -->
										첨부파일 <a href="qna_download?qnaNum=${article.qna_no}"> <%-- ${article.file_no} --%>
										<i class="fas fa-download font-img"></i>
									</a>
								</c:if>
							</div>
							&nbsp;&nbsp;&nbsp;
							<div>
								<!-- day -->
								${article.reg_date }
							</div>
						</div>
					</div>

					<hr>

					<section id="articleForm">
						<section id="articleContentArea">
							<div id="image_preview">
								<img id="rep" class="img_wrap img"
									src="${pageContext.request.contextPath}/resources${article.filepath}"
									alt="사진영역" />
									
							</div>
							<div class="content">${article.qna_content }</div>
						</section>
					</section>
					<hr>
					<section class="buttonList">
						<div class="d-grid gap-2 d-md-block ad_button">
						
							<!-- user_id 작성자만 수정할수있음 -->
							<c:if test="${authUser.id == article.user_id}">
								<button class="btn btn-outline-secondary" type="button">
									<a class="admin_btn"
										href="qnamodifyform?qna_no=${article.qna_no}">수정</a>
								</button>
							</c:if>

							<!-- 관리자만 답변가능 -->
							<c:if test="${authUser.user_type >= 9}">
								<button class="btn btn-outline-secondary" type="button">
									<a href="qnareplyform?qna_no=${article.qna_no}">답변</a>
								</button>
							</c:if>
							
							<!-- user_id 작성자 or 관리자만 삭제가능 -->
							<c:if test="${authUser.id == article.user_id || authUser.user_type >= 9}">
								<button class="btn btn-outline-secondary" type="button">
									<a class="admin_btn" href="qnadeleteform?qna_no=${article.qna_no}">삭제</a>
								</button>
							</c:if>
							
							<button class="btn btn-outline-secondary" type="button">
								<a class="admin_btn" href="./qnaList">목록</a>
							</button>
						</div>
					</section>
				</div>
			</div>
		</div>
	</div>
</body>
</html>

<script>
$(document).ready(function() {
	//이미지 미리보기
	$(function() {
		$('#image_preview').change(function(event) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#rep').attr('src', e.target.result);
			};
			reader.readAsDataURL(event.target.files[0]);	
		});
	})
});
</script>