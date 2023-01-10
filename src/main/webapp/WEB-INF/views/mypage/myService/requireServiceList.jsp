<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images" />
<style>
.card_list_type_B li {
	padding: 28px;
	margin-top: 40px;
	border-radius: 5px;
	box-shadow: 1px 1px 5px 2px rgba(222, 222, 222, 0.75);
	-webkit-box-shadow: 1px 1px 5px 2px rgba(222, 222, 222, 0.75);
	-moz-box-shadow: 1px 1px 5px 2px rgba(222, 222, 222, 0.75);
}

.data1 {
	display: flex;
	align-items: flex-start;
	margin-bottom: 20px;;
}

.card_list_type_B .pet_img {
	width: 120px;
	height: 100px;
	overflow: hidden;
	border-radius: 50%;
	margin-right: 20px
}

.card_list_type_B img {
	width: 100%;
	height: 100%;
}

/* text-area */
.card_list_type_B .matching_status {
	display: flex;
	align-items: center;
	justify-content: space-between;
	margin-bottom: 20px
}

.card_list_type_B .matching_status .status {
	padding: 2px 4px;
	margin-right: 10px;
	background-color: #FAB561;
	border-radius: 5px;
}

.card_list_type_B .hire_detail {
	
}

.card_list_type_B .hire_detail p:nth-child(1) {
	font-size: 1.8rem;
	margin-bottom: 15px;
}

.card_list_type_B .hire_detail p:nth-child(2) {
	
}

.card_list_type_B .data2 {
	display: flex;
	align-items: center;
}

.card_list_type_B .date_info {
	margin-right: 20px;
}

.card_list_type_B .icons span {
	background-color: bisque;
	padding: 2px 13px;
	border-radius: 20px;
	margin-right: 5px;
	font-size: 1.4rem;
}
.list_count{
	padding-top: 40px;
	text-align: end;
}
</style>
<script>
$(document).ready(function(){
	//각 게시글마다 태그 띄우기
	var html = '';
	var data = new Array();
	var arrSpTag ='';
	var tagList = '';
	//^: ~로 시작하는 엘리먼트 접근하는 정규식
	$("input[id^='tagList']").each(function(){
		tagList = this.value;
		data.push(tagList);
	})
	
	for(var i=0; i<data.length; i++){
		//console.log(data[i]);
		if(data[i].match(",")){
			arrSpTag = data[i].split(",");
			html="";
			for(var j=0; j<arrSpTag.length; j++){
				//console.log("arrSpTag["+j+"]:  "+arrSpTag[j]);
				html += '<span class="pet">'+arrSpTag[j]+'</span>';
			}
		}else{
			html = '<span class="pet">'+data[i]+'</span>';
		}
		$("#tagIcons"+(i+1)).empty();
		$("#tagIcons"+(i+1)).append(html);
	}
	
})
</script>
<div class="content_view">
	<p class="list_title">요청한 서비스 보기</p>
	<c:if test="${csListCount < 1}">
		<div class="card_list_type_B">
			<ul>
				<li>
					<div class="data1">
						<!-- 텍스트정보 영역 -->
						<div class="text_area" style="width: 100%">
							<div class="hire_detail">
								<p>요청한 서비스가 없습니다.</p>
							</div>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</c:if>
	<c:if test="${csListCount > 0}">
		<div class="list_count" id="csListCount" >${csListCount}개</div>
		<c:forEach var="csList" items="${csList}" varStatus="status">
		<!-- 카드형 리스트 B : 보호자가 신청한 서비스  -->
		<div class="card_list_type_B">
			<ul>
				<li>
					<div class="data1">
						<!-- 텍스트정보 영역 -->
						<div class="text_area" style="width: 100%">
							<div class="matching_status">
								<div>
									<c:if test="${csList.status == '매칭중' }">
										<span class="status" style="color: #393939">매칭중</span>
									</c:if>
									<c:if test="${csList.status == '매칭완료' }">
										<span class="status" style="background-color: #c7c2c2; color: #f9f9f9;">매칭완료</span>
										<span class="sitter_name">매칭된 시터 : 열정의 펫시터</span>
									</c:if>
								</div>
								<div>
									<span>금액&nbsp;&nbsp;&nbsp;&nbsp;</span>
									<span style="color:green;">${csList.request_money }원</span>
								</div>
							</div>
							<div class="hire_detail">
								<p>${csList.request_title }</p>
								<p>${csList.request_detail }</p>
							</div>
						</div>
					</div>
					<div class="data2">
						<p class="date_info">${csList.reg_date }</p>
						<div class="icons" id="tagIcons${status.count }">
							<input type="hidden" id="tagList${status.count -1}" value="${csList.service }">
						</div>
					</div>
				</li>
			</ul>
		</div>
		</c:forEach>
		<!-- 페이징 -->
		<ul class="pagination">
			<c:choose>
				<c:when test="${pageInfo.page<=1}">
					<li class="prev"><a href="#"><i class="fa-solid fa-chevron-left"></i></a></li>
				</c:when>
				<c:otherwise>
					<li class="prev"><a href="${pageContext.request.contextPath}/mypage/myService/requireServiceList?page=${pageInfo.page-1}"><i class="fa-solid fa-chevron-left"></i></a></li>
				</c:otherwise>
			</c:choose>
		
			<c:forEach var="i" begin="${pageInfo.startPage }" end="${pageInfo.endPage }">
				<c:choose>
					<c:when test="${pageInfo.page==i }"><li class="on"><a href="#">${i}</a></li></c:when>
					<c:otherwise>
						<li><a href="${pageContext.request.contextPath}/mypage/myService/requireServiceList?page=${i}">${i}</a></li>
					</c:otherwise>
				</c:choose>
			</c:forEach>
		
			<c:choose>
				<c:when test="${pageInfo.page>=pageInfo.maxPage }">
					<li class="next"><a href="#"><i class="fa-solid fa-chevron-right"></i></a></li>
				</c:when>
				<c:otherwise>
					<li class="next"><a href="${pageContext.request.contextPath}/mypage/myService/requireServiceList?page=${pageInfo.page+1}"><i class="fa-solid fa-chevron-right"></i></a></li>
				</c:otherwise>
			</c:choose>
		</ul>
	</c:if>
	
</div>