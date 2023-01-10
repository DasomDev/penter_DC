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
<style>
.q_list {
	background: #f1f1f1;
	border-bottom: 1px solid #ccc;
}

.q_list .text {
	cursor: pointer;
	background: #fff;
	height: 40px;
	padding: 20px;
	display: flex;
	align-items: center;
	justify-content: space-between;
}

.q_list .hide {
	display: none;
	padding: 30px 20px;
}

.q_list .text svg {
	transform: rotate(180deg);
}
</style>
<body>
	<!-- 공지사항 리스트 -->
	<div id="wrapper">
		<!-- CONTAINER -->
		<div class="container w90">
			<p class="list_title">QNA</p>
			<div class="formbox">
				<!-- Questions list -->
				<h3>자주하는 질문</h3>
				<div class="formbox">
					<form method="post" action="list_qna" id="list">
						<input type="hidden" name="curPage" value="1" />

						<div class="table_top">
							<div>
								<!-- 검색 -->
								<ul class="search_box">
									<li><select name="search" class="search">
											<option class="option_box" value="all"
												${qna.search eq 'all' ? 'selected' : '' }>전체</option>
											<option class="option_box" value="title"
												${qna.search eq 'title' ? 'selected' : '' }>질문</option>
											<option class="option_box" value="content"
												${qna.search eq 'content' ? 'selected' : '' }>내용</option>
											<%-- <option class="option_box" value="writer"
												${qna.search eq 'writer' ? 'selected' : '' }>작성자</option> --%>
									</select></li>
									<li><input value="${qna.keyword }" type="text"
										name="keyword" class="w-px300" /></li>
									<li><button class="pet_btn" onclick="$('form').submit()">검색</button></li>
								</ul>
								<ul>
									<c:if test="${authUser.user_type >= 9}">
										<li><a class="pet_btn" href="new_qna">글쓰기</a></li>
									</c:if>
								</ul>
							</div>
						</div>
					</form>
					<div class="questions_list">
						<ul style='width: 100%;'>

							<c:forEach items="${qna.list}" var="vo">
								<li class="q_list" style="cursor: pointer;">
									<div class="text">
										${vo.title}<i class="fa-solid fa-chevron-up"></i>
									</div>
									<ul class="hide">
										<li>
											<!-- 첨부된 이미지 보여주기 --> <c:if test="${!empty vo.filename }">
												<div class="preview">
													<img src="resources/${vo.filepath }" class="img3"
														style="width: auto; max-height: 200px;" />
												</div>
											</c:if> ${vo.content}
										</li>
									</ul> 
								</li>
							</c:forEach>
						</ul>
					</div>
					<div class="btnSet">
						<div class="page_list">
							<button class="page_first" onclick="go_page(1)">처음</button>

							<!-- step : 지정하지 않아도 디폴트 1 -->
							<c:forEach var="no" begin="${qna.beginPage }"
								end="${qna.endPage }" step="1">
								<c:if test="${no eq qna.curPage}">
									<button class="page_on">${no }</button>
								</c:if>

								<c:if test="${no ne qna.curPage }">
									<button class="page_off" onclick="go_page(${no })">${no }</button>
								</c:if>
							</c:forEach>
							<button class="page_last" onclick="go_page(${qna.totalPage })">마지막</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>


</body>
<script>
    $(document).ready(function(){
        $(".q_list>.text").click(function(){
            var submenu = $(this).next("ul");
            if( submenu.is(":visible") ){
                submenu.slideUp();
            }else{
                submenu.slideDown();
            }
        });
    });
</script>
<script type="text/javascript">
$(function(){
	$('#data-list ul').css('height', 
			( ( $('.grid li').length % 5 > 0 ? 1 : 0 ) + Math.floor($('.grid li').length / 5) )
			 * $('.grid li').outerHeight(true) - 20);
})

function go_detail(id) {
	$('[name=id]').val(id);
	$('form').attr('action', 'detail_qna');
	$('form').submit();	
}
</script>

<script>
function go_page(no) {
	$('[name=curPage]').val(no);
	$('[name=keyword]').val('${qna.keyword}');
	$('#list').submit();
}




</script>