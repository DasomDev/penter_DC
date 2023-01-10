<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2d6fc6008c147d8c5d81603f2166c5d&libraries=services"></script>
<script>
	$(document).ready(function() {
		
		
		var serviceArr = [];
		var petKindArr = []; 
		var genderArr = [];
		var dayArr = [];
		//펫시터 성별
		$(document).on("click", "input[name=gender]", function () {
			genderArr = [];
		    $("input[name='gender']:checked").each(function(e){
		        var value = $(this).val();
		        genderArr.push(value);        
			})
			console.log("genderArr:  "+genderArr);
		    searchAjax();
		});
		//필요한 서비스
		$(document).on("click", "input[name=service]", function () {
			serviceArr = [];
		    $("input[name='service']:checked").each(function(e){
		        var value = $(this).val();
		        serviceArr.push(value);        
			})
			console.log("serviceArr:  "+serviceArr);
		    searchAjax();
		});
		//동물 종류
		$(document).on("click", "input[name=pet_kind]", function () {
			petKindArr = [];
		    $("input[name='pet_kind']:checked").each(function(e){
		        var value = $(this).val();
		        petKindArr.push(value);        
			})
			console.log("petKindArr:  "+petKindArr);
		    searchAjax();
		});
		//가능한 요일
		$(document).on("click", "input[name=day]", function () {
			dayArr = [];
		    $("input[name='day']:checked").each(function(e){
		        var value = $(this).val();
		        dayArr.push(value);        
			})
			console.log("dayArr:  "+dayArr);
		    searchAjax();
		});
		
		var addr = [];
		
		function searchAjax(){
			
			// 성별, 서비스, 동물종류, 요일
			var gender = genderArr;
			var service = serviceArr;
			var pet_kind = petKindArr;
			var day = dayArr;
			var zipcode = $("#zipcode").val();
			
			// contentType: "application/json" 꼭 써주기
	 		$.ajax({
				url : "${pageContext.servletContext.contextPath}/findSitter/findSitterSearch",
				type : "POST",
				dataType: "json",
				contentType: "application/json",
				data:JSON.stringify({
				    	 "gender":gender
				    	,"service":service
				    	,"pet_kind":pet_kind
				    	,"day":day
				    	,"zipcode":zipcode
				  }),
				success : function(data) {
					console.log("data"+data);
					var str = '';
					if(data.length == 0){
						$("#card_list").empty();
						str +='<ul>';
						str +='<li>';
						str +='<div class="data">';
						str +='<div>';
						str +='<span class="see_info">조회된 데이터가 없습니다.</span>';
						str +='</div>';
						str +='</div>';
						str+='</li>';
						str+='</ul>';
						$("#card_list").append(str);
					}else{
						$("#card_list").empty();
						var days_ko = ["일요일", "월요일", "화요일", "수요일", "목요일", "금요일", "토요일"];
						var days_en = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"];
						
						var dayStr;
						
						$.each(data, function(i, item) { // 데이터 =item
							dayStr = item.WORK_DAY; // mon,wed
							strArr = dayStr.split(","); // 배열로 변환
							//console.log("strArr"+strArr); //배열크기만큼 돌면서 인덱스 가져와서 글자 바꿈
							
							for(var i in strArr){
							    
							    var idx = days_en.indexOf(strArr[i]);
							    //console.log("idxforstrArr["+strArr[i]+"]:"+idx);//02
							    strArr[i] = days_ko[idx]
							}
							
							//console.log("요일"+strArr)
							
							str +='<ul>';
							str +='<li user_no="'+item.USER_NO+'">';
							str +='<div class="data">';
							<!-- 이미지영역 -->
							str +='<div class="img_area">';
							str +='<img src="${pageContext.request.contextPath}/getImg/'+ item.FILE_NO +'" alt="프로필이미지">';
							str +='</div>';
							<!-- 텍스트정보 영역 -->
							str +='<div class="text_area">';
							str +='<div class="row1">';
							str +='<p><span class="nick">'+ item.NICKNAME +'</span></p>';
							str +='<p><span class="id">'+ item.ID +'</span></p>';
							str +='</div>';
							str +='<div class="row2">';
							str +='<p><a href="#">팔로워<span class="f_val">122</span></a></p>';
							str +='<p><a href="#">팔로잉<span class="f_val">122</span></a></p>';
							str +='</div>';
							str +='<div class="row3">';	
							str +='<span class="days">'+strArr+'</span>';
							str +='<div class="see_info">펫시터 소개보기</div>';
							str +='</div>';
							str +='<div class="row4">'+item.SITTER_INFO+'</div>';
							str +='</div>';
							str +='</div>';
							str +='<div class="icons">';
							str+= '<form action="createChat.do" method="POST" >';
							str+= '<input type="hidden" id="user_nickname" name="user_nickname" value= "${authUser.nickname}"/>';
							str+= '<input type="hidden" id="user_id" name="user_id" value= "${authUser.id}"/>';
							str+= '<input type="hidden" id="another_nickname" name="another_nickname" value="'+item.NICKNAME+'"/>';
							str+= '<input type="hidden" id="another_id" name="another_id" value="'+item.ID+'"/>';	
							str+= '<button type="submit" id="chatting"><i class="fa-solid fa-comment-dots"></i></button>';
							str +='<a href="#" title="저장하기" class="transition02 heart"><i class="fa-solid fa-heart"></i></a>';
							str +='<a href="javascript:follow();" title="팔로우하기" class="transition02 follow"><i class="fa-solid fa-user-plus"></i></a>';
							str +='<a href="#" title="팔로우하기" class="transition02 follow"><i class="fa-solid fa-user-plus"></i></a>';
							str+= '</form>';	
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
				                    console.log(result[0].address.region_1depth_name);
				                    console.log(result[0].address.region_2depth_name);
				                    console.log(result[0].address.region_3depth_name);
				                    if(!result[0].road_address.zone_no){
				                    	alert("현재 위치의 정보를 불러올 수 없습니다.");
				                    }else{
				                    	console.log(result[0].road_address.zone_no);
				                    	 $("#zipcodeP").text("["+result[0].road_address.zone_no+"]");
						                 $("#zipcode").val(result[0].road_address.zone_no);
				                    }
				                    $("#addrP").text(result[0].address.address_name);
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
	
			    // 정상적으로 검색이 완료됐으면 
		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        var message = '<div style="padding:5px;">사용자 위치</div>'; // 인포윈도우에 표시될 내용입니다
		        
		        // 결과값으로 받은 위치를 마커로 표시합니다
		        var marker = new kakao.maps.Marker({
		            map: map,
		            title: "현위치",
		            position: coords
		        });

		        var iwContent = message, // 인포윈도우에 표시할 내용
                iwRemoveable = true;

	            // 인포윈도우를 생성합니다
	            var infowindow = new kakao.maps.InfoWindow({
	                content : iwContent,
	                removable : iwRemoveable
	            });
	            
	            // 인포윈도우를 마커위에 표시합니다 
	            infowindow.open(map, marker);
            
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
				
				// 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
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
//----------------------------------------------------------------------------------------------------
		$(document)
		    .on("click", ".see_info", function(){
		    	var infoStr = $(this).parents("li").find(".row4").text();
		      showModal(infoStr);
		    })
		    .on("click", ".modal_mask", function(){
		      deleteModal();
		    })  
		    .on("click", ".go_top", function(){
		    	$('html, body').animate({scrollTop:0}, '200');
		    }) 
		   
		
	})
	
	
	$(window).scroll(function(){
		//var scrollValue = $(document).scrollTop(); 
		//console.log(scrollValue);
    if ($(this).scrollTop() > 400) {
      $('.go_top').fadeIn();
    }else {$('.go_top').fadeOut(); }
  });  
	
  function showModal(infoStr){
    $("body").prepend("<div class='modal_mask'></div>");
    $(".modal_mask").after("<div class='modal_box'></div>");
    $(".modal_box").append("<div class='content'>"+infoStr+"</div>");
  }

  function deleteModal(){
    $(".modal_box, .modal_mask"). remove();
    // $(".modal_mask"). remove();
  }
  
	//json data 가져오기
	function follow(){
		console.log("팔로우를해보자")
		//var strURL = "${pageContext.servletContext.contextPath}/findPetTest/getJsonData";
				
		//objData = getJsonData(strURL, {});
			
			if(objData.result != "success"){
				alert(objData.error_message);
			}else{
				rowData = objData.data;
				renderList();
				//console.log("rowData.data1?"+rowData);	
	    }
	};
  
  
  function chatting() {
	  document.getElementById('CreateChat').submit();
	  }
    	  
</script>

<style>
	.search_form{display:none;}
	.card_list_type{box-shadow:none}
	.heart:hover{color:var(--red)}
	.follow:hover{color:#6198db}
	.chat:hover{color:var(--orange)}
	
	.card_list_type li .data .row3{
		background-color:#fff;
	}
	.days{
	  background: #e0e0f0;
    padding: 6px;
    border-radius: 5px;
    margin-bottom: 10px;
    display: inline-block;
    color: #6f8693;}
  
  .see_info{    
  	text-decoration: underline;
    cursor: pointer;
    display: inline-block;
    margin-left: 15px;
   }
	.row4{
		display:none;
	  max-width: 520px;
    line-height: 20px;
    overflow: hidden;
  }
  label.fcCbox1{margin-right:0;}
  /* MODAL COMMON */
   .modal_mask{
    display: block;
    position: fixed;
    inset: 0px;
    background-color: rgba(0, 0, 0, 0.5);
    z-index:11
  }
  .modal_box{
    position:fixed;
    left:50%;
    top:50%;
    z-index: 14;
    transform: translate(-50%, -50%);
    background-color: #fff;
    border-radius: 5px;
    padding:20px;
    line-height:24px;
    min-width: 500px;
    max-width: 520px;
    min-height: 300px
   
  }
  .map_wrap {position:relative;width:100%;height:350px;}
  .title {font-weight:bold;display:block;}
  .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
  #centerAddr {display:block;margin-top:2px;font-weight: normal;}
  .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
	
	.card_list_type li .img_area{
		box-shadow: 0px 0px 5px 1px rgba(239 239 239 / 75%);
    -webkit-box-shadow: 0px 0px 5px 1px rgba(239 239 239 / 75%);
    -moz-box-shadow: 0px 0px 5px 1px rgba(239 239 239 / 75%)}
</style>

<!-- CONTAINER -->
<div class="container w90">
	<p class="list_title">펫시터 찾기</p>
	<!-- 시터성별, 요일, 서비스, 동물종류 필터 피드-->
	<div class="filter_feed">
		<!-- 펫시터성별  -->
		<div class="f_row">
			<p class="filter_title">펫시터 성별</p>
			<div class="select_box">
				<label class="fcCbox1"><input type="checkbox" name="gender" value="female"><span>여성펫시터</span></label>
				<label class="fcCbox1"><input type="checkbox" name="gender" value="male"><span>남성펫시터</span></label>
			</div>
		</div>
		<!-- 서비스  -->
		<div class="f_row">
			<p class="filter_title">필요한 서비스</p>
			<div class="select_box">
				<label class="fcCbox1"><input type="checkbox" name="service" value="visit"><span>방문</span></label>
				<label class="fcCbox1"><input type="checkbox" name="service" value="walk"><span>산책</span></label>
				<label class="fcCbox1"><input type="checkbox" name="service" value="shower"><span>목욕</span></label>
				<label class="fcCbox1"><input type="checkbox" name="service" value="education"><span>교육</span></label>
			</div>
		</div>
		<!-- 동물종류 -->
		<div class="f_row">
			<p class="filter_title">동물종류</p>
			<div class="select_box">
				<label class="fcCbox1"><input type="checkbox" name="pet_kind"	value="dog"><span>강아지</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="pet_kind"	value="cat"><span>고양이</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="pet_kind"	value="fish"><span>관상어</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="pet_kind"	value="bird"><span>새</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="pet_kind"	value="reptile"><span>파충류</span></label> 
			</div>
		</div>
		<!-- 요일 -->
		<div class="f_row">
			<p class="filter_title">가능한 요일</p>
			<div class="select_box">
				<label class="fcCbox1"><input type="checkbox" name="day" value="mon"><span>월</span></label>
				<label class="fcCbox1"><input type="checkbox" name="day" value="tue"><span>화</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="day" value="wed"><span>수</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="day" value="thu"><span>목</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="day" value="fri"><span>금</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="day" value="sat"><span>토</span></label> 
				<label class="fcCbox1"><input type="checkbox" name="day" value="sun"><span>일</span></label>  
			</div>
		</div>
		<!-- 위치 -->
		<div class="f_row">
			<p class="filter_title">위치</p>
			<div class="select_box">
				<input type="hidden" value="${authUser.user_no}" id="authUser">
				<p class="filter_title">현재 위치</p>
				<p class="filter_title" id="zipcodeP">[${userInfo.zipcode }]</p>
				<input type="hidden" value="${userInfo.zipcode }" id="zipcode">
				<p class="filter_title" id="addrP">${userInfo.addr }</p>
				<input type="button" value="내주변찾기" class="filter_title" id="findAreaBtn">
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

	<!-- 카드형 리스트 -->
	<div class="card_list_type" id="card_list">
	</div>
	
</div>

<!--  카드리스트의 값을 보내야 되는데 못보내는 중... -->
<%--  <form action= "createChat.do" method="post" id="CreateChat">
							<input type="text" name=user_nickname value= "${authUser.nickname}"/>
							<input type="text" name=user_id value= "${authUser.id}"/>
							<input type="text" name=another_nickname value= "${dataList.nickname}"/>
							<input type="text" name=another_id value=" ${dataList.id}"/>				
							</form>
 --%>


<div class="go_top"><i class="fa-solid fa-arrow-up-long"></i></div>
 