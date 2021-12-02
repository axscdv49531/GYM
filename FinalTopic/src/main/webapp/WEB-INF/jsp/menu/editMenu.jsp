<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Online order</title>
<link rel=stylesheet href="editFrom.css">
<link rel=stylesheet href="style.css">
<link rel=stylesheet href="showhidemenu.css">
<link rel=stylesheet href="showMenu.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
</head>
<body>



	<form:form action="ModifyShoppingcart.controller" method='POST'
		modelAttribute="updateOrderMenu">

		<!--顯示資訊及訂餐-->
		<div class="editFrom">
			<div class="title">修改訂單</div>
			<br> <font class="menuName">產品名稱:</font>
			<form:input path="menu.menuName" class="menuName" size="10"
				id="menuName" />

			<br> <font class="price">價格:</font>
			<form:input path="price" class="price" size="3" id="price" />
			<br> <font class="qty1">數量:</font> <img
				src="images/MinusSign.svg" class="minusIcon" />
			<form:input path="qty" class="qty1" size="3" id="menuqty" />
			<img src="images/plus.svg" class="plusIcon" /> <br>
			<div style="display: none">
				<form:input path="id" />
			</div>
			<br> <input type="submit" value="更改此訂單" class="detailDiv01Font1" />
		</div>

	</form:form>

	<script>
		document.getElementById("price").readOnly = true;
		document.getElementById("menuName").readOnly = true;

		$(".minusIcon").click(function() {
			var qty = $("#menuqty").val();
			qty = Number(qty);
			qty = qty - 1;
			if (qty <= 1) {
				qty = 1;
			}
			$("#menuqty").val(qty);

		});
		$(".plusIcon").click(function() {
			var qty = $("#menuqty").val();
			qty = Number(qty);
			qty = qty + 1;
			$("#menuqty").val(qty);

		});
	</script>






</body>
</html>