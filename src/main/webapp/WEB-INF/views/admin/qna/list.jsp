<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />
	<c:set var="pluginsPath" value="${pageContext.request.contextPath}/resources/plugins"/>
	
	<!-- font-awesome -->
<link rel="stylesheet" href="${pluginsPath}/font-awesome/all.min.css">
<script src="${pluginsPath}/font-awesome/all.min.js"></script>

<!-- 세션있을때  -->
<c:if test="${not empty authUser}">
	<!-- 관리자 일때 -->
	<c:if test="${authUser.user_type >= 9}">

		<!-- qna 리스트 -->
		<div class="card ad_card mb-4">
			<div class="card-body">
				<h2 class="card-title">qna 글 목록</h2>
				<form method="post" action="ad_list_qna" id="list">
					<input type="hidden" name="curPage" value="1" />

					<div class="table_top">
						<!-- 검색 -->
						<ul class="search_box">
							<li><select name="search" class="search form-select">
									<option class="option_box" value="all"
										${qna.search eq 'all' ? 'selected' : '' }>전체</option>
									<option class="option_box" value="title"
										${qna.search eq 'title' ? 'selected' : '' }>제목</option>
									<option class="option_box" value="content"
										${qna.search eq 'content' ? 'selected' : '' }>내용</option>
									<option class="option_box" value="writer"
										${qna.search eq 'writer' ? 'selected' : '' }>작성자</option>
							</select></li>
							<li><input class="form-control me-2" type="search"
								placeholder="Search" aria-label="Search"
								value="${qna.keyword }" name="keyword"></li>
							<li><a type="button" class="btn btn-outline-secondary"
								onclick="$('form').submit()">검색</a></li>
						</ul>
						<ul>
						<c:if test="${authUser.user_type >= 9}">
								<a type="button" class="btn btn-outline-secondary"
									href="ad_new_qna">글쓰기</a>
							</c:if>
						</ul>
					</div>

					<div class="user_table">
						<table class="table table-hover">
							<thead>
								<tr>
									<th scope="col">번호</th>
									<th scope="col">제목</th>
									<th scope="col">작성자</th>
									<th scope="col">날짜</th>
									<th scope="col">조회수</th>
									<th scope="col">첨부파일</th>
									<th scope="col" style="text-align: end;">삭제</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${qna.list}" var="vo">
									<tr style="cursor: pointer;">
											<td class="col-1">${vo.id}</td>
											<td class="col-4"><c:forEach var="i" begin="1"
													end="${vo.indent }">
													<span class="qna_indent">
													<i class="fa-solid fa-arrow-right"></i> 
													<c:if
															test="ad_detail_qna?id=${vo.id }?${vo.title}=${vo.title}">${vo.title}</c:if></span>&nbsp;&nbsp;
											</c:forEach> <a
												href="ad_detail_qna?id=${vo.id }&curPage=${qna.curPage }">${vo.title }</a>
											</td>
											<td class="col-2">${vo.writer}</td>
											<td class="col-2">${vo.writedate}</td>
											<td class="col-1">${vo.readcnt}</td>
											<td class="col-1" style="text-align: center;"><c:if test="${!empty vo.filename }">
													<a href="ad_download_qna?id=${vo.id }"> 
													<i class="fa-solid fa-file"></i>
													</a>
												</c:if></td>
											<td class="col-1 d-flex-end" style="text-align: end;">
										<input type="checkbox" name="table_no" value="${vo.id}"></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
					<button type="submit" class="btn btn-outline-secondary" id="delBtn">삭제</button>

					<nav aria-label="Page navigation example" class="paging">
						<ul class="pagination">
							<li class="page-item"><a class="page-link page_first"
								onclick="go_page(1)">처음</a></li>
							<!-- step : 지정하지 않아도 디폴트 1 -->
							<c:forEach var="no" begin="${qna.beginPage }"
								end="${qna.endPage }" step="1">
								<c:if test="${no eq qna.curPage}">
									<li class="page-item"><a class="page-link page_on">${no }</a></li>
								</c:if>

								<c:if test="${no ne qna.curPage }">
									<li class="page-item"><a class="page-link page_off"
										onclick="go_page(${no })">${no }</a></li>
								</c:if>
							</c:forEach>
							<li class="page-item"><a class="page-link page_last"
								onclick="go_page(${notice.totalPage })">마지막</a></li>
						</ul>
					</nav>
				</form>

			</div>
		</div>
		<!-- 관리자 일때.end -->
	</c:if>

	<!-- 관리자 아닐때 -->
	<c:if test="${authUser.user_type < 9}">
		<c:import url='/WEB-INF/views/include/not_admin.jsp' />
	</c:if>
</c:if>

<!-- 세션없을때 -->
<c:if test="${empty authUser}">
	<c:import url='/WEB-INF/views/include/not_users.jsp' />
</c:if>

<script type="text/javascript">
$(function(){
	$('#data-list ul').css('height', 
			( ( $('.grid li').length % 5 > 0 ? 1 : 0 ) + Math.floor($('.grid li').length / 5) )
			 * $('.grid li').outerHeight(true) - 20);
	
	//
	
	//삭제 체크박스 12.21 hyekyung
	var noArr = [];
	$("input[name=table_no]").click(function() {
		noArr = [];
		$("input[name='table_no']:checked").each(function(e){
			var value = $(this).val();
			noArr.push(value);        
		});
	});
	//삭제 체크박스 12.21 hyekyung
	$("#delBtn").click(function(){
		console.log("noArr "+noArr);
		$.ajax({
			url : "${pageContext.servletContext.contextPath}/delQna",
			type : "POST",
		    data: {"noArr":noArr},
			success : function() {
				alert("삭제완료");
				document.location.reload(true);
			},
			error : function(xhr, error) {
				console.error("error : " + error);
			}
		});
	})
	
	//
	
});

function go_detail(id) {
	$('[name=id]').val(id);
	$('form').attr('action', 'ad_detail_qna');
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