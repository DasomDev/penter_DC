<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />


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
	border: 1px solid #ced4da;
	border-radius: 0.375rem;
	width: 80%;
	max-height: 400px;
	resize: none;
}

.input-group {
	padding-bottom: 40px
}

.input-group-text {
	margin-bottom: 50px
}

.rateon {
	font-size: 20px;
	color: #ff9966 !important;
}

.rate span {
	color: #dddddd;
	font-size: 20px;
}
</style>

<!-- 공지사항 글 등록 -->
<div class="card ad_card mb-4">
	<div class="card-body">
		<form action="./reviewwrite" method="post"
			enctype="multipart/form-data" name="reviewwrite">


			<div class="input-group flex-nowrap">
				<span class="input-group-text" id="addon-wrapping">제 목</span> <br>
				<br> <input type="text" class="form-control"
					name="review_title" id="review_title" required="required"
					aria-label="제 목" aria-describedby="addon-wrapping">
			</div>


			<div class="input-group flex-nowrap">
				<span class="input-group-text" id="addon-wrapping">내 용</span> <br>
				<br>
				<textarea id="review_content" class="fcc_textarea form-control"
					name="review_content" cols="40" rows="15" required="required">
				</textarea>
			</div>




			<div input-group flex-nowrap>
				<span class="input-group-text" id="addon-wrapping">별 점</span><br>
				<div class="rate-group">
					<p class="rate">
						<span class="rateon"><i class="fa-solid fa-paw"></i></span> <span><i
							class="fa-solid fa-paw "></i></span> <span><i
							class="fa-solid fa-paw "></i></span> <span><i
							class="fa-solid fa-paw "></i></span> <span><i
							class="fa-solid fa-paw "></i></span>
					</p>
				</div>
				</span>


			</div>



			<section id="commandCell">
				<div class="d-grid gap-2 d-md-block">

					<button type="submit" class="pet_btn btn-outline-secondary"><a
						href="${pageContext.request.contextPath}/mypage/review/writtenReviewList">수정</a></button>
					<button type="submit" class="pet_btn btn-outline-secondary"><a
						href="${pageContext.request.contextPath}/mypage/review/writtenReviewList">취소</a></button>
				</div>
			</section>
		</form>
	</div>
</div>

<script>
	$(".rate span").click(function() {
		$(this).parent().children("span").removeClass("rateon");
		$(this).addClass("rateon").prevAll("span").addClass("rateon");
		return false;
	});
</script>