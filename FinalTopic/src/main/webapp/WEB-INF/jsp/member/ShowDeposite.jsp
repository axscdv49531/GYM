<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align='center'>
		<form:form method='POST' modelAttribute="DepositeBean">
			<h3>儲值紀錄</h3>
			<hr>
			<table border='1'>
				<tr>	
					<th width='200'>儲值日期</th>
					<th width='160'>儲值金額</th>				
					<th width='160'>餘額</th>				
				</tr>
				<c:choose>
					<c:when test="${not empty depositeBeanList}">
						<c:forEach var='deposite' items="${depositeBeanList}">
							<tr>
								<td>${deposite.timestamp}</td>
								<td>${deposite.value}</td>
								<td>${deposite.total}</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
				無付款記錄
			</c:otherwise>
				</c:choose>
			</table>
		</form:form>
		<br> <a href="<c:url value='/findAllMember' />">回前頁</a>
	</div>
</body>
</html>