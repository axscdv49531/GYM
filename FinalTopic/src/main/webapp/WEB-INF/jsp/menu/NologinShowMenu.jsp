<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet" href="../css/style.css">
<!-- Colors CSS -->
<!-- ALL VERSION CSS -->

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


<script src="/js/3dslider.js"></script>

    <script src="../js/3dslider.js"></script>


<!-- ALL JS FILES -->
<script src="../js/all.js"></script>

<!-- ALL PLUGINS -->
<script src="../js/custom.js"></script>


<link rel=stylesheet href="style.css">
<link rel=stylesheet href="showMenu.css">
<link rel=stylesheet href="editFrom.css">





</head>

<body>
	<div class="container" style="background-color:	#DEDEBE ;width: 100%;height: 100% ">
		<section id="top">
			<header>
				<div class="container">
					<div class="header-top">
						<div class="row">
							<div class="col-md-6">
								<div class="full">
									<div class="logo">
										<a href="<c:url value='/login/MemberSuccess' />"><img
											src="../images/springfitnesslogo6.png" alt="index" /></a>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="right_top_section">
									<%-- <c:out value="${loginUser.name },歡迎您" /> --%>
									<!-- button section -->
									<ul class="login">
										
										<li class="logout-modal"><a
											href="<c:url value='/logout' />" class="logout"><svg
													xmlns="http://www.w3.org/2000/svg" width="16" height="16"
													fill="currentColor" class="bi bi-person-fill"
													viewBox="0 0 16 16">
                                                    <path
														d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
                                                </svg><i class="fa fa-user"></i>登入</a></li>
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
															href="<c:url value='/' />">主頁</a></li>
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
																	</ul>
																</li>
															</ul></li>
														<li class="dropdown-header"><a
															href="<c:url value= '/showCoachList'/>">教練師資</a></li>
														<!--                                                         <li><a href="/classRes">預約私人課程</a></li> -->

														<li class="dropdown mega-dropdown"><a href="#"
															class="dropdown-toggle" data-toggle="dropdown ">預約私人課程<span
																class="caret"></span></a>
															<ul class="dropdown-menu mega-dropdown-menu member">
																<li class="col-sm-12">
																	<ul>
																		<li class="dropdown-header">一對一課程</li>
																		<li><a class="dropdown-item"
																			href="/classReservation">課程預約</a></li>
																		<li><a class="dropdown-item"
																			href="/classIntroduction">課程介紹</a></li>
																		<li><a class="dropdown-item"
																			href="/memberViewClassLists">我的課程 </a></li>
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

														<li><a href="/login/Member" >購物車 
														</a></li>
									
														<li><a href="news.html">周邊商品</a></li>

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
			<div class="full-slider">
				<div id="carousel-example-generic" class="carousel slide">
					<div
				style="height: 55px; width: 55px; float: right; cursor: pointer; margin: 10px 20px; position: relative; display: none;">
				<font size=4 color="red" style="float: right" id="cart_n">0</font> <a
					href="shoppingCart.controller" class="transition"> <img
					id="cart" src="images/carts.png"
					style="height: 50px; width: 50px; position: absolute; top: 10px; right: 10px;">
				</a>
			</div>

			<div style="">
				<!-- 主要DIV -->
				<div class="mainDiv">
					<h3 class="FontTitle"></h3>
					<c:forEach var="menuList" items="${MenuList}" varStatus="index">


						<div class="PictureDivR">

							<div style="float: left">
								<img id="image1" src="images/${menuList.getMenuName()}.png"
									class="img01">
							</div>

							<div style="float: right; width: 600px; height: 200px">





								<div
									style="margin-left: 25px; margin-top: 25px; font-family: DFKai-sb; font-size: 25px; float: left">${menuList.getMenuName()}</div>

								<div
									style="margin-left: 25px; margin-top: 25px; font-family: DFKai-sb; font-size: 25px; float: right">.............................${menuList.getPrice()}</div>



								<div
									style="margin-left: 25px; font-family: DFKai-sb; font-size: 25px; margin-top: 40px; float: left"
									id="score${index.index}">綜合評分&emsp;</div>
								<div
									style="margin-left: 25px; font-family: DFKai-sb; font-size: 25px; margin-top: 40px; float: right; cursor: pointer;"
									onclick="checkSuggestion('${menuList.getMenuName()}')">查看網友評論</div>


								<div
									style="margin-left: 25px; font-family: DFKai-sb; font-size: 25px; margin-top: 170px; clear: both">${menuList.getMenudetail() }
									<div
										style="float: right; text-decoration: underline; cursor: pointer"
										id="clickOrder${index.index}"
										><a href="/login/Member">點此訂購</a></div>

								</div>



							</div>

						</div>

					</c:forEach>
				</div>

				<form:form action="OrderMenu.controller" method='POST'
					modelAttribute="orderMenu">

					<!--顯示資訊及訂餐-->
					<div class="detailDiv01" id="showDetail1"
						style="position: fixed; z-index: 999">
						<img src="images/cross.png" onclick="order_close()"
							style="height: 25px; width: 25px; float: right; cursor: pointer; margin: 10px 10px">
						<br>
						<form:select path="menu.menuName" size="1"
							class="detailDiv01Font1" id="menuSelect">
							<br>
							<option value="0" style="background-color: 	#8E8E8E">請選擇餐點</option>
							<c:forEach var="menuList" items="${MenuList}">
								<option value="${menuList.getMenuName()}" style="background-color: #8E8E8E">${menuList.getMenuName()}</option>
							</c:forEach>

						</form:select>
						<br> <font size="5" class="detailDiv01Font2">價格:</font>
						<form:input path="price" id="price2" class="detailDiv01Font2"
							value="0" size="2" />
						<br> <br> <font class="detailDiv01Font2">數量:</font> <img
							src="images/MinusSign.svg" class="minusIcon"
							style="cursor: pointer" />
						<form:input path="qty" class="detailDiv01Font3" size="2"
							id="menuqty" value="1" />
						<img src="images/plus.svg" class="plusIcon"
							style="cursor: pointer;margin:0px;" /><input
							type="submit" value="加入購物車" class="detailDiv01Font1"
							id="orderButton" />
					</div>
				</form:form>





				<div id="suggestion"
					style="border-style: solid; border-color: #D6D6AD; border-width: 1px; background-color: #D6D6AD; margin: 0 auto; overflow: auto; position: fixed; z-index: 999; left: 15%; top: 100px; width: 70%; height: 600px; display: none;">
					
					<img src="images/cross.png" onclick="suggestion_close()"
						style="height: 25px; width: 25px; float: right; cursor: pointer; margin: 10px 10px; background-color: #D6D6AD">
					<br> <br>
					<div id="suggestionText"
						style="color: black; text-align: center; width: 90%; ">

					</div>
				</div>



			</div>
				</div>
				</div>
			
			
		</section>
	</div>		



		



			<script>
		var data = {
			<c:forEach var="menuList" items="${MenuList}" varStatus="loop">
	            '${menuList.getMenuName()}': ${menuList.getPrice()}${!loop.last ? ',' : ''}
	        </c:forEach>
	    };
		
		
		var score = {
				<c:forEach var="menuList" items="${MenuList}" varStatus="loop">
		            '${menuList.getMenuName()}': [0,0]${!loop.last ? ',' : ''}
		        </c:forEach>
		    };
		
		var suggestion = {
				<c:forEach var="menuList" items="${MenuList}" varStatus="loop">
		            '${menuList.getMenuName()}':''${!loop.last ? ',' : ''}
		        </c:forEach>
		    };
		
		<c:set var="sum" value="0"></c:set>
		<c:forEach var="OrderMenuList" items="${OrderMenuList}" varStatus="loop">
			<c:set var="sum" value="${sum+OrderMenuList.getQty()}"></c:set>
		</c:forEach>
		document.getElementById('cart_n').innerHTML= '${sum}';
		if(${sum}>0) {
			document.getElementById("cart").src = "images/trolley.png";
		}							 
	
		$("#menuSelect").change(function(){
			
			var x=$(this).val()
			document.getElementById("price2").value = data[x];
			
			document.getElementById("price2").readOnly = true;
		});
		
		
		$("#orderButton").click(function(){
			
			var menuqty=$("#menuqty").val();
			var menuSelect=$("#menuSelect").val();
			
			<c:forEach var="menuList" items="${MenuList}">
				var name='${menuList.getMenuName()}';
					if(name==menuSelect){
						menuqty=Number(menuqty);
						var total=Number(${menuList.getMenuQty()});
						if(total<menuqty){
							alert(name+"產品不足");
							return false;
						}
					}
       		</c:forEach>
			
		});
		
		
		function changCss()
		{
			document.getElementById("showDetail1").style.display = "block";
			document.getElementById("OutDisplayNone").style.display = "none";
			document.getElementById("OrdermenuButton").style.display = "none";
		
		}
		
		function order(select, price)
		{
			document.getElementById("showDetail1").style.display="block"; 
			document.getElementById("menuSelect").value = select;
			document.getElementById("price2").value = price;
			document.getElementById("price2").readOnly = true;
			
		}
		
		function order_close()
		{
			document.getElementById("showDetail1").style.display="none"; 
		}
				

		 $("#clickOrder").click(function(){
			 document.getElementById("showDetail1").style.display="block"; 
			 console.log("ok")
	        });
		
		
		
		 $(".menu").click(function(){
	            $(this).toggleClass("active");
	        });
		 
		 $(".minusIcon").click(function(){
	            var qty=$("#menuqty").val();
	            qty=Number(qty);
	            qty=qty-1;
	            if(qty<=1){
	            	qty=1;
	            }
	            $("#menuqty").val(qty);
	           
	        });
		 $(".plusIcon").click(function(){
			   var qty=$("#menuqty").val();
			   qty=Number(qty);
	           qty=qty+1;
	            $("#menuqty").val(qty);
	            
	        });
		 
		  $(document).ready(function(){
			   load();
		   });
		  
		  
		  function suggestion_close(){
			  $("#suggestion").css("display","none");
			  
		  }
		  
	
      	
      	
      	function checkSuggestion(name){

      	  $("#suggestion").css("display","block");
      	  $('#suggestionText').empty("");
      	  	
      		var s=suggestion[name];
      		if(s.length == 0) {
      			$("#suggestionText").append("<div style='width:80%;'><u>"+name+"</u>無網友評分"+"</div>");
      			$("#suggestionText").append("<br>");
      			
      			return;
      		}
      		var strAry = s.split('<br>');
      		console.log(strAry[0]+"s");
      		console.log(strAry[1]+"s1");
      		
      	
      		
      		var size=strAry.length;
      		var tr="";
      		
      		
      		var total=score[name][0]/score[name][1];
      		$("#suggestionText").append("<div style='width:80%;font-size:25px;font-family:DFKai-sb;'>網友評分:"+total.toFixed(1)+" 分"+"</div>");
      		$("#suggestionText").append("<br>");
      		for(var x=0;x<strAry.length-1;x++){
      			$("#suggestionText").append("<div style='width:55%;border-left-style:solid;border-left-color:grey;border-left-width:3px;margin:20px 20px;padding:20px 20px;border-radius:0px'>"
              	+"&emsp;"+"<p style='float:left;font-size:25px;	font-family:DFKai-sb;'>網友 "+(x+1)+" 說 :</p> "
              	+"<textarea cols='40' wrap='hard' style='border:none;outline:none;font-size:20px;font-family:DFKai-sb;' readonly>"
              	+strAry[x]
              	+"</textarea>"
              	+"<br></div>");
      			
      		}
      		
      		const tx = document.getElementsByTagName("textarea");
            for (let i = 0; i < tx.length; i++) {
             tx[i].setAttribute("style", "height:" + (tx[i].scrollHeight) + "px;overflow-y:hidden;border:none;outline:none;");
             //tx[i].addEventListener("input", OnInput, false);
            }
            $('#suggestion').height($(window).height()*8/10);
      	}
      		  
      		
      	
      	
		  
		 
		  
		  
		  
		  function load(){
			 var evaluation= [];
			 
			 
			  
			  $.ajax({
				   type:'post',
				   url:"findAll.controller",
				   dataType:'JSON',
				   contentType:'application.json',
				   success: function(data){
					   
						
					   console.log('success:' + data);
					   var json = JSON.stringify(data);
					   console.log('json: findAll.controller=' + json);
					   $.each(data, function(i,n){
						   evaluation.push(n);
					   });	
					   
					   console.log(evaluation[0]+"->evaluation");
					   var number=0;
					   for(var i =0;i<evaluation.length;i++){
						   console.log(evaluation.length+"evaluation.length")
							food =evaluation[i]['menuname'];
							if(food.length < 4) {
								continue;
							}
							score[food][0]+=Number(evaluation[i]['score'][0]);
							
							console.log(score[food][0]);
								
							
							
							score[food][1]++;
							if(evaluation[i]["suggestion"].length>0){
								suggestion[food]+=evaluation[i]["suggestion"]+"<br>";
								number=number+1;
							}
							
							
						}
					   
					   
					   
						console.log(score+"score");
						console.log(suggestion+"suggestion");
						
						
						
						var menuName=[];
						<c:forEach var="menuList" items="${MenuList}" varStatus="loop">
							menuName.push('${menuList.getMenuName()}');
				        </c:forEach>
						
						for(var x=0;x<${MenuList.size()};x++){
							var total=score[menuName[x]][0]/score[menuName[x]][1];
							total=total.toFixed(1)
							$("#score"+x).append(total);
							$("#suggestion"+x).html(suggestion[menuName[x]]);
						}
						
						
						
			           
			       		
						
						
					 
				   }
			  		
			   });
		  }
			

	</script>
</body>

</html>