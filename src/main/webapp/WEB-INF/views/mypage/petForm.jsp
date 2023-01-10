<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images" />

<div class="content">
<h3 class="form_title fs24">나의 반려동물 정보</h3>
<form action="/petner/petForm/register" method="POST" id="petForm" class="mypage_form" enctype="multipart/form-data">
	<input type="hidden" value="${authUser.user_no}" name="user_no">
	<input type="hidden" value="${authUser.zipcode}" name="zipcode">
	<input type="hidden" value="${authUser.addr}" name="addr">
	<input type="hidden" value="${authUser.addr_detail}" name="addr_detail">
	<div class="tip tip1 mb25">
		펫시터를 구하기 위해 보호자님의<br>소중한 반려동물의 정보가 필요해요.<br /> 딱맞는 펫시터를 찾아드릴게요
	</div>
	
	<!-- 사진등록 -->
	<div class="f_row profile_upload">
		<p class="fc_title">반려동물의 사진을 올려주세요</p>
		<div class="profile_upload">
			<div class="prof_img">
				<img src="${imgPath}/noimg.webp" id="rep" class="img_wrap img"> 
				<label for="file" class="pet_btn edit_btn"> 
					<i class="fa-solid fa-pen" id="pen"></i>
				</label> 
				<input type="file" id="file" name="imageFile" hidden="hidden"></input>
			</div>
		</div>
	</div>

	<!-- 동물체크 -->
	<div class="f_row">
		<p class="fc_title">반려동물의 종류를 알려주세요</p>
		<label class="fcRadio1 mr12"> 
			<input type="radio" name="pet_kind" value="개">
			<span>개</span>
		</label>
		<label class="fcRadio1 mr12"> 
			<input type="radio" name="pet_kind" value="고양이">
			<span>고양이</span>
		</label> 
		<label class="fcRadio1 mr12"> 
			<input type="radio" name="pet_kind" value="관상어">
			<span>관상어</span>
		</label> 
		<label class="fcRadio1 mr12"> 
			<input type="radio" name="pet_kind" value="새">
			<span>새</span>
		</label> 
		<label class="fcRadio1"> 
			<input type="radio" name="pet_kind" value="파충류">
			<span>파충류</span>
		</label>
	</div>

	<!-- 종류 -->
	<div class="f_row">
		<p class="fc_title">반려동물의 품종을 알려주세요</p>
		<P class="tip">반려동물의 특징을 잘아는 펫시터분을 찾을수 있어요</P>
		<input type="text" name="pet_specie" placeholder="치와와 / 샴 / 코숏" />
	</div>

	<!-- 이름 -->
	<div class="f_row">
		<p class="fc_title">반려동물의 이름을 입력해주세요</p>
		<input type="text" name="pet_name"/>
	</div>
	<!-- 나이 -->
	<div class="f_row">
		<p class="fc_title">반려동물의 나이를 알려주세요</p>
		<input type="number" name="pet_age" min="1"/>
	</div>
	<!-- 체중 -->
	<div class="f_row weight">
		<p class="fc_title">반려동물의 체중을 알려주세요</p>
		<input type="number" name="pet_weight" class="mr12" style="min-width: auto; width: 228.65px;" min="1"/>
		<span>Kg</span>
	</div>

	<!-- 성별 -->
	<div class="f_row">
		<p class="fc_title">반려동물의 성별을 알려주세요</p>
		<label class="fcRadio1 mr12"><input type="radio" name="pet_gender" value="암컷"><span>암컷</span></label>
		<label class="fcRadio1 mr12"><input type="radio" name="pet_gender" value="수컷"><span>수컷</span></label>
	</div>

	<!-- 중성화 -->
	<div class="f_row">
		<p class="fc_title">중성화 여부를 알려주세요</p>
		<label class="fcRadio1 mr12"><input type="radio" name="pet_neutral" value="YES"><span>O</span></label>
		<label class="fcRadio1 mr12"><input type="radio" name="pet_neutral" value="NO"><span>X</span></label>
	</div>

	<div class="f_row">
		<p class="fc_title">펫시터가 알아야할 정보를 알려주세요</p>
		<p class="tip">예) 노견이라 산책을 짧게해주세요, 다른 강아지를 좋아하지 않아요</p>
		<textarea class="fcc_textarea" name="pet_info"></textarea>
	</div>

	<span class="pet_btn submit_btn transition02">나의 반려동물 정보 등록하기</span>
</form>
</div>
<script>
$(document).ready(function(){
	//이미지 미리보기
	var eTarget = '';
	$('#file').change(function(event) {
		let reader = new FileReader();
		reader.onload = function(e) {
			$('#rep').attr('src', e.target.result);
			eTarget = e.target.result;
		};
		reader.readAsDataURL(event.target.files[0]);	
	});
 
	var pet_kindArr = [];
	$("input[name=pet_kind]").click(function() {
		pet_kindArr = [];
		var value = $(this).val();
		pet_kindArr.push(value);        
	});
	
	
	//submit 
	$(".submit_btn").click(function(){
		var radioGender = $("input[name=pet_gender]:checked").val();
		var radioNeutral = $("input[name=pet_neutral]:checked").val();
		
		if(pet_kindArr.length < 1){
			alert("반려동물의 종류를 선택해주세요.");
			return false;
		}
		if( !$("input[name=pet_specie]").val() || !$("input[name=pet_name]").val() || !$("input[name=pet_age]").val() || 
			!$("input[name=pet_weight]").val() || !$("textarea[name=pet_info]").val()){
				alert("빠진 항목들이 없는지 다시 한번 확인해주세요.");
				return false;
		}
		if(typeof radioGender == "undefined" || radioGender == "" || radioGender == null){
			alert("반려동물의 성별을 알려주세요.");
			return false;
		}
		if(typeof radioNeutral == "undefined" || radioNeutral == "" || radioNeutral == null){
			alert("반려동물의 중성화 여부를 알려주세요.");
			return false;
		}
		if(!eTarget){
			alert("반려동물의 사진을 올려주세요.");
			return false;
		}
		
	  $("#petForm").submit();
	})
});
</script>