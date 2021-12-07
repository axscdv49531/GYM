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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<body>
					<div align="center">
						<form:form method='POST' modelAttribute="admin"
							enctype='multipart/form-data'>
							<fieldset class="fieldset-auto-width">
								<legend>會員資料</legend>

								<table>

									<tr>
										<td align='right'>使用者帳號：<br>&nbsp;
										</td>
										<td><form:input path="email" /><br>&nbsp; </td>
									</tr>
									<tr>
										<td align='right'>密碼：<br>&nbsp;
										</td>
										<td><form:input type="password" path="password" /><br>&nbsp;</td>
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