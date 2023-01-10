<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images" />
<c:import url='/WEB-INF/views/include/common_head.jsp' />
<style>
/* pc 화면 */
@media ( min-width : 768px) {
	#kakao-talk-channel-chat-button {
		margin-top: 100px;
	}
}
/* 모바일 화면 */
@media ( max-width :767px) {
	#kakao-talk-channel-chat-button {
		position: fixed;
		z-index: 999;
		right: 15px; /* 화면 오른쪽으로부터의 거리, 숫자만 변경 */
		bottom: 30px; /* 화면 아래쪽으로부터의 거리, 숫자만 변경 */
	}
}
.desc {
	text-align: center;
	margin-bottom: 45px;
}

.kakao-talk-channel-chat-button {
	margin: auto;
	padding: 100px;
}
</style>
<body>
	<div id="wrapper">
		<!-- HEADER BASIC -->
		<c:import url='/WEB-INF/views/include/header.jsp' />
		
		<!-- CONTAINER -->
		<div class="container">
			<div class="w45">
				<h3 class="form_title">1:1 문의</h3>
				<div class="desc">
					<p class="mb10" style="color: #988DB3;">안녕하세요 펫트너입니다.</p>
					<p class="mb10" style="color: #988DB3;">1:1문의를 원하시면 아래의 톡상담을 눌러주시길 바랍니다.</p>
					<p id="kakao-talk-channel-chat-button"></p>
				</div>
			</div>
			
		</div>
		
		<!-- FOOTER BASIC -->
		<c:import url='/WEB-INF/views/include/footer.jsp' />
	</div>
</body>
</html>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
<script type='text/javascript'>
	//<![CDATA[
		// 사용할 앱의 JavaScript 키를 설정해 주세요.
		Kakao.init('c0e219869901ec8d8a08516bae54855c');
		// 카카오톡 채널 1:1채팅 버튼을 생성합니다.
		Kakao.Channel.createChatButton({
		  container: '#kakao-talk-channel-chat-button',
		  channelPublicId: '_QLywxj' // 카카오톡 채널 홈 URL에 명시된 ID
		});
	//]]>
</script>