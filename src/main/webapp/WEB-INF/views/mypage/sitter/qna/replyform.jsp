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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet">
<c:import url='/WEB-INF/views/include/common_head.jsp' />
<link rel="stylesheet" href="${cssPath}/table.css">
<style type="text/css">
table {
	margin: auto;
	width: 450px;
}

.td_left {
	width: 150px;
	background: orange;
}

.td_right {
	width: 300px;
	background: skyblue;
}

#commandCell {
	text-align: center;
}

textarea {
	width: 100%;
	border: 1px solid #ced4da;
	border-radius: 0.375rem;
	max-height: 150px;
}
</style>

<meta charset="UTF-8" />
<title>MVC 게시판</title>

</head>
<body>
	<!-- 게시판 답변 -->
	<!-- QNA 글 등록 -->
	<div id="wrapper">
		<!-- CONTAINER -->
		<div class="container w90">
			<div class="">
				<p class="list_title">QNA 답변</p>
				
				<form action="qnareply" method="post" name="qnaform">
			<input type="hidden" name="page" value="${page}" /> 
			<input
				type="hidden" name="qna_no" value="${qnaNum}">
				
				파일첨부
				<td class="left">
					<label>
						<input type="file" name="file" id="attach-file" />
						<img src="img/select.png" class="file-img" />
					</label>
					<span id="file-name"></span>
					<span id="delete-file" style="color: red; margin-lefT: 20px;"><i class="fas fa-times font-img" ></i></span>
 				</td>
 				
 				<div class="row user_id">
					<div>
					<!-- 글쓴이 -->
						<span class="by">by</span><input name="user_id" id="user_id"
								value="${authUser.id}">
						</div>
					</div>
					<hr>
					
					<!-- title 제목 -->
					<div class="title">
						<input type="text" name="qna_title" id="qna_title"
							required="required" placeholder="제목을 입력하세요" aria-label="제 목"
							aria-describedby="addon-wrapping">
					</div>
					<hr>
					
					<!-- content 글내용 -->
					<div class="content">
						<textarea class="fcc_textarea" id="qna_content" name="qna_content"
							cols="40" rows="15" required="required" placeholder="내용을 입력하세요"></textarea>
					</div>

					<hr>
					<section id="commandCell">
						<div class="d-grid gap-2 d-md-block">
							<button type="submit" class="btn btn-outline-secondary">등록</button>
							<button type="reset" class="btn btn-outline-secondary">다시쓰기</button>
						</div>
					</section>
 			
				</form>
			</div>
		</div>
	</div>


	
</body>
</html>