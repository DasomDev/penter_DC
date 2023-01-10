<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images" />
<!DOCTYPE html>
<html>
<head>
<title>시터정보입력</title>
</head>
<div class="content">
	<h3 class="form_title fs24">펫시터 정보 등록</h3>
	<form action="/petner/sitterForm/register" method="POST" id="sitterForm" class="mypage_form" enctype="multipart/form-data">
		<input type="hidden" value="${authUser.user_no}" name="user_no">
		<input type="hidden" value="${authUser.zipcode}" name="zipcode">
		<input type="hidden" value="${authUser.addr}" name="addr">
		<input type="hidden" value="${authUser.addr_detail}" name="addr_detail">
		<div class="tip tip1 mb25">펫시터 활동을 위한 추가 정보 등록이 필요해요</div>
		
		<!-- 사진등록 -->
		<div class="f_row profile_upload">
			<p class="fc_title">프로필 사진을 올려주세요</p>
			<p class="tip">프로필 사진이 있으면 보호자에게 연락올 확률이 높아져요</p>
			<div class="profile_upload">
				<div class="prof_img">
					<img src="${imgPath}/noimg.webp" id="rep2" class="img_wrap img"> 
					<label for="file" class="pet_btn edit_btn">
						<i class="fa-solid fa-pen" id="pen"></i>
					</label>
					<input type="file" id="file" name="imageFile" hidden="hidden"></input>
				</div>
			</div>
		</div>

		<!-- 동물체크 -->
		<div class="f_row">
			<p class="fc_title">케어가능한 반려동물의 종류를 선택해주세요</p>
			<label class="fcCbox2 mr12"> 
				<input type="checkbox" name="pet_kind" value="dog">
				<span>강아지</span>
			</label> 
			<label class="fcCbox2 mr12"> 
				<input type="checkbox" name="pet_kind" value="cat">
				<span>고양이</span>
			</label> 
			<label class="fcCbox2 mr12"> 
				<input type="checkbox" name="pet_kind" value="fish">
				<span>관상어</span>
			</label> 
			<label class="fcCbox2 mr12"> 
				<input type="checkbox" name="pet_kind" value="bird">
				<span>새</span>
			</label> 
			<label class="fcCbox2"> 
				<input type="checkbox" name="pet_kind" value="reptile">
				<span>파충류</span>
			</label>
		</div>

		<!-- 가능한 요일 -->
		<div class="f_row days">
			<p class="fc_title">펫시터 활동이 가능한 요일을 알려주세요</p>
			<p class="pb12 select_all">
				<label class="fcCbox1"><input type="checkbox" id="day_chkAll"><span>전체선택</span></label>
			</p>
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="work_day" value="mon"><span>월</span>
			</label>
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="work_day" value="tue"><span>화</span>
			</label> 
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="work_day" value="wed"><span>수</span>
			</label> 
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="work_day" value="thu"><span>목</span>
				</label> 
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="work_day" value="fri"><span>금</span>
			</label> 
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="work_day" value="sat"><span>토</span>
			</label> 
			<label class="fcCbox2">
				<input type="checkbox" name="work_day" value="sun"><span>일</span>
			</label>
		</div>

		<!-- 제공가능서비스 -->
		<div class="f_row">
			<p class="fc_title">제공가능한 서비스를 알려주세요</p>
			<p class="pb12 select_all">
				<label class="fcCbox1"><input type="checkbox" id="service_chkAll"><span>전체선택</span></label>
			</p>
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="service" value="visit"><span>방문관리</span>
			</label> 
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="service" value="walk"><span>산책</span>
			</label>
			<label class="fcCbox2 mr12">
				<input type="checkbox" name="service" value="shower"><span>목욕</span>
			</label>
			<label class="fcCbox2">
				<input type="checkbox" name="service" value="education"><span>교육</span>
			</label>
		</div>

		<div class="f_row">
			<p class="fc_title">활동가능한 지역</p>
			<p class="fc_title">[${authUser.zipcode}] ${authUser.addr} ${authUser.addr_detail}</p>
		</div>

		<div class="f_row">
			<p class="fc_title">자기소개를 간단하게 해주세요. 펫시터 경험을 써주셔도 좋아요</p>
			<textarea name="sitter_info"class="fcc_textarea"></textarea>
		</div>

		<span class="pet_btn submit_btn transition02">펫시터정보등록하기</span>
	</form>
</div>
<script>
$(document).ready(function() {
	//이미지 미리보기
	var eTarget = '';
	$('#sitterForm #file').change(function(event) {
		let reader = new FileReader();
		reader.onload = function(e) {
			$('#rep2').attr('src', e.target.result);
			eTarget = e.target.result;
		};
		reader.readAsDataURL(event.target.files[0]);	
	});
	
	//------------- 체크박스 전체선택 시작 ---------------
	
	//케어가능한 반려동물 종류
	var pet_kindArr = [];
	$("input[name=pet_kind]").click(function() {
		pet_kindArr = [];
		$("input[name='pet_kind']:checked").each(function(e){
			var value = $(this).val();
			pet_kindArr.push(value);        
		});
		console.log(pet_kindArr);
	});
	
	//활동가능요일
	var dayArr = [];
	$("#day_chkAll").click(function() {
		dayArr = [];
		if($("#day_chkAll").is(":checked")) {
			$("input[name=work_day]").prop("checked", true);
			$("input[name='work_day']:checked").each(function(e){
				var value = $(this).val();
				dayArr.push(value);        
			});
			console.log("222 "+dayArr);
		}else{
			$("input[name=work_day]").prop("checked", false);
		}
	});
	$("input[name=work_day]").click(function() {
		dayArr = [];
		$("input[name='work_day']:checked").each(function(e){
			var value = $(this).val();
			dayArr.push(value);        
		});
		console.log(dayArr);
		var total = $("input[name=work_day]").length;
		var checked = $("input[name=work_day]:checked").length;
		
		if(total != checked){
			$("#day_chkAll").prop("checked", false);
		}else $("#day_chkAll").prop("checked", true); 
	});
	
	//제공가능서비스
	var serviceArr = [];
	$("#service_chkAll").click(function() {
		serviceArr = [];
		if($("#service_chkAll").is(":checked")) {
			$("input[name=service]").prop("checked", true);
			$("input[name='service']:checked").each(function(e){
				var value = $(this).val();
			    serviceArr.push(value);        
			});
			console.log("222 "+serviceArr);
		}else{
			$("input[name=service]").prop("checked", false);
		}
	});
	$("input[name=service]").click(function() {
		serviceArr = [];
		$("input[name='service']:checked").each(function(e){
			var value = $(this).val();
		    serviceArr.push(value);        
		});
		console.log(serviceArr);
		var total = $("input[name=service]").length;
		var checked = $("input[name=service]:checked").length;
		if(total != checked){
			$("#service_chkAll").prop("checked", false);
		}else $("#service_chkAll").prop("checked", true); 
	});
	//------------- 체크박스 전체선택 끝 ----------------
	$(".submit_btn").click(function() {
		if(!eTarget){
			alert("프로필 사진을 올려주세요.");
			return false;
		}
		//array
		if(pet_kindArr.length < 1){
			alert("케어가능한 반려동물의 종류를 선택해주세요.");
			return false;
		}
		if(dayArr.length < 1){
			alert("요일을 선택해주세요.");
			return false;
		}
		if(serviceArr.length < 1){
			alert("제공 가능한 서비스를 선택해주세요.");
			return false;
		}
		if(!$("textarea[name=sitter_info]").val()){
			alert("자기소개를 해주세요.");
			return false;
		}
		
		$("#sitterForm").submit();
	})
});
</script>