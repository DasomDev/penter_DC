<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<style>
textarea {
	width: 100%;
	border: 1px solid #ced4da;
	border-radius: 0.375rem;
	max-height: 150px;
}
</style>
<script>
	/* user_type 이 9 일 경우에 체크박스 체크되어있게 */
	$(document)
			.ready(
					function() {
						var user_auth = '${users.user_auth}';

						if (user_auth == 10) {
							$("input:checkbox[name='user_auth']:checkbox[value='10']")
							.attr("checked", true);
						} else if (user_auth == 9) {
							$("input:checkbox[name='user_auth']:checkbox[value='9']")
							.attr("checked", true);
						} else if (user_auth == 2) {
							$("input:checkbox[name='user_auth']:checkbox[value='2']")
							.attr("checked", true);
						} else if (user_auth == 1) {
							$("input:checkbox[name='user_auth']:checkbox[value='1']")
							.attr("checked", true);
						} else if (user_auth == 0) {
							$("input:checkbox[name='user_auth']:checkbox[value='0']")
							.attr("checked", true);
						}
					}
			);
	/* 체크박스 하나만 선택되게 하기 */
	function checkOnlyOne1(element) {
		  
		  const checkboxes1 
		      = document.getElementsByName("user_auth");
		  
		  checkboxes1.forEach((cb) => {
		    cb.checked = false;
		  })
		  
		  element.checked = true;
		}
	
	$(document).ready(function(){
		// 체크
		let tyep_kind = '${users.user_auth}';
		tyep_kind = tyep_kind.split(',');
		console.log(tyep_kind);
		
		tyep_kind.forEach(function(e){
		    $("input[value="+e+"]").prop("checked", true);
		});
	})
</script>

<script>
	/* user_type 이 9 일 경우에 체크박스 체크되어있게 */
	$(document)
			.ready(
					function() {
						var user_level = '${users.user_level}';

						if (user_level == 'Gold') {
							$("input:checkbox[name='user_level']:checkbox[value='Gold']")
							.attr("checked", true);
						} else if (user_level == 'Silver') {
							$("input:checkbox[name='user_level']:checkbox[value='Silver']")
							.attr("checked", true);
						} else {
							$("input:checkbox[name='user_level']:checkbox[value='Bronze']")
							.attr("checked", true);
						}
					}
			);
	/* 체크박스 하나만 선택되게 하기 */
	function checkOnlyOne(element) {
		  
		  const checkboxes 
		      = document.getElementsByName("user_level");
		  
		  checkboxes.forEach((cb) => {
		    cb.checked = false;
		  })
		  
		  element.checked = true;
		}
	
	$(document).ready(function(){
		// 체크
		let tyep_kind = '${users.user_level}';
		tyep_kind = tyep_kind.split(',');
		console.log(tyep_kind);
		
		tyep_kind.forEach(function(e){
		    $("input[value="+e+"]").prop("checked", true);
		});
	})
</script>

<!-- 게시판 등록 -->
<div class="card ad_card mb-4">
	<div class="card-body">
		<h2 class="card-title">회원 상세정보</h2>
		<form action="ad_userupdate" method="post" enctype="multipart/form-data">
			<input type="hidden" name="user_no" value="${users.user_no}" />
			<!-- 회원상세정보 -->
			<ul class="user_detail">
				<li>
					<p>회원번호 :</p>
					<p>${users.user_no}</p>
				</li>
				<li>
					<p>회원구분 :</p>
					<p>${users.user_auth}</p>
						<!-- user_type 체크박스 -->
					<div class="form-inline">
								<label>
								<input
								type="checkbox" name="user_auth" value="10"
								onclick="checkOnlyOne1(this)"  placeholder="${users.user_auth}">최고관리자</label>
							
								<label>
								<input
								type="checkbox" name="user_auth" value="9"
								onclick="checkOnlyOne1(this)"  placeholder="${users.user_auth}">관리자</label>
								
								<label>
								<input
								type="checkbox" name="user_auth" value="0"
								onclick="checkOnlyOne1(this)"  placeholder="${users.user_auth}">블랙</label>
								
								<label>
								<input
								type="checkbox" name="user_auth" value="2"
								onclick="checkOnlyOne1(this)"  placeholder="${users.user_auth}">카카오</label>
								
								<label>
								<input 
								type="checkbox" name="user_auth" value="1" 
								onclick="checkOnlyOne1(this)" placeholder="${users.user_auth}">일반회원</label> 
					</div>
				</li>
				<li>
					<p>이름 :</p>
					<p>${users.name}</p>					
				</li>
				<li>
					<p>아이디 :</p>
					<p>${users.id}</p>				
				</li>
				<li class="user_nickname">
					<p>닉네임 :</p>
					<%-- <p>${users.nickname}</p> --%>
					<input type="text" name="nickname" value="${users.nickname}">
				</li>
				<li>
					<p>이메일 :</p>
					<p>${users.email}</p>
				</li>
				<li>
					<p>비밀번호 :</p>
					<p>${users.password}</p>
				</li>
				<li>
					<p>가입일 :</p>
					<p>${users.joindate}</p>
				</li>
				<li>
					<p>성별 :</p>
					<p>${users.gender}</p>
				</li>
				<li>
					<p>주소 :</p>
					<p>${users.addr}${users.addr_detail}</p>
				</li>
				<li>
					<p>등급 :</p>
					<p>${users.user_level}</p>
					<div class="form-inline">
							<label>
								<input type="checkbox" name="user_level"
								value="Gold" onclick="checkOnlyOne(this)" placeholder="${users.user_level}">Gold</label> 
							<label>
								<input
								type="checkbox" name="user_level" value="Silver"
								onclick="checkOnlyOne(this)"  placeholder="${users.user_level}">Silver</label>
								<label>
								<input
								type="checkbox" name="user_level" value="Bronze"
								onclick="checkOnlyOne(this)"  placeholder="${users.user_level}">Bronze</label>
					</div>
				</li>

			</ul>

			<button type="submit" class="btn btn-outline-secondary" style="display:inline-block;">
				회원정보 변경
				</button>
			</form>
	
	</div>
</div>
