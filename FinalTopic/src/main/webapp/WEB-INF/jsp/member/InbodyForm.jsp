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
		<form:form method='POST' modelAttribute="inbodyBean">
		
			<fieldset class="fieldset-auto-width">
				<legend>會員身體組成分析(Inbody)</legend>
				<table>

					<tr>
						<td align='right'>檢測日期：<br>&nbsp;
						</td>
						<td><form:input type="date" path="measurementDate" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>身高：<br>&nbsp;
						</td>
						<td><form:input path="height" /><br>&nbsp;</td>
					</tr>

					<tr>
						<td align='right'>體重：<br>&nbsp;
						</td>
						<td><form:input path="weight" /><br>&nbsp;</td>
					</tr>

					<tr>
						<td align='right'>骨骼肌重：<br>&nbsp;
						</td>
						<td><form:input path="smm" /><br>&nbsp;</td>
					</tr>

					<tr>
						<td align='right'>體脂肪重：<br>&nbsp;
						</td>
						<td><form:input path="bodyFatMass" /><br>&nbsp;</td>
					</tr>

					<tr>
						<td align='right'>BMI:<br>&nbsp;
						</td>
						<td><form:input path="bmi" /><br>&nbsp;</td>
					</tr>

					<tr>
						<td align='right'>體脂肪率：<br>&nbsp;
						</td>
						<td><form:input path="pbf" /><br>&nbsp;</td>
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