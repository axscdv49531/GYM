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
	<div align="center">
		<form:form method='POST' modelAttribute="paymentBean">
		
			<fieldset class="fieldset-auto-width">
				<legend>會員繳費紀錄</legend>
				<table>

					<tr>
						<td align='right'>繳費日期：<br>&nbsp;
						</td>
						<td><form:input type="date" path="paymentDate" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>金額：<br>&nbsp;
						</td>
						<td><form:input path="paymentAmount" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td colspan='2' align='center'><input type='submit'
							value='提交'></td>
					</tr>
				</table>
			</fieldset>
		</form:form>
		<br> <a href="<c:url value='/' />">回首頁</a>
	</div>
</body>
</html>