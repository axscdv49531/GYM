<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form:form method='Post' modelAttribute="loginBean">
		<legend>教練登入</legend>
		<table>
			<tr>
				<td align='right'>帳號：</td>
				<td><form:input path="userAccount" /><br> <form:errors
						path="userAccount" />
			</tr>
			<tr>
				<td align='right'>密碼：</td>
				<td><form:input path="userPassword" /><br> <form:errors
						path="userPassword" />
			</tr>
			<tr>
				<td colspan='2' align='center'><input type='submit' name='edit'
					value='登入'></td>
			</tr>
		</table>
	</form:form>
</body>
</html>