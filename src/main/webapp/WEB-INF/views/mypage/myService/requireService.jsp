<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
	.profile_upload_small .img{
		width:75px; height:75px;
	}
	.petSelected:after{
	content: "\f058";
    font-family: "Font Awesome 5 Free";
    color: var(--orange);
    font-size: 2.5rem;
    font-weight: 900;
    position: absolute;
    bottom: 0;
    right: 3px;
	}
</style>
<script>
$(document).ready(function(){
	$("#card_list_type").hide();
	//air-datepicker
	var date = new Date();
	var dp = $('#date_start').datepicker({
	  //년-월-일
	  startDate: new Date(date.getFullYear(), date.getMonth(), date.getDate()),
	  language: 'ko',
	  autoClose: true,
	  //선택한 날짜를 가져옴
	  onSelect: function (date) {
	      var endNum = date;
	      //종료일 datepicker에 최소날짜를 방금 클릭한 날짜로 설정
	      $('#date_end').datepicker({
	          minDate: new Date(endNum),
	      });
	  }
	}).data('datepicker');
	var dp2 = $('#date_end').datepicker({
	  startDate: new Date(date.getFullYear(), date.getMonth(), date.getDate()),  // 시간, 분은 00으로 초기 설정
	  language: 'ko',
	  autoClose: true,
	  //선택한 날짜를 가져옴
	  onSelect: function (date) {
	      var startNum = date;
	      $('#date_start').datepicker({
	          //시작일 datepicker에 최대날짜를 방금 클릭한 날짜로 설정
	          maxDate: new Date(startNum),
	      });
	  }
	}).data('datepicker');
	
	var serviceArr = [];
	//체크박스 전체선택 요청서비스
	$("#service_chkAll").click(function() {
		serviceArr = [];
		if($("#service_chkAll").is(":checked")) {
			$("input[name=service]").prop("checked", true);
			$("input[name='service']:checked").each(function(e){
				var value = $(this).val();
			    serviceArr.push(value);        
			});
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
		var serviceTotal = $("input[name=service]").length;
		var checked = $("input[name=service]:checked").length;
		if(serviceTotal != checked){
			$("#service_chkAll").prop("checked", false);
		}else $("#service_chkAll").prop("checked", true); 
	});
	
	//펫 선택시 정보 불러오기
	$(document)
		.on("click", "a.petImg", function () {
			$("#card_list_type").show();
			$("a.petImg").removeClass("petSelected");
			$(this).toggleClass("petSelected");
			
			//pet_no가져오기
		    var pet_no = $(this).closest('div').children('input').attr('value');
		    $('input[name=pet_no]').attr('value', pet_no);
		    //console.log("clicked pet_no: "+pet_no);
		    
			// contentType: "application/json" 꼭 써주기
	 		$.ajax({
				url : "${pageContext.servletContext.contextPath}/getPetInfo",
				type : "POST",
				dataType: "json",
				contentType: "application/json",
			    data: JSON.stringify({
			    	"pet_no":pet_no
			    }),
				success : function(petInfo) {
					$("#petInfo_name").attr('value',petInfo.pet_name);
					$("#petInfo_gender").attr('value',petInfo.pet_gender);
					$("#petInfo_neutral").attr('value',petInfo.pet_neutral);
					$("#petInfo_specie").attr('value',petInfo.pet_specie);
					$("#petInfo_weight").attr('value',petInfo.pet_weight);
					$("#pet_img_area").attr('src',"${pageContext.request.contextPath}/" + petInfo.pet_no);
					var txt = petInfo.pet_info;
					$("#textareaId").val(txt);
				},
				error : function(xhr, error) { //xmlHttpRequest?
					console.error("error : " + error);
				}
			});
		});//on
	
		//이미지 미리보기
		var eTarget = '';
		$('#file').change(function(event) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#requestPetImg').attr('src', e.target.result);
				eTarget = e.target.result;
			};
			reader.readAsDataURL(event.target.files[0]);	
		});
		
	//submit 
	$(".submit_btn").click(function(){
		if($('input[name=pet_no]').val() == 0){
			alert("펫을 선택해주세요");
			return false;
		}
		if(!$('.date-picker').val() || !$("input[name=request_money]").val() || !$("input[name=request_title]").val() || !$("textarea[name=request_detail]").val()){
			alert("빠진 항목들이 없는지 다시 한번 확인해주세요.");
			return false;
		}
		if(serviceArr.length < 1){
			alert("서비스를 선택해주세요.");
			return false;
		}
		if(!eTarget){
			alert("반려동물의 사진을 올려주세요.");
			return false;
		}
	  $("#requireServiceFrom").submit();
	});
});
</script>

<div class="content">
	<c:if test="${empty petInfo}">
		<div>
			<p class="mb25">등록된 반려동물 정보가 없어요.</p>
			<a href="${pageContext.request.contextPath}/petForm" class="pet_btn">반려동물 정보 등록하기</a>
		</div>
	</c:if>
	<c:if test="${not empty petInfo}">
		<h3 class="form_title fs24">펫케어 서비스 신청</h3>
		<form action="${pageContext.request.contextPath}/mypage/myService/requireServiceForm" method="POST" id="requireServiceFrom" class="mypage_form" enctype="multipart/form-data">
			<!-- 선택한 pet_no보내기 -->
			<input type="hidden" name="pet_no" id="pet_no"/>
			<!-- 펫 선택 -->
			<div class="f_row">
				<p class="fc_title">펫을 선택해주세요</p>
				<div class="profile_upload_small">
					<c:forEach var="petInfo" items="${petInfo}">
						<div class="prof_img_small" id="img_small">
							<a class="petImg"><img src="${pageContext.request.contextPath}/${petInfo.pet_no}" id="rep" class="img_wrap img"></a>
							<input type="hidden" value="${petInfo.pet_no}">
						</div>
					</c:forEach>
				</div>
			</div>
			<!-- 카드형 리스트 -->
			<div class="f_row">
				<div class="card_list_type" id="card_list_type">
					<table>
						<tr>
							<td colspan="2">
								<div class="img_area">
									<img id="pet_img_area" >
								</div>
							</td>
						</tr>
						<tr class="tr-left">
							<td class="pdr40">이름</td>
							<td class="td-inner" >
								<input type="text" id="petInfo_name" name="pet_name" readonly>
							</td>
						</tr>
						<tr class="tr-left">
							<td class="pdr40">성별</td>
							<td class="td-inner">
								<input type="text" id="petInfo_gender" name="pet_gender" readonly>
							</td>
						</tr>
						<tr class="tr-left">
							<td class="pdr40">종류</td>
							<td class="td-inner">
								<input type="text" id="petInfo_specie" name="pet_specie" readonly>
							</td>
						</tr>
						<tr class="tr-left">
							<td class="pdr40">체중</td>
							<td class="td-inner">
								<input type="text" id="petInfo_weight" name="pet_weight" readonly>kg
							</td>
						</tr>
						<tr class="tr-left" style="border-top:1px #777 dotted">
							<td class="pdr40" width="30%">중성화</td>
							<td class="td-inner" width="70%">
								<input type="text" id="petInfo_neutral" name="pet_neutral" readonly>
							</td>
						</tr>
					</table>
					<div style="padding: 20px 0px;">
						<p class="p-style">특이사항</p>
						<P class="p-style-content">
						<textarea id="textareaId" name="pet_info" readonly></textarea>
						</P>
					</div>
				</div>
			</div>
			
			<div class="f_row">
				<p class="tip">보호자가 펫시터에게 요청하고 싶은 사항을 입력해주세요. (모든 사항은 필수입니다.)</p>
			</div>
			
			<!-- 지역 -->
			<div class="f_row">
				<p class="fc_title">지역</p>
				<input type="text" name="zipcode" style="width:100px; min-width: auto;" value="${userInfo.zipcode}" readonly="readonly"/>
				<input type="text" name="addr" style="width:356px; min-width: auto;" placeholder="주소" value="${userInfo.addr}" readonly="readonly"/>
				<input type="text" name="addr_detail" style="width:100%; min-width: auto; margin-top: 10px;" placeholder="상세주소" value="${userInfo.addr_detail}" readonly="readonly"/>
			</div>
		
			<!-- 날짜 -->
		 	<div class="f_row">
		 		<p class="fc_title">가능한 날짜를 선택해주세요</p>
		      <input type="text" class="date-picker" id="date_start" name="st_date">&nbsp;~&nbsp;
		      <input type="text" class="date-picker" id="date_end" name="end_date">
		    </div>  
			
			<!-- 서비스 -->
			<div class="f_row">
				<p class="fc_title">요청하실 서비스를 선택해 주세요</p>
				<p class="pb12 select_all">
					<label class="fcCbox1"><input type="checkbox" id="service_chkAll"><span>전체선택</span></label>
				</p>
				<label class="fcCbox2 mr12">
					<input type="checkbox" name="service" value="방문관리"><span>방문관리</span>
				</label> 
				<label class="fcCbox2 mr12">
					<input type="checkbox" name="service" value="산책"><span>산책</span>
				</label>
				<label class="fcCbox2 mr12">
					<input type="checkbox" name="service" value="목욕"><span>목욕</span>
				</label>
				<label class="fcCbox2">
					<input type="checkbox" name="service" value="교육"><span>교육</span>
				</label>
			</div>
			
			<!-- 금액 -->
			<div class="f_row">
				<p class="fc_title">해당 요청서의 금액을 책정해주세요</p>
				<input type="text" name="request_money" style="width:96%; min-width: auto; margin-top: 10px;"/>원
			</div>
			
			<!-- 요쳥사항 -->
			<div class="f_row">
				<p class="fc_title">요청서의 제목을 입력해주세요</p>
				<input type="text" name="request_title" style="width:100%; min-width: auto; margin-top: 10px;" placeholder="제목" value=""/>
			</div>
			<div class="f_row">
				<p class="fc_title">요청하실 사항을 자세히 입력해주세요</p>
				<p class="tip">예) 노견이라 산책을 짧게해주세요, 다른 강아지를 좋아하지 않아요</p>
				<textarea class="fcc_textarea" name="request_detail"></textarea>
			</div>
			
			<!-- 사진 업로드 -->
			<div class="f_row profile_upload">
				<p class="fc_title">서비스 요청할 때 보여질 반려동물 사진을 올려주세요!</p>
				<div class="profile_upload_square">
					<div class="prof_img">
						<img id="requestPetImg"> <br>
						<label for="file" class="pet_btn edit_btn"> 
							<i class="fa-solid fa-pen" id="pen"></i>
						</label> 
						<input type="file" id="file" name="imageFile" hidden="hidden"></input>
					</div>
				</div>
			</div>
			
			<span class="pet_btn submit_btn transition02">서비스 신청하기</span>
		</form>
	</c:if>
</div>
