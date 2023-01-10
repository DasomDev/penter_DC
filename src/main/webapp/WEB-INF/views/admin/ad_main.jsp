<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />


<!-- 세션있을때  -->
<c:if test="${not empty authUser}">
	<!-- 관리자 일때 -->
	<c:if test="${authUser.user_type >= 9}">
		<!-- 공지사항 리스트 -->
		<div class="card ad_card mb-4">
			<div class="card-body">
				<h2 class="card-title">공지사항 글 목록</h2>
				<form method="post" action="ad_list_notice" id="list">
					<input type="hidden" name="curPage" value="1" />

					<div class="table_top">

						<ul>
							<c:if test="${authUser.user_type >= 9}">
								<a type="button" class="btn btn-outline-secondary"
									href="ad_new_notice">글쓰기</a>
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
									<th scope="col" style="text-align: end;">첨부파일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${notice.list}" var="vo" end="4">
									<tr style="cursor: pointer;">
										<div class="row">
											<td class="col-1">${vo.id}</td>
											<td class="col-4"><c:forEach var="i" begin="1"
													end="${vo.indent }">
													<span class="notice_indent">Re <c:if
															test="ad_detail_notice?id=${vo.id }?${vo.title}=${vo.title}">${vo.title}</c:if></span>&nbsp;&nbsp;
											</c:forEach> <a
												href="ad_detail_notice?id=${vo.id }&curPage=${notice.curPage }">${vo.title }</a>
											</td>
											<td class="col-2">${vo.writer}</td>
											<td class="col-2">${vo.writedate}</td>
											<td class="col-1">${vo.root}</td>
											<td class="col-1" style="text-align: center;"><c:if test="${!empty vo.filename }">
													<a href="ad_download_notice?id=${vo.id }"> <i
														class="fa-solid fa-file"></i>
													</a>
												</c:if></td>
										</div>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</form>
			</div>
		</div>

		<!-- 게시판 리스트 -->
		<div class="card ad_card mb-4">
			<div class="card-body">
				<h2 class="card-title">이벤트 글 목록</h2>
				<form id="list" method="post" action="">
					<input type="hidden" name="curPage" value="1" /> <input
						type="hidden" name="id" />
					<div class="table_top">
						<ul>
							<li><a class="btn btn-outline-secondary" href="ad_new_board">글쓰기</a>
							</li>
							<li><a class="btn btn-outline-secondary"
								href="ad_list_board">메뉴로 이동</a></li>
						</ul>
					</div>

					<div class="user_table_list">
						<c:if test="${board.viewType eq 'list' }">
							<table class="table table-hover">
								<thead>
									<tr>
										<th scope="col">번호</th>
										<th scope="col">제목</th>
										<th scope="col">작성자</th>
										<th scope="col">작성일자</th>
										<th scope="col">조회수</th>
										<th scope="col" style="text-align: end;">첨부 파일</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${board.list }" var="vo" end="4">
										<tr style="cursor: pointer;">
											<td class="col-1">${vo.no }</td>
											<td class="col-4"><a
												href="ad_detail_board?id=${vo.id }&curPage=${board.curPage }">${vo.title }</a>
												<%-- <a onclick="go_detail(${vo.id})">${vo.title }</a> --%>
											</td>
											<td class="col-2">${vo.name }</td>
											<td class="col-2">${vo.writedate }</td>
											<td class="col-1">${vo.readcnt}</td>
											<td class="col-1" style="text-align: center;"><c:if test="${!empty vo.filename }">
													<a href="ad_download_board?id=${vo.id }"> <i
														class="fa-solid fa-file"></i>
													</a>
												</c:if></td>
											
										</tr>
									</c:forEach>
								</tbody>
							</table>
						</c:if>
					</div>
				</form>
			</div>
		</div>
		
				<!-- qna 리스트 -->
		<div class="card ad_card mb-4">
			<div class="card-body">
				<h2 class="card-title">qna 글 목록</h2>
				<form method="post" action="ad_list_qna" id="list" >
					<input type="hidden" name="curPage" value="1" />

					<div class="table_top">
						<ul>
							<c:if test="${authUser.user_type >= 9}">
								<a type="button" class="btn btn-outline-secondary"
									href="ad_new_notice">글쓰기</a>
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
									<th scope="col" style="text-align: end;">첨부파일</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${qna.list}" var="vo" end="4">
									<tr style="cursor: pointer;">
										<div class="row">
											<td class="col-1">${vo.id}</td>
											<td class="col-4"><c:forEach var="i" begin="1"
													end="${vo.indent }">
													<span class="qna_indent">Re <c:if
															test="ad_detail_qna?id=${vo.id }?${vo.title}=${vo.title}">${vo.title}</c:if></span>&nbsp;&nbsp;
											</c:forEach> <a href="ad_detail_qna?id=${vo.id }&curPage=${qna.curPage }">${vo.title }</a>
											</td>
											<td class="col-2">${vo.writer}</td>
											<td class="col-2">${vo.writedate}</td>
											<td class="col-1">${vo.root}</td>
											<td class="col-1" style="text-align: center;"><c:if test="${!empty vo.filename }">
													<a href="ad_download_qna?id=${vo.id }"> <i
														class="fa-solid fa-file"></i>
													</a>
												</c:if></td>
										</div>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</div>
				</form>
			</div>
		</div>
		<!-- --------- container --------- -->

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




