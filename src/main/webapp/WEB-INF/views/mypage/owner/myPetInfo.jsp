<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images" />


<style>
   .mypet_card{max-width: 460px;}
   .mypet_card img{width:100%; height: inherit;}
   .mypet_card li{
     padding: 28px;
     margin-top:20px;
     border-radius: 10px;
     background:#fefefe;
     /* border:1px solid #ddd; */
    	box-shadow: 1px 1px 5px 2px rgba(222,222,222,0.75);
     -webkit-box-shadow: 1px 1px 5px 2px rgba(222,222,222,0.75);
     -moz-box-shadow: 1px 1px 5px 2px rgba(222,222,222,0.75);
   }
   
   .mypet_card .edit{text-align:right; padding-bottom:5px}
   .mypet_card .pet_img{
     background-color: tan;
     width: 140px;
     height: 140px;
     margin: 0 auto;
     background-color: grey;
     border-radius: 50%;
     overflow: hidden;
     margin-bottom:40px;
   }
   .mypet_card .text_info > *:not(:last-child){
     padding-bottom:15px;
   }
   .mypet_card .text_info .field{
     min-width: 120px;
     display:inline-block
   }
   .mypet_card .text_info .detail{
    display: flex;
    flex-direction: column;
    border-top: 1px solid #ddd;
    padding-top: 15px;

   }
   .mypet_card .text_info .detail .field{padding-bottom:10px;}
   

 </style>

<div class="content">

	<c:if test="${empty data}">
		<div>
			<p class="mb25">등록된 반려동물 정보가 없어요.</p>
			<a href="${pageContext.request.contextPath}/petForm" class="pet_btn">반려동물
				정보 등록하기</a>
		</div>
	</c:if>

	<c:if test="${not empty data}">
		<p class="menu_title">
			<span>나의 반려동물</span>
			<a href="${pageContext.request.contextPath}/petForm" class="icon">
				<i class="fa-solid fa-square-plus"></i>
			</a>
		</p>

		<ul class="mypet_card">
			<c:forEach items="${data}" var="data">
				<li pet_no="${data.pet_no}">
					<p class="edit ">
						<a href="${pageContext.request.contextPath}/mypage/myPetInfoEdit?petNo=${data.pet_no}"><i class="fa-regular fa-pen-to-square"></i></a>
					</p>
					<div class="pet_img">
						<img src="${pageContext.request.contextPath}/${data.pet_no}" alt="동물이미지">
					</div>
					<div class="text_info">
						<p>
							<span class="field">이름</span>
							<span class="value">${data.pet_name}</span>
						</p>
						<p>
							<span class="field">성별</span>
							<span class="value">${data.pet_gender}</span>
						</p>
						<p>
							<span class="field">종류</span>
							<span class="value">${data.pet_kind}</span>
						</p>
						<p>
							<span class="field">체중</span>
							<span class="value">${data.pet_weight}</span>
						</p>
						
						<p class="detail">
							<span class="field">특이사항</span>
							<span class="value" style="display:inline-block; word-break: normal;">${data.pet_info}</span>
						</p>
					</div>
				</li>
				
			</c:forEach>
		</ul>


	</c:if>

</div>