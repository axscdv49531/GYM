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
	<div align='center'>
		<h3>教練資料</h3>
		<hr>
		<table border='1'>
			<tr>
<!-- 				<th width='60'>編輯</th> -->
				<th width='160'>教練大頭照</th>
				<th width='160'>教練姓名</th>
			</tr>
			<c:forEach var='coach' items='${coachBeanList}'>
				<tr>
					<td><img width='50' height='50' src="<c:url value='/administrator/getCoachPicture?coachAccount=' />${coach.coachAccount}" /></td>
					<td> <a href='updateCoach/${coach.coachAccount}'>${coach.coachName}</a></td>
				</tr>
			</c:forEach>
		</table>

	</div>
</body>
</html>