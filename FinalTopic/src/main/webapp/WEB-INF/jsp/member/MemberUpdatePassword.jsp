<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>編輯會員資料</title>
</head>

</head>
<body>
	<div align="center">
		<form:form method='POST' modelAttribute="memberBean">
			<input type="hidden" name="noname" id='putOrDelete' value="">
			<c:if test='${memberBean.number != null}'>
				<form:hidden path="number" />
				<br>&nbsp;
			</c:if>
			<fieldset class="fieldset-auto-width">
				<legend>會員資料</legend>
				<table>
					<tr>
						<td align='right'>原密碼：<br>&nbsp;
						<td><form:input path="password" /><br>&nbsp; <form:errors
								path="password" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>新密碼：<br>&nbsp;
						<td><form:input path="password" /><br>&nbsp; <form:errors
								path="password" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>新密碼確認：<br>&nbsp;
						</td>
						<td><form:input path="confirmedPassword" /><br>&nbsp; <form:errors
								path="confirmedPassword" cssClass="error" /></td>
					</tr>
					<tr>
						<td colspan='2' align='center'><input type='submit'
							value='確認變更' name='updateBtn'
							onclick="window.alert('密碼變更成功');">&nbsp;
						</td>
					</tr>
				</table>
			</fieldset>
		</form:form>
		<a href="<c:url value='/selectMember' />">回前頁</a>
	</div>

</body>
</html>