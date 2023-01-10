<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images" />
<!DOCTYPE html>
<html>
<head>
<c:import url='/WEB-INF/views/include/common_head.jsp' />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2d6fc6008c147d8c5d81603f2166c5d&libraries=services"></script>
<title>${title}</title>
<style>
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
</head>
<script>
$(document).ready(function() {
	//viewForm에서 목록으로 갈 때 내주변찾기 검색값 유지
	var qszipcode = $("#qszipcode").val();
	var qsaddrp = $("#qsaddrp").val();
	if(qszipcode != 1){
		$("#zipcodeP").text("["+qszipcode+"]");
        $("#zipcode").val(qszipcode);
        $("#addrP").text(qsaddrp);
	}
	
	//위로가기	
	$(document).on("click", ".go_top", function(){
    	$('html, body').animate({scrollTop:0}, '200');
    });
	
	//이미지 미리보기
	$(function() {
		$('#file').change(function(event) {
			let reader = new FileReader();
			reader.onload = function(e) {
				$('#rep').attr('src', e.target.result);
			};
			reader.readAsDataURL(event.target.files[0]);	
		});
	})
	//air-datepicker
	var date = new Date();
	var dp = $('#date_start').datepicker( {
			//년-월-일
			startDate : new Date(date.getFullYear(), date.getMonth(), date.getDate()),
			language : 'ko',
			autoClose : true,
			//선택한 날짜를 가져옴
			onSelect : function(date) {
				var endNum = date;
				//종료일 datepicker에 최소날짜를 방금 클릭한 날짜로 설정
				$('#date_end').datepicker({
					minDate : new Date(endNum),
				});
				searchAjax();
			}
	}).data('datepicker');
	var dp2 = $('#date_end').datepicker({	
				startDate : new Date(date.getFullYear(), date .getMonth(), date.getDate()), // 시간, 분은 00으로 초기 설정
				language : 'ko',
				autoClose : true,
				//선택한 날짜를 가져옴
				onSelect : function(date) {
					var startNum = date;
					$('#date_start').datepicker({
						//시작일 datepicker에 최대날짜를 방금 클릭한 날짜로 설정
						maxDate : new Date(startNum),
					});
					searchAjax();
				}
	}).data('datepicker');
	var serviceArr = [];
	var petKindArr = []; 
	var genderArr = [];
	
	arr = serviceArr.toString().split(',');
    var servicearrLen = arr.length;
	var cnt = arr.length;

	for(var i=0; i<cnt; i++){
	  $('input:checkbox[name=service]').each(function(){
	    if( arr[i].indexOf(this.value) > -1 ){ //현재 라인 배열에 값 존재여부 조건문 수정
	    this.checked = true;
	    }
	  });
	}
    
	//서비스
	$(document).on("click", "input[name=service]", function () {
		serviceArr = [];
	    $("input[name='service']:checked").each(function(e){
	        var value = $(this).val();
	        serviceArr.push(value);        
		})
		//console.log("serviceArr:  "+serviceArr);
	    searchAjax();
	});
	//동물종류
	$(document).on("click", "input[name=pet_kind]", function () {
		petKindArr = [];
	    $("input[name='pet_kind']:checked").each(function(e){
	        var value = $(this).val();
	        petKindArr.push(value);        
		})
		//console.log("petKindArr:  "+petKindArr);
	    searchAjax();
	});
	//보호자 성별
	$(document).on("click", "input[name=gender]", function () {
		genderArr = [];
	    $("input[name='gender']:checked").each(function(e){
	        var value = $(this).val();
	        genderArr.push(value);        
		})
		//console.log("genderArr:  "+genderArr);
	    searchAjax();
	});
	var addr = [];
	
	function searchAjax(){
		var result = get_query();
		
		//날짜, 서비스, 동물종류, 보호자성별, 위치, 펫이름 검색
		var st_date='';
		var end_date='';
		var service='';
		var pet_kind='';
		var gender='';
		
		if(!result.st_date){
			st_date = $('#date_start').val();
		}else{
			st_date = result.st_date;
		}
		
		if(!result.end_date){
			end_date = $('#date_end').val();
		}else{
			end_date = result.end_date;
		}
		
		if(!result.service){
			service = serviceArr;
		}else{
			service = result.service;
			$("input:checkbox[value="+service+"]").prop("checked", true);
		}
		
		if(!result.pet_kind){
			pet_kind = petKindArr;
		}else{
			pet_kind = result.pet_kind;
			$("input:checkbox[value="+pet_kind+"]").prop("checked", true);  
		}
		
		if(!result.gender){
			gender = genderArr;
		}else{
			gender = result.gender;
			$("input:checkbox[value="+gender+"]").prop("checked", true);  
		}
		
		var zipcode = $("#zipcode").val();
		var addrP = $("#addrP").text();
		
		var params='';
		if(st_date){
			params += "st_date="+st_date;
		}
		if(end_date){
			params += "&end_date="+end_date; 
		}
		if(service){
			params += "&service="+service; 
		}
		if(pet_kind){
			params += "&pet_kind="+pet_kind;
		}
		if(gender){
			params += "&gender="+gender;
		}
		if(zipcode){
			params += "&zipcode="+zipcode; 
		}
		if(addrP){
			params += "&addrP="+addrP;
		}
		
		//contentType: "application/json",
		jQuery.ajaxSettings.traditional = true;
 		$.ajax({
			url : "${pageContext.servletContext.contextPath}/findPet/viewForm/findPetSearch?"+params,
			type : "GET",
			success : function(data) {
				console.log(data);
				var str = '';
				if(data.length == 0){
					$("#card_list").empty();
					str +='<span class="see_info">조회된 데이터가 없습니다.</span>';
					$("#card_list").append(str);
				}else{
					$("#card_list").empty();
					$.each(data, function(i, item) { // 데이터 =item
						str +='<ul class="flex_between" id="ulId">';
						str +='<li>';
						<!-- 글 간략정보 -->
						str +='<div class="info">';
						str +='<div class="flex_agn_center">';
						str +='<div class="owner_img">';
						str +='<img src="${imgPath}/noimg.webp" alt="노프로필"/>';
						str +='<img src="" alt="프로필">';
						str +='</div>';
						str +='<span id="nickname">'+item.NICKNAME+'</span>';
						str +='</div>';
						var status = $.trim(item.STATUS);
						if(status == '매칭중'){
							str +='<span class="status open" style="background-color: yellowgreen;">'+item.STATUS+'</span>';
						}else if(status == '매칭완료'){
							str +='<span class="status open" style="background-color: #c7c2c2;">'+item.STATUS+'</span>';
						}
						str +='</div>';
						<!-- 동물사진 -->
						str +='<div class="img_area" style="width: 357px; height: 200px">';
						str +='<a href="${pageContext.request.contextPath}/findPet/viewForm/'+item.SERVICE_NO+'" target="_blank">';
						if(item.FILE_NO == null){
							str +='<img src="/petner/resources/images/header_logo.png" alt="이미지">';  
						}else{
							str +='<img src="${pageContext.request.contextPath}/findPet/'+item.FILE_NO+'" id="rep" class="img_wrap img">';		
						}
						str +='</a>';	
						str +='</div>';
						<!-- 시팅요청사항디테일 -->
						str +='<div class="text_area">';
						str +='<div class="title ellipsis">'+item.REQUEST_TITLE+'</div>';
						str +='<div class="content ellipsis">'+item.REQUEST_DETAIL+'</div>';
						str +='<div class="view_info">';
						str +='<span class="date">'+item.ST_DATE+'&nbsp;~&nbsp;'+item.END_DATE+'</span>';
						/* str +='<p>';
						str +='<span class="mr12"> <i class="fa-solid fa-comment-dots"></i>20</span>';
						str +='<span><i class="fa-regular fa-eye"></i>13</span>';
						str +='</p>'; */
						str +='</div>';
						str +='</div>';
						str+='</li>';
						str+='</ul>';
						str+='<input type="hidden" id="ajaxAddr" value="'+item.ADDR+'">';
						addr.push(item.ADDR);
					});
					$("#card_list").append(str);
				}
			},
			error : function(xhr, error) {
				console.error("error : " + error);
			}
		});//ajax();
	}//searchAjax();
	
	//내주변찾기 버튼
	$("#findAreaBtn").click(function(){
		var mapContainer = document.getElementById("map");
		var coordXY   = document.getElementById("coordXY");
		var distanceGap  = document.getElementById("distance");
		var radius = 2000;	// 반경 미터(m), 2km
		var geocoder = new kakao.maps.services.Geocoder();
		
		function curLocation(){
			//지도의 중심을 현재 위치로 변경(HTML5의 geolocation으로 사용할 수 있는지 확인합니다.)
			if (navigator.geolocation) {
				// GeoLocation을 이용해서 접속 위치를 얻어옵니다
		    	navigator.geolocation.getCurrentPosition(function(position) {
			        var x = position.coords.latitude, y = position.coords.longitude; // x:위도, y:경도
			        var latlngyo = new daum.maps.LatLng(x, y);
			        var mapOption = {
			          		center: latlngyo, // 지도의 중심좌표
			                level: 6      // 지도의 확대 레벨
			         };
			        var lat = x;
			        var lng = y;
			        //좌표 > 도로명주소
			        getAddr(lat,lng);
			        function getAddr(lat,lng){
			            let coord = new kakao.maps.LatLng(lat, lng);
			            let callback = function(result, status) {
			                if (status === kakao.maps.services.Status.OK) {
			                    console.log(result[0].address.address_name);
			                    console.log(result[0].road_address.zone_no);
			                    if(!result[0].road_address.zone_no){
			                    	alert("현재 위치의 정보를 불러올 수 없습니다.");
			                    }else{
		                    		 $("#zipcodeP").text("["+result[0].road_address.zone_no+"]");
					                 $("#zipcode").val(result[0].road_address.zone_no);
					                 $("#addrP").text(result[0].address.address_name);
			                    }
			                }
			               searchAjax();
			            }
			            geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
			            var map = new daum.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
				        map.setCenter(coord);
			            
				        var circle = new daum.maps.Circle({
				            map: map,
				            center : latlngyo,
				            radius: radius,
				            strokeWeight: 2,
				            strokeColor: '#FF00FF',
				            strokeOpacity: 0.8,
				            strokeStyle: 'dashed',
				            fillColor: '#D3D5BF',
				            fillOpacity: 0.5
				        });
	
				        var marker = new daum.maps.Marker({
				         position: latlngyo, // 마커의 좌표
				         title: "현위치",
				         map: map          // 마커를 표시할 지도 객체
				        });
				        
				    	for(var i in addr){
				    		// 주소로 좌표를 검색합니다
					        geocoder.addressSearch(addr[i], function(result, status) {
					            // 정상적으로 검색이 완료됐으면 
					            if (status === kakao.maps.services.Status.OK) {
					                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
					                // 결과값으로 받은 위치를 마커로 표시합니다
					                var marker = new kakao.maps.Marker({
					                    map: map,
					                    position: coords
					                });
					            } 
				        	});//geocoder.addressSearch
				    	}
				}
		    });//navigator.geolocation.getCurrentPosition
		    	 
		}else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

			var locPosition = new kakao.maps.LatLng(37.4812845080678, 126.952713197762),
				message = '현재 위치를 알 수 없어 기본 위치로 이동합니다.'

			currentLatLon['lat'] = 33.450701
			currentLatLon['lon'] = 126.570667

			displayMarker(locPosition, message);
		}
			
			return true;
		}//지도 띄우기 끝
		
		//지도 불러오기
		curLocation();
	});
	
	//페이지 처음 띄워질 때 나타나는 지도
	function firstMap(){
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
	    mapOption = {
	        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
	        level: 3 // 지도의 확대 레벨
	    };  
		// 지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 

		// 주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		// 주소로 좌표를 검색합니다
		geocoder.addressSearch($("#addrP").text(), function(result, status) {
	        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

	        // 결과값으로 받은 위치를 마커로 표시합니다
	        var marker = new kakao.maps.Marker({
	            map: map,
	            title: "현위치",
	            position: coords
	        });
	        
	     	// 인포윈도우에 표시될 내용입니다
	        var message = '<div style="padding:5px;">사용자 위치</div>'; 
	     	// 인포윈도우에 표시할 내용
            var iwContent = message, 
                iwRemoveable = true;

            // 인포윈도우를 생성합니다
            var infowindow = new kakao.maps.InfoWindow({
                content : iwContent,
                removable : iwRemoveable
            });
            
            infowindow.open(map, marker);  
            
            for(var i in addr){
	    		// 주소로 좌표를 검색합니다
		        geocoder.addressSearch(addr[i], function(result, status) {
		            // 정상적으로 검색이 완료됐으면 
	                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
	                // 결과값으로 받은 위치를 마커로 표시합니다
	                var marker = new kakao.maps.Marker({
	                    map: map,
	                    position: coords
	                });
	                
	        	});//geocoder.addressSearch
		    }
            
            // 지도 중심좌표를 접속위치로 변경합니다
            map.setCenter(coords);
		});
	}
	
	//ajax검색 실행
	var authUser = $("#authUser").val();
	if(!authUser){
		$("#findAreaBtn").trigger("click");
	}else{
		searchAjax();
		firstMap();
	}	
});//ready
	//쿼리스트링 파라미터가져오기
	function get_query(){
	    var url = document.location.href;
	    var qs = url.substring(url.indexOf('?') + 1).split('&');
	    for(var i = 0, result = {}; i < qs.length; i++){
	        qs[i] = qs[i].split('=');
	        result[qs[i][0]] = decodeURIComponent(qs[i][1]);
	    }
	    return result;
	}
	
	$(window).scroll(function(){
		//var scrollValue = $(document).scrollTop(); 
		//console.log(scrollValue);
	if ($(this).scrollTop() > 400) {
	  $('.go_top').fadeIn();
	}else {$('.go_top').fadeOut(); }
	});
</script>
<!-- CONTAINER -->
<div class="container w90">
	<p class="list_title">돌봐줄 동물 찾기</p>
	<!-- 검색조건 -->
	<div class="filter_feed">
		<!-- 날짜 -->
		<div class="f_row">
			<p class="filter_title">가능한 날짜를 선택해주세요</p>
			<div>
				<input type="text" class="date-picker" id="date_start" name="st_date" style="height: 29px; width: 162px; text-align: center;">&nbsp;~&nbsp;
				<input type="text" class="date-picker" id="date_end" name="end_date" style="height: 29px; width: 162px; text-align: center;">
			</div>
		</div>
		<!-- 서비스 -->
		<div class="f_row">
			<p class="filter_title">서비스</p>
			<div class="select_box">
				<label class="fcCbox1">
					<input type="checkbox" name="service" value="방문관리"> 
					<span>방문관리</span>
				</label> 
				<label class="fcCbox1"> 
					<input type="checkbox" name="service" value="산책"> 
					<span>산책</span>
				</label> 
				<label class="fcCbox1"> 
					<input type="checkbox" name="service" value="목욕"> 
					<span>목욕</span>
				</label> 
				<label class="fcCbox1"> 
					<input type="checkbox" name="service" value="교육"> 
					<span>교육</span>
				</label>
			</div>
		</div>
		<div class="f_row">
			<p class="filter_title">보호자 성별</p>
			<div class="select_box">
				<label class="fcCbox1">
					<input type="checkbox" name="gender" value="여"> 
					<span>여성</span>
				</label>
				<label class="fcCbox1"> 
					<input type="checkbox" name="gender" value="남"> 
					<span>남성</span>
				</label>
			</div>
		</div>
		<div class="f_row">
			<p class="filter_title">동물종류</p>
			<div class="select_box">
				<label class="fcCbox1"> 
					<input type="checkbox" name="pet_kind" value="개"> 
					<span>개</span>
				</label> 
				<label class="fcCbox1">
					<input type="checkbox" name="pet_kind" value="고양이"> 
					<span>고양이</span>
				</label> 
				<label class="fcCbox1">
					<input type="checkbox" name="pet_kind" value="관상어"> 
					<span>관상어</span>
				</label> 
				<label class="fcCbox1"> 
					<input type="checkbox" name="pet_kind" value="새"> 
					<span>새</span>
				</label> 
				<label class="fcCbox1"> 
					<input type="checkbox" name="pet_kind" value="파충류"> 
					<span>파충류</span>
				</label>
				<label class="fcCbox1"> 
					<input type="checkbox" name="pet_kind" value="기타"> 
					<span>기타</span>
				</label>
			</div>
		</div>
		<div class="f_row">
			<p class="filter_title">위치</p>
			<div class="select_box">
				<input type="hidden" id="qszipcode" value="${qszipcode}" >
				<input type="hidden" id="qsaddrp" value="${qsaddrp}" >
				<input type="hidden" id="authUser" value="${authUser.user_no}" >
				<input type="hidden" id="zipcode" value="${userInfo.zipcode }" >
				<p class="filter_title" id="zipcodeP">[${userInfo.zipcode }]</p>
				<p class="filter_title" id="addrP">${userInfo.addr }</p>
				<input type="button" id="findAreaBtn" value="내주변찾기" class="filter_title" >
			</div>
		</div>
	</div>
	<div>
		<div>
			<div class="content" id="mapDiv">
				<h3 class="form_title fs24">지도</h3>
				<div class="map_wrap">
				    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
				     <div class="hAddr">
				        <span id="centerAddr"></span>
				    </div>
				</div>
				<br>
			</div>
		</div>
	</div>
	<!-- 카드형 리스트 펫찾기 -->
	<div class="card_list_type find_pet_list" id="card_list"></div>
</div>
<div class="go_top"><i class="fa-solid fa-arrow-up-long"></i></div>
