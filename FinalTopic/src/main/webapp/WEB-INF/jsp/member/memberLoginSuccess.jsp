<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="text-align: center">
		<c:out value="${loginUser.memberName },歡迎您" />
		<a href="<c:url value='/classReservation' />">課程預約</a><br>
		<br>
	</div>
	<div style="text-align: center">
		<a href="<c:url value='/member/viewReservationClass' />">查看已預約課程
		</a><br> <br>
	</div>
</body>
</html>