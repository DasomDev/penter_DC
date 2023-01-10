<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=e2d6fc6008c147d8c5d81603f2166c5d&libraries=services"></script>
<title>지도</title>
<style>
    .map_wrap {position:relative;width:100%;height:350px;}
    .title {font-weight:bold;display:block;}
    .hAddr {position:absolute;left:10px;top:10px;border-radius: 2px;background:#fff;background:rgba(255,255,255,0.8);z-index:1;padding:5px;}
    #centerAddr {display:block;margin-top:2px;font-weight: normal;}
    .bAddr {padding:5px;text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
</style>
</head>
<div class="content">
	<h3 class="form_title fs24">지도</h3>
	<div class="map_wrap">
	    <div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
	     <div class="hAddr">
	        <span class="title">지도중심기준 행정동 주소정보</span>
	        <span id="centerAddr"></span>
	    </div>
	</div>
	<br>
</div>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
mapOption = { 
    center: new kakao.maps.LatLng(37.566826, 126.9786567), // 지도의 중심좌표
    level: 5 // 지도의 확대 레벨 
}; 

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
//------------- 지도 띄우기 시작 ------------------
function curLocation(){
	/////////////////지도의 중심을 현재 위치로 변경///////////////////////
	// HTML5의 geolocation으로 사용할 수 있는지 확인합니다 
	if (navigator.geolocation) {
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        var lat = position.coords.latitude, // 위도
	            lon = position.coords.longitude; // 경도
	        var locPosition = new kakao.maps.LatLng(lat, lon) // geolocation으로 얻어온 좌표
	        var message = '<div style="padding:5px;">현위치</div>'; // 인포윈도우에 표시될 내용입니다
	       
	        //map.setCenter(locPosition);   
	        displayMarker(locPosition, message);// 마커와 인포윈도우를 표시합니다
	        var lng = lon;
	        //좌표 > 도로명주소
	        getAddr(lat,lng);
	        function getAddr(lat,lng){
	            let geocoder = new kakao.maps.services.Geocoder();

	            let coord = new kakao.maps.LatLng(lat, lng);
	            let callback = function(result, status) {
	                if (status === kakao.maps.services.Status.OK) {
	                    console.log(result[0].address.address_name);
	                    console.log(result[0].address.region_1depth_name);
	                    console.log(result[0].address.region_2depth_name);
	                    console.log(result[0].address.region_3depth_name);
	                }
	            }
	            geocoder.coord2Address(coord.getLng(), coord.getLat(), callback);
	        }
	      });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다

		var locPosition = new kakao.maps.LatLng(37.4812845080678, 126.952713197762),
			message = '현재 위치를 알 수 없어 기본 위치로 이동합니다.'

		currentLatLon['lat'] = 33.450701
		currentLatLon['lon'] = 126.570667

		displayMarker(locPosition, message);
	}
	
	return true;
}
//------------- 지도 띄우기 끝 ------------------
//------------- 마커 생성 시작 ------------------
function displayMarker(locPosition, message) {
	var imageSize = new kakao.maps.Size(24, 35);
	var imageSrc ="https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/markerStar.png";
	var markerImage = new kakao.maps.MarkerImage(imageSrc, imageSize);

	// 마커를 생성합니다
	var marker = new kakao.maps.Marker({
		map: map, 
		position: locPosition, 
		image : markerImage
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

	// 지도 중심좌표를 접속위치로 변경합니다
	map.setCenter(locPosition);
}
//------------- 마커 생성 끝 ------------------

$(document).ready(function() {
	//지도 불러오기
	curLocation();
	
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
});
</script>