<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="cssPath" value="${pageContext.request.contextPath}/resources/css"/>
<c:set var="imgPath" value="${pageContext.request.contextPath}/resources/images"/>




<!DOCTYPE html>
<html lang="en">
<head>
	<c:import url='/WEB-INF/views/include/common_head.jsp' />
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link rel="stylesheet" href="resources/css/common.css">
  <link rel="stylesheet" href="resources/css/form_component.css">
  <script src="https://kit.fontawesome.com/064a55beb6.js" crossorigin="anonymous"></script>
  <title>회원가입</title>
  <script src= "https://code.jquery.com/jquery-3.4.1.js"></script>
  <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
  <script>
  
  
  function check() {
     //id유효성검사
	  var id =$("#id").val();   //id 입력 값
	  var reg_id = /^[A-Za-z]{1}[A-Za-z0-9_-]{3,19}$/;  //영문+숫자조합(4~20까지)
	  var checked_id = $("input[name='checked_id']").val();  //중복체크 여부
	  
	  if(id == "") {
	  	$('#checkid-msg').text("아이디를 입력해주세요").css("color", "red");
	  $("#id").focus();
	  return false;
	  
	  }if(!reg_id.test(id)){
			$('#checkid-msg').text("아이디는 영문과 숫자조합만 가능합니다.(4~20자)").css("color", "red");
	  $("#id").focus();
		return false;
		
	  }if(checked_id==''){
	  	$('#checkid-msg').text("아이디 중복확인을 먼저 해주세요").css("color", "red");
	      $("#id").focus();
			return false;
			
	  }else{
			$('#checkid-msg').text("사용가능한 아이디입니다.").css("color", "green");
	  }
	  
	//비밀번호 유효성검사
	  var password =$("#password").val();          //비밀번호 입력값
	  var ck_password = $("#ck_password").val();   //비밀번호 체크 입력값
	  var acceptPass = /^(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,16}$/; 
	  
	  if(!password){
	  	$('#checkpass-msg').text("비밀번호를 입력해주세요").css("color", "red");
	    $("#password").focus();
	    return false;
	    
	  }if(!acceptPass.test(password)){
			$('#checkpass-msg').text("비밀번호는 영어+숫자+특수문자를 조합해야 합니다(8자 이상)").css("color", "red");
		    $("#password").focus();
		  return false;
		  
	  }if(!ck_password){
	  	$('#checkpass-msg').text("비밀번호 확인을 입력해주세요").css("color", "red");
	    $("#ck_password").focus();
	    return false;
	    
	  }if(password !== ck_password){
	  	$('#checkpass-msg').text("비밀번호가 일치하지 않습니다").css("color", "red");
	      $("#password").focus();
	      return false;
	      
	  }else{
			$('#checkpass-msg').text("사용가능한 비밀번호입니다.").css("color", "green");
	  }
  
	  //email유효성검사 +email 합치기
	  var reg_email = /^[a-zA-Z]{1}[a-zA-Z0-9_]{4,11}$/; 
	  var email_id =$("#email_id").val();
	  var email_domain =$("#email_domain").val();
	  var email ="";
	 
	  if(!email_id){
	    $('#checkmail-msg').text("이메일을 입력해주세요").css("color", "red");
	    $("#email_id").focus();
	    return false;
	    
	  }if(!reg_email.test(email_id)){
	    $('#checkmail-msg').text("올바른 이메일을 입력해주세요").css("color", "red");
	      $("#email_id").focus();
	    return false;
	    
	  }else{
			$('#checkmail-msg').text("사용가능한 이메일입니다.").css("color", "green");
	  }
	  
	  email = email_id+"@"+email_domain;  //콤마뺴기
	  $("#email").val(email);  
	
		//이름 유효성 검사
	  var reg_name = /^[가-힣]+$/;
	  var name = $("#name").val();
		
	  if(!name){
	      $('#checkname-msg').text("이름을 입력해주세요").css("color", "red");
	      $("#name").focus();
	      return false;
	      
	    } if(!reg_name.test(name)){
	      $('#checkname-msg').text("이름은 한글로 입력해주세요").css("color", "red");
		      $("#name").focus();
	      return false;
	      
	    }else{
			$('#checkname-msg').text("사용가능한 이름입니다.").css("color", "green");
	    }
	    
	    //별명 유효성검사
	  	var reg_nickname = /^[가-힣]{2,6}$/;
		var nickname = $("#nickname").val();
		
		 	 if(!nickname){
	    $('#checknickname-msg').text("별명을 입력해주세요").css("color", "red");
	    $("#nickname").focus();
	    return false;
	    
	  } if(!reg_name.test(nickname)){
	    $('#checknickname-msg').text("별명은 한글로 지어주세요(2~6)").css("color", "red");
	      $("#nickname").focus();
	    return false;
	  }
	 
	  //주소 유효성검사
	  	var add3 = $("#add3").val();
		
		 	 if(!add3){
	    $('#checkaddress-msg').text("상세주소를 입력해주세요").css("color", "red");
	    $("#add3").focus();
	    return false;
	    
		}else{
		 return true;
	  }
  } //check()끝
  
  //주소검색 API

    function Zipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수
                
                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    
                	}
                 // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    // 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("add4").value = extraAddr;
                
                } else {
                    document.getElementById("add4").value = '';
                }

              			  // 우편번호와 주소 정보를 해당 필드에 넣는다.
             			  $("#add1").val(data.zonecode);
             			  $("#add2").val(addr);
                
        	}
  	  }).open();
	}


  
  $(function () {
	   $('#joinForm').submit(function() {
		
			  }); //유효성체크 끝
		
	 	//중복아이디 = ajax 쓰는이유: data를 서버에 주고 다시 받아올때 비동기방법을 씀
	   	$('#doubleId').click(function() {
	   		var id = $("#id").val();  //사용자가 입력한 아이디를 변수 id에 담음
	   		var reg_id = /^[A-Za-z]{1}[A-Za-z0-9_-]{3,19}$/; 
	   		
	   		$("input[name=checked_id]").val('y'); //중복체크  yes

	   		if(id=="") {
	   			$('#checkid-msg').text("아이디를 입력해주세요").css("color", "red");
	   			$("#id").focus();
	   			return;

	   		}if(!reg_id.test(id)){
				$('#checkid-msg').text("아이디는 영문과 숫자조합만 가능합니다.(4~20자)").css("color", "red");
				$("#id").focus();
				return;
	   		}
	   		$.ajax({
	   			type:"post",
	   			url:"http://localhost:8088/petner/checkId",
	   			data:{id:id},   //id(key):id(value)
	   			success:function(data,textStatus) {
	   				if(data=="true") {
	   					$('#checkid-msg').text("중복아이디 입니다").css("color", "red");
	   				}else{ 
	   					$('#checkid-msg').text("사용 가능한 아이디입니다").css("color", "green");
	   				}	
	   				
	   			} 
			}) //ajax 끝
		}); // 중복체크 끝
	});//function ready 끝
  

</script>
</head>



 </head>


<body>
  <div id="wrapper">
  		<!-- HEADER BASIC -->
		<c:import url='/WEB-INF/views/include/header.jsp' />

    <div class="login_form w50">      
      <h3 class="form_title">회원가입</h3>
      <form id= "joinForm" action="./joinpet" method="POST" class="join_form" onsubmit = "return check()">
      
        <div class="f_row">
          <p class="fc_title">&#128586 펫트너 가족되기 &#128586</p>
          <p class="tip"><i class="fa-solid fa-asterisk"></i> 회원가입후 추가로 정보를 등록할 수 있어요</p>
          <div class="flex_col">
            <label class="fcRadio1 mb10"><input type="radio" name="user_type" id="user_type" value= "2" checked><span>보호자로 등록하기 ( 펫시터를 찾고있어요 )  </span></label>
            <label class="fcRadio1 "><input type="radio" name="user_type" value= "1"><span>펫시터로 등록하기 ( 돌봐줄 동물을 찾고있어요 )</span></label>
          </div>          
        </div>
        <!-- TEXT/PASSWORD -->
        
        <div class="f_row">
          <p class="fc_title">아이디</p>
          <p class="flex_agn_center">
          <input type="hidden" name="checked_id" value="">
          <input class="mr12" type="text" placeholder="ID" name ="id" id="id"/>
            <span class="pet_btn second_btn transition02" id="doubleId">중복확인</span>
          </p>
          <p><small id="checkid-msg" class="form-error"></small></p>
        </div>
        <div class="f_row flex_col" style= "width:200px;">
          <p class="fc_title">비밀번호</p>
          <input class="mb10" type="password" name ="password" id="password" placeholder="비밀번호입력"/>
          <input type="password" name="ck_password" id="ck_password" placeholder="비밀번호확인"/>
          <p><small id="checkpass-msg" class="form-error"></small></p>
        </div>
        <div class="f_row">
          <p class="fc_title">이메일</p>
          <p class="flex_agn_center">
          	<input type ="hidden" id= "email" name= "email"/>
            <input type="text" placeholder="" id="email_id" name=""/>
            <span style="margin:0 10px;">@</span>
            <select class="fcc_select" name="" id="email_domain">
                <option value="naver.com">naver.com</option>
   				<option value="gmail.com">gmail.com</option>
    			<option value="hanmail.net">hanmail.net</option>
    			<option value="hotmail.com">hotmail.com</option>
   			 	<option value="korea.com">korea.com</option>
   				<option value="nate.com">nate.com</option>
   				<option value="yahoo.com">yahoo.com</option>
            </select>
          </p>
          <p><small id="checkmail-msg" class="form-error"></small></p>
        </div>
        <div class="f_row">
          <p class="fc_title">이름</p>
          <input type="text" id="name" name="name"/>
          <p><small id="checkname-msg" class="form-error"></small></p>
        </div>
        <div class="f_row">
          <p class="fc_title">나의별명</p>
          <input type="text" id="nickname" name="nickname"/>
         <p><small id="checknickname-msg" class="form-error"></small></p>
        </div>
        <div class="f_row">
          <p class="fc_title">성별</p>
          <label class="fcRadio1 mr12">
            <input type="radio" name="gender" id="gender" value="male" checked><span>남자</span>
			</label>          
            <label class="fcRadio1 mr12">
            <input type="radio" name="gender" value="female"><span>여자</span>
          </label>
        </div>
        <div class="f_row">
          <p class="fc_title">주소입력</p>
          <div class="flex_col">
            <p class="mb10">
              <input class="mr12" type="text" id="add1" name="zipcode" readonly/><input type="button" class="pet_btn second_btn transition02" onclick="Zipcode()" value= "주소찾기"/>
            </p>            
            <input class="mb10" type="text" id ="add2" name="addr" readonly/>
            <input class="mb10" type="text" id ="add3" name="addr_detail" placeholder="상세주소입력"/>
            <input type="hidden" id="add4" name="address" placeholder="참고항목">
             <p><small id="checkaddress-msg" class="form-error"></small></p>
          </div>
           <input type="hidden" name="joindate" id="joindate"/>
           
           
        </div>
        
        <input type="submit" class="pet_btn submit_btn transition02" value= "회원가입하기"/>
      </form>
    </div>
  </div>
  
		<!-- FOOTER BASIC -->
		<c:import url='/WEB-INF/views/include/footer.jsp' />
</body>