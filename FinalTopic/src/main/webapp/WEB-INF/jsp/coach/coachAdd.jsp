<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增教練資料</title>
</head>
<body>
	<form:form method='Post' modelAttribute="coachBean"
		enctype='multipart/form-data'>
		<legend>教練資料</legend>
		<table>
			<tr>
				<td align='right'>姓名：</td>
				<td><form:input path="coachName" /><br> <form:errors
						path="coachName" />
			</tr>
			<tr>
				<td align='right'>帳號：</td>
				<td><form:input path="coachAccount" /><br> <form:errors
						path="coachAccount" />
			</tr>
			<tr>
				<td align='right'>密碼：</td>
				<td><form:input type="password" readonly="true"
						path="coachPassword" /><br> <form:errors path="coachPassword" />
			</tr>
			<tr>
				<td align='right'>性別：</td>
				<td><form:radiobuttons items="${radioData}" path="coachGender" /><br>
					<form:errors path="coachGender" />
			</tr>
			<tr>
				<td align='right'>信箱：</td>
				<td><form:input path="coachEmail" /><br> <form:errors
						path="coachEmail" />
			</tr>
			<tr>
				<td align='right'>經驗：</td>
				<td><form:input path="coachExp" /><br> <form:errors
						path="coachExp" />
			</tr>
			<tr>
				<td align='right'>地址：</td>
				<td><form:input path="coachAddress" /><br>
					<form:errors path="coachAddress" />
			</tr>
			<tr>
				<td align='right'>生日：</td>
				<td><form:input type="date" path="coachBirth" /><br>
					<form:errors path="coachBirth" />
			</tr>
			<tr>
				<td align='right'>大頭照：</td>
				<td><form:input path="cPhoto" type="file" /><br> <form:errors
						path="cPhoto" />
			</tr>
			<tr>
				<td colspan='2' align='center'><input type='submit' value='提交'></td>
			</tr>

		</table>
	</form:form>
</body>
</html>