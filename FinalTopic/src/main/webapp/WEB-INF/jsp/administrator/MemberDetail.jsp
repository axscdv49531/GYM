<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div align="center">
		<form:form method='POST' modelAttribute="memberBean">
			<input type="hidden" name="noname" id='putOrDelete' value="">
			<c:if test='${memberBean.number != null}'>
				<form:hidden path="password" />
				<form:hidden path="confirmedPassword" />
				<br>&nbsp;
			</c:if>
			<h3>會員資料</h3>
			<table border='1'>
				<tr>
					<th width='80'>會員編號</th>
					<th width='70'>身份證字號</th>
					<th width='60'>姓名</th>
					<th width='40'>性別</th>
					<th width='80'>生日</th>
					<th width='60'>電話</th>
					<th width='160'>Email</th>
					<th width='360'>地址</th>
					<th width='80'>入會時間</th>
					<th width='60'>緊急連絡人</th>
					<th width='60'>緊急連絡人電話</th>
				</tr>
				<tr>
					<td>${memberBean.number}</td>
					<td>${memberBean.id}</td>
					<td>${memberBean.name}</td>
					<td>${memberBean.gender}</td>
					<td>${memberBean.birthday}</td>
					<td>${memberBean.phone}</td>
					<td>${memberBean.email}</td>
					<td>${memberBean.county}
					${memberBean.district}				
					${memberBean.address}</td>
					<td>${memberBean.expirationdate}</td>
					<td>${memberBean.emergencyContact}</td>
					<td>${memberBean.emergencyPhone}</td>
				</tr>
			</table>
		</form:form>
		<br> <a href="<c:url value='/findAllMember' />">回前頁</a>
	</div>
</body>
</html>