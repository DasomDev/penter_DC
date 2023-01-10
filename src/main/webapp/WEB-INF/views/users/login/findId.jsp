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
<title>아이디 찾기</title>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
   $(function() {

      $('#findId').submit(function() {

      });

   });//function ready 끝
</script>
</head>
<style>
   #findId input[type=text]{width:100%;}
   .desc{text-align:center; margin-bottom:35px;}
   .find_id{width:120px !important; text-align:center;}
   .flex_between{flex-wrap:nowrap}
   .id_email{   
   		 width: 260px;
    	margin: 0 auto;
    	}
   .submit_btn{
   		width: 200px;
		line-height: 30px;
		margin: auto;
		}
</style>
<body>
   <div id="wrapper">
      <!-- HEADER BASIC -->
      <c:import url='/WEB-INF/views/include/header.jsp' />
      <!-- CONTAINER -->

      <div class="container">
         <div class="w45">
            <h3 class="form_title">아이디찾기</h3>
            <form action="./findId" id="findId" method="POST">
            <div class="desc">
               <p class="mb10">가입한 이메일로 아이디를 찾을수 있습니다.</p>
               <p class="tip">이름과 이메일 정보를 입력해주세요.</p>
            </div>
            <div class="id_email">
            <div class="f_row" style="width:20px;">
               <p class="fc_title">이름</p>
               <input type="text" placeholder="이름" name="name" id="name" />
            </div>
            <div class="f_row"style="width:20px;">
               <p class="fc_title">이메일</p>
               <div class="flex_between">
                  <input type="text" placeholder="E-mail" name="email" id="email"/>
                  
               </div>
            </div>
            </div>
            <div class="f_row" style="text-align:center; margin-top:20px">
               <input type="submit" class="pet_btn submit_btn transition02" value="ID찾기"/>
            </div>            
         </form>
         
         </div>
         
         

      </div>



      <!-- FOOTER BASIC -->
      <c:import url='/WEB-INF/views/include/footer.jsp' />

   </div>
</body>
</html>