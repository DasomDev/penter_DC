<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>

<script>
$(document).ready(function(){
	// 동물종류체크
	let neut = '${data.pet_neutral}';
	console.log("중성화여부"+neut);
	if(neut !=''){
		$("input[name=pet_neutral]").val(neut).prop("checked", true);
	}else{
		console.log("중성화정보없음");
	}

	
	
	//자기소개
	let str = '${data.pet_info}';
	$("textarea[name=pet_info").text(str);
	
	// 삭제
	$(".del_btn").click(function(){
		if(confirm("정말 삭제하시겠습니까?") == true){
			window.location.href = "${pageContext.request.contextPath}/mypage/myPetDel?petNo=${data.pet_no}";
		}else{
			return false;
		} 
	})
	
	//제출
	$(".submit_btn").click(function(){
		$(".edit_form").submit();
	})
	// 이미지미리보기
	$('#file').change(function(event) {
		let reader = new FileReader();
		reader.onload = function(e) {
			$('#rep2').attr('src', e.target.result);
		};
		reader.readAsDataURL(event.target.files[0]);	
	});
})
		
</script>

<style>
form{max-width:480px;}
.profile_upload{
    width: 500px;
    display: flex;
    align-items: center;
    justify-content: center;
 }
 .profile_upload .prof_img{margin:0;}
 .btn_area{
    display: flex;
    gap: 15px;
  }
  .del_btn{background-color:#ddd;}
</style>
<div class="content">
  <p class="menu_title">반려동물 정보 수정</p>
  <form action="${pageContext.request.contextPath}/mypage/myPetInfoEdit" method="POST" class="data edit_form" enctype="multipart/form-data">
		<input type="hidden" value="${data.pet_no}" name="pet_no"/>
		<input type="hidden" value="${data.file_no}" name="file_no"/>
		<!-- 동물사진 -->
		<div class="f_row profile_upload">
			<div class="profile_upload">
				<div class="prof_img">
					<img id="rep2" class="img_wrap img" src="${pageContext.request.contextPath}/getImg/${data.file_no}"/> <br>
					<label for="file" class="pet_btn edit_btn">
						<i class="fa-solid fa-pen" id="pen"></i>
					</label>
					<input type="file" id="file" name="imageFile" hidden="hidden"></input>
				</div>
			</div>
		</div>
		<!-- 정보 -->
		<div>
      <span class="key">반려동물이름</span>
      <span class="value"><input type="text" value="${data.pet_name}" disabled></span>
    </div>
    <div>
      <span class="key">반려동물성별</span>
      <span class="value"><input type="text" value="${data.pet_gender}" disabled></span>
    </div>
    <div>
      <span class="key">중성화여부</span>
      <span class="value">
      	<label class="fcRadio1 mr12"><input type="radio" name="pet_neutral" value="YES"><span>O</span></label>
      	<label class="fcRadio1 mr12"><input type="radio" name="pet_neutral" value="NO"><span>X</span></label>
      </span>
    </div>
    <div class="f_row">
			<p class="fc_title">특이사항</p>
			<textarea name="pet_info" id="" class="fcc_textarea"></textarea>
		</div>
    
    <div class="btn_area">
    	<span class="pet_btn del_btn btn_auto transition02">반려동물정보 삭제</span>
    	<span class="pet_btn submit_btn btn_auto transition02">반려동물정보 수정</span>
    </div>
    
	</form>
</div>
