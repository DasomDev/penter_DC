<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>board detail jsp</title>
</head>
<body>
<div id="wrapper">
		<!-- CONTAINER -->
		<div class="container w90">
<p class="list_title">이벤트</p>

<!-- CONTAINER -->


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
								<a class="by" href="download_notice?id=${vo.id }"
									style='margin-left: 5px'> <i class="fa-solid fa-file"></i></a>
							</c:if>
						</div>
						<%-- <c:if test="${article.file_no!=null }">
										<!-- 첨부파일 다운로드 -->
										첨부파일 <a href="qna_download?qnaNum=${article.qna_no}">
											${article.file_no}
											<i class="fas fa-download font-img"></i>
										</a>
								</c:if> --%>
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
									<img src="resources/${vo.filepath }" class="img3" style="width: 100%;" />
								</div>
							</c:if>
				<div class="txt">${fn:replace(vo.content, crlf, '<br>') }</div>
			</div>
			<hr class="hr">

			<div class="btnSet">
				<a class="pet_btn" href="list_board">목록으로</a>
				<!-- 작성자로 로그인한 경우만 수정/삭제 가능, 관리자는 삭제 가능 -->
				<c:if test="${authUser.id eq vo.writer}">
					<a class="pet_btn"
						onclick="$('form').attr('action', 'modify_board'); $('form').submit()">수정</a>
				</c:if>
				<c:if test="${authUser.id eq vo.writer }">
					<a class="pet_btn"
						onclick="if( confirm('정말 삭제하시겠습니까??') ) { $('form').attr('action', 'delete_board'); $('form').submit(); } ">삭제</a>
				</c:if>
			</div>

			<div class="comment_container">
				<div id="comment_regist">
					<h3>댓글 작성</h3>
					<div class="box">
					<textarea id="comment" class="fcc_textarea"></textarea>
					<span class="right"><button class="pet_btn"
							onclick="comment_regist()">등록</button></span>
					</div>
					
				</div>
				<div id="comment_list" class="comment_list"></div>
			</div>


			<form method="post" action="list_board">
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
</body>

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