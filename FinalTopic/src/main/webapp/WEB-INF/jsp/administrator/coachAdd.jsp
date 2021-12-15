<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<script>
function autoKeyIn(){
	document.getElementById("name").value = "葉問";
	document.getElementById("account").value = "Ipman";
	document.getElementById("boy").checked = true;
	document.getElementById("email").value = "ipman@gmail.com";
	document.getElementById("phone").value = "0912273856";
	document.getElementById("exp").value = "13";
	document.getElementById("address").value = "彰化縣和美鎮和旺街18號";
	document.getElementById("birth").value = "1984-11-06";
	
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
	<form:form method='Post' modelAttribute="coachBean"
		enctype='multipart/form-data'>
		<legend>教練資料</legend>
		<table style="border-collapse:separate; border-spacing:0px 10px;">
			<tr>
				<td align='right'>姓名：</td>
				<td><form:input id="name" path="coachName" /><br> <form:errors
						path="coachName" />
			</tr>
			<tr>
				<td align='right'>帳號：</td>
				<td><form:input id="account" path="coachAccount" /><br> <form:errors
						path="coachAccount" />
			</tr>
			<tr>
				<td align='right'>密碼：</td>
				<td><form:input type="password" readonly="true"
						path="coachPassword" /><br> <form:errors path="coachPassword" />
			</tr>
<!-- 			<tr> -->
<!-- 				<td align='right'>性別：</td> -->
<%-- 				<td><form:radiobuttons items="${radioData}" path="coachGender" /><br> --%>
<%-- 					<form:errors path="coachGender" /> --%>
<!-- 			</tr> -->
<tr>
         <td><form:label path="coachGender">性別：</form:label></td>
         <td>
            <form:radiobutton path="coachGender" id="boy" value="男" label="男" />
            <form:radiobutton path="coachGender" id="girl" value="女" label="女" />
         </td>
      </tr> 
			<tr>
				<td align='right'>信箱：</td>
				<td><form:input id="email" path="coachEmail" /><br> <form:errors
						path="coachEmail" />
			</tr>
			<tr>
				<td align='right'>手機：</td>
				<td><form:input id="phone" path="coachPhone" /><br> <form:errors
						path="coachPhone" />
			</tr>
			<tr>
				<td align='right'>經驗：</td>
				<td><form:input id="exp" path="coachExp" /><br> <form:errors
						path="coachExp" />
			</tr>
			<tr>
				<td align='right'>地址：</td>
				<td><form:input id="address" path="coachAddress" /><br>
					<form:errors path="coachAddress" />
			</tr>
			<tr>
				<td align='right'>生日：</td>
				<td><form:input id="birth" type="date" path="coachBirth" /><br>
					<form:errors path="coachBirth" />
			</tr>
			<tr>
				<td align='right'>大頭照：</td>
				<td><form:input path="cPhoto" type="file" /><br> <form:errors
						path="cPhoto" />
			</tr>
			<tr>
				<td colspan='2' align='center'><input class="btn" type='submit' value='提交'></td>
			</tr>

		</table>
		<input type="button" id="auto" class="btn" value="一鍵輸入" onclick="autoKeyIn()"/>
	</form:form>
	
	           </div>

        </div>
        </div>

    </div>
</body>
</html>