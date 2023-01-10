<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core" %>
<%@ taglib  uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<core:forEach items="${list }" var="vo" varStatus="status"> 
	<!-- varStatus 인덱스값 찾아갈때 사용하는 속성 -->
	<%-- ${status.index eq 0 ? '<hr>' : '' } --%>
	${status.index eq 0 ? '' : '' }
	<hr class="hr">
	<div data-id="${vo.id }"> <!-- data-* 속성 : 특별한 조작 없이 HTML 요소에 추가 정보를 저장할 수 있게 해주는 속성 -->
		<%-- ${vo.name } [${vo.writedate }] --%>
		<div class="text_box">
			<p>${vo.name } <span>[${vo.writedate }]</span></p>
			
		</div>
		
		<div class="original">${fn:replace(fn:replace(vo.content, lf, '<br>' ), crlf, '<br>') }</div>
		<div class="modify" style="display:none; margin-top:6px;"></div>
		
		<core:if test="${authUser.id eq vo.writer }"><!-- 로그인한 사용자가 작성한 댓글 수정/삭제 기능 -->
			<span class="ad_comm main_comm">
				<a class="pet_btn btn-modify-save">수정</a>
				<a class="pet_btn btn-delete-cancel">삭제</a>
			</span>
		</core:if>
		
	</div>
	<%-- <div data-id="${vo.id }"> <!-- data-* 속성 : 특별한 조작 없이 HTML 요소에 추가 정보를 저장할 수 있게 해주는 속성 -->
		
		<div class="text_box">
			<p>${vo.name } <span>[${vo.writedate }]</span></p>
			<div class="original">${fn:replace(fn:replace(vo.content, lf, '<br>' ), crlf, '<br>') }</div>
		</div>
		
		<core:if test="${authUser.id eq vo.writer }"><!-- 로그인한 사용자가 작성한 댓글 수정/삭제 기능 -->
			<div class="cm_btnSet">
				<a class="pet_btn btn-modify-save">수정</a>
				<a class="pet_btn btn-delete-cancel">삭제</a>
			</div>
		</core:if>
		<div class="modify" style="display:none; margin-top:6px;"></div>
	</div> --%>
	
</core:forEach>
<script>

//수정 / 저장 버튼 클릭
$('.btn-modify-save').on('click', function(){
	var $div = $(this).closest('div');

	if( $(this).text() == '수정' ) {
		//수정 텍스트 창 크기 고정
		$div.children('.modify').css('height', $div.children('.original').height()-6); 

		//줄바꿈 태그 변환
		var tag = "<textarea style='width:calc(100% - 120px);min-height: 20px; height:100%; resize:none'>" + $div.children('.original').html().replace(/<br>/g, '\n') + "</textarea>";
		$div.children('.modify').html(tag);
		display($div, 'm');
	} else {
		var comment = {id:$div.data('id'),
						 content:$div.children('.modify').find('textarea').val() };
		//alert(JSON.stringify(comment)); JSON형태로 잘 출력되는지 확인
		
		$.ajax({
			url: 'board/comment/update',
			data: JSON.stringify(comment),
			contentType: 'application/json',
			type: 'post',
			success: function(data) {
				alert(data);
				comment_list();
			}, error: function(req, text) {
				alert(text + ':' + req.status);
			}
		});
	}
});

//삭제 / 취소 버튼 클릭
$('.btn-delete-cancel').on('click', function(){
	var $div = $(this).closest('div');

	if( $(this).text() == '취소' ) {
		display($div, 'd');
	} else {
		if( confirm('정말 삭제하시겠습니까?') ) {
			$.ajax({
				url: 'board/comment/delete/' + $div.data('id'),
				success: function() {
					comment_list();
				}, error: function(req, text) {
					alert(text + ':' + req.status);
				},
			});
		}
	}
})

function display(div, mode) {
	//수정 상태(m) : 저장/취소, 원글 안 보이고, 수정 글은 보이고 
	//보기 상태(d) : 수정/삭제, 원글 보이고, 수정 글은 안 보이고
	div.find('.btn-modify-save').text(mode=='m' ? '저장' : '수정');
	div.find('.btn-delete-cancel').text(mode=='m' ? '취소' : '삭제');
	div.children('.original').css('display', mode=='m' ? 'none' : 'block');
	div.children('.modify').css('display', mode=='m' ? 'block' : 'none');
}
</script>