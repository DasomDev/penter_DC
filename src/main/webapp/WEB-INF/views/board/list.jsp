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
<body>
	<!-- 이벤트 리스트 -->
	<div id="wrapper">
		<!-- CONTAINER -->
		<div class="container w90">
			<div class="">
				<p class="list_title">이벤트</p>
				<div class="formbox">
					<form id="list" method="post" action="">
						<input type="hidden" name="curPage" value="1" /> <input
							type="hidden" name="id" />
						<div id="list-top" class="table_top">
							<div>
								<!-- 검색 -->
								<ul class="search_box">
									<li><select name="search" class="w-px80">
											<option value="all"
												${board.search eq 'all' ? 'selected' : '' }>전체</option>
											<option value="title"
												${board.search eq 'title' ? 'selected' : '' }>제목</option>
											<option value="content"
												${board.search eq 'content' ? 'selected' : '' }>내용</option>
											<option value="writer"
												${board.search eq 'writer' ? 'selected' : '' }>작성자</option>
									</select></li>
									<li><input type="text" name="keyword" class="w-px300" /></li>
									<li>
										<button class="pet_btn" onclick="$('form').submit()">검색</button>
									</li>
								</ul>

								<ul class="option_box">
									<li><select name="pageList" class="w-px80"
										onchange="$('[name=curPage]').val(1); $('form').submit()">
											<option value="10" ${board.pageList eq 10 ? 'selected' : '' }>10개씩</option>
											<option value="20" ${board.pageList eq 20 ? 'selected' : '' }>20개씩</option>
											<option value="30" ${board.pageList eq 30 ? 'selected' : '' }>30개씩</option>
									</select></li>
									<li><select name="viewType" class="w-px100"
										onchange="$('form').submit()">
											<option value="list"
												${board.viewType eq 'list' ? 'selected' : '' }>리스트
												형태</option>
											<option value="grid"
												${board.viewType eq 'grid' ? 'selected' : '' }>바둑판
												형태</option>
									</select></li>
									<!-- 로그인되어 있으면 글쓰기 가능 -->
									<c:if test="${!empty authUser}">
										<li>
											<!-- 글쓰기 버튼 --> <a class="pet_btn" href="new_board">글쓰기</a>
										</li>
									</c:if>
								</ul>
							</div>
						</div>

						<c:if test="${board.viewType eq 'list' }">
							<div class="user_table">
								<table class="table table-hover">
									<c:forEach items="${board.list}" var="vo">
										<tr style="cursor: pointer;"
											onClick="location.href='detail_board?id=${vo.id }&curPage=${board.curPage }'">
											<td>
												<!-- 1.box -->
												<div class="box1">
													<p class="user_by">
														<span class="by">by</span>&nbsp;${vo.name }
													</p>
													<p class="day">${vo.writedate }</p>
													<p>
														<i class="fa-regular fa-eye"></i> ${vo.readcnt}
													</p>
												</div> <!-- 제목, 내용 -->
												<div class="box2">
													<h2>${vo.title }</h2>
													<p class="content">${vo.content}</p>
												</div> <!-- 이미지 있을때 -->
												<div class="box3" id="box3">
													<c:if test="${!empty vo.filename }">
														<div class="preview">
															<img src="resources/${vo.filepath }" class="img3"
																style='widht: 100%' />
														</div>
													</c:if>
													<!-- 업로드한 이미지 없을때 -->
													<c:if test="${empty vo.filename }">
														<div class="preview_no"></div>
													</c:if>
												</div>
											</td>
										</tr>
									</c:forEach>
								</table>
							</div>
						</c:if>


						<c:if test="${board.viewType eq 'grid' }">
							<div class="user_table_grid">
								<div class="grid_box">
									<c:forEach items="${board.list}" var="vo">
										<div class="item" style="cursor: pointer;"
											onClick="location.href='detail_board?id=${vo.id }&curPage=${board.curPage }'">
											<!-- 이미지 있을때 -->
											<div class="img_box">
												<c:if test="${!empty vo.filename }">
													<div class="preview">
														<img src="resources/${vo.filepath }" class="img3"
															style='width: 100%; object-fit: cover; height: 120px; margin-bottom: 15px;' />
													</div>
												</c:if>
												<!-- 업로드한 이미지 없을때 -->
												<c:if test="${empty vo.filename }">
													<div class="preview_no"
														style='display: flex; justify-content: center;'>
														<img src="${imgPath }/header_logo.png"
															style='object-fit: cover; height: 90px; padding: 15px; margin-bottom: 15px;' />
													</div>
												</c:if>
											</div>

											<!-- 제목, 내용 -->
											<div class="box2">
												<h2>
													<a onclick="go_detail(${vo.id})">${vo.title }grid</a>
												</h2>
											</div>

											<!-- 1.box -->
											<div class="box1"
												style='display: flex; justify-content: space-between; position: absolute; bottom: 20px;'>
												<p class="user_by">
													<span class="by">by</span>&nbsp;${vo.name }
												</p>
												<p class="day">${vo.writedate }</p>
											</div>
										</div>
									</c:forEach>
								</div>
							</div>
						</c:if>
					</form>
				</div>
			</div>
		</div>

		<div class="btnSet">
			<div class="page_list">
				<button class="page_first" onclick="go_page(1)">처음</button>

				<!-- step : 지정하지 않아도 디폴트 1 -->
				<c:forEach var="no" begin="${board.beginPage }"
					end="${board.endPage }" step="1">
					<c:if test="${no eq board.curPage}">
						<button class="page_on">${no }</button>
					</c:if>

					<c:if test="${no ne board.curPage }">
						<button class="page_off" onclick="go_page(${no })">${no }</button>
					</c:if>
				</c:forEach>
				<button class="page_last" onclick="go_page(${board.totalPage })">마지막</button>
			</div>
		</div>
	</div>

</body>

<script type="text/javascript">

function go_detail(id) {
	$('[name=id]').val(id);
	$('form').attr('action', 'detail_board');
	$('form').submit();	
}
</script>

<script>
function go_page(no) {
	$('[name=curPage]').val(no);
	$('[name=keyword]').val('${board.keyword}');
	$('#list').submit();
}
</script>
