<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>課程管理系統</title>

<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
    href="../admintemplate/img/apple-icon.png">
<link rel="icon" type="image/png"
    href="../admintemplate/img/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta
    content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
    name='viewport' />
<link
    href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
    rel="stylesheet" />
<link rel="stylesheet"
    href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<link href="../admintemplate/css/bootstrap.min.css" rel="stylesheet" />
<link href="../admintemplate/css/light-bootstrap-dashboard.css?v=2.0.0 "
    rel="stylesheet" />
<link href="../admintemplate/css/demo.css" rel="stylesheet" />
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="../js/3dslider.js"></script>

<script>
$(document).ready(function() {
	My_Date();

});

function autoKeyIn(){
    document.getElementById("classname").value = "瑜珈專題展示用";
    document.getElementById("coach").value = "神力女超人";
    document.getElementById("datee").value = "2022-01-05";
    document.getElementById("start").value = "13:00";
    document.getElementById("show").value = "2";
    document.getElementById("end").value = "15:00";
    document.getElementById("price").value = "1000";
    document.getElementById("description").value = "運用懸掛的布，透過地心引力增加身體的協調感與核心力量的穩定性，並改善身體的柔軟度。因許多動作都會纏着各個淋巴位置，能有效改善內分泌、淋巴、消化及血液循環系統。";
}

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
<div class="wrapper">
<%--        <c:import url="/adminsidebar"></c:import>  --%>
       <c:import url="/adminCoachsidebar"></c:import> 
        <div class="main-panel">
            <c:import url="/adminnavbar"></c:import> 
            <div class="content">
                <div class="container-fluid">
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
						<td><form:input id="classname" path="className" /><br>
						<form:errors path="className" />
					</tr>
					
					<tr>
                        <td align='right'>教練：</td>
                        <td><form:select id="coach" path="coach">
                                <form:options items="${coachList}" />

                            </form:select> <br> <form:errors path="coach" />
                    </tr>
					
					<tr>
						<td align='right'>開課日期：</td>
						<td><form:input id="datee" type="date" path="classDate" /> <br> <form:errors
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
						<td><form:input id="show" type="number" min="1"
								max="2" step="1" onchange="print_value();" path="classDuration" />小時<br>
							<form:errors path="classDuration" />
					</tr>
					<tr>
						<td align='right'>結束時間：</td>
						<td><form:input id="end"
								path="classEndTimeTemp" readonly="true" /> <%-- 						<form:options items="${selectData}" /> --%>

							<br> <form:errors path="classEndTimeTemp" />
					</tr>
					<tr>
						<td align='right'>課程價格：</td>
						<td><form:input id="price" path="classPrice" /><br> <form:errors
								path="classPrice" />
					</tr>
					<tr>
						<td align='right'>課程描述：</td>
						<td><form:textarea id="description" path="classDescription" /><br> <form:errors
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
						<td colspan='2' align='center'><input class="btn" type='submit' value='提交'></td>
					</tr>

				</table>
<!-- 				</fieldset> -->
<input type="button" id="auto" class="btn" value="一鍵輸入" onclick="autoKeyIn()"/>
			</form:form>
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</section> -->
	<!-- 	</fieldset> -->
	</div>
	</div>
	</div>
	</div>
</body>
</html>