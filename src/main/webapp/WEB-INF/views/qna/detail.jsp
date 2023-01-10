<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>detail JSP</title>
</head>
<body>
	<div id="wrapper">
		<!-- CONTAINER -->
		<div class="container w90">
			<div class="">
				<p class="list_title">qna detail</p>
				<div class="formbox">
					<div class="pn_view">
						<div class="title">
							<h1>${vo.title }</h1>
						</div>
						<div class="source">
							<div>
								<span>by</span>${vo.name }
							</div>
							<div class="data_box d-flex">
								<div>
									<div colspan="5" class="left">
										첨부파일 <span class="by">${vo.filename }</span>
										<c:if test="${!empty vo.filename }">
											<a class="by" href="download_qna?id=${vo.id }"
												style='margin-left: 5px'>
												<i class="fa-solid fa-file"></i></a>
										</c:if>
									</div>
								</div>
								&nbsp;&nbsp;&nbsp;
								<div>
									<!-- day -->
									${vo.writedate  }&nbsp;&nbsp; <i class="fa-regular fa-eye"></i> ${vo.readcnt }
								</div>
							</div>
						</div>

						<hr class="hr">

						<span id="preview"></span>
						
						<div class="content">
						<!-- 첨부된 이미지 보여주기 -->
							<c:if test="${!empty vo.filename }">
								<div class="preview">
									<img src="resources/${vo.filepath }" class="img3" style="width: 100%;" />
								</div>
							</c:if>
							<div class="txt">
							${fn:replace(vo.content, crlf, '<br>') }
							</div>
						
						</div>

						<hr class="hr">

						<div class="btnSet">
							<a class="pet_btn"
								href="list_qna">목록으로</a>
							<!-- 관리자인 경우 수정/삭제 가능 -->
							<c:if test="${authUser.user_type >= 9}">
								<a class="pet_btn" href='modify_qna?id=${vo.id }'>수정</a>
								<a class="pet_btn"
									onclick="if(confirm('정말 삭제하시겠습니까?')) {href='delete_qna?id=${vo.id }' }">삭제</a>
							</c:if>
							<!-- 로그인이 된 경우 답글 쓰기 가능 -->
							<c:if test="${!empty authUser}">
								<a class="pet_btn" href="reply_qna?id=${vo.id }">답글 쓰기</a>
							</c:if>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
</body>
</html>