<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />
<html>



<!-- 세션있을때  -->
<c:if test="${not empty authUser}">
	<!-- 관리자 일때 -->
	<c:if test="${authUser.user_type >= 9}">

		<!-- qna 리스트 -->
		<div class="card ad_card mb-4">
			<div class="container w90">
				<div class="card-body">
					<p class="card_title">QNA</p>
					<a href="qnawriteform">QNA 글쓰기</a>
					<form method="post" action="ad_qnaList" id="qnaList">

					<!-- 검색 -->
					<ul>
						<li><select name="search" class="w-px80">
								<option value="all"
									${qnaPage.search eq 'all' ? 'selected' : '' }>전체</option>
								<option value="title"
									${qnaPage.search eq 'title' ? 'selected' : '' }>제목</option>
								<option value="content"
									${qnaPage.search eq 'content' ? 'selected' : '' }>내용</option>
								<option value="writer"
									${qnaPage.search eq 'writer' ? 'selected' : '' }>작성자</option>
						</select></li>
						<li><input value="${qnaPage.keyword }" type="text"
							name="keyword" class="w-px300" /></li>
						<li><a class="btn-fill" onclick="$('form').submit()">검색</a></li>
					</ul>
					<!-- 검색.end -->



					<c:choose>
						<c:when test="${articleList!=null && pageInfo.listCount > 0 }">
							<form name="deleteForm" action="ad_qnadelete" method="post">
								<section id="listForm">
									<table class="table table-hover">
										<thead>
											<tr>
												<th scope="col">번호</th>
												<th scope="col">제목</th>
												<th scope="col">작성자</th>
												<th scope="col">날짜</th>
												<th scope="col">조회수</th>
												<th scope="col" style="text-align: end;">삭제</th>
											</tr>
										</thead>
										<tbody>
											<c:forEach var="article" items="${articleList }">
												<tr style="cursor: pointer;">
													<div class="row">
														<td class="col-2">${article.qna_no}</td>
														<td class="col-3"><c:choose>
																<c:when test="${article.qna_re_lev!=0}">
																	<c:forEach var="i" begin="0"
																		end="${article.qna_re_lev*2}">
													&nbsp;
												</c:forEach>
													▶
											</c:when>
																<c:otherwise>▶</c:otherwise>
															</c:choose> <a
															href="./ad_qnadetail?qna_no=${article.qna_no}&page=${pageInfo.page}">
																${article.qna_title}</a></td>
														<td class="col-2">${article.user_id }</td>
														<td class="col-2">${article.reg_date }</td>
														<td class="col-1">${article.qna_hit }</td>
														<td class="col-1" style="text-align: end;"><label>
																<input type="checkbox" name="qna_no"
																value="${article.qna_no}">
														</label></td>

													</div>
												</tr>
											</c:forEach>
									</table>
								</section>
								
								

								<section id="pageList">
									<nav aria-label="Page navigation example">
										<ul class="pagination admin_page">
											<li class="page-item"><c:choose>
													<c:when test="${pageInfo.page<=1}">
														<a class="page-link" href="#" aria-label="Previous">이전</a>
													</c:when>
													<c:otherwise>
														<a class="page-link"
															href="qnaList?page=${pageInfo.page-1}"
															aria-label="Previous">이전</a>
													</c:otherwise>
												</c:choose></li>
											<c:forEach var="i" begin="${pageInfo.startPage }"
												end="${pageInfo.endPage }">
												<c:choose>
													<c:when test="${pageInfo.page==i }">
														<a class="page-link">${i }</a>
													</c:when>

													<c:otherwise>

														<a class="page-link" href="qnaList?page=${i}">${i }</a>

													</c:otherwise>

												</c:choose>
											</c:forEach>
											<li class="page-item"><c:choose>
													<c:when test="${pageInfo.page>=pageInfo.maxPage }">
														<a class="page-link" href="#" aria-label="Next"> 다음 </a>
													</c:when>
													<c:otherwise>
														<a class="page-link"
															href="qnaList?page=${pageInfo.page+1}" aria-label="Next">다음</a>
													</c:otherwise>
												</c:choose></li>
											<button type="submit" class="btn btn-outline-secondary">
												삭제</button>
										</ul>
									</nav>
								</section>
							</form>
						</c:when>
					</c:choose>
					</form>
				</div>
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