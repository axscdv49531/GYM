<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Online order</title>
<link rel=stylesheet href="style.css">
<link rel=stylesheet href="showhidemenu.css">
<link rel=stylesheet href="showMenu.css">
<link rel=stylesheet href="editFrom.css">
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">

</head>
<body>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<div
		style="height: 55px; width: 55px; float: right; cursor: pointer; margin: 10px 20px; position: relative">
		<font size=4 color="red" style="float: right" id="cart_n">0</font> <a
			href="shoppingCart.controller" class="transition"> <img id="cart"
			src="images/carts.png"
			style="height: 50px; width: 50px; position: absolute; top: 10px; right: 10px;">
		</a>
	</div>

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
						style="margin-left: 25px; margin-top: 25px; font-family: DFKai-sb; font-size: 25px; float: right">................................$${menuList.getPrice()}</div>
						
					<div style="margin-left: 25px;font-family: DFKai-sb; font-size: 25px;margin-top:40px; float: left" id="score${index.index}">綜合評分&emsp;</div>
					<div style="margin-left: 25px;font-family: DFKai-sb; font-size: 25px;margin-top:40px;float: right ;cursor: pointer;" onclick="checkSuggestion('${menuList.getMenuName()}')">查看網友評論</div>
					
					<div
						style="margin-left: 25px; font-family: DFKai-sb; font-size: 25px; margin-top: 150px; clear: both">${menuList.getMenudetail() }
						<div
							style="float: right; text-decoration: underline; cursor: pointer"
							id="clickOrder${index.index}"
							onclick="order('${menuList.getMenuName()}', '${menuList.getPrice()}')">點此訂購</div>

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
			<form:select path="menu.menuName" size="1" class="detailDiv01Font1"
				id="menuSelect">
				<br>
				<option value="0">請選擇餐點</option>
				<c:forEach var="menuList" items="${MenuList}">
					<option value="${menuList.getMenuName()}">${menuList.getMenuName()}</option>
				</c:forEach>

			</form:select>
			<br> <font size="5" class="detailDiv01Font2">價格:</font>
			<form:input path="price" id="price2" class="detailDiv01Font2"
				value="0" size="2" />
			<br> <br> <font class="detailDiv01Font2">數量:</font> <img
				src="images/MinusSign.svg" class="minusIcon" style="cursor: pointer" />
			<form:input path="qty" class="detailDiv01Font3" size="2" id="menuqty"
				value="1" />
			<img src="images/plus.svg" class="plusIcon" style="cursor: pointer" />

			<br> <br> <input type="submit" value="加入購物車"
				class="detailDiv01Font1" id="orderButton" />
		</div>
	</form:form>
	
	
	
	
	
		<div id="suggestion" style="width:500px; border-style:solid;border-color: black;border-width:1px; 
										background-color: #E0E0E0; margin: 0 auto;position: fixed; z-index: 999; left:40%;display:none;">
			<img src="images/cross.png" onclick="suggestion_close()"
				style="height: 25px; width: 25px; float: right; cursor: pointer; margin: 10px 10px">
			<br>
			<table id="suggestionText" >
			</table>
		</div>
			

	<div class="wrapper">
		<div class="menu transition">
			<div class="bar bar1 transition"></div>
			<div class="bar bar2 transition"></div>
			<div class="bar bar3 transition"></div>
			<ul class="transition">
				<li><a href="shoppingCart.controller" class="transition">前往購物車</a></li>
				<li><a class="transition" id="clickOrder">選此訂購</a></li>
				<!-- <li><a class="transition">Home</a></li>
                <li><a class="transition">Shop</a></li>
                <li><a class="transition">Gallery</a></li>
                <li><a class="transition">About</a></li> -->
			</ul>
		</div>
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
      		var strAry = s.split('<br>');
      		console.log(strAry[0]+"s");
      		console.log(strAry[1]+"s1");
      		
      	
      		
      		var size=strAry.length;
      		var tr="";
      		
      		
      		
      		var total=score[name][0]/score[name][1];
      		$("#suggestionText").append("<tr >"+"<td class='suggestionScore'>"+"網友評分:"+total+"顆星"+"</td>"+"</tr>");
      		 $("#suggestionText").append("<br>");
      		for(var x=0;x<strAry.length-1;x++){
      			
      			
      			 $("#suggestionText").append("<tr>"+"<td class='suggestioncss'>"+strAry[x]+"</td>"+"</tr>");
      			 $("#suggestionText").append("<br>");
      		}
      		
      	
      		
      		
      	
    	  
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
					   console.log('json:' + json);
					   $.each(data, function(i,n){
						   evaluation.push(n);
					   });	
					   
					   console.log(evaluation);
					   for(var i =0;i<evaluation.length;i++){
							food =evaluation[i]['menuname'];
							score[food][0]+=Number(evaluation[i]['score'][0]);
							score[food][1]++;
							if(evaluation[i]["suggestion"].length>0){
								suggestion[food]+=evaluation[i]["suggestion"]+"<br>";
							}
							
							
						}
					   
						console.log(score);
						console.log(suggestion);
						
						
						
						var menuName=[];
						<c:forEach var="menuList" items="${MenuList}" varStatus="loop">
							menuName.push('${menuList.getMenuName()}');
				        </c:forEach>
						
						for(var x=0;x<${MenuList.size()};x++){
							var total=score[menuName[x]][0]/score[menuName[x]][1];
							$("#score"+x).append( total+"顆星");
							$("#suggestion"+x).html(suggestion[menuName[x]]);
						}
						
						
						
			           
			       		
						
						
					 
				   }
			  		
			   });
		  }
			

	</script>

</body>
</html>