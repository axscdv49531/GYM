<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="apple-touch-icon" sizes="76x76"
	href="../admintemplate/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="../admintemplate/img/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Insert title here</title>
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<!--     Fonts and icons     -->
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<!-- CSS Files -->
<link href="../admintemplate/css/bootstrap.min.css" rel="stylesheet" />
<link href="../admintemplate/css/light-bootstrap-dashboard.css?v=2.0.0 "
	rel="stylesheet" />

<!--   Core JS Files   -->
<script src="../admintemplate/js/core/jquery.3.2.1.min.js"
	type="text/javascript"></script>
<script src="../admintemplate/js/core/popper.min.js"
	type="text/javascript"></script>
<script src="../admintemplate/js/core/bootstrap.min.js"
	type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="../admintemplate/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="../admintemplate/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="../admintemplate/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="../admintemplate/js/light-bootstrap-dashboard.js?v=2.0.0 "
	type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="../admintemplate/js/demo.js"></script>


</head>
<script type="text/javascript">
	function confirmUpdate(number) {
		var result = confirm("確定更新會員編號:" + number.trim() + "?");
		if (result) {
			return true;
		}
		return false;
	}
</script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<script src="https://code.essoduke.org/js/twzipcode/twzipcode.js"></script>
<script src="https://kit.fontawesome.com/e60209ac9e.js"></script>
<body>
	<div class="wrapper">
		<div class="sidebar" data-image="../admintemplate/img/sidebar-0.jpg"
			data-color="red">
			<!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"

        Tip 2: you can also add an image using data-image tag
    -->
			<div class="sidebar-wrapper">
				<div class="logo">
					<a href="#" class="simple-text"> ADMIN </a>
				</div>
				<ul class="nav">
					<li><a class="nav-link"
						href="<c:url value= '/findAllMember'/>"> <i
							class="nc-icon nc-circle-09"></i>
							<p>查詢會員</p>
					</a></li>
					<li><a class="nav-link" href="<c:url value= '/insertMember'/>">
							<i class="nc-icon nc-circle-09"></i>
							<p>新增會員</p>
					</a></li>
					<li class="nav-item active"><a class="nav-link"
						href="<c:url value= '/findInbodyMember'/>"> <i
							class="nc-icon nc-notes"></i>
							<p>會員Inbody分析</p>
					</a></li>
					<li><a class="nav-link"
						href="<c:url value= '/findDepositeMember'/>"> <i
							class="nc-icon nc-money-coins"></i>
							<p>會員儲值紀錄</p>
					</a></li>
					<li><a class="nav-link" href="<c:url value='/adminindex' />">
							<i class="nc-icon nc-chart-pie-35"></i>
							<p>返回管理者首頁</p>
					</a></li>
				</ul>
			</div>
		</div>
		<div class="main-panel">
			<!-- Navbar -->
			<nav class="navbar navbar-expand-lg " color-on-scroll="500">
				<div class="container-fluid">
					<a class="navbar-brand" href="#pablo"> Spring Fitness </a>
					<button href="" class="navbar-toggler navbar-toggler-right"
						type="button" data-toggle="collapse"
						aria-controls="navigation-index" aria-expanded="false"
						aria-label="Toggle navigation">
						<span class="navbar-toggler-bar burger-lines"></span> <span
							class="navbar-toggler-bar burger-lines"></span> <span
							class="navbar-toggler-bar burger-lines"></span>
					</button>
					<div class="collapse navbar-collapse justify-content-end"
						id="navigation">
						<ul class="nav navbar-nav mr-auto">
							<li class="nav-item"><a href="#" class="nav-link"
								data-toggle="dropdown"> <i class="nc-icon nc-palette"></i> <span
									class="d-lg-none">Dashboard</span>
							</a></li>
							<li class="dropdown nav-item"><a href="#"
								class="dropdown-toggle nav-link" data-toggle="dropdown"> <i
									class="nc-icon nc-planet"></i> <span class="notification">5</span>
									<span class="d-lg-none">Notification</span>
							</a>
								<ul class="dropdown-menu">
									<a class="dropdown-item" href="#">Notification 1</a>
									<a class="dropdown-item" href="#">Notification 2</a>
									<a class="dropdown-item" href="#">Notification 3</a>
									<a class="dropdown-item" href="#">Notification 4</a>
									<a class="dropdown-item" href="#">Another notification</a>
								</ul></li>
							<li class="nav-item"><a href="#" class="nav-link"> <i
									class="nc-icon nc-zoom-split"></i> <span class="d-lg-block">&nbsp;Search</span>
							</a></li>
						</ul>
						<ul class="navbar-nav ml-auto">
							<li class="nav-item"><a class="nav-link" href="#pablo">
									<span class="no-icon">Account</span>
							</a></li>
							<li class="nav-item dropdown"><a
								class="nav-link dropdown-toggle" href="http://example.com"
								id="navbarDropdownMenuLink" data-toggle="dropdown"
								aria-haspopup="true" aria-expanded="false"> <span
									class="no-icon">Dropdown</span>
							</a>
								<div class="dropdown-menu"
									aria-labelledby="navbarDropdownMenuLink">
									<a class="dropdown-item" href="#">Action</a> <a
										class="dropdown-item" href="#">Another action</a> <a
										class="dropdown-item" href="#">Something</a> <a
										class="dropdown-item" href="#">Something else here</a>
									<div class="divider"></div>
									<a class="dropdown-item" href="#">Separated link</a>
								</div></li>
							<li class="nav-item"><a class="nav-link"
								href="<c:url value='/logout' />"> <span class="no-icon">Log
										out</span>
							</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<!-- End Navbar -->
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
									<td><form:input type="date" path="measurementDate"
											id="date" /><br>&nbsp;</td>
								</tr>
								<tr>
									<td align='right'>身高：<br>&nbsp;
									</td>
									<td><form:input path="height" id="height" /><br>&nbsp;</td>
								</tr>

								<tr>
									<td align='right'>體重：<br>&nbsp;
									</td>
									<td><form:input path="weight" id="weight" /><br>&nbsp;</td>
								</tr>

								<tr>
									<td align='right'>骨骼肌重：<br>&nbsp;
									</td>
									<td><form:input path="smm" id="smm" /><br>&nbsp;</td>
								</tr>

								<tr>
									<td align='right'>體脂肪重：<br>&nbsp;
									</td>
									<td><form:input path="bodyFatMass" id="bodyFatMass" /><br>&nbsp;</td>
								</tr>

								<tr>
									<td align='right'>BMI:<br>&nbsp;
									</td>
									<td><form:input path="bmi" id="bmi" /><br>&nbsp;</td>
								</tr>

								<tr>
									<td align='right'>體脂肪率：<br>&nbsp;
									</td>
									<td><form:input path="pbf" id="pbf" /><br>&nbsp;</td>
								</tr>
								<tr>
									<td colspan='2' align='center'><input type="button"
										value="一鍵輸入" class="btn btn-info btn-fill pull-right" style="margin:30px;"
										onclick="auto()"> <input type='submit' value='提交'
										class="btn btn-info btn-fill pull-right"  style="margin:30px;"></td>

								</tr>
							</table>
						</fieldset>
					</form:form>
					<br> <a href="<c:url value= '/findInbodyMember'/>">回前頁</a>
				</div>
				<script>
					function auto() {
						document.getElementById("date").value = "2021-12-15";
						document.getElementById("height").value = "172";
						document.getElementById("weight").value = "70.4";
						document.getElementById("smm").value = "32.8";
						document.getElementById("bodyFatMass").value = "11.7";
						document.getElementById("bmi").value = "23.7";
						document.getElementById("pbf").value = "18.4";
					}
				</script>
			</body>
</html>