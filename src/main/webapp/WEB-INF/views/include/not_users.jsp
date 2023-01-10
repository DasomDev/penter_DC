<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div class="container-fluid">
	<div class="row">
		<div class="not_admin">
			<h2>
			 회원이 아닙니다.<br>
			 <span>접근할수있는 권한이 없습니다.</span>
			</h2>
			<p>펫트너 로그인 하러 가기</p>
			<button class="admin_btn">
				<a class="login" href="${pageContext.request.contextPath}/gologin">로그인</a>
			</button>
		</div>	
	</div>
</div>
</body>
</html>