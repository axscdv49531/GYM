<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<c:out value="${loginUser.coachName}, 歡迎您" />
	<div style="text-align: center">
		<a href="<c:url value='/coach/coachClassAdd' />">新增課程</a><br> <br>
	</div>
	<div style="text-align: center">
		<a href="<c:url value='/coach/coachClassList' />">課程清單</a><br> <br>
	</div>
</body>
</html>