<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<head>
<link rel="stylesheet" href="${cssPath}/table.css">

</head>
<h3>방명록 글쓰기</h3>
<form action="insert_board" method="post" enctype="multipart/form-data" class="pn_write">
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
				<textarea class="fcc_textarea" name="content" class="need" title="내용"
					placeholder="내용을 입력하세요"></textarea>
			</div>

			<!-- 첨부 파일 영역 -->
			<div class="file_box">
				<p>첨부 파일</p>
				<div>
					<label> 
					<input type="file" name="file" id="attach-file" />
						<i class="fa-solid fa-file"></i>
					</label> 
					<span id="file-name"></span>
					<!-- 첨부파일 이미지 영역 -->
					<span id="preview"></span> 
					<span id="delete-file"
						style="color: red; margin-left: 20px;"> <i
						class="fas fa-times font-img"></i>
					</span>
				</div>
			</div>
		</div>
		<hr class="hr">

	</div>

	<div class="btnSet">
		<button type="submit" class="btn"
			onclick="if( necessary() ){ $('form').submit() }">저장</button>
		<a class="btn" href="list_board">취소</a>
	</div>
</form>
<script type="text/javascript">
	$('#attach-file')
			.on(
					'change',
					function() {
						var attach = this.files[0];
						if (attach) {
							if (isImage(attach.name)) {
								var img = "<img id='preview-img' class='file-img' src=''/>";
								$('#preview').html(img);

								var reader = new FileReader();
								reader.onload = function(e) {
									$('#preview-img').attr('src',
											e.target.result);
								}
								reader.readAsDataURL(attach);
							} else {
								$('#preview').html('')
							}
						}
					});

	$('#delete-file').on('click', function() {
		$('#preview').html('')
	});
</script>
<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
