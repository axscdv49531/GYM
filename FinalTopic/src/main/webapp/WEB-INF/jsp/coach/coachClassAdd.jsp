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
$(document).ready(function() {
    My_Date();

});

function My_Date() { 
    var date = new Date();
    var datee = date.getFullYear() +  date.getMonth() + ( date.getDate() + 1);
    var year = date.getFullYear().toString();
    var month = (date.getMonth() +1 ).toString();
    var day = (date.getDate() +1 ).toString();
    var dateee = year + "-" + month + "-" + day;
    console.log(dateee)
    document.getElementById("datee").min = dateee;
} 
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
	<section id="top">
	<div class="top">
		<c:import url="/top_coachlogin"></c:import>
	</div>
	    </section>
	<!-- <fieldset> -->
	<!--  <legend>新增課程:</legend> -->
<!-- 	<section id="contant" class="contant"> -->
<!-- 		<div class="container"> -->
<!-- 		<div class="contact-us"> -->
			<form:form method='Post' modelAttribute="classBean"
				enctype='multipart/form-data'>
<!-- 				 <fieldset> -->
				<legend>新增課程</legend>
				<table style="border-collapse:separate; border-spacing:0px 10px;">
					<tr>
						<td align='right'>課程名稱：</td>
						<td><form:input style="background-color:rgb(33, 37, 41);width:100%;border:2px white solid;color:white" path="className" /><br>
						<form:errors path="className" />
					</tr>
					<tr>
						<td align='right'>開課日期：</td>
						<td><form:input id="datee" style="background-color:rgb(33, 37, 41);width:100%;border:2px white solid;color:white" type="date" path="classDate" /> <br> <form:errors
								path="classDate" />
					</tr>
					<tr>
						<td align='right'>開課時間：</td>
						<td><form:select style="background-color:rgb(33, 37, 41);width:100%;border:2px white solid;color:white" id="start" onchange="print_value();"
								path="classStartTimeTemp">
								<form:options items="${selectData}" />

							</form:select> <br> <form:errors path="classStartTimeTemp" />
					</tr>
					<tr>
						<td align='right'>課程時長：</td>
						<td><form:input style="background-color:rgb(33, 37, 41);width:100%;border:2px white solid;color:white" id="show" type="number" min="1"
								max="2" step="1" onchange="print_value();" path="classDuration" />小時<br>
							<form:errors path="classDuration" />
					</tr>
					<tr>
						<td align='right'>結束時間：</td>
						<td><form:input style="background-color:rgb(33, 37, 41);width:100%;border:2px white solid;color:white" id="end"
								path="classEndTimeTemp" readonly="true" /> <%-- 						<form:options items="${selectData}" /> --%>

							<br> <form:errors path="classEndTimeTemp" />
					</tr>
					<tr>
						<td align='right'>課程價格：</td>
						<td><form:input style="background-color:rgb(33, 37, 41);width:100%;border:2px white solid;color:white" path="classPrice" /><br> <form:errors
								path="classPrice" />
					</tr>
					<tr>
						<td align='right'>課程描述：</td>
						<td><form:textarea style="background-color:rgb(33, 37, 41);width:100%;border:2px white solid;color:white" path="classDescription" /><br> <form:errors
								path="classDescription" />
					</tr>
					<tr>
						<td align='right'>課程標籤：</td>
						<td><form:checkboxes items="${checkBoxList}"
								path="classLabel" /><br> <form:errors path="classLabel" />
					</tr>
					<tr>
						<td align='right'>課程照片：</td>
						<td><form:input style="background-color:rgb(33, 37, 41);width:100%;border:2px white solid;color:white" path="claPhoto" type="file" /><br> <form:errors
								path="claPhoto" />
					</tr>
					<form:input type="hidden" value="0" path="classAvaliable" />
					<tr>
						<td colspan='2' align='center'><input type='submit' value='提交'></td>
					</tr>

				</table>
<!-- 				</fieldset> -->
			</form:form>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</section> -->
	<!-- 	</fieldset> -->
</body>
</html>