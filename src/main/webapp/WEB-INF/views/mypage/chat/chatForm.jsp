<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />
<!DOCTYPE html>
<html lang="en">
<head>
<c:import url='/WEB-INF/views/include/common_head.jsp' />
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Petner Chat</title>

<style>
@import url('https://fonts.googleapis.com/css2?family=Dongle:wght@700&display=swap');

.display-none {
	display: none;
}

.chatListContainer {
	width: 420px;
	min-height: 400px;
	border-radius: 10px;
	margin: 30px auto;
}

.chatList {
	margin: 20px 10px;
}

.chatContainer {
	border-radius: 10px;
	width: 400px;
	height:540px;
	margin: 30px auto;
	background: #fefefe;
	border: 1px solid #ccc;
	box-shadow: 2px 5px 17px 3px rgba(186, 186, 186, 0.51);
	-webkit-box-shadow: 2px 5px 17px 3px rgba(186, 186, 186, 0.51);
	-moz-box-shadow: 2px 5px 17px 3px rgba(186, 186, 186, 0.51);
	over-flow:hidden;
}

.chatTop {

    padding: 10px;
    height: 50px;
    border-bottom: 1px solid #ddd;
    display: flex;
    align-items: center;
    justify-content: space-between;
	
}

.chatIcon {
	display: inline-block;
	vertical-align: middle;
	background-color: orange;
	border-radius: 50%;
}

.listTitle {
	font-size: 70px;
	font-family: 'Dongle', sans-serif;
	color: #FFB432;
	padding: 10px;
}

#loginOn{
	 display: flex;
   align-items: center;
   gap: 12px;
}
.right {
	text-align: right;
}

.Left {
	text-align: left;
}

.profile_img {
	position: relative;
	overflow: hidden;
	width: 50px;
	height: 50px;
	border-radius: 50%;
	background-color: #eee;
	cursor: pointer;
}

.chat_main {
	position: relative;
	width: 70px;
	height: 70px;
}

.chatMiddle {
	width: 400px;
	height: 360px;
	overflow: auto;
}

.sender {
	margin: 10px 25px 0px 10px;
	font-weight: bold;
}

.message {
	display: inline-block;
	margin: 5px 20px 0px 10px;
	max-width: 75%;
	border: 1px solid gray;
	padding: 5px;
	border-radius: 5px;
	background-color: #FCFCFC;
	text-align: left;
}



textarea {
	  width: 100%;
    height: 86.25px;
    border-top: 1px solid #ddd;
    padding: 10px;
    box-sizing: border-box;
    resize: none;
}

.chatTitle {
	padding: 20px;
	margin: auto;
    width: 400px;
    border-radius: 10px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
}



.chatList>div {
	border: 1px solid #ddd;
	border-radius: 5px;
	padding: 10px;
	display: flex;
	align-items: center;
	gap: 20px;
	margin: 5px;
	-webkit-box-shadow: 2px 5px 17px 3px rgba(186, 186, 186, 0.51);
	
}


.chatList>div:hover {
	background:	#FAAB78;
    
    cursor: pointer;
}


.chatMiddle::-webkit-scrollbar {
    width: 10px;  /* 스크롤바의 너비 */
}

.chatMiddle::-webkit-scrollbar-thumb {
    height: 30%; /* 스크롤바의 길이 */
    background: #FAAB78; /* 스크롤바의 색상 */
    
    border-radius: 10px;
}

.chatMiddle::-webkit-scrollbar-track {
    background: rgba(200, 100, 20, .1);  /*스크롤바 뒷 배경 색상*/
}

.modal {
      position: absolute;
      top: 0;
      left: 0;
	  display: none;
      width: 100%;
      height: 100%;
      background-color: rgba(0, 0, 0,.5);
	}

  .modal.show {
    display: block;
  }

  .modal_body {
    position: absolute;
    top: 30%;
    left: 50%;

    width: 280px;
    height: 100px;

    padding: 40px;

   

  background-color: rgb(255, 255, 255);
  border-radius: 10px;
  box-shadow: 0 2px 3px 0 rgba(34, 36, 38, 0.15);

  transform: translateX(-50%) translateY(-50%);
}

 .modal_btn {
  position: absolute;
  top: 50%;
  left: 60%;

  width: 280px;
  height: 100px;

  padding: 40px;
  

 } 



</style>
<body>
	<!-- HEADER BASIC -->
	<c:import url='/WEB-INF/views/include/header.jsp' />
	<!-- 채팅 아이콘 -->
	<div class="chatTitle">
		<div class="chatIcon">
			<img src="resources/images/paw.png" class="chat_main">
		</div>
		<div class="listTitle"> Petner Chat</div>
	</div>
	<!-- 채팅 리스트 / 채팅 방 OPEN / CLOSE -->
	<script>
		$(function() {
			getRoomList();
			
		});
		
		$(document).on("click", ".btnImgclose", function() {
			$(".modal").show();
			$(".profile_img").hide();
		});
		
		$(document).on("click", "#close_btn", function() {
			$(".modal").hide();
			$(".profile_img").show();
		})
		$(document).on("click", "#x_button", function() {
			$(".modal").hide();
			$(".profile_img").show();
		})
		


		$(document).on("click", "#exit_btn", function() { // X 버튼 클릭 시,
		
			$.ajax({
	   			type:"post",
	   			url:"http://localhost:8088/petner/deleteRoom",
	   			data:{room_id:room_id},   //id(key):id(value)
	   			success:function(data,textStatus) {
	   				window.location.reload();

	   				$('.chatContainer').hide();
	 			$('.chatListContainer').show(); 
	   				}	
	   				
	   			
			}) //ajax 끝
			
			websocket.close(); // socket 연결 종료
		});

		$(document).on("click", ".btnImgdown", function() { // - 버튼 클릭 시,
			$('.chatContainer').hide(); // 채팅방을 닫고,
			$('.chatListContainer').show(); // 리스트를 연다.
			websocket.close(); // socket 연결 종료
		});
		
		$(document).on("click", ".chatTitle", function() { // 배너 클릭 시,
			window.location.reload();
			$('.chatContainer').hide(); // 채팅방을 닫고,
			$('.chatListContainer').show(); // 리스트를 연다.
			websocket.close(); // socket 연결 종료
		});
		
		
	</script>
	<!-- 모달창 -->
	  <div class="modal">
				<div class="modal_body">
						<button class="" id="x_button" style= "color: black; cursor:pointer; background-color:white; margin: -35px 50px 0px 300px; position:absolute ">❌</button>
							<p style="color: #FF9614; ">Petner &#128062</p>
						
							<p id="modal_msg" style="padding: 15px 0px 0px 15px;" >채팅방을 나갈시 메세지가 복원되지 않습니다. 그래도 나가시겠습니까?</p>
						
						<div class="modal_btn">
						<button class="pet_btn" id="exit_btn" style= "background-color:#B4B4DC;">나가기</button>
						<button class="pet_btn" id="close_btn" style= "background-color:#FF9614;">취소</button>
						</div>
				</div>				
   		  </div>
	
	
	<!-- 채팅 창 -->
	<div class="chatContainer display-none">
		<div class="chatTop">
			<div id="loginOn">
				<img class="profile_img" id="setPic">	<!-- src 사진 경로 동적 생성 -->
				<span class="name_container font_noto" id="setName"><!-- 이름 동적 생성 --></span>
			</div>

			<div class = "two_btn">
				<img src="resources/images/chat-minus.png"
						style="width: 20px; cursor: pointer;" class="btnImgdown">
				<img src="resources/images/chat-close.png" id="ask_close"
					style="width: 20px; cursor: pointer;" class="btnImgclose"> 				
			</div>
		</div>
		
		<div class="chatMiddle">
			<ul>
				<!-- 동적 생성 -->
			</ul>
		</div>
		<div class="chatBottom">
			<textarea placeholder="메세지를 입력해 주세요."></textarea>
		</div>
	</div>

	<!-- format -->
	<div class="chatMiddle format" style="display: none">
		<ul>
			<li>
				<div class="sender">
					<span></span>
				</div>
				<div class="message">
					<span></span>
				</div>
			</li>
		</ul>
	</div>

	<!-- 채팅 리스트 -->
	<div class="chatListContainer">
		<div class="chatList">
			<!-- 동적 생성 -->
		</div>
	</div>

	<!-- 채팅 목록 관련 -->
	<script>
		// 총 읽지 않은 갯수
		let countAll = 0;

		function getRoomList() {
			// 채팅 방 목록 가져오기
			$.ajax({
						url : "chatRoomList.do",
						data : {
							user_id : "${authUser.id}"
						},
						dataType : "json",
						async : false, // async : false를 줌으로써 비동기를 동기로 처리 할 수 있다.
						success : function(data) {

							// 현재 로그인 된 User들
							let loginList = "";

							// 로그인 된 User들을 가져온다.
							$.ajax({
								url : "chatSession.do",
								data : {},
								async : false,
								dataType : "json",
								success : function(data) {
									for (var i = 0; i < data.length; i++) {
										loginList += data[i];
									}
								}
							});
							
							$chatWrap = $(".chatList");
							$chatWrap.html("");

							var $div; // 1단계
							var $img; // 2단계
							var $divs; // 2단계
							var $span; // 2단계

							if (data.length > 0) {
								// 읽지 않은 메세지 초기화
								countAll = 0;

								// 태그 동적 추가
								for ( var i in data) {

									// 자신이 채팅거는 입장일 때
									if (data[i].user_id == "${authUser.id}") {
										// 현재 상대방 로그인 상태 일 때
										if (loginList
												.indexOf(data[i].another_id) != -1) {
											$div = $(
													"<div class='chatList_box enterRoomList' onclick='enterRoom(this);'>")
													.attr("id", data[i].room_id)
													.attr("another_id",
															data[i].another_id);
											// 현재 상대방 로그아웃 상태 일 때
										}else{
										$div = $("<div class='chatList_box2 enterRoomList' onclick='enterRoom(this);'>")
													.attr("id", data[i].room_id)
													.attr("another_id",
															data[i].another_id);
										//사진이업을시
										if(data[i].another_pic !=0){
										$img = $("<img class='profile_img'>")
												.attr(
														"src",
														"getImg/"
																+ data[i].another_pic);
										}else{
											$img = $("<img class='profile_img'>")
											.attr(
													"src",
													"${imgPath}"
															+ "/noimg.webp");				
										}
										$divs = $("<div class='userNameId'>")
												.text(data[i].another_nickname);
									}
									// 자신이 채팅 받는 입장일 때
									}else {
										// 현재 보낸사람이 로그인 상태 일 때
										if (loginList.indexOf(data[i].user_id) != -1) {
											$div = $(
													"<div class='chatList_box enterRoomList' onclick='enterRoom(this);'>")
													.attr("id", data[i].room_id)
													.attr("user_id",
															data[i].user_id);
										}else{
											$div = $(
													"<div class='chatList_box2 enterRoomList' onclick='enterRoom(this);'>")
													.attr("id", data[i].room_id)
													.attr("user_id",
															data[i].user_id);
										
										if( data[i].user_pic !=0){									
										$img = $("<img class='profile_img'>")
												.attr(
														"src",
														"getImg/"
																+ data[i].user_pic);
										}else{
											$img = $("<img class='profile_img'>")
											.attr(
													"src",
													"${imgPath}"
															+ "/noimg.webp");
										}
										$divs = $("<div class='userNameId'>")
												.text(data[i].user_nickname);
									}
									}
								
									
									
									

									// 읽지 않은 메세지가 0이 아닐 때
									if (data[i].unReadCount != 0) {
										$span = $("<span class='notRead'>")
												.text(data[i].unReadCount);
									} else {
										$span = $("<span>");
									}

									$div.append($img);
									$div.append($divs);
									$div.append($span);

									$chatWrap.append($div);

									// String을 int로 바꿔주고 더해준다.
									countAll += parseInt(data[i].unReadCount);
								}//For문 끝
							}
						}
					});
		}

		/*        // 화면 로딩 된 후
		        $(window).on('load', function(){
		           
		           // 2초에 한번씩 채팅 목록 불러오기(실시간 알림 전용)
		           setInterval(function(){
		               // 방 목록 불러오기
		               getRoomList();
		               
		               // 읽지 않은 메세지 총 갯수가 0개가 아니면
		               if(countAll != 0){
		                   // 채팅 icon 깜빡거리기
		                   $('.chatIcon').addClass('iconBlink');
		                   play();
		               }else{
		                   // 깜빡거림 없애기
		                   $('.chatIcon').removeClass('iconBlink');
		               }
		           },2000);
		       });  */
	</script>

	<!-- 채팅 방 관련 -->
	<script>
		let room_id;
		// enter 키 이벤트
		$(document).on('keydown', 'div.chatBottom textarea', function(e) {
			if (e.keyCode == 13 && !e.shiftKey) {
				e.preventDefault(); // 엔터키가 입력되는 것을 막아준다.
				const message = $(this).val(); // 현재 입력된 메세지를 담는다.

				let search3 = $('div.chatBottom textarea').val();

				if (search3.replace(/\s|  /gi, "").length == 0) {
					return false;
					$('div.chatBottom textarea').focus();
				}

				sendMessage(message);
				// textarea 비우기
				clearTextarea();
			}
		});

		// 채팅 방 클릭 시 방번호 배정 후 웹소켓 연결
		function enterRoom(obj) {
			// 현재 html에 추가되었던 동적 태그 전부 지우기
			$('div.chatMiddle:not(.format) ul').html("");
			// obj(this)로 들어온 태그에서 id에 담긴 방번호 추출
			room_id = obj.getAttribute("id");
			// 해당 채팅 방의 메세지 목록 불러오기
			$.ajax({
				url : room_id + ".do",
				data : {
					user_id : "${authUser.id}"
				},
				async : false,
				dataType : "json",
				success : function(data) {
					for (var i = 0; i < data.length; i++) {
						// 채팅 목록 동적 추가
						CheckLR(data[i]);
					}
				}
			});
			// 웹소켓 연결
			connect();
			console.log("enterRoom");
		}

		// 채팅 방 열어주기
		$(document).on(
				"click",
				".enterRoomList",
				function() {
					$(".chatContainer").show();
					$(this).parent().parent().hide();
					// 이름 추가
					$("#setName").html($(this).children('div').html());
					// 사진 추가
					$("#setPic").attr("src",
							$(this).children('img').attr('src'));
					// 스크롤바 아래 고정
					$('div.chatMiddle').scrollTop(
							$('div.chatMiddle').prop('scrollHeight'));				
				});

		// 웹소켓
		let websocket;

		//입장 버튼을 눌렀을 때 호출되는 함수
		function connect() {
			// 웹소켓 주소
			var wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/websocket/echo.do";
			// 소켓 객체 생성
			websocket = new WebSocket(wsUri);
			//웹 소켓에 이벤트가 발생했을 때 호출될 함수 등록
			websocket.onopen = onOpen;
			websocket.onmessage = onMessage;
			console.log(websocket.send);
		}

		//웹 소켓에 연결되었을 때 호출될 함수
		function onOpen() {
			// ENTER-CHAT 이라는 메세지를 보내어, Java Map에 session 추가
			const data = {
				"room_id" : room_id,
				"user_nickname" : "${ authUser.nickname }",
				"user_id" : "${ authUser.id }",
				"message" : "ENTER-CHAT"
			};
			let jsonData = JSON.stringify(data);
			websocket.send(jsonData);
			console.log(websocket);
		}

		// * 1 메시지 전송
		function sendMessage(message) {

			const data = {
				"room_id" : room_id,
				"user_nickname" : "${ authUser.nickname }",
				"user_id" : "${ authUser.id }",
				"message" : message
			};

			CheckLR(data);

			let jsonData = JSON.stringify(data);

			websocket.send(jsonData);
		}

		// * 2 메세지 수신
		function onMessage(evt) {

			let receive = evt.data.split(",");

			const data = {
				"user_nickname" : receive[0],
				"user_id" : receive[1],
				"message" : receive[2]
			};

			if (data.user_id != "${ authUser.id }") {
				CheckLR(data);
			}
		}

		// * 2-1 추가 된 것이 내가 보낸 것인지, 상대방이 보낸 것인지 확인하기
		function CheckLR(data) {
			// email이 loginSession의 email과 다르면 왼쪽, 같으면 오른쪽
			const LR = (data.user_id != "${ authUser.id}") ? "left" : "right";
			// 메세지 추가
			appendMessageTag(LR, data.user_id, data.message, data.user_nickname);
		}

		// * 3 메세지 태그 append
		function appendMessageTag(LR_className, user_id, message, user_nickname) {

			const chatLi = createMessageTag(LR_className, user_id, message,
					user_nickname);

			$('div.chatMiddle:not(.format) ul').append(chatLi);

			// 스크롤바 아래 고정
			$('div.chatMiddle').scrollTop(
					$('div.chatMiddle').prop('scrollHeight'));
		}

		// * 4 메세지 태그 생성
		function createMessageTag(LR_className, user_email, message,
				user_nickname) {

			// 형식 가져오기
			let chatLi = $('div.chatMiddle.format ul li').clone();

			chatLi.addClass(LR_className); // left : right 클래스 추가
			// find() : chatLi의 하위 요소 찾기
			chatLi.find('.sender span').text(user_nickname); // 이름 추가
			chatLi.find('.message span').text(message); // 메세지 추가

			return chatLi;
		};

		// * 5 - 채팅창 비우기
		function clearTextarea() {
			$('div.chatBottom textarea').val('');
			return false;
		};
	</script>
	<!-- FOOTER BASIC -->
	<c:import url='/WEB-INF/views/include/footer.jsp' />

</body>
</html>