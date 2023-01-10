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
<script>
	//이미지 미리보기
	$(document).ready(function() {
		$('#attach-file').change(function(event) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#rep').attr('src', e.target.result);
			};
			reader.readAsDataURL(event.target.files[0]);
		});
	});
</script>
<body>
	<!-- QNA 글 등록 -->
	<div id="wrapper">
		<!-- CONTAINER -->
		<div class="container w90">
			<div class="">
				<p class="list_title">QNA 글 등록</p>

				<form action="./qnawrite" method="post"
					enctype="multipart/form-data" name="qnawriteform" class="pn_write">

					<!-- <input name="file" type="file" id="file_no" /> -->

					<!-- 사진 업로드 -->
					<!-- <div class="f_row profile_upload">
						<p class="fc_title">사진을 올려주세요</p>
						<div class="profile_upload_square">
							<div class="prof_img">
								<img id="qnaImg"> <br> <label for="file"
									class="pet_btn edit_btn"> <i class="fa-solid fa-pen"
									id="pen"></i>
								</label> <input type="file" id="file_no" name="file" hidden="hidden"></input>
							</div>
						</div>
					</div> -->
					<!-- 사진 업로드.end -->

					<div class="pn_view">
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
					
					<!-- <div class="input-group flex-nowrap">
				<span class="input-group-text" id="addon-wrapping">비밀번호</span> <input
					type="password" class="form-control" name="board_pass"
					id="board_pass" required="required" placeholder="****"
					aria-label="****" aria-describedby="addon-wrapping">
			</div> -->

					<!-- content 글내용 -->
					<div class="content">
					
					<c:if test="${!empty ('#attach-file')}">
					<div id="image_preview">
					<img id="rep" class="img_wrap img"
									src="${pageContext.request.contextPath}/resources${article.filepath}"
									alt="사진영역" />
						</div>
					</c:if>
						
						<textarea class="fcc_textarea" id="qna_content" name="qna_content"
							cols="40" rows="15" required="required" placeholder="내용을 입력하세요"></textarea>
						<div class="data_box d-flex">
							<p>파일첨부</p>
							<label> <input type="file" name="file" id="attach-file" />

							</label> <span id="file-name"></span> <span id="delete-file"
								style="color: red; margin-lefT: 20px;"><i
								class="fas fa-times font-img"></i></span>
						</div>
					</div>

					<hr>
					</div>
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