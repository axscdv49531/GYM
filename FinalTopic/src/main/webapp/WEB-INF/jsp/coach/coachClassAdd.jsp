<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script>
	function print_value() {
		var startString = document.getElementById("start").value + ":00";
		var startTime = new Date("1970-01-01 " + startString);
		var endString = document.getElementById("end").value + ":00";
		var endTime = new Date("1970-01-01 " + endString);
		var duration = (endTime - startTime) / (1000 * 60 * 60);
		document.getElementById("show").value = duration;
	}
</script>
<body>
	<form:form method='Post' modelAttribute="classBean"
		enctype='multipart/form-data'>
		<legend>${LoginOK.coachName}新增課程</legend>
		<table>
			<tr>
				<td align='right'>課程名稱：</td>
				<td><form:input path="className" /><br> <form:errors
						path="className" />
			</tr>
			<tr>
				<td align='right'>開課日期：</td>
				<td><form:input type="date" path="classDate" /> <br> <form:errors
						path="classDate" />
			</tr>
			<tr>
				<td align='right'>開課時間：</td>
				<td><form:select id="start" path="classStartTimeTemp">
						<form:options items="${selectData}" />

					</form:select> <br> <form:errors path="classStartTimeTemp" />
			</tr>
			<tr>
				<td align='right'>結束時間：</td>
				<td><form:select id="end" onchange="print_value();"
						path="classEndTimeTemp">
						<form:options items="${selectData}" />

					</form:select> <br> <form:errors path="classEndTimeTemp" />
			</tr>
			<tr>
				<td align='right'>課程時長：</td>
				<td><form:input id="show" path="classDuration" readonly="true" />小時<br>
					<form:errors path="classDuration" />
			</tr>
			<tr>
				<td align='right'>課程價格：</td>
				<td><form:input path="classPrice" /><br> <form:errors
						path="classPrice" />
			</tr>
			<tr>
				<td align='right'>課程描述：</td>
				<td><form:textarea path="classDescription" /><br> <form:errors
						path="classDescription" />
			</tr>
			<tr>
				<td align='right'>課程標籤：</td>
				<td><form:checkboxes items="${checkBoxList}" path="classLabel" /><br>
					<form:errors path="classLabel" />
			</tr>
			<tr>
                <td align='right'>課程照片：</td>
                <td><form:input path="claPhoto" type="file" /><br> <form:errors
                        path="claPhoto" />
            </tr>
			<form:input type="hidden" value="0" path="classAvaliable" />
			<tr>
				<td colspan='2' align='center'><input type='submit' value='提交'></td>
			</tr>

		</table>
	</form:form>
</body>
</html>