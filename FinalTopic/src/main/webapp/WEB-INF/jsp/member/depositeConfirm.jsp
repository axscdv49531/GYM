<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
${depositeBean.id}
	<form:form method='POST' modelAttribute="depositeBean">
		<h3>確認儲值</h3>
		<hr>
		<table border='1'>
			<tr>
				<th width='200'>儲值日期</th>
				<th width='160'>儲值金額</th>
			</tr>
			<tr>
				<td>${depositeBean.timestamp}</td>
				<td>${depositeBean.value}</td>
			</tr>
			
			<tr>
			
				<td><a href="<c:url value='/depositeControl/${depositeBean.id}'/>"
					class="transition" id="clickOrder">確認訂購</a></td>
			</tr>
		</table>
	</form:form>
</body>
</html>