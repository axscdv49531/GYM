<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Final Project</title>
</head>
<body>
	<h2 style="text-align: center">教練系統</h2>
	<hr />
	   <div style="text-align: center">
        <a href="<c:url value='/administrator/coachPage' />">教練管理系統</a><br> <br>
    </div>
	<div style="text-align: center">
		<a href="<c:url value='/coach/coachAdd' />">新增教練資料</a><br> <br>
	</div>
	   <div style="text-align: center">
        <a href="<c:url value='/coach/coachLogin' />">教練登入</a><br> <br>
    </div>
	   <div style="text-align: center">
        <a href="<c:url value='/member/memberLogin' />">會員登入</a><br> <br>
    </div>

</body>
</html>