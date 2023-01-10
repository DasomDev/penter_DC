<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />
<!DOCTYPE html>
<html>
<head>
<c:import url='/WEB-INF/views/include/common_head.jsp' />
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2d6fc6008c147d8c5d81603f2166c5d&libraries=services"></script>
<title>${title}</title>
<style>
.feed_wrap{border-bottom: 1px solid var(--fcc-border);}
.filter_feed{border-bottom:0;}
.feed_btn{
    float: right;
    padding: 10px;
    font-size: 2rem;
    color: var(--navy);
    cursor: pointer;
}
.data_view {
	display: flex;
	width:100%;
	gap: 40px;
	margin-top: 40px;
}

.map_wrap {
	width: 47%;
	height: 390px;
	background-color: beige;
	border-radius: 10px;
	overflow: hidden;
}

.map_wrap img {
	width: 100%;
}

.find_pet_list {
	width: 58%;
	padding: 4px;
	box-shadow: none;
	display:block;
}

.find_pet_list .summary {
	padding-bottom: 10px;
	font-size: 1.4rem;
}

.find_pet_list ul {
	gap: 35px;
	height: 850px;
	overflow-y: scroll;
	padding: 4px;
}

.find_pet_list ul::-webkit-scrollbar {
	display: none;
}

.find_pet_list {
	
}

.find_pet_list li {
	max-width: 240px;
	height:fit-content;
	margin-top: 0;
	/* max-width: 420px; */
	flex-direction: column;
}

.find_pet_list li .data {
	
}

.find_pet_list li .img_area {
	border-radius: 5px;
	width: 100%;
	height: 158px;
	max-height: 200px;
	margin: 0;
	margin: 20px auto;
}
.card_list_type li img{height:fit-content}

.find_pet_list .info {
	width: 100%;
	display: flex;
	justify-content: space-between;
	align-items: center;
	font-size: 1.4rem
}

.find_pet_list .owner_img {
	width: 45px;
	height: 45px;
	background-color: pink;
	border-radius: 50%;
	overflow: hidden;
	margin-right: 8px
}

.find_pet_list .status {
	background-color: red;
	border-radius: 5px;
	padding: 4px;
	color: #fff;
}

.find_pet_list .text_area {
	width: 100%
}

.find_pet_list .text_area .title {
	font-weight: 500;
	padding-bottom: 8px
}

.find_pet_list .text_area .content {
	padding-bottom: 8px
}

.find_pet_list .text_area .view_info {
	margin-top: 10px;
	display: flex;
	justify-content: space-between;
}

.find_pet_list .text_area .view_info .date {
	background-color: #eee;
	padding: 4px 6px;
	border-radius: 5px;
}
</style>
</head>
<script>

var rowData;
var objData;

$(document).ready(function() {
	getPetList();
	console.log("첵첵");
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
									   mapOption = {
									        center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
									        level: 3 // 지도의 확대 레벨
									   };  
	
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	
	// 지도이동 이벤트 
	kakao.maps.event.addListener(map, 'center_changed', function() {
		console.log('center changedㅎㅎㅎ!');
		// 센터의 위도경도
		var center = map.getCenter();
		// 이 위도 경도의 zip 코드 검색
		console.log("센터 위도경도"+center);
		console.log("위도"+center.getLat());
		console.log("경도"+center.getLng());
		
		var geocoder = new kakao.maps.services.Geocoder();

		var coord = new kakao.maps.LatLng(center.getLat(), center.getLng());
		
		console.log("센터 위도경도 주소ㄹㄹㄹ??"+coord);
		
		var callback = function(result, status) {
		    if (status === kakao.maps.services.Status.OK) {
		        console.log('그런 너를 마주칠까 ' + result[0].address.address_name + '을 못가');
		    }
		};

		geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
		
		getPetListByLocation();
	})

	
	
	
	//위로가기	
	$(document)
	.on("click", ".feed_btn", function(){
	 	$(".filter_feed").slideToggle();
	})
	.on("click", ".go_top", function(){
    	$('html, body').animate({scrollTop:0}, '200');
  })
  .on("click", "#current_btn", function(){
	  	getPetListByCurrLocation();
  });
	
	
		
	
});//ready
	
	// json data 가져오기
	function getPetList(){
		var strURL = "${pageContext.servletContext.contextPath}/findPetTest/getJsonData";
				
		objData = getJsonData(strURL, {});
			
			if(objData.result != "success"){
				alert(objData.error_message);
			}else{
				rowData = objData.data;
				renderList();
				//console.log("rowData.data1?"+rowData);	
	    }
	};
	
	
	// 리스트 그리기
	function renderList(){
			var strHTML = '';
			for ( var i in rowData){
				
				strHTML += "<li>"
								+  "<div class='info'>" 
								+  "<div class='flex_agn_center'>" 
								+  "<div class='owner_img'><img src='${pageContext.request.contextPath}/getImg/"+ rowData[i].USER_FILE_NO +" '></div>"
								+	 "<span>" +rowData[i].NICKNAME+ "</span>"
								+  "</div>" 
								+  "</div>"
								+  "<div class='img_area'><img src='${pageContext.request.contextPath}/getImg/"+ rowData[i].FILE_NO +" '/></div>"
								+	 "<div class='text_area'>"
								+	 "<div>" +rowData[i].REQUEST_TITLE+ "</div>"
								+	 "<div>" +rowData[i].REQUEST_DETAIL+ "</div>"
								
								+  "<div class='view_info'>"
								+  "<span class='date'>2021.211212</span>"
								+  "<p><span><i class='fa-solid fa-comment-dots'></i>20</span>"
								+	 "<span><i class='fa-regular fa-eye'></i> 13</span></p>"
								+  "</div>"
								+  "</div>"
								+  "</li>";
							
			}
			$(".find_pet_list ul").html(strHTML);
			console.log(strHTML);
	}
	
	
	// 지도 API 현재위지기반으로 리스트 찾기
	function getPetListByCurrLocation(){
		alert("adni");
	}
	
	// 내주소로 시터찾기
	
	// 화면 상단 버튼 
	$(window).scroll(function(){
		//var scrollValue = $(document).scrollTop(); 
		//console.log(scrollValue);
		if ($(this).scrollTop() > 400) {
	  	$('.go_top').fadeIn();
		}else {
			$('.go_top').fadeOut(); 
		}
	});
</script>
<!-- CONTAINER -->
<div class="container w120">
	<div class="">
		<p class="list_title">펫시터 찾기</p>
		<!-- 시터성별, 요일, 서비스, 동물종류 필터 피드-->
		<div class="feed_wrap">
			<div class="feed_btn"><i class="fa-solid fa-square-minus"></i></div>
			<div class="filter_feed">
				<!-- 날짜 -->
				<div class="f_row">
					<p class="filter_title">가능한 날짜를 선택해주세요</p>
					<div class="select_box">
						<input type="text" class="date-picker" id="date_start"
							name="st_date" autocomplete="off"
							style="height: 29px; width: 162px; text-align: center;">&nbsp;~&nbsp;
						<input type="text" class="date-picker" id="date_end"
							name="end_date" autocomplete="off"
							style="height: 29px; width: 162px; text-align: center;">
					</div>
				</div>
				<!-- 서비스 -->
				<div class="f_row">
					<p class="filter_title">서비스</p>
					<div class="select_box">
						<label class="fcCbox1"> <input type="checkbox"
							name="service" value="방문관리"> <span>방문관리</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="service" value="산책"> <span>산책</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="service" value="목욕"> <span>목욕</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="service" value="교육"> <span>교육</span>
						</label>
					</div>
				</div>
				<div class="f_row">
					<p class="filter_title">보호자 성별</p>
					<div class="select_box">
						<label class="fcCbox1"> <input type="checkbox"
							name="gender" value="여"> <span>여성</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="gender" value="남"> <span>남성</span>
						</label>
					</div>
				</div>
				<div class="f_row">
					<p class="filter_title">동물종류</p>
					<div class="select_box">
						<label class="fcCbox1"> <input type="checkbox"
							name="pet_kind" value="개"> <span>개</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="pet_kind" value="고양이"> <span>고양이</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="pet_kind" value="관상어"> <span>관상어</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="pet_kind" value="새"> <span>새</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="pet_kind" value="파충류"> <span>파충류</span>
						</label> <label class="fcCbox1"> <input type="checkbox"
							name="pet_kind" value="기타"> <span>기타</span>
						</label>
					</div>
				</div>
				<div class="f_row">
					<p class="filter_title">위치</p>
					<div class="select_box">
						<input type="hidden" id="qszipcode" value="${qszipcode}">
						<input type="hidden" id="qsaddrp" value="${qsaddrp}">
						<input type="hidden" id="authUser" value="${authUser.user_no}">
						<input type="hidden" id="zipcode" value="${userInfo.zipcode }">
						<%-- <p class="filter_title" id="zipcodeP">[${userInfo.zipcode }]</p> --%>
						<p class="filter_title" id="addrP">${userInfo.addr }</p>
						<input type="button" id="current_btn" value="현재위치로 찾기"	 class="filter_title">
						<input type="button" id="myaddr_btn" value="내주소로 찾기" class="filter_title"/>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- 지도&리스트 -->
	<div class="data_view">
		<div class="map_wrap">
			<div id="map" style="height: 100%;"></div>
			<div class="hAddr">
				<span id="centerAddr"></span>
			</div>
		</div>
		<!-- 카드형 리스트 펫찾기 -->
		<div class="card_list_type find_pet_list">
			<div class="summary">총 236개의 결과를 찾았어요</div>
			<ul class="flex_between">
				<!-- li 구조  -->
				<li>
					<div class="info">
						<div class="flex_agn_center">
							<div class="owner_img">
								<img src="" alt="사진쓰">
							</div>
							<span>김곽곽</span>
						</div>
						<span class="status open">매칭중</span>
					</div> 
					<!-- 동물사진 -->
					<div class="img_area">
						<img
							src="https://img.wkorea.com/w/2022/10/style_634f9b4c8c907-500x354-1666161931.jpg"
							alt="이미지">
					</div> <!-- 시팅요청사항디테일 -->
					<div class="text_area">
						<div class="title">제목제목제목</div>
						<div class="content">내용내용내용엘립시스처리하세요</div>
						<div class="view_info">
							<span class="date">2021.211212</span>
							<p>
								<span class="mr12"><i class="fa-solid fa-comment-dots"></i>20</span>
								<span><i class="fa-regular fa-eye"></i> 13</span>
							</p>
						</div>
					</div>
				</li>
			</ul>
		</div>
	</div>
</div>

<div class="go_top"><i class="fa-solid fa-arrow-up-long"></i></div>

<!--  function getJsonData(){
		console.log("데이터를 jason으로 가져오자");
		$.ajax({
			url : "${pageContext.servletContext.contextPath}/findPetTest/getJsonData",
			type : "GET",
			dataType : "json",
			data :{"id":"coconut"}
			success:function(response){
				
				console.log(response);
				
				if(response.result != "success"){
					console.error(response.message);
					return;
				}else{ //성공일때 jason 렌더
					arrData = response.data;
					renderList();
					console.log("데이터를뿌리자");
				}
			},
			error : function(xhr, error){ //xmlHttpRequest?
					console.error("완전error 2: "+error);
			}
	
		})
	}  -->