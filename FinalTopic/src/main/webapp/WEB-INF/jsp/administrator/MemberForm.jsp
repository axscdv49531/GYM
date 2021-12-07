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
	<div class="wrapper">
		<c:import url="/adminsidebar"></c:import>
		<div class="main-panel">
			<c:import url="/adminnavbar"></c:import>
			<div class="content">
				<div class="container-fluid">
					<div align="center">
						<form:form method='POST' modelAttribute="memberBean"
							enctype='multipart/form-data'>
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
										<td align='right'><form:label path="gender">性別：</form:label><br>&nbsp;
										</td>
										<td><form:radiobutton path="gender" value="男" label="男" />
											<form:radiobutton path="gender" value="女" label="女" /><br>&nbsp;
											<form:errors path="gender" cssClass="error" /></td>
									</tr>

									<tr>
										<td align='right'>生日 <font size='-3' color='blue'>(yyyy-MM-dd)</font>：<br>&nbsp;
										</td>
										<td><form:input type="date" path="birthday" /><br>&nbsp;
											<form:errors path="birthday" cssClass="error" /></td>
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
										<td>
											<div id="twzipcode"></div> <script>
												$("#twzipcode").twzipcode();
											</script> <br>&nbsp; <form:input type="text" size="40" id="twzipcode"
												path="address" /><br>&nbsp; <form:errors
												path="address" cssClass="error" />
										</td>
									</tr>

									<tr>
										<td align='right'>入會時間: <font size='-3' color='blue'>(yyyy-MM-dd)</font>：<br>&nbsp;
										</td>
										<td><form:input type="date" path="expirationdate" /><br>&nbsp;
											<form:errors path="expirationdate" cssClass="error" /></td>
									</tr>

									<tr>
										<td align='right'>緊急聯絡人：<br>&nbsp;
										</td>
										<td><form:input path="emergencyContact" /><br>&nbsp;
											<form:errors path="emergencyContact" cssClass="error" /></td>
									</tr>

									<tr>
										<td align='right'>緊急聯絡人電話：<br>&nbsp;
										</td>
										<td><form:input path="emergencyPhone" /><br>&nbsp;
											<form:errors path="emergencyPhone" cssClass="error" /></td>
									</tr>
									<tr>
										<td align='right'>大頭照：</td>
										<td><form:input path="mPhoto" type="file" /><br> <form:errors
												path="mPhoto" />
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
				</div>
			</div>
		</div>
	</div>

</body>
</html>