<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css"/>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>

<footer id="footer">
  <div class="footer_inner">
    <div class="footer_logo"><img src="${imgPath}/footer_logo.png" alt=""></div>
    <div class="footer_menu">
      <!-- 마이페이지 -->
      <div>
        <p class="fm_title">마이페이지</p>
        <div class="fms">
          <a href="/petner/mypage">마이페이지</a>
          <a href="#">팔로우/팔로워</a>
          <a href="#">내가찜한게시글</a>
          <a href="#">리뷰관리</a>
          <a href="${pageContext.request.contextPath}/kaChat">1:1문의</a>
        </div>
      </div>
      <!-- 펫시터찾기 -->
      <div>
        <p class="fm_title">펫시터찾기</p>
        <div class="fms">
          <a href="#">서비스 신청</a>
          <a href="#">내 주변 시터</a>
        </div>
      </div>
      <!-- 공지사항 -->
      <div>
        <p class="fm_title">공지사항</p>
        <div class="fms">
          <a href="/petner/list_qna">Q&A</a>
          <a href="/petner/list_board">이벤트</a>
        </div>
      </div>
    </div>
  </div>
</footer>