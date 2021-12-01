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
<script type="text/javascript">
	function confirmUpdate(id) {
		var result = confirm("確定送出此筆記錄(會員編號:" + id.trim() + ")?");
		if (result) {
			return true;
		}
		return false;
	}
</script>

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
						<td align='right'>身分證字號：<br>&nbsp;
						</td>
						<td><form:input path="id" /><br>&nbsp; <form:errors
								path="id" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>姓名：<br>&nbsp;
						</td>
						<td><form:input path="name" /><br>&nbsp; <form:errors
								path="name" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>性別：<br>&nbsp;
						</td>
						<td><form:input path="gender" /><br>&nbsp; <form:errors
								path="gender" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>生日: <font size='-3' color='blue'>(yyyy-MM-dd)</font>：<br>&nbsp;
						</td>
						<td><form:input path="birthday" /><br>&nbsp; <form:errors
								path="birthday" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>手機：<br>&nbsp;
						</td>
						<td><form:input path="phone" /><br>&nbsp; <form:errors
								path="phone" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>Email：<br>&nbsp;
						</td>
						<td><form:input path="email" /><br>&nbsp; <form:errors
								path="email" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>地址：<br>&nbsp;
						</td>
						<td><form:input path="address" /><br>&nbsp; <form:errors
								path="address" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>入會時間: <font size='-3' color='blue'>(yyyy-MM-dd)</font>：<br>&nbsp;
						</td>
						<td><form:input path="expirationdate" /><br>&nbsp; <form:errors
								path="expirationdate" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>緊急聯絡人：<br>&nbsp;
						</td>
						<td><form:input path="emergencyContact" /><br>&nbsp; <form:errors
								path="emergencyContact" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>緊急聯絡人電話：<br>&nbsp;
						</td>
						<td><form:input path="emergencyPhone" /><br>&nbsp; <form:errors
								path="emergencyPhone" cssClass="error" /></td>
					</tr>
					<tr>
						<td colspan='2' align='center'><input type='submit'
							value='修改' name='updateBtn'
							onclick="return confirmUpdate('${memberBean.number}');">&nbsp;
						</td>
					</tr>

				</table>
			</fieldset>
		</form:form>
		<a href="<c:url value='/selectMember' />">回前頁</a>
	</div>

</body>
</html>