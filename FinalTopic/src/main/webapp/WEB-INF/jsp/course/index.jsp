<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>首頁</title>
</head>
<body>
<h3>Hi, This is Course Sytem !</h3>

  
<header>
<a href="<c:url value='/courseQuery' />">查詢課程</a>
<a href="<c:url value='/courseform' />">新增課程</a>
<a href="<c:url value='/courseSelectSystem' />">會員課程系統</a>
<a href="<c:url value='/' />">回首頁</a>
</header>

</body>
</html>