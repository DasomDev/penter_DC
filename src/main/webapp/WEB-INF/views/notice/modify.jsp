<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<!DOCTYPE html>
<html>
<head>
<!-- font-awesome -->
<link rel="stylesheet" href="${pluginsPath}/font-awesome/all.min.css">
<script src="${pluginsPath}/font-awesome/all.min.js"></script>
<link rel="stylesheet" href="${cssPath}/table.css">
<meta charset="UTF-8">
</head>
<body>
	<div id="wrapper">
		<!-- CONTAINER -->
		<div class="container w90">
			<div class="">
				<p class="list_title">공지 글 수정</p>
				<div class="formbox">
					<form action="update_notice" method="post" class="pn_write"
						enctype="multipart/form-data">
						<input type="hidden" name="id" value="${vo.id }" /> <input
							type="hidden" name="attach" />

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
									placeholder="제목을 입력하세요." value="${vo.title }" />
							</div>
							<hr class="hr">
							<div class="content">
								<!-- 첨부된 이미지 보여주기 -->
								<c:if test="${!empty vo.filename }">
									<div class="preview">
										<img src="resources/${vo.filepath }" class="img3"
											style="width: 100%;" />
									</div>
								</c:if>

								<div>
									<textarea class="fcc_textarea" name="content" class="need"
										title="내용" placeholder="내용을 입력하세요">${vo.content }</textarea>
								</div>

								<!-- 첨부 파일 영역 -->
								<div class="file_box">
									<p>첨부 파일</p>
									<div>
										<label> <input type="file" name="file"
											id="attach-file" /> <i class="fa-solid fa-file"></i>
										</label> <span id="file-name">${vo.filename }</span>
										<!-- 첨부파일 이미지 영역 -->
										<span id="preview"></span> <span id="delete-file"
											style='display:${empty vo.filename ? "none" : "inline"}; color:red; margin-left:20px;'>
											<i class="fas fa-times font-img"></i>
										</span>
									</div>
								</div>
							</div>
							<hr class="hr">
							<div class="btnSet">
								<a class="pet_btn btn-fill"
									onclick="if( necessary() ) { $('[name=attach]').val($('#file-name').text()); $('form').submit(); }">저장</a>
								<a class="pet_btn btn-empty" href="detail_notice?id=${vo.id }">취소</a>
								<!-- <a class="btn-empty" href="javascript:history.go(-1)">취소</a> -->
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 실시간 갱신을 위해 getTime을 붙여준다 -->
	<script type="text/javascript"
		src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
	<script type="text/javascript"
		src="js/need_check.js?v=<%=new java.util.Date().getTime()%>"></script>
	<script type="text/javascript" src="js/file_attach.js"></script>
</body>
</html>