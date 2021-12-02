<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>


	${payError}


	<c:forEach var="list" items="${MenuList}">
		<div style="margin-top: 30px">
			<div>訂單編號:${ list.getOrderId()}</div>
			<div>訂購餐點:${ list.getMenu().getMenuName()}</div>
			<div>訂購數量:${list.getQty()}</div>
			<div>餐點價格:${list.getPrice() }</div>
			<div>訂購時間:${list.getOrderTime() }</div>
		</div>
	</c:forEach>



	<div
		style="clear: both; margin-top: 50px; margin-left: 100px; height: 35px; width: 200px; border-width: 1px; border-color: black; border-style: solid; text-align: center; font-size: 30px">

		<a href="Menumain.controller">返回訂購首頁</a>
	</div>
</body>
</html>