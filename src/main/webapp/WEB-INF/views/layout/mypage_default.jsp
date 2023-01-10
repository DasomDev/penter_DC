<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<!DOCTYPE html>
<html>
<head>
<c:import url='/WEB-INF/views/include/common_head.jsp' />
<title>${title}</title>
</head>


<style>
	.my_profile .edit_btn{
	  width: 25px;
    height: 25px;
    background: #e8a87e;
    border-radius: 50%;
    display: flex;
    justify-content: center;
    align-items: center;
    position: absolute;
    right: -4px;
    bottom: 3px;
    font-size: 1rem;
	}
</style>

<script>
	$(document).ready(function(){	
		$(".toggle input").click( function(){
			
				$(".text1").toggleClass("active");
				$(".text2").toggleClass("active");

				if ($(this).is(':checked')) { // check가 보호자임        
					var owner_menu1 = "";
					owner_menu1 += "<a href='${pageContext.request.contextPath}/mypage'>나의 정보</a>"
											+  "<a href='${pageContext.request.contextPath}/mypage/myPetInfo'>나의반려동물정보</a>";

					var owner_menu2 = "";
					owner_menu2 += "<a href='${pageContext.request.contextPath}/mypage/myService/requireServic'>서비스 요청하기</a>"
							+ "<a href='#'>요청한 서비스보기</a>";
					$(".toggle_menu1").html(
							owner_menu1);
					$(".toggle_menu2").html(
							owner_menu2);

				} else { // 시터일경우
					var sitter_menu1 = "";
					sitter_menu1 += "<a href='${pageContext.request.contextPath}/mypage'>나의 정보</a>"
							+ "<a href='#'>나의시터정보보기</a>";

					var sitter_menu2 = "";
					sitter_menu2 += "<a href='#'>나의펫시팅활동</a>"
							+ "<a href='#'>내가받은요청</a>"
							+ "<a href='#'>내가찜한요청</a>";
					$(".toggle_menu1").html(
							sitter_menu1);
					$(".toggle_menu2").html(
							sitter_menu2);
				}
		})
		
		//console.log("첵첵ㅎg")
		// 프로필 ajax
		/* $("#file").change(function(){
			// 필요한 정보 id users=>file_no 업데이트,
			// file_tb에 user_no=와 board_no 5인것이 없다면 insert, 있다면 update처리 
			let user_no = ${mypageSession.user_no};
			
			console.log("첵첵"+user_no)
			$.ajax({
				url : "${pageContext.request.contextPath}/mypage/profileImgEdit", //문자열로 인식이 되는게 아니라 서버에서 el값으로 먼저 치환후 js통신을 한다.
				type : "POST",
				data : {"user_no":user_no}, //post방식일때 값을 여기에 넣어줌
				success:function(response){
					
					console.log(response);
					
					if(response.result != "success"){
						console.error(response.message);
						return;
					}else{ //성공일때 jason 렌더
						console.log("보고싶다이문구")
						//arrData = response.data;
						//getList();
					}
				},
				error : function(xhr, error){ //xmlHttpRequest?
						console.error("완전error : "+error);
				}
			});
		}) */
	})
</script>
<body>
	<div id="wrapper">
		<!-- HEADER BASIC -->
		<c:import url='/WEB-INF/views/include/header.jsp' />
		<!-- CONTAINER -->
		<div class="container">
			<div class="mypage_wr w100">	
				<div class="my_profile">
					<div class="">
						<!-- 이미지영역 -->
						<div class="prof_img">
							<c:if test="${mypageSession.file_no==0}">
								<img src="${imgPath}/noimg.webp" alt="노프로필" id="prof_img_view"/>
							</c:if>
							<c:if test="${mypageSession.file_no != 0}">
								<img class="img_wrap img" src="${pageContext.request.contextPath}/getImg/${mypageSession.file_no}"/>
							</c:if>
							<!-- <label for="file" class="pet_btn edit_btn prof_btn">
								<i class="fa-solid fa-pen" id="pen"></i>
							</label> -->
							<!-- <input type="file" id="file_root" name="imageFileRoot" hidden="hidden"></input> -->
							
						</div>
						<!-- 텍스트정보 영역 -->
						<div class="prof_text">
							<div class="row1">
								<p>${mypageSession.nickname}</p>
							</div>
							<div class="row2">
								<p>
									<a href="#">팔로워<span class="f_val">122</span></a>
								</p>
								<p>
									<a href="#">팔로잉<span class="f_val">122</span></a>
								</p>
								<p>
									<span class="badge">최강기요미</span>
								</p>
							</div>
						</div>
					</div>
				</div>

				<div class="my_view">
					<div class="side_menu">
						<!-- 조건 둘다일경우만 user_type 3일 경우에만토글 출력 -->
						<c:if test="${authUser.user_type==3}">
							<div class="toggle">
								<label class="switch"> <input type="checkbox"> <span
									class="slider round"></span> <span class="texts"> <span
										class="text1 active">펫시터</span> <span class="text2">보호자</span>
								</span>
								</label>
							</div>
						</c:if>
						<ul>
							<c:choose>
								<c:when test="${authUser.user_type==1}">
									<!-- 시터일경우 -->
									<li>
										<p class="first_menu">내정보</p>
										<div class="second_menu toggle_menu1">
											<a href="${pageContext.request.contextPath}/mypage">나의 정보</a>
											<a href="${pageContext.request.contextPath}/mypage/mySitterInfo">나의 시터정보 관리</a>
										</div>
									</li>
									<li>
										<p class="first_menu">나의 서비스</p>
										<div class="second_menu toggle_menu2">
											<a href="#">나의펫시팅활동</a> <a href="#">내가 받은 요청</a> <a href="#">내가
												찜한 요청</a>
										</div>
									</li>
								</c:when>

								<c:when test="${authUser.user_type==2}">
									<!-- 보호자일경우 -->
									<li>
										<p class="first_menu">내정보</p>
										<div class="second_menu toggle_menu1">
											<a
												href="${pageContext.request.contextPath}/mypage">나의 정보</a>
											<a href="${pageContext.request.contextPath}/mypage/myPetInfo">나의반려동물정보</a>
										</div>
									</li>
									<li>
										<p class="first_menu">나의 서비스</p>
										<div class="second_menu toggle_menu2">
											<a href="${pageContext.request.contextPath}/mypage/myService/requireService">서비스 요청하기</a>
											<a href="${pageContext.request.contextPath}/mypage/myService/requireServiceList">요청한 서비스 보기</a>
										</div>
									</li>
								</c:when>
								<c:otherwise>
									<li>
										<p class="first_menu">내정보</p>
										<div class="second_menu toggle_menu1">
											<a
												href="${pageContext.request.contextPath}/mypage">나의 정보</a>
											<a href="${pageContext.request.contextPath}/mypage/mySitterInfo">나의 시터정보 관리</a>
										</div>
									</li>
									<li>
										<p class="first_menu">나의 서비스</p>
										<div class="second_menu toggle_menu2">
											<a href="#">나의펫시팅활동</a> <a href="#">내가 받은 요청</a> <a href="#">내가
												찜한 요청</a>
										</div>
									</li>
								</c:otherwise>

							</c:choose>
							<li>
								<p class="first_menu">리뷰관리</p>
								<div class="second_menu">
									<a href="${pageContext.request.contextPath}/mypage/review/myReviewList">리뷰 쓰기</a> 
									<a href="${pageContext.request.contextPath}/mypage/review/writtenReviewList">내가 쓴 리뷰</a> 
									<a href="${pageContext.request.contextPath}/mypage/review/receiveReviewList">내가 받은 리뷰</a>
								</div>
							</li>
							<li>
								<p class="first_menu">고객센터</p>
								<div class="second_menu">
									<a href="${pageContext.request.contextPath}/kaChat">1:1문의</a>
								</div>
							</li>
						</ul>
					</div>

					<div class="cont_view">
						<c:import url='/WEB-INF/views/${page}.jsp' />
					</div>
				</div>
			</div>
		</div>

		<!-- FOOTER BASIC -->
		<c:import url='/WEB-INF/views/include/footer.jsp'/>

	</div>
</body>
</html>