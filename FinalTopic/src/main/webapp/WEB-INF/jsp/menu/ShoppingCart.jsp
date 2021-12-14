<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>購物車</title>
<link rel=stylesheet href="style.css">
<link rel=stylesheet href="showhidemenu.css">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet" href="../css/style.css">
<!-- Colors CSS -->
<link rel="stylesheet" href="../css/colors.css">
<!-- ALL VERSION CSS -->
<link rel="stylesheet" href="../css/versions.css">
<!-- Responsive CSS -->
<link rel="stylesheet" href="../css/responsive.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="../css/custom.css">
<!-- font family -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- end font family -->

<link rel="stylesheet" href="../css/3dslider.css" />

<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>

<link href="http://www.jqueryscript.net/css/jquerysctipttop.css"
	rel="stylesheet" type="text/css">

<script src="../js/3dslider.js"></script>

<!-- ALL JS FILES -->
<script src="../js/all.js"></script>

<!-- ALL PLUGINS -->
<script src="../js/custom.js"></script>
</head>

<body>
	<div class="container"
		style="background-color: #DEDEBE; width: 100%; height: 1000px">
		<section id="top">
			<header>
				<div class="container">
					<div class="header-top">
						<div class="row">
							<div class="col-md-4">
								<a class="logo" href="<c:url value='/login/MemberSuccess' />">
									<div class="logo-content">
										<img src="../images/springfitnesslogo6.png" alt="index" />
										<h1>SPRINGFITNESS</h1>
									</div>
								</a>
							</div>
							<div class="col-md-8 header-button-container">
								<div class="right_top_section">
									<!-- button section -->
									<ul class="login">
										<li class="login-modal"><a
											href="/updatePassword/<c:out value='${loginUser.number}' />"
											class="login"> <svg xmlns="http://www.w3.org/2000/svg"
													width="16" height="16" fill="currentColor"
													class="bi bi-lock-fill" viewBox="0 0 16 16">
                                                    <path
														d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z" />
                                                </svg><i class="fa fa-user"></i>密碼變更
										</a></li>
										<li class="logout-modal"><a
											href="<c:url value='/logout' />" class="login"><svg
													xmlns="http://www.w3.org/2000/svg" width="16" height="16"
													fill="currentColor" class="bi bi-person-fill"
													viewBox="0 0 16 16">
                                                    <path
														d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
                                                </svg><i class="fa fa-user"></i>登出</a></li>
										<li>
											<div class="context-option">
												<a href="#"><i class="fa fa-envelope"><svg
															xmlns="http://www.w3.org/2000/svg" width="16" height="16"
															fill="currentColor" class="bi bi-envelope"
															viewBox="0 0 16 16">
                                                            <path
																d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z" />
                                                        </svg></i>聯絡我們</a>
											</div>
										</li>
									</ul>
									<!-- end button section -->
								</div>
							</div>
						</div>
					</div>
					<div class="header-bottom">
						<div class="row">
							<div class="col-md-12">
								<div class="full">
									<div class="main-menu-section">
										<div class="menu">
											<nav class="navbar navbar-inverse">
												<div class="navbar-header">
													<button class="navbar-toggle" type="button"
														data-toggle="collapse" data-target=".js-navbar-collapse">
														<span class="sr-only">Toggle navigation</span> <span
															class="icon-bar"></span> <span class="icon-bar"></span> <span
															class="icon-bar"></span>
													</button>
													<a class="navbar-brand" href="#">Menu</a>
												</div>
												<div class="collapse navbar-collapse js-navbar-collapse">
													<ul class="nav navbar-nav">
														<li class="active"><a
															href="<c:url value='/login/MemberSuccess' />">主頁</a></li>
														<li><a href="about.html">關於</a></li>

														<li class="dropdown mega-dropdown member"><a href="#"
															class="dropdown-toggle" data-toggle="dropdown ">會員中心<span
																class="caret"></span></a>
															<ul class="dropdown-menu mega-dropdown-menu member">
																<li class="col-sm-12">
																	<ul>
																		<li class="dropdown-header">會員中心</li>
																		<li><a class="dropdown-item"
																			href="/MemberProfile">個人資料</a></li>
																		<li><a class="dropdown-item"
																			href="/selectInbody/<c:out value='${loginUser.number}' />">Inbody紀錄</a>
																		</li>
																		<li><a class="dropdown-item"
																			href="/selectPayment/<c:out value='${loginUser.number}' />">會費紀錄
																		</a></li>
																		<li><a class="dropdown-item"
																			href="/findAllDeposite/<c:out value='${loginUser.number}' />">儲值紀錄</a>
																		</li>
																		<li><a class="dropdown-item"
																			href="/updateDeposite/<c:out value='${loginUser.number}' />">我要儲值</a>
																		</li>
																	</ul>
																</li>
															</ul></li>
														<li><a href="<c:url value= '/member/showCoachList'/>">教練師資</a></li>
														<li class="dropdown mega-dropdown"><a href="#"
															class="dropdown-toggle" data-toggle="dropdown ">預約私人課程<span
																class="caret"></span></a>
															<ul class="dropdown-menu mega-dropdown-menu coach">
																<li class="col-sm-12">
																	<ul>
																		<li class="dropdown-header">一對一課程</li>
																		<li><a class="dropdown-item"
																			href="/member/classReservation">課程預約</a></li>
																		<li><a class="dropdown-item"
																			href="/classIntroduction">課程介紹</a></li>
																		<li><a class="dropdown-item"
																			href="/member/memberViewClassLists">我的課程 </a></li>
																		<li><a class="dropdown-item"
																			href="/member/memberClassListHistory">我的課程(歷史紀錄)
																		</a></li>
																	</ul>
																</li>
															</ul>
														<li class="dropdown mega-dropdown"><a href="#"
															class="dropdown-toggle" data-toggle="dropdown">團體課程<span
																class="caret"></span></a>
															<ul class="dropdown-menu mega-dropdown-menu classRes">
																<li class="col-sm-12">
																	<ul>
																		<li class="dropdown-header">團體課程 Cousres</li>
																		<li><a class="dropdown-item"
																			href="/courseSelectSystem">預約課程</a></li>
																		<li><a class="dropdown-item"
																			href="/myCourseSchedule">我的課程</a></li>
																		<li><a class="dropdown-item"
																			href="/pastCourseRecord">上課紀錄</a></li>

																	</ul>
																</li>
															</ul></li>
														<li class="dropdown mega-dropdown"><a href="#"
															class="dropdown-toggle" data-toggle="dropdown">健康餐盒<span
																class="caret"></span></a>
															<ul class="dropdown-menu mega-dropdown-menu food-menu">
																<li class="col-sm-12">
																	<ul>
																		<li class="dropdown-header">餐點</li>
																		<li><a href="shoppingCart.controller" style="color:black">購物車 </a></li>
																		<li><a href="ToEvaluationMainPage" style="color:black">餐點滿意度調查 </a></li>
																	</ul>
																</li>
															</ul></li>
														<li><a href="<c:url value= '/commodity'/>">周邊商品</a></li>
													</ul>
												</div>
											</nav>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</header>
			
			<div class="full-slider" >
				<div id="carousel-example-generic" class="carousel slide">
				
					<c:set var="sum" value="0"></c:set>

	


	<c:choose>
		<c:when test="${orderId=='0'}">
			<br>
			<br>
			<div style="margin-left: 150px">
				<div style="font-size: 25px; height: 100px ;clear: both; text-align: center; margin-top: 300px ;color:black">查無訂單</div>
			</div>
		</c:when>
		<c:otherwise>

			
			<div style=" width: 100%;color: black">
				<div id='totalprice' style="clear: both; margin-left: 150px; border-radius:0 px;height: 100px;">
					<div style=" margin-left: 10px;">
						<font size="6" style="line-height:100px ">您的訂購編號為:${orderId}</font> &emsp; &emsp;
						<font size="5" id='sum' id="totalprice">共 ${sum} 元 </font> &emsp; &emsp;
					<a href="Menumain.controller" class="transition">繼續購物</a> 
					&emsp;&emsp; 
					
					<a href="pay.ControllerTest?orderId=${OrderMenuList.get(0).getOrderId()}"
								class="transition" id="clickOrder">確認訂購</a> 
					
					<br> <br>
					</div>
				 
				</div>
			</div>



			<br>
			<c:set var="sum" value="0"></c:set>

			<div style="margin-left: 150px; margin-top: 50px">
				<c:forEach var="cart" items="${OrderMenuList}">


					<div class="shoppingCart" id="shoppingCart">
						<div style="float: right; margin-top: 10px; margin-right: 5px">
							<a href='DeleteShoppingcart.controller?id=${cart.getId()}'><img
								src="images/cross.png" class="icon"></a>
						</div>
						<br> <br> <br> <font size="5">${cart.getMenu().getMenuName()}</font>
						<br> <font size="5">$${cart.getMenu().getPrice()}</font> <br>
						<font size="5">您所訂購的數量:${cart.getQty()}</font> <br>
						<c:set var="sum"
							value="${sum+cart.getMenu().getPrice()*cart.getQty()}"></c:set>
						<br> <a
							href='ModifyShoppingcart.controller?id=${cart.getId()}'>修改此筆訂單</a>
						<br> <br>
					</div>

				</c:forEach>

			</div>





			<ul class="transition,menu,">
				<li></li>
				<li></li>
				<!-- <li><a class="transition">Home</a></li>
                <li><a class="transition">Shop</a></li>
                <li><a class="transition">Gallery</a></li>
                <li><a class="transition">About</a></li> -->
			</ul>





			<br>





		</c:otherwise>
	</c:choose>
				
				
				</div>
				</div>
		</section>
	</div>		

	




	<script>
	if(${sum}>0) {
		document.getElementById('sum').innerHTML= '共 ${sum} 元';
	}		  
function qtychange(){
	 var qty = document.getElementsByName('menuqty');
	 var price = document.getElementsByName('price');
	    var tot=0;
	    for(var i=0;i<qty.length;i++){
	        if(parseInt(qty[i].value) && parseInt(price[i].value))
	            tot += parseInt(qty[i].value*parseInt(price[i].value));
	    }
	    document.getElementById('totalprice').innerHTML= "共"+tot+"元";
	
}







</script>
</body>
</html>