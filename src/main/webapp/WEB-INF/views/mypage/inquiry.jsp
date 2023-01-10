<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<div class="content">
	<div id="talk_view" class="w60">
		<div class="talk_list">

			<%-- 내가 보낸 메세지 --%>
			<c:if test="${empty requestScope.sender}">
				<div class="me">
					<span class="datetime">${requestScope.date}</span>
					<div class="cont">${requestScope.content}</div>
				</div>
			</c:if>

			<%-- 관리자가 보낸 메세지 --%>
			<c:if test="${!empty requestScope.sender}">
				<div class="you">
					<span class="datetime">${requestScope.content}</span>
					<div class="cont">${requestScope.date}</div>
				</div>
			</c:if>
		</div>
		<div class="type_here">
			<span class="pet_btn photo_btn"><i class="fa-regular fa-image"></i>&nbsp;사진</span>
			<p class="input">
				<input name="content" type="text" /> <span class="send_icon"
					id="sendBtn" onclick="send('message');">전송</span>
			</p>
		</div>
	</div>
</div>

<script>
    
		<!-- 변수 선언 -->
		let webSocket; 		// 웹소켓 전역변수
		let uuid; 			// 상대방 고유 UUID
		
		// HTML 전송 공통 AJAX
		function ajaxForHTML(url, data, contentType){
			
			let htmlData;
			
    		// HTML AJAX 통신
    		$.ajax({
    		    url : url,
    		    data: data,
    		    contentType: contentType,
    		    type:"POST",
    		 	// html(jsp)로 받기
    		    dataType: "html",
    		    async: false,
    		    // 성공 시
    		    success:function(data){
    		    	htmlData = data;
    		    },
    		    error:function(jqxhr, textStatus, errorThrown){
    		       alert("ajax 처리 실패");
    		    }
    		});
    		
    		return htmlData;
		}
	
		<!-- 로그인 (세션 추가 및 WebSocket 연결) -->
		function login(){
        	// 이름
       		let name = document.getElementById("name").value;
           	// AJAX 통신
           	let data = ajaxForHTML("/login", {"name" : name});
       		// 로그인 성공 시
         	if(data !== ""){
	           	// DOM 변경
	           	$("#loginContainer").html(data);
	           	// WebSocket 연결
	           	connect();
	           	// 유저 목록 가져오기
	           	$("#userList").html(ajaxForHTML("/userList"));
           	}else{
               	alert("로그인 실패!");
           	}
		}
        
        <!-- 로그아웃 (세션 제거) -->
        function logout(){
        	// WebSocket 연결 해제
			if(webSocket !== undefined){
				send('logout');
				// 연결 종료
				webSocket.close();
				// 객체 초기화
				webSocket = undefined;
			}
        	// AJAX 통신
        	let data = ajaxForHTML("/logout");
        	// DOM 변경
        	$("#loginContainer").html(data);
        	// 유저 목록 초기화
        	$("#userList").html("");
        }
		
		/* 
			WebSocket Session은 새로고침 시, 연결이 해제 된다.
			하지만, HttpSession은 해제되지 않는다.
			그러므로, HttpSession이 연결되어 있을 때(로그인 중)에는 
			WebSocketSession을 연결시켜 주도록 하자.
		*/
		if(webSocket === undefined && "${sessionScope.authUser}" !== ""){
			connect();
           	// 유저 목록 가져오기
           	$("#userList").html(ajaxForHTML("/userList"));
		}
		
		<!-- webSocket 연결 -->
		function connect(){
			
			// webSocket 연결되지 않았을 때만 연결
			if(webSocket === undefined){
				// webSocket URL
				let wsUri = "ws://${pageContext.request.serverName}:${pageContext.request.serverPort}${pageContext.request.contextPath}/webSocket/echo";
				// 연결
				webSocket = new WebSocket(wsUri);
				if(webSocket){
					webSocket.onopen = onOpen;
					webSocket.onmessage = onMessage;
					/* webSocket.onclose = onClose; */
				}
			}else{
				document.getElementById("message").innerHTML+="<br/>" + "<b>이미 연결되어 있습니다!!</b>";
			}
		}

		<!-- webSocket 연결 성공 시 -->
		function onOpen(){
			// 첫 로그인 시
			if("${sessionScope.authUser}" === ""){
           		send('login');
			}
			// 새로고침 시
			else{
				send('onLineList');
			}
		}
		
		<!-- webSocket 메세지 발송 -->
		function send(handle, secret){
			
			let data = null;
			let chatMessage = document.getElementById("chat");
			
			if(handle === "message"){
				if(!chatMessage.value){
					return;
				}
				
				data = {
					"handle" : "message",
					"content" : chatMessage.value
				}
				
				// 1:1 채팅방의 경우 uuid 추가
				if(secret === true){
					data.uuid = uuid;
				}
				
				// 채팅 메세지 초기화
				chatMessage.value = "";
			}else if(handle === "login"){
				data = {
					"handle" : "login"
				}
			}else if(handle === "logout"){
				data = {
					"handle" : "logout",
					"uuid" : "${sessionScope.authUser.email}" || document.getElementById("loginUuid").value,
				}
			}else if(handle === "onLineList"){
				data = {
					"handle" : "onLineList"
				}
			}
			
			let jsonData = JSON.stringify(data);
			webSocket.send(jsonData);
		}
		
		// 엔터로 채팅 전송
		$(document).on('keydown', '#chat', function(e){
            if(e.keyCode == 13 && !e.shiftKey) {
            	
            	send('message',true);
            }
       	});
		
		<!-- webSocket 메세지 수신 시 -->
		function onMessage(evt){			
			
			// 수신한 메세지 (,)로 자르기
        	let receive = evt.data.split(",");
        	let data = {};
        	let count = 0;
     		
        	if(receive[0] === "message"){
                data = {
                	 "handle" : receive[0],
                   	 "sender" : receive[1],
                   	 "content" : receive[2],
                   	 "uuid" : receive[3]
                }
        	}else if(receive[0] === "login"){
                data = {
                   	 "handle" : receive[0],
                     "uuid" : receive[1]
                }
        	}else if(receive[0] === "logout"){
                data = {
                   	 "handle" : receive[0],
                     "uuid" : receive[1]
                }
           	}else if(receive[0] === "onLineList"){
        		data.handle = receive[0];
        		for(let i = 1; i < receive.length; i++){
        			data[count++] = receive[i];
        		}
        	}
        	
            writeResponse(data);
		}
		
		<!-- webSocket 메세지 화면에 표시해주기 -->
        function writeResponse(data){
        	
        	// JSON.stringify() : JavaScript 객체 → JSON 객체 변환
        	
        	if(data.handle === "message"){
            	// HTML 데이터 받기
            	let messageData = ajaxForHTML("/message", 
    					        			  JSON.stringify(data), 
    					        			  "application/json");
            	// 채팅방에 메세지 추가
            	document.getElementById("message").innerHTML += messageData;
            	
            	// 채팅방 목록에 알림 효과
            	$("#" + data.uuid).addClass('temp');
            	
            	// 스크롤 하단 고정
            	$('#message').scrollTop($('#message').prop('scrollHeight'));
            	
        	}else if(data.handle === "login"){
            	// [상대방 → 나] 로그인 표시
            	document.getElementById(data.uuid).innerHTML = "로그인";
        	}else if(data.handle === "logout"){
        		// [상대방 → 나] 로그인 제거
        		document.getElementById(data.uuid).innerHTML = "";
        	}else if(data.handle === "onLineList"){
        		// [유저 목록 → 나] 로그인 표시
        		for(let i = 0; i < Object.keys(data).length - 1; i++){
        			document.getElementById(data[i]).innerHTML = "로그인";
        		}
        	}
        }
        
        // 채팅창 공백
        function chatClear(){
        	document.getElementById("message").innerHTML=" ";
        }
        
        // 채팅방 입장
        function roomEnter(room){ 
        	
        	let bb = document.getElementsByClassName('active')[0];
        	
        	// 1. 채팅방 목록 리스트 CSS 변경
        	// 활성화 되어 있는 방 클릭 시 [효과 X]
        	if($(room).hasClass("active")){
        		return;
        	}
        	if(bb !== undefined){
            	bb.classList.add('list-group-item-light');
            	bb.classList.remove('active', 'text-white');
        	}
        	
        	room.classList.add('active', 'text-white');
        	room.classList.remove('list-group-item-light');
        	
        	// 2. 현재 열려있는 채팅방 초기화
        
    		// 3. secret true값으로 메세지 보내기
    		// send('message', true);
        	
        	// 3. 상대방 UUID로 session 찾기 (1. 입장과 동시에 채팅방 집어넣기 or 첫 메세지 보낼 때 연결하기)
        	uuid = room.dataset.uuid;
        	
        	// 4. 메세지 보내기 onClick 이벤트 변경
        	$("#sendBtn").attr("onClick", "send('message', true)");
        }
        
	</script>