<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="core"%>
<div class="page_list">
	<core:if test="${page.curBlock gt 1 }">
		<a class="page_first" onclick="go_page(1)">처음</a>
		<a class="page_prev" onclick="go_page(${page.beginPage - page.blockPage })">이전</a>
	</core:if>

	<!-- step : 지정하지 않아도 디폴트 1 -->
	<core:forEach var="no" begin="${page.beginPage }" end="${page.endPage }" step="1">
		<core:if test="${no eq page.curPage}">
			<span class="page_on">${no }</span>
		</core:if>
		
		<core:if test="${no ne page.curPage }">
			<a class="page_off" onclick="go_page(${no })">${no }</a>
		</core:if>
	</core:forEach>
	
	<core:if test="${page.curBlock lt page.totalBlock }">
		<a class="page_next" onclick="go_page(${page.endPage + 1 })">다음</a>
		<a class="page_last" onclick="go_page(${page.totalPage })">마지막</a>
	</core:if>
</div>

<script>
function go_page(no) {
	$('[name=curPage]').val(no);
	$('[name=keyword]').val('${page.keyword}');
	$('#list').submit();
}
</script>