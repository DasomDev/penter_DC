<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>
<style>
	form.edit_form{}
	.edit_form > div{    
		display: flex;
    align-items: center;
    margin-bottom: 20px;}
</style>

<div class="content">
  <p class="menu_title">나의 정보 수정</p>
  <form action="${pageContext.request.contextPath}/mypage/myinfoEdit" method="POST" class="data edit_form" enctype="multipart/form-data">
		<input type="hidden" value="${member.id}" name="id"/>
		<input type="hidden" value="${mypageSession.file_no}" name="file_no"/>
		
		<div class="f_row profile_upload">
			<div class="profile_upload">
				<div class="prof_img">
					<c:if test="${mypageSession.file_no==0}">
						<img class="rep2 img_wrap img" src="${imgPath}/noimg.webp" alt="노프로필" id="prof_img_view"/>
					</c:if>
					<c:if test="${mypageSession.file_no != 0}">
						<img class="img_wrap img rep2 img_wrap img" src="${pageContext.request.contextPath}/getImg/${mypageSession.file_no}"/>
					</c:if>
					<!-- <img id="rep2" class="img_wrap img"/> <br> -->
					<label for="file" class="pet_btn edit_btn">
						<i class="fa-solid fa-pen" id="pen"></i>
					</label>
					<input type="file" id="file" name="imageFile" hidden="hidden"></input>
				</div>
			</div>
		</div>
		<div>
      <span class="key">이름</span>
      <span class="value"><input type="text" value="${member.name}" disabled></span>
    </div>
    <div>
      <span class="key">별명</span>
      <span class="value"><input type="text" value="${member.nickname}" name="nickname"></span>
    </div>
    <div>
      <span class="key">이메일</span>
      <span class="value"><input type="text" value="${member.email}" name="email"></span>
    </div>
    <div>
      <span class="key flex_start">주소</span>
      <div class="value flex_col">
      	<p class="mb10">
      		<input class="mr12" type="text" id="add1" name="zipcode" value="${member.zipcode}" readonly/>
      		<input type="button" class="pet_btn second_btn transition02" onclick="Zipcode()" value= "주소찾기"/>
      	</p>      	
      	<input class="mb10" type="text" id ="add2" name="addr" value="${member.addr}" readonly/>
      	<input class="mb10" type="text" id ="add3" name="addr_detail" value="${member.addr_detail}" />
      	<input type="hidden" id="add4"/>
      	
      </div>
    </div>
    <span class="pet_btn submit_btn btn_auto transition02">기본 정보 수정</span>
	</form>
</div>
<script>
	$(document).ready(function(){		
		$(function() {
			$('#file').change(function(event) {
				let reader = new FileReader();
				reader.onload = function(e) {
					$('.rep2').attr('src', e.target.result);
				};
				reader.readAsDataURL(event.target.files[0]);	
			});
		})
		$(".submit_btn").click(function(){
			$(".edit_form").submit();
		})
	})
</script>