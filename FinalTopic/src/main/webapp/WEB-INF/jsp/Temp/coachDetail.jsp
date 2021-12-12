<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
    


<!-- <script src="../admintemplate/js/core/jquery.3.2.1.min.js" type="text/javascript"></script> -->
<!-- <script src="../admintemplate/js/core/popper.min.js" type="text/javascript"></script> -->
<!-- <script src="../admintemplate/js/core/bootstrap.min.js" type="text/javascript"></script> -->
<!-- <script src="../admintemplate/js/plugins/bootstrap-switch.js"></script> -->
<!-- <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script> -->
<!-- <script src="../admintemplate/js/plugins/chartist.min.js"></script> -->
<!-- <script src="../admintemplate/js/plugins/bootstrap-notify.js"></script> -->
<!-- <script src="../admintemplate/js/light-bootstrap-dashboard.js?v=2.0.0 " type="text/javascript"></script> -->
<!-- <script src="../admintemplate/js/demo.js"></script> -->


</head>
<body>







<div class="wrapper">
<%--        <c:import url="/adminsidebar"></c:import>  --%>
       <c:import url="/adminCoursesidebar"></c:import> 
        <div class="main-panel">
            <c:import url="/adminnavbar"></c:import> 
            <div class="content">
                <div class="container-fluid">
	<form:form method='Post' modelAttribute="coachBean"
		enctype='multipart/form-data'>
		<legend>教練資料</legend>
		<form:input type="hidden" path="coachId" />
		<br>
		<form:errors path="coachId" />
		<table>
			<tr>
				<td align='right'>姓名：</td>
				<td><form:input path="coachName" /><br> <form:errors
						path="coachName" />
			</tr>
			<tr>
				<td align='right'>帳號：</td>
				<td><form:input path="coachAccount" /><br> <form:errors
						path="coachAccount" />
			</tr>
			<tr>
				<td align='right'>密碼：</td>
				<td><form:input type="password" path="coachPassword" /><br> <form:errors
						path="coachPassword" />
			</tr>
			<tr>
				<td align='right'>性別：</td>
				<td><form:radiobuttons items="${radioData}" path="coachGender" /><br>
					<form:errors path="coachGender" />
			</tr>
			<tr>
				<td align='right'>信箱：</td>
				<td><form:input path="coachEmail" /><br> <form:errors
						path="coachEmail" />
			</tr>
			<tr>
				<td align='right'>手機：</td>
				<td><form:input path="coachPhone" /><br> <form:errors
						path="coachPhone" />
			</tr>
			<tr>
				<td align='right'>經驗：</td>
				<td><form:input path="coachExp" /><br> <form:errors
						path="coachExp" />
			</tr>
			<tr>
				<td align='right'>地址：</td>
				<td><form:input path="coachAddress" /><br> <form:errors
						path="coachAddress" />
			</tr>
			<tr>
				<td align='right'>生日：</td>
				<td><form:input type="date" path="coachBirth" /><br>
					<form:errors path="coachBirth" />
			</tr>
			<tr>
				<td align='right'>大頭照：</td>
				<td><form:input path="cPhoto" type="file" /><br> <form:errors
						path="cPhoto" />
			</tr>
			<tr>
				<td colspan='2' align='center'><input type='submit' name='edit'
					value='提交變更'><input type='submit' name='delete' value='刪除此筆'></td>
			</tr>

		</table>
	</form:form>
	</div>
	</div></div>
	</div>
</body>
</html>