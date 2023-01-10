<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<style>
textarea {
	width: 100%;
	border: 1px solid #ced4da;
	border-radius: 0.375rem;
	max-height: 150px;
} 
</style>
<!-- 게시판 등록 -->
<div class="card ad_card mb-4">
	<div class="card-body">
		<h2 class="card-title">공지사항 글수정</h2>
		<form action="qnamodify" method="post" name="modifyform">
			<input type="hidden" name="notice_no" value="${article.qna_no}" />

			<div class="input-group flex-nowrap">
				<span class="input-group-text" id="addon-wrapping">글쓴이</span> <input
					type="text" class="form-control" name="user_id" id="user_id"
					required="required" placeholder="${article.qna_no}"
					aria-label="이름" aria-describedby="addon-wrapping">
			</div>

			<!-- <div class="input-group flex-nowrap">
				<span class="input-group-text" id="addon-wrapping">비밀번호</span> <input
					type="password" class="form-control" name="board_pass"
					id="board_pass" required="required" placeholder="****"
					aria-label="****" aria-describedby="addon-wrapping">
			</div> -->

			<div class="input-group flex-nowrap">
				<span class="input-group-text" id="addon-wrapping">제 목</span> <input
					type="text" class="form-control" name="qna_title"
					id="qna_title" required="required"
					placeholder="${article.qna_title}" aria-label="제 목"
					aria-describedby="addon-wrapping" value="${article.qna_title}">
			</div>

			<div class="input-group flex-nowrap">
				<textarea id="qna_content" name="qna_content" cols="40"
					rows="15" required="required">
					${article.qna_content}
				</textarea>
			</div>

			<div class="input-group flex-nowrap">
				<span class="input-group-text" id="addon-wrapping">글쓴이</span> <input
					type="text" class="form-control" name="user_id" id="user_id"
					required="required" placeholder="${article.qna_no}"
					aria-label="이름" aria-describedby="addon-wrapping">
			</div>


			<section id="commandCell">
				<div class="d-grid gap-2 d-md-block">
					<button type="submit" class="btn btn-outline-secondary">
						<a href="javascript:modifyqna()">수정</a>
					</button>
					<button type="reset" class="btn btn-outline-secondary">
						<a href="javascript:history.go(-1)">뒤로</a>
					</button>
				</div>
			</section>
		</form>
	</div>
</div>
