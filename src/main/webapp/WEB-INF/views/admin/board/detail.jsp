<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>

<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />


<!-- 세션있을때  -->
<c:if test="${not empty authUser}">
	<!-- 관리자 일때 -->
	<c:if test="${authUser.user_type >= 9}">
		<!-- board 리스트 -->
		<div class="card ad_card mb-4">
			<div class="card-body">
				<h2 class="card-title">이벤트 detail</h2>

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
											<a class="by" href="ad_download_notice?id=${vo.id }"
												style='margin-left: 5px'> <i class="fa-solid fa-file"></i></a>
										</c:if>
									</div>

								</div>
								&nbsp;&nbsp;&nbsp;
								<div>
									<!-- day -->
									${vo.writedate  }&nbsp;&nbsp; <i class="fa-regular fa-eye"></i>
									${vo.readcnt }
								</div>
							</div>
						</div>

						<hr class="hr">

						<div class="content">
							<!-- 첨부된 이미지 보여주기 -->
							<c:if test="${!empty vo.filename }">
								<div class="preview">
									<img src="resources/${vo.filepath }" class="img3"
										style="width: 100%;" />
								</div>
							</c:if>
							<div class="txt">${fn:replace(vo.content, crlf, '<br>') }</div>

						</div>
						<hr class="hr">

						<div class="btnSet">
							<a class="btn btn-outline-secondary" type="button"
								href="ad_list_board">목록으로</a>
							<!-- 작성자로 로그인한 경우만 수정/삭제 가능, 관리자는 삭제 가능 -->
							<c:if test="${authUser.id eq vo.writer}">
								<a class="btn btn-outline-secondary" type="button"
									onclick="$('form').attr('action', 'ad_modify_board'); $('form').submit()">수정</a>
							</c:if>
							<c:if test="${authUser.id eq vo.writer }">
								<a class="btn btn-outline-secondary" type="button"
									onclick="if( confirm('정말 삭제하시겠습니까?') ) { $('form').attr('action', 'delete_board'); $('form').submit(); } ">삭제</a>
							</c:if>
						</div>

						<div class="comment_container">
							<div id="comment_regist">
								<h3>댓글 작성</h3>
								<div class="box">
									<textarea id="comment" class="fcc_textarea"></textarea>
									<span class="right">
									<button class="btn btn-outline-secondary"
											onclick="comment_regist()">등록</button></span>
								</div>

							</div>
							<div id="comment_list" class="comment_list"></div>
						</div>


						<form method="post" action="ad_list_board">
							<input type="hidden" name="id" value="${vo.id }" /> <input
								type="hidden" name="curPage" value="${board.curPage }" /> <input
								type="hidden" name="search" value="${board.search }" /> <input
								type="hidden" name="keyword" value="${board.keyword }" /> <input
								type="hidden" name="viewType" value="${board.viewType }" /> <input
								type="hidden" name="pageList" value="${board.pageList }" />
						</form>
						<div id="popup"
							onclick="$('#popup, #popup-background').css('display', 'none')"></div>
						<div id="popup-background"></div>

					</div>
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

<script type="text/javascript"
	src="${pageContext.request.contextPath}/resources/js/reply.js"></script>
<script type="text/javascript">
function go_list() {
	$('form').submit();
}

function showAttachImage(id) {
	//첨부된 파일이 이미지인 경우 보여지게
	var filename = '${vo.filename}';
	var ext = filename.substring( filename.lastIndexOf('.') + 1 ).toLowerCase(); //확장자
	var imgs = [ 'gif', 'jpg', 'jpeg', 'png', 'bmg' ];
	if( imgs.indexOf(ext) > -1 ) {
		var img = '<img src="' + '${vo.filepath}'.substring(1) + '" '
			+ 'id="preview-img" ' 
			+ 'class="' + (id == '#popup' ? 'popup' : 'file-img') + '" '
			+ 'style="border-radius: 50%"/>';
		$(id).html(img);
	}
}

if( ${!empty vo.filename} ) {
	showAttachImage('#preview');
} 

 $('#preview-img').click(function() {
	$('#popup, #popup-background').css('display', 'block');
	showAttachImage('#popup');
});

function comment_regist() {
	if(${empty authUser}) {
		alert("댓글을 등록하려면 로그인하세요!");
		return;	
	}
	
	if( $("#comment").val() == "" ) {
		alert("댓글을 입력하세요!");
		$("#comment").focus();
		return;
	}

	$.ajax({
		url: "board/comment/insert",
		data: { pid:${vo.id}, content: $("#comment").val() },
		success: function(data) {
				if(data) {
					$("#comment").val('');
					comment_list();
				}
		},
		error: function(req, text) {
			alert(text + " : " + req.status)
		}
	});
}

function comment_list() {
	$.ajax({
		url: 'board/comment/${vo.id}',
		success: function(data) {
			$("#comment_list").html(data);
		},
		error: function(req, text) {
			alert(text + ' : ' + req.status);
		}
		
	});
}
comment_list();
</script>
</html>