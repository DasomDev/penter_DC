<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<div class="content">
	<div class="list_type_A">
		<ul>
			<li>
				<div class="col1">
					<!-- 동물이미지영역 -->
					<div class="img_area">
						<p class="pet_img">
							v <img
								src="https://img.wkorea.com/w/2022/10/style_634f9b4c8c907-500x354-1666161931.jpg"
								alt="이미지">
						</p>
					</div>
					<!-- 텍스트정보 영역 -->
					<div class="text_area">
						<div class="flex_agn_center mb10">
							<p class="title">내일 방문해서 사료주실분</p>
							<!-- 상태값이 있으면 span으로 추가 -->
							<span class="status com">완료</span>
						</div>
						<p class="cont">강아지 두마리 고양이 1마리 ㅅ세달동안 방문케어 해주실 시터분을 구해요
							어쩌고저쩌고저쩌고시터분을 구해요 어쩌고저쩌고저쩌고시터분을 구해요 어쩌고저쩌고저쩌고</p>
						<p class="rate">
							<i class="fa-solid fa-paw"></i> <i class="fa-solid fa-paw"></i> <i
								class="fa-solid fa-paw"></i> <i class="fa-solid fa-paw"></i> <i
								class="fa-solid fa-paw"></i>
						</p>
					</div>
				</div>
				<div class="col2">
					<!-- 완료된경우 리뷰버튼 -->
					<p class="pet_btn review_btn">리뷰쓰기</p>
					<p class="date">2022/10/23</p>
				</div>
			</li>
			<li>
				<div class="col1">
					<!-- 동물이미지영역 -->
					<div class="img_area">
						<p class="pet_img">
							<img
								src="https://img.wkorea.com/w/2022/10/style_634f9b4c8c907-500x354-1666161931.jpg"
								alt="이미지">
						</p>

					</div>
					<!-- 텍스트정보 영역 -->
					<div class="text_area">
						<div class="flex_agn_center mb10">
							<p class="title">내일 방문해서 사료주실분</p>
							<!-- 상태값이 있으면 span으로 추가 -->
							<span class="status com">완료</span>
						</div>
						<p class="cont">강아지 두마리 고양이 1마리 ㅅ세달동안 방문케어 해주실 시터분을 구해요
							어쩌고저쩌고저쩌고시터분을 구해요 어쩌고저쩌고저쩌고시터분을 구해요 어쩌고저쩌고저쩌고</p>
						<p class="rate">
							<i class="fa-solid fa-paw"></i> <i class="fa-solid fa-paw"></i> <i
								class="fa-solid fa-paw"></i> <i class="fa-solid fa-paw"></i> <i
								class="fa-solid fa-paw"></i>
						</p>
					</div>
				</div>
				<div class="col2">
					<!-- 완료된경우 리뷰버튼 -->
					<p class="pet_btn review_btn">리뷰쓰기</p>
					<p class="date">2022/10/23</p>
				</div>
			</li>
		</ul>
	</div>
</div>
