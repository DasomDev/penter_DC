<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>
<style>
	.cont_view .menu_title{justify-content:center;}
</style>

<script>
	$(document).ready(function(){
		// 동물종류체크
		let pet_kind = '${data.pet_kind}';
		pet_kind = pet_kind.split(',');
		console.log(pet_kind);
		
		pet_kind.forEach(function(e){
		    $("input[value="+e+"]").prop("checked", true);
		});
		
		// 요일 선택
		let work_day = '${data.work_day}';
		work_day = work_day.split(',');
		work_day.forEach(function(e){
		    $("input[value="+e+"]").prop("checked", true);
		});
		
		// 서비스 선택
		let service = '${data.service}';
		service = service.split(',');
		service.forEach(function(e){
		    $("input[value="+e+"]").prop("checked", true);
		});
		
		// 자기소개
		let str = '${data.sitter_info}';
		$("textarea[name=sitter_info").text(str);
		
		
		
		$(".submit_btn").click(function(){
			$(".edit_form").submit();
		})
		
		//활동가능 요일
		$("#day_chkAll").click(function() {
			if($("#day_chkAll").is(":checked")) {
				$("input[name=work_day]").prop("checked", true);
			}else{
				$("input[name=work_day]").prop("checked", false);
			}
		});
		
		$("input[name=work_day]").click(function() {
			var total = $("input[name=work_day]").length;
			var checked = $("input[name=work_day]:checked").length;
			
			if(total != checked){
				$("#day_chkAll").prop("checked", false);
			}else $("#day_chkAll").prop("checked", true); 
		});
		
		//제공가능서비스
		$("#service_chkAll").click(function() {
			if($("#service_chkAll").is(":checked")) {
				$("input[name=service]").prop("checked", true);
			}else{
				$("input[name=service]").prop("checked", false);
			}
		});
		
		$("input[name=service]").click(function() {
			var total = $("input[name=service]").length;
			var checked = $("input[name=service]:checked").length;
			
			if(total != checked){
				$("#service_chkAll").prop("checked", false);
			}else $("#service_chkAll").prop("checked", true); 
		});
		// 이미지미리보기
		$(function() {
			$('#file').change(function(event) {
				let reader = new FileReader();
				reader.onload = function(e) {
					$('#rep2').attr('src', e.target.result);
				};
				reader.readAsDataURL(event.target.files[0]);	
			});
		})               
		
	})
</script>

<div class="content">
  <p class="menu_title">나의 시터정보 수정</p>	
	<form action="${pageContext.request.contextPath}/mypage/mySitterInfoEdit" 
		method="POST" id="sitterForm" 
		class="mypage_form data edit_form" enctype="multipart/form-data">
		<input type="hidden" value="${data.user_no}" name="user_no"/>
		<input type="hidden" value="${data.file_no}" name="file_no"/>
		
		<!-- 사진등록 -->
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
			<p class="fc_title">종을 입력해주세요</p>
			<input type="text" name="pet_specie">
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
      <span class="key flex_start">활동가능한 지역</span>
      <div class="value flex_col">
      	<p class="mb10" style="align-self:flex-start">
      		<input class="mr12" type="text" id="add1" name="zipcode" value="${data.zipcode}" readonly/>
      		<input type="button" class="pet_btn second_btn transition02" onclick="Zipcode()" value= "주소찾기"/>
      	</p>      	
      	<input class="mb10" type="text" id ="add2" name="addr" value="${data.addr}" readonly/>
      	<input class="mb10" type="text" id ="add3" name="addr_detail" value="${data.addr_detail}" />
      	<input type="hidden" id="add4"/>      	
      </div>
    </div>

		<div class="f_row">
			<p class="fc_title">자기소개를 간단하게 해주세요. 펫시터 경험을 써주셔도 좋아요</p>
			<textarea name="sitter_info" id="" class="fcc_textarea"></textarea>
		</div>

		<span class="pet_btn submit_btn btn_auto transition02">펫시터 정보 수정</span>
	</form>
</div>
