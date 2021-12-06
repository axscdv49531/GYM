<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="styles_classIntro/bootstrap-4.1.2/bootstrap.min.css">
<link href="plugins_classIntro/font-awesome-4.7.0/css/font-awesome.min.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="plugins_classIntro/OwlCarousel2-2.2.1/owl.carousel.css">
<link rel="stylesheet" type="text/css" href="plugins_classIntro/OwlCarousel2-2.2.1/owl.theme.default.css">
<link rel="stylesheet" type="text/css" href="plugins_classIntro/OwlCarousel2-2.2.1/animate.css">
<link href="plugins_classIntro/colorbox/colorbox.css" rel="stylesheet" type="text/css">
<link rel="stylesheet" type="text/css" href="styles_classIntro/services.css">
<link rel="stylesheet" type="text/css" href="styles_classIntro/services_responsive.css">
</head>
<body>

<!--  <div style="width: 1205px; height: 194.13px" class ="top"> -->
<%--         <c:import url="/top_memberlogin"></c:import> --%>
<!--     </div> -->

<div class="services">
        <div class="container">
            <div class="row">
                <div class="col">
                    <div class="section_title_container">
                        <div class="section_subtitle">歡迎您</div>
                        <div class="section_title">課程介紹</div>
                    </div>
                </div>
            </div>
            <div class="row services_row">
                
                <!-- Service -->
                <div class="col-xl-4 col-md-6 service_col">
                    <div class="service">
                        <div class="service_title_container d-flex flex-row align-items-center justify-content-start">
                            <div><div class="service_icon"><img src="images/yoga.png" alt=""></div></div>
                            <div class="service_title">瑜珈</div>
                        </div>
                        <div class="service_text">
                            <p>藉由瑜珈的體位，配合深沈平穩的呼吸，來舒展全身筋骨及肌肉。</p>
                        </div>
                    </div>
                </div>

                <!-- Service -->
                <div class="col-xl-4 col-md-6 service_col">
                    <div class="service">
                        <div class="service_title_container d-flex flex-row align-items-center justify-content-start">
                            <div><div class="service_icon"><img src="images/TRX.png" alt=""></div></div>
                            <div class="service_title">懸吊訓練</div>
                        </div>
                        <div class="service_text">
                            <p>利用身體重量做為阻力，自行調整傾斜角度或站姿來控制合適的強度，增加全身肌群的平衡、協調與穩定。</p>
                        </div>
                    </div>
                </div>

                <!-- Service -->
                <div class="col-xl-4 col-md-6 service_col">
                    <div class="service">
                        <div class="service_title_container d-flex flex-row align-items-center justify-content-start">
                            <div><div class="service_icon"><img src="images/AerobicTraining.png" alt=""></div></div>
                            <div class="service_title">重量訓練</div>
                        </div>
                        <div class="service_text">
                            <p>以器械或個人體重為主要重量負荷器具，以增強肌肉力量、雕塑及改善體型。</p>
                        </div>
                    </div>
                </div>


                <!-- Service -->
                <div class="col-xl-4 col-md-6 service_col">
                    <div class="service">
                        <div class="service_title_container d-flex flex-row align-items-center justify-content-start">
                            <div><div class="service_icon"><img src="images/crossfit.png" alt=""></div></div>
                            <div class="service_title">混合健身</div>
                        </div>
                        <div class="service_text">
                            <p>結合各項器材及有氧運動，透過身體全方位的訓練，改善身體爆發力。</p>
                        </div>
                    </div>
                </div>

                <!-- Service -->
                <div class="col-xl-4 col-md-6 service_col">
                    <div class="service">
                        <div class="service_title_container d-flex flex-row align-items-center justify-content-start">
                            <div><div class="service_icon"><img src="images/WheightLifting.png" alt=""></div></div>
                            <div class="service_title">減重</div>
                        </div>
                        <div class="service_text">
                            <p>透過高耗能量的運動再加上短暫歇息的方式來消耗熱量，減低脂肪率，達到瘦身的效果。</p>
                        </div>
                    </div>
                </div>

                <!-- Service -->
                <div class="col-xl-4 col-md-6 service_col">
                    <div class="service">
                        <div class="service_title_container d-flex flex-row align-items-center justify-content-start">
                            <div><div class="service_icon"><img src="images/BodyCombat.png" alt=""></div></div>
                            <div class="service_title">拳擊</div>
                        </div>
                        <div class="service_text">
                            <p>結合拳擊、泰拳、跆拳道〈踢擊〉各項武術的訓練課程，有效地消耗大量的卡洛里、雕塑身體體線。</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <center><input type="button" onclick="location.href='/classReservation';" value="立即預約" /></center>

</body>
</html>