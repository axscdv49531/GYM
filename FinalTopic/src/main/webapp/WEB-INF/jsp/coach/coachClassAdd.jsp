<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet" href="../css/style.css">
<!-- Colors CSS -->
<link rel="stylesheet" href="../css/colors.css">
<!-- ALL VERSION CSS -->
<link rel="stylesheet" href="../css/versions.css">
<!-- Responsive CSS -->
<link rel="stylesheet" href="../css/responsive.css">
<!-- Custom CSS -->
<link rel="stylesheet" href="../css/custom.css">
<!-- font family -->
<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- end font family -->
<link rel="stylesheet" href="../css/3dslider.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css"
	rel="stylesheet" type="text/css">
<script src="../js/3dslider.js"></script>

<script>
	function print_value() {

		var startString = (document.getElementById("start").value).substring(2,0);
		var startInt = parseInt(startString)
		var durationString = document.getElementById("show").value;
		var durationInt = parseInt(durationString);
		var endInt = startInt + durationInt;
		var endString = endInt.toString() + ":00";
		document.getElementById("end").value = endString;
	}
</script>
</head>
<body>
	<!-- <section id="top"> -->
	<div style="width: 1205px; height: 194.13px" class="top">
		<c:import url="/top_coachlogin"></c:import>
	</div>
	<!--     </section> -->
	<!-- <fieldset> -->
	<!--  <legend>新增課程:</legend> -->
	<section id="contant" class="contant">
		<div class="container">
			<form:form method='Post' modelAttribute="classBean"
				enctype='multipart/form-data'>
				<legend>${LoginOK.coachName}新增課程</legend>
				<table>
					<tr>
						<td align='right'>課程名稱：</td>
						<td><form:input path="className" /><br>
						<form:errors path="className" />
					</tr>
					<tr>
						<td align='right'>開課日期：</td>
						<td><form:input type="date" path="classDate" /> <br> <form:errors
								path="classDate" />
					</tr>
					<tr>
						<td align='right'>開課時間：</td>
						<td><form:select id="start" onchange="print_value();"
								path="classStartTimeTemp">
								<form:options items="${selectData}" />

							</form:select> <br> <form:errors path="classStartTimeTemp" />
					</tr>
					<tr>
						<td align='right'>課程時長：</td>
						<td><form:input id="show" type="number" value="1" min="1"
								max="2" step="1" onchange="print_value();" path="classDuration" />小時<br>
							<form:errors path="classDuration" />
					</tr>
					<tr>
						<td align='right'>結束時間：</td>
						<td><form:input style="width:80px" id="end"
								path="classEndTimeTemp" readonly="true" /> <%-- 						<form:options items="${selectData}" /> --%>

							<br> <form:errors path="classEndTimeTemp" />
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
						<td><form:checkboxes items="${checkBoxList}"
								path="classLabel" /><br> <form:errors path="classLabel" />
					</tr>
					<tr>
						<td align='right'>課程照片：</td>
						<td><form:input path="claPhoto" type="file" /><br> <form:errors
								path="claPhoto" />
					</tr>
					<form:input type="hidden" value="0" path="classAvaliable" />
					<tr>
						<td colspan='2' align='center'><input type='submit'
							value='提交'></td>
					</tr>

				</table>
			</form:form>
		</div>
	</section>
	<!-- 	</fieldset> -->
</body>
</html>