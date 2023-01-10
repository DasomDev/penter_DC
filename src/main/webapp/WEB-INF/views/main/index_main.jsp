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
<title>Petner</title>
<style>
  .container{margin-top:0;}

  .main h3{
    font-size: 4rem;
    line-height: 4.2rem;
    padding-bottom: 68px;
  }
  .main h4{
    font-size: 3rem;
    padding-bottom: 45px;
    text-align: center;
  }

  .main_visual{
    position: relative;
    height: 620px;
    overflow: hidden;
    /* outline: 1px solid red; */}
  .main_visual video{width: 100%; }
  .main_visual .title{
    position:absolute;
    bottom:18%; 
    left:10%;
    /* outline:red 1px solid; */
    color:#fff;
  }
  .main_visual .title .text{
    font-size: 6rem;
    font-weight: 900;
    line-height: 76px;
    padding-bottom: 20px;
  }
  .main_visual .title .btn{
    background: #F9B25C;
    width: fit-content;
    font-size: 2.8rem;
    padding: 12px 36px;
    border-radius: 40px;
  }

  .service_desc{
    text-align: center;
    padding: 70px 0;
  }
  .service_desc > div:not(:last-child){padding-bottom:54px}
  
  .service_desc .title{
    text-decoration: underline;
    font-size: 2.4rem;
    font-weight: 500;
    padding-bottom: 18px;

  }
  .service_desc .desc{}
  .service_desc .desc > p{padding-bottom: 10px;}

  .review{
    padding: 60px 0 100px;
    background-color: #F7F7F8;
  }
  .review .slide_wr{position: relative; margin-top: 30px;}
  .review .btn_area{
    width: 1368px;
    height: 80px;
    position: absolute;
    /* outline: 1px solid red; */
    overflow: hidden;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    z-index: 10;
  }
  .review .slick_btn{
    cursor: pointer;
    z-index: 1;
    position: absolute;
    display: inline-block;
    width: 65px;
    height: 65px;
    border-radius: 50%;
    border: 1px solid var(--orange);
    background: #fff;
    -webkit-box-shadow: 0 5px 10px rgba(233 211 152 / 20%);
    box-shadow: 0 5px 10px rgba(233 211 152 / 20%);
    outline: none;
    font-size: 2rem;
    color:var(--orange)
  }
  .review .next{right:0;}
  .review_slick{
    width: 1200px;
    height: 462px;
    margin: 0 auto;
    display: flex;
    /* gap: 30px; */
    /* justify-content: space-evenly; */
  }
  .review_slick .row1{    
    display: flex;
    align-items: center;
    /* justify-content: space-between; */
    margin-bottom:34px;
  }
  .review_slick .review_card{
    width: 320px;
    height: 385px;
    padding: 36px 24px;
    background-color: #fff;
    border-radius: 5px;
    box-shadow: 1px 1px 5px 2px rgb(222 222 222 / 75%);
    -webkit-box-shadow: 1px 1px 5px 2px rgb(222 222 222 / 75%);
    -moz-box-shadow: 1px 1px 5px 2px rgba(222,222,222,0.75);
    
  }
  .review_slick .review_card .img_area{
    overflow: hidden;
    width: 95px;
    height: 95px;
    border-radius: 50%;
    margin-right:22px
   
  }
  .review_slick .review_card .img_area img{width: 100%; height: inherit;}
  .review_slick .review_card .text_area{
    display: flex;
    flex-direction: column;
    gap: 14px;
  }
  .review_slick .review_card .row2{
    word-break: break-all;
    text-align: justify;
    line-height: 24px;
  }
  .review_slick .review_card .row2{}
  .review_slick .review_card .rate{color:orange}

  .review_slick .slick-slide{ margin:0 11px; overflow: hidden;}
  
  
  .matching_service{
    padding:120px 0;
  }
  
  .join_petner{
    background-color:#FEAC48;
    padding:140px 0;
    color:#fff;
    margin-bottom: -50px;;
  }
  .join_petner .inner{
    width:1000px; 
    margin:0 auto;
    display: flex;
    justify-content: space-between;
  }
  .join_petner h3{padding-bottom: 18px;}
  .join_petner .text_area{
    display: flex;
    flex-direction: column;
    justify-content: space-between;
  }
  .join_petner .text_area .intro{line-height: 20px;}
  .join_petner .img_area{width:40%}
  .join_petner img{width:100%}
  .join_petner .btn_area{}
  .join_petner .btn_area a{
    display: block;
    border: 1px solid #fff;
    padding: 14px 28px;
    border-radius: 40px;
    width: fit-content;
    margin-top: 20px;
    font-size: 2rem;
  }

  .join_petner .btn_area a:hover{
    background-color: #fff;
    color:#FEAC48
  }
  
  .cl_grey{color:#ddd}
 
</style>
</head>

<script>
	$(document).ready(function(){
    $('.review_slick').slick({
      infinite: true,
      autoplay: true,
      autoplaySpeed: 5000,
      slidesToShow: 3,
			slidesToScroll: 1,
      nextArrow: $('.next'),
			prevArrow: $('.prev')
			
    });
   
  }) // jquery ENDS
  
</script>

<body>
	<div id="wrapper">
		<!-- HEADER BASIC -->
		<c:import url='/WEB-INF/views/include/header.jsp' />
		
		<!-- CONTAINER -->
    <div class="container main">
      <!-- 비디오 -->
      <div class="main_visual">
        <video autoplay loop muted type="video.mp4">
          <source src="${imgPath}/petner_main_video.mp4"/>
        </video>
        <div class="title">
          <p class="text">펫시터의 도움이 <br> 지금 필요해요</p>
          <p class="btn"><a href="${pageContext.request.contextPath}/join">회원가입하기</a></p>
        </div>
      </div>
      <!-- 섹션1 서비스 설명 -->
      <div class="service_desc ">
        <h3>필요할때 언제든지 <br> 펫시터를 부르세요</h3>
        <div>
          <p class="title">안전한 산책</p>
          <div class="desc">
            <p>목줄과 하네스가 연결된 이중산책줄을 통해 안전하게 산책합니다.</p>
            <p>* 목줄은 비상시에만 활용되며 평소 산책시에는 목에 무리가 가지 않도록 설계되었습니다.</p>
          </div>
        </div>
        <div>
          <p class="title">배식 및 환경정리</p>
          <div class="desc">
            <p>요청사항에 맞는 식사를 급여하며배변 치우기 등 간단한 환경정리를 진행합니다.</p>
          </div>
        </div>
        <div>
          <p class="title">다양한 실내놀이</p>
          <div class="desc">
            <p>기상 상황에 의해 산책이 어려울 땐 실내놀이를 합니다.</p>
          </div>
        </div>
        <div>
          <p class="title">환경 맞춤 돌봄</p>
          <div class="desc">
            <p>노령견 또는 환견의 경우, 요청사항에 따라일대일 맞춤 돌봄을 진행합니다.</p>
          </div>
        </div>
      </div>

      <!-- 후기영역  -->
      <div class="review">
        <h4>펫트너 후기</h4>
        <div class="slide_wr">
          <div class="btn_area">
            <button class="slick_btn prev"><i class="fa-solid fa-chevron-left"></i></button>
            <button class="slick_btn next"><i class="fa-solid fa-chevron-right"></i></button>
          </div>
          <div class="review_slick">
            <!-- 슬릭반복 -->
            <div class="review_card">
              <div class="row1">
                <div class="img_area">
                  <img src="${imgPath}/p1.png" alt=""/>
                </div>
                <div class="text_area">
                  <span>홍시*</span>
                  <div class="rate">
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <span class="cl_grey"><i class="fa-solid fa-paw"></i></span>
                  </div>
                </div>
              </div>
              <div class="row2">
                시터님께서 잘 돌보아주신 덕분에 맘 편하게 여행 다녀올수 있었습니다! 시터님과 잘놀았는지 오자마자 기절해서 잠만자네요~
                처음으로 맡기는 펫시팅이라 어느 분께 부탁드려야하나 정말 고민하다가 연락드린거였는데 탁월한 선택이었던것 같습니다!! 정말 감사했습니다!!
              </div>
            </div>
            
            <div class="review_card">
              <div class="row1">
                <div class="img_area">
                  <img src="${imgPath}/p2.png" alt=""/>
                </div>
                <div class="text_area">
                  <span>김혜*</span>
                  <div class="rate">
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                  </div>
                </div>
              </div>
              <div class="row2">
                갑자기 출장을 가야하는 상황이여서 당황스러웠는데 펫트너를 이용하게되어 너무 다행이였습니다.
                저희 고양이에 대해서 꼼꼼하게 쓸 수 있는 항목이 있어서 봐주시는데 큰 도움이 되었다고 합니다. 덕분에 저도 우리 고양이 스트레스 안받고 잘 놀고있는것 같았어요.
                다음에도 급한 일 생기면 또 이용 할 예정입니다. 감사합니다 펫트너!
              </div>
            </div>
            
            <div class="review_card">
              <div class="row1">
                <div class="img_area">
                  <img src="${imgPath}/p3.png" alt=""/>
                </div>
                <div class="text_area">
                  <span>김유*</span>
                  <div class="rate">
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                  </div>
                </div>
              </div>
              <div class="row2">
                다리가 다친탓에 산책도 못하고 돌봐주지도 못하고있었는데
                펫트너덕분에 울댕댕이 걱정안하고 회복 잘할수있었어요
                거동이 지금 불편한 상태였는데 픽업와주신다하셔서 정말 감사했습니다!
                정말 친절하셨고 또 이용하고싶어요~!!
              </div>
            </div>
            
            <div class="review_card">
              <div class="row1">
                <div class="img_area">
                  <img src="${imgPath}/p4.png" alt=""/>
                </div>
                <div class="text_area">
                  <span>정다*</span>
                  <div class="rate">
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <span class="cl_grey"><i class="fa-solid fa-paw"></i></span>
                  </div>
                </div>
              </div>
              <div class="row2">
              	평소에 10시간 이상 외출 해야할때 아이들 혼자 있는게 항상 맘에 걸렸는데
              	펫트너를 알게되어 방문서비스를 이용해보았습니다.
              	아이들을 저보다도 잘 놀아주시고 돌봐주셔서 걱정없이 외출 할수 있어요.
              	다음에도 다시 펫트너 펫시터님에게 아이들 맡길거에요
              </div>
            </div>
            
            <div class="review_card">
              <div class="row1">
                <div class="img_area">
                  <img src="${imgPath}/p5.png" alt=""/>
                </div>
                <div class="text_area">
                  <span>최동*</span>
                  <div class="rate">
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                  </div>
                </div>
              </div>
              <div class="row2">
                긴 출장으로 방문 돌봄서비스를 이용했는데 아이들 세심하게 잘 봐주셔서 마음 편하게 출장 잘 다녀왔습니다. 
                펫트너 펫시터 분들은 모두 반려동물 돌봄 교육을 받는다고 하는데 정말 잘 돌봐주셔서 주변에도 추천했습니다.
              </div>
            </div>
            
            <div class="review_card">
              <div class="row1">
                <div class="img_area">
                  <img src="${imgPath}/p6.png" alt=""/>
                </div>
                <div class="text_area">
                  <span>조아*</span>
                  <div class="rate">
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                    <i class="fa-solid fa-paw"></i>
                  </div>
                </div>
              </div>
              <div class="row2">
                제가 손을 다쳐서 아이들 목욕서비스를 신청하였는데 너무 전문적으로 빠르고 깔끔하게 해주셨어요.
                큰 강아지라 목욕하는게 일인데 앞으로 목욕서비스만이라도 정기적으로 이용하고 싶을 정도로 너무 편하고 좋았어요
              </div>
            </div>
          </div>
        </div>
      </div>
      
      <!-- 매칭서비스 설명  -->
      <div class="service_desc matching_service">
        <h3>믿을수 있고 <br> 안심할 수 있어요</h3>
        <p class="intro">철저한 인증, 충분한 대화후 매칭 가능</p>
      </div>

      <!-- 가입유도화면 -->
      <div class="join_petner">
        <div class="inner">
          <div class="text_area">
            <div>
              <h3>펫트너 파트너로 함께해요!</h3>
              <p class="intro">반려가족에게 행복한 시간을 선물할 수 있도록 <br> 펫트너와 함께 성장할 파트너를 찾습니다.</p>
            </div>
            <div class="btn_area">
              <a class="transition02" href="">펫시터 가입 <i class="fa-solid fa-arrow-right"></i></a>
              <a class="transition02" href="">보호자 가입 <i class="fa-solid fa-arrow-right"></i></a>
            </div>
          </div>
          <div class="img_area">
            <img src="${imgPath}/main_img1.png" alt="">
          </div>
        </div>
      </div>
    </div>
		<!-- FOOTER BASIC -->
		<c:import url='/WEB-INF/views/include/footer.jsp' />

	</div>
</body>
</html>