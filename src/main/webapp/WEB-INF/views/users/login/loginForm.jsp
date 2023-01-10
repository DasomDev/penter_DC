<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css"/>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>



<style>
  .login_wr .logo{text-align: center; padding:30px 0;}
  .login_form{margin-bottom:12px;}
  .login_form .f_row{border:1px solid #e4e4e4; padding-bottom: 0; margin-bottom:28px; border-radius: 5px; overflow: hidden;}
  .login_form input{width:100%; height:52px; border:none; border-radius: 0;;}
  .login_form input:focus{border:none; outline:none;}
  .login_form input:nth-child(1){border-bottom: 1px solid #e4e4e4;}
  .login_form .login_btn{background-color: #e4e4e4; color:var(--black); height:52px; }  
  
  .login_wr .info_are label.fcCbox1 > span:before{color:var(--fcc-font01) !important}
  .login_wr .info_area label.fcCbox1 span{color:#e4e4e4}
  .login_wr p:nth-child(1){
    display:flex; 
    justify-content: space-between; 
    padding-bottom: 10px;
    color:#e4e4e4;
  }
  .login_wr p:nth-child(3){text-align: center; text-decoration: underline; padding-top:20px;}
  .kakao_btn{background-color:#FAE100; color:#3B1E1E; font-size:1.4rem; height:52px;}
  #close_btn{position: height:20px; width:50px;}
  .login_option{
    padding-top: 30px;
    border-top: 1px solid #e4e4e4;
    margin-top: 30px;
  }
  
  .login_optionA{
    display: flex;
    justify-content: space-between;
    margin-top: 15px;
    color:gray;
   }
   
       .modal {
        position: absolute;
        top: 0;
        left: 0;
		
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
        left: 70%;
		
        width: 280px;
        height: 100px;

        padding: 40px;
        

       } 

</style>


<script>
		$(document).ready(function(){
			$("#close_btn").click(function(){
				$(".modal").hide();
			})
			$("#x_button").click(function(){
				$(".modal").hide();
			})

			
		})

		//뒤로가기 모달창 뜨지마라
	window.history.pushState({page: 1}, "", "");	
	window.onpopstate = function(event) {
	  // "event" object seems to contain value only when the back button is clicked
	  // and if the pop state event fires due to clicks on a button
	  // or a link it comes up as "undefined" 
	
	  if(event){
		  $(".modal").hide();  }
	 
	}

	
	

	
	function login() {
		loginForm.submit();
		$("input:checkbox[id='useCookie']").prop("checked",true);
		$("input:checkbox[id='useCookie']").prop("checked",false);
			
	
	}
	

</script>

<div class="w45 login_wr">      
  <div class="logo"><img src="./images/logo3.svg" alt=""></div>
  <form action="./login" method="POST" id="loginForm" class="login_form">
  	  <div class="f_row">
      <input type="text" placeholder="ID" name="id" id="id" >
      <input type="password" placeholder="비밀번호" name="password" id="password">
    </div>
     <input type ="submit" class="pet_btn login_btn transition02" value= "로그인" onsubmit="login()"/>
    <div class="login_optionA">
    	<label class="fcCbox1">
	      <input type="checkbox" id="useCookie" name="useCookie" >
	      <span>로그인 유지하기</span>
	    </label>
	    <span><a href="./findId" >아이디</a>&nbsp;/&nbsp;<a href="./findPass">비밀번호찾기</a></span>
   </div>
  </form>

	<div class="form-label-group">
		<c:if test="${check == 1}">
		   <div class="modal">
				<div class="modal_body">
						<button class="" id="x_button" style= "color: black; cursor:pointer; background-color:white; margin: -35px 50px 0px 300px; position:absolute ">❌</button>
							<p style="color: #FF9614; ">Petner &#128062</p>
							<p style="text-decoration: none;">	&#128531 ${message} </p>
							
						<div class="modal_btn">
							<button class="pet_btn" id="close_btn" style= "background-color:#FF9614;">닫기</button>
						</div>
				</div>				
   		  </div>
		</c:if>
	</div>
	<div class="info_area">
		<p>
	    <a class="p-2" href="https://kauth.kakao.com/oauth/authorize?client_id=7d545fe4f1b025d4ae839deae7232c74&redirect_uri=http://localhost:8088/petner/kakaoLogin&response_type=code">
			<p class="login_option"><span class="pet_btn login_btn kakao_btn">카카오톡계정으로 로그인하기</span></p></a>		
	    <p class="login_option"><a href="./join">펫트너회원가입</a></p>
	 </div>
</div>