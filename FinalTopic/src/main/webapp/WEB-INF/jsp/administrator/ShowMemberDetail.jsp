<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="apple-touch-icon" sizes="76x76"
	href="../admintemplate/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="../admintemplate/img/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>Light Bootstrap Dashboard - Free Bootstrap 4 Admin
	Dashboard by Creative Tim</title>
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
<link href="../admintemplate/css/style.css" rel="stylesheet" />

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
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
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
					<li><a class="nav-link" href="<c:url value='/adminindex' />">
							<i class="nc-icon nc-chart-pie-35"></i>
							<p>管理者首頁</p>
					</a></li>
					<li class="nav-item active dropdown nav-item"><a
						class="dropdown-toggle nav-link" data-toggle="dropdown"
						href="<c:url value= '/insertMember'/>"> <i
							class="nc-icon nc-circle-09"></i>
							<p>會員資料專區</p>
					</a>
						<ul class="dropdown-menu">
							<a class="dropdown-item" href="<c:url value= '/insertMember'/>">新增會員</a>
							<a class="dropdown-item" href="<c:url value= '/findAllMember'/>">查詢會員名單</a>
							<a class="dropdown-item" href="#">會員儲值</a>
							<a class="dropdown-item" href="#">會員會費查詢</a>
						</ul></li>
					<li><a class="nav-link" href="<c:url value='' />"> <i
							class="nc-icon nc-notes"></i>
							<p>教練專區</p>
					</a></li>
					<li><a class="nav-link" href="<c:url value='' />"> <i
							class="nc-icon nc-paper-2"></i>
							<p>團體課程專區</p>
					</a></li>
					<li><a class="nav-link" href="./icons.html"> <i
							class="nc-icon nc-atom"></i>
							<p>訂餐系統專區</p>
					</a></li>
					<li><a class="nav-link" href="./maps.html"> <i
							class="nc-icon nc-pin-3"></i>
							<p>周邊商品專區</p>
					</a></li>
					<li><a class="nav-link" href="./notifications.html"> <i
							class="nc-icon nc-bell-55"></i>
							<p>Notifications</p>
					</a></li>
					<li class="nav-item active active-pro"><a
						class="nav-link active" href="/"> <i
							class="nc-icon nc-alien-33"></i>
							<p>Back to Spring Fitness</p>
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
							<li class="nav-item"><a class="nav-link" href="#pablo">
									<span class="no-icon">Log out</span>
							</a></li>
						</ul>
					</div>
				</div>
			</nav>
			<!-- End Navbar -->
			<div align="center">
				<form:form method='POST' modelAttribute="memberBean">
					<input type="hidden" name="noname" id='putOrDelete' value="">
					<c:if test='${memberBean.number != null}'>
						<form:hidden path="password" />
						<form:hidden path="confirmedPassword" />
						<br>&nbsp;
			</c:if>
					<h3>會員資料</h3>
					<table border='1'>
						<tr>
							<th width='80'>會員編號</th>
							<th width='60'>姓名</th>
							<th width='40'>性別</th>
							<th width='100'>生日</th>
							<th width='60'>電話</th>
							<th width='160'>Email</th>
							<th width='360'>地址</th>
							<th width='100'>入會時間</th>
							<th width='90'>緊急連絡人</th>
							<th width='120'>緊急連絡人電話</th>
						</tr>
						<tr>
							<td>${memberBean.number}</td>
							<td>${memberBean.name}</td>
							<td>${memberBean.gender}</td>
							<td>${memberBean.birthday}</td>
							<td>${memberBean.phone}</td>
							<td>${memberBean.email}</td>
							<td>${memberBean.county}${memberBean.district}
								${memberBean.address}</td>
							<td>${memberBean.expirationdate}</td>
							<td>${memberBean.emergencyContact}</td>
							<td>${memberBean.emergencyPhone}</td>
						</tr>
					</table>
				</form:form>
				<br> <a href="<c:url value='/findAllMember' />">回前頁</a>
			</div>
</body>
</html>