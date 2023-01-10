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
			 관리자가 아닙니다.<br>
			 <span>접근할수있는 권한이 없습니다.</span>
			</h2>
			<p>펫트너 메인화면 가기</p>
			<button class="admin_btn">
				<a href="${pageContext.request.contextPath}/">펫트너 메인</a>
			</button>
		</div>	
	</div>
</div>
</body>
</html>