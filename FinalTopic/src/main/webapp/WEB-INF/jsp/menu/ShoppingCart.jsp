<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>

<html>
<head>
<meta charset="UTF-8">
<title>購物車</title>
<link rel=stylesheet href="style.css">
<link rel="stylesheet"
	href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css">
<link rel=stylesheet href="showhidemenu.css">
</head>
<body>




	<c:set var="sum" value="0"></c:set>


	<c:choose>
		<c:when test="${orderId=='0'}">
			<br>
			<br>
			<div style="margin-left: 150px">
				<div style="font-size: 25px; height: 100px">查無訂單</div>

				<a href="Menumain.controller" class="transition">繼續購物</a>
			</div>
		</c:when>
		<c:otherwise>

			<div style="background-color: #FBFCFC; width: 100%;">
				<div id='totalprice' style="clear: both; margin-left: 150px;">
					<div style="margin-top: 50px; margin-left: 10px">
						<font size="6">您的訂購編號為:${orderId}</font>
					</div>
					<br> <font size="5" id='sum' id="totalprice">共 ${sum} 元 </font> &emsp; &emsp;
					<a href="Menumain.controller" class="transition">繼續購物</a> &emsp;
					&emsp; <a
						href="pay.Controller?orderId=${OrderMenuList.get(0).getOrderId()}"
						class="transition" id="clickOrder">確認訂購</a> <br> <br>
				</div>
			</div>



			<br>
			<c:set var="sum" value="0"></c:set>

			<div style="margin-left: 150px">
				<c:forEach var="cart" items="${OrderMenuList}">


					<div class="shoppingCart" id="shoppingCart">
						<div style="float: right; margin-top: 10px; margin-right: 5px">
							<a href='DeleteShoppingcart.controller?id=${cart.getId()}'><img
								src="images/cross.png" class="icon"></a>
						</div>
						<img id="image1" src="images/${cart.getMenu().getMenuName()}.png"
							class="img01"> <br> <font size="5">${cart.getMenu().getMenuName()}</font>
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