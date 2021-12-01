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
<h2 style="text-align: center">教練系統</h2>
    <hr />
       <div style="text-align: center">
        <a href="<c:url value='/administrator/coachList' />">教練資料修改</a><br> <br>
    </div>
    <div style="text-align: center">
        <a href="<c:url value='/administrator/allCoachClasses' />">一對一課程清單 </a><br> <br>
    </div>
</body>
</html>