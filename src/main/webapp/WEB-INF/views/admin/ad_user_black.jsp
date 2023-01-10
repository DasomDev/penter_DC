<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="cssPath"
	value="${pageContext.request.contextPath}/resources/css" />
<c:set var="imgPath"
	value="${pageContext.request.contextPath}/resources/images" />

<!-- 세션있을때  -->
<c:if test="${not empty authUser}">
	<!-- 관리자 일때 -->
	<c:if test="${authUser.user_type >= 9}">
		<!-- ********** 회원정보 관리 ********** -->
		<div class="card ad_card mb-4">
			<div class="card-body">
				<h2 class="card-title">Black 회원정보</h2>

    <form name="admin_user" action="ad_usersdelete" method="post">
				<div class="tab-content">
				<!-- 카카오 -->
					<table class="table table-hover user_table">
						<thead>
							<tr>
								<th scope="col">회원번호</th>
								<th scope="col">이름</th>
								<th scope="col">email</th>
								<th scope="col">회원구분</th>
								<th scope="col">주소</th>
								<th scope="col" style="text-align: end;">탈퇴</th>
							</tr>
						</thead>
						<tbody class="tab-content">
							<c:forEach var="users" items="${list}">
								<c:if test="${ users.user_auth == 0}">
								
							<div class="row">
							<tr>
										<td class="col-1">
											<p>
												<span class="value">z${users.user_no}</span>
											</p>
										</td>
										<td class="col-1">
											<p>
												<span class="value"> <%-- <a href="./ad_authorityForm">
										${users.name}
										</a> --%> <a href="./ad_detailForm?user_no=${users.user_no}">
														${users.name} </a>
												</span>
											</p>
										</td>
										<td class="col-3">
											<p>
												<span class="value">${users.email}</span>
											</p>
										</td>
										<td class="col-2 type_box">
											<!-- 관리자 분류 --> <c:if test="${users.user_auth == 10}">
												<div class="admin10">
													<span class="value">최고관리자</span>
												</div>
											</c:if>
											<c:if test="${users.user_auth == 9}">
												<div class="admin9">
													<span class="value">관리자</span>
												</div>
											</c:if>
											<c:if test="${users.user_auth == 1}">
												<div class="admin1">
													<span class="value">일반</span>
												</div>
											</c:if>
											<c:if test="${users.user_auth == 2}">
												<div class="admin2">
													<span class="value">카카오</span>
												</div>
											</c:if>
											<c:if test="${users.user_auth == 0}">
												<div class="admin0">
													<span class="value">블랙</span>
												</div>
											</c:if>
										</td>
										<td class="col-4">
											<p>
												<span class="value">${users.addr}</span>
											</p>
										</td>
										<td class="col-1" style="text-align: end;"><label><input
												type="checkbox" name="user_no" value="${users.user_no}"></label>
										</td>
										</tr>
									</div>
									</c:if>
								
							</c:forEach>
						</tbody>
					</table>
				</div>
					<button type="submit" class="btn btn-outline-secondary">
						탈퇴시키기</button>
				</form>
				
			</div>
		</div>

		<!-- 관리자 일때.end -->
	</c:if>

	<!-- 관리자 아닐때 -->
	<c:if test="${authUser.user_type < 9}">
		<c:import url='/WEB-INF/views/include/not_admin.jsp' />
	</c:if>
</c:if>

<!-- 세션없을때 -->
<c:if test="${empty authUser}">
	<c:import url='/WEB-INF/views/include/not_users.jsp' />
</c:if>

<script>
$('.tabgroup > div').hide();
$('.tabgroup > div:first-of-type').show();
$('.tabs a').click(function(e){
  e.preventDefault();
    var $this = $(this),
        tabgroup = '#'+$this.parents('.tabs').data('tabgroup'),
        others = $this.closest('li').siblings().children('a'),
        target = $this.attr('href');
    others.removeClass('active');
    $this.addClass('active');
    $(tabgroup).children('div').hide();
    $(target).show();
  
})
</script>
