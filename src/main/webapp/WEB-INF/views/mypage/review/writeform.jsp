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

.rate .on {
	font-size: 20px;
	color: #ff9966 !important;
}
.rate:not(.on) {
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
					name="title" id="title" required="required"
					aria-label="제 목" aria-describedby="addon-wrapping">
			</div>


			<div class="input-group flex-nowrap">
				<span class="input-group-text" id="addon-wrapping">내 용</span> <br>
				<br>
				<textarea id="content" class="fcc_textarea form-control"
					name="content" cols="40" rows="15" required="required">
				</textarea>
			</div>




			<div input-group flex-nowrap>
				<span class="input-group-text" id="addon-wrapping">별 점</span><br>
				<div class="rate-group" id="rate">
					<p class="rate">
						<span class="rate" id="rating1"><i class="fa-solid fa-paw"></i></span> 
						<span class="rate" id="rating2"><i class="fa-solid fa-paw "></i></span> 
						<span class="rate" id="rating3"><i class="fa-solid fa-paw "></i></span> 
						<span class="rate" id="rating4"><i class="fa-solid fa-paw "></i></span> 
						<span class="rate" id="rating5"><i class="fa-solid fa-paw "></i></span>
					</p>
				</div>
				</span>


			</div>



			<section id="commandCell">
				<div class="d-grid gap-2 d-md-block">

					<button type="submit" class="pet_btn btn-outline-secondary">
					<a
						href="${pageContext.request.contextPath}/mypage/review/reviewwrite">등록</a></button>
					<button type="reset" class="pet_btn btn-outline-secondary">다시쓰기</button>
				</div>
			</section>
		</form>
	</div>
</div>

<script>
	/* $(".rate span").click(function() {
		$(this).parent().children('span').removeClass('on');
		$(this).addClass('on').prevAll('span').addClass('on');
		return false;
	});
	 */
	 
	 (function () {
		    var rateEls = document.querySelectorAll('#rate span.rate');
		    var rate = 0;

		    loop(rateEls, function (el, index) {
		        el.addEventListener('click', function () {
		            rating(index + 1);
		        });
		    });

		    function loop(list, func) {
		        Array.prototype.forEach.call(list, func);
		    }

		    function rating(score) {
		        loop(rateEls, function (el, index) {
		            if (index < score) {
		                el.classList.add('on');
		            } else {
		                el.classList.remove('on');
		            }
		        });

		        rate = score;
		    }
		})();
	
</script>