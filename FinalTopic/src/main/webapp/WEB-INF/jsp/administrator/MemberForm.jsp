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
					<li><a class="nav-link"
						href="<c:url value= '/findAllMember'/>"> <i
							class="nc-icon nc-circle-09"></i>
							<p>????????????</p>
					</a></li>
					<li class="nav-item active"><a class="nav-link"
						href="<c:url value= '/insertMember'/>"> <i
							class="nc-icon nc-circle-09"></i>
							<p>????????????</p>
					</a></li>
					<li><a class="nav-link"
						href="<c:url value= '/findInbodyMember'/>"> <i
							class="nc-icon nc-notes"></i>
							<p>??????Inbody??????</p>
					</a></li>
					<li><a class="nav-link"
						href="<c:url value= '/findDepositeMember'/>"> <i
							class="nc-icon nc-money-coins"></i>
							<p>??????????????????</p>
					</a></li>
					<li><a class="nav-link" href="<c:url value='/adminindex' />">
							<i class="nc-icon nc-chart-pie-35"></i>
							<p>?????????????????????</p>
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
			<div class="content">
				<div class="container-fluid">
					<!-- 					<div align="center"> -->
					<form:form method='POST' modelAttribute="memberBean"
						enctype='multipart/form-data'>
						<fieldset class="fieldset-auto-width">
							<legend>????????????</legend>
							<form>
								<div class="row">
									<div class="col-md-4 px-1">
										<div class="form-group">
											<label>?????????</label>
											<form:input path="name" class="form-control" placeholder="??????"
												id="name" />
											<form:errors path="name" cssClass="error" />
										</div>
									</div>
									<div class="col-md-8 pl-1">
										<div class="form-group">
											<label for="exampleInputEmail1">Email???</label>
											<form:input path="email" class="form-control"
												placeholder="name@example.com" id="email" />
											<form:errors path="email" cssClass="error" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-4 pr-1">
										<div class="form-group" align="center">
											<form:label path="gender">?????????</form:label>
											<br>
											<form:radiobutton path="gender" value="???" label="???" id="man" />
											<form:radiobutton path="gender" value="???" label="???" />
											<form:errors path="gender" cssClass="error" />
										</div>
									</div>
									<div class="col-md-4 pl-1">
										<div class="form-group">
											<label>?????? <font size='-3' color='blue'>(yyyy-MM-dd)</font>???
											</label>
											<form:input type="date" path="birthday" class="form-control"
												id="birth" />
											<form:errors path="birthday" cssClass="error" />
										</div>
									</div>
									<div class="col-md-4 pl-1">
										<div class="form-group">
											<label>?????????</label>
											<form:input path="phone" class="form-control"
												placeholder="phone" id="phone" />
											<form:errors path="phone" cssClass="error" />
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label>Address</label>
											<div id="twzipcode" class="form-row">
												<div class="form-group col">
													<div data-role="county" data-style="form-control"
														data-name="county" data-value="" id="county"></div>
												</div>
												<div class="form-group col">
													<div data-role="district" data-style="form-control"
														data-name="district" data-value="" id="district"></div>
												</div>
												<div class="form-group col">
													<div data-role="zipcode" data-style="form-control"
														data-name="zipcode" data-value="" id="zipcode"></div>
												</div>
												<form:input type="text" size="40" id="address"
													path="address" class="form-control"
													placeholder="Home Address" />
												<form:errors path="address" cssClass="error" />
											</div>
										</div>
									</div>
								</div>
								<div class="row">
									<div class="col-md-4 pl-1">
										<div class="form-group">
											<label>????????????:</label>
											<form:input type="date" path="expirationdate"
												class="form-control" id="expirationdate" />
											<form:errors path="expirationdate" cssClass="error" />
										</div>
									</div>
									<div class="col-md-4 pl-1">
										<div class="form-group">
											<label>??????????????????</label>
											<form:input path="emergencyContact" class="form-control"
												placeholder="???????????????" id="emergencyContact" />
											<form:errors path="emergencyContact" cssClass="error" />

										</div>
									</div>
									<div class="col-md-4 pl-1">
										<div class="form-group">
											<label>????????????????????????</label>
											<form:input type="number" path="emergencyPhone"
												class="form-control" placeholder="phone" id="emergencyPhone" />
											<form:errors path="emergencyPhone" cssClass="error" />
										</div>
									</div>
								</div>

								<div class="row">
									<div class="col-md-4">
										<label>????????????</label>
										<form:input path="mPhoto" type="file" />
										<br>
										<form:errors path="mPhoto" />
									</div>
									<div class="col-md-4"></div>
									<div class="col-md-2">
									<button type="submit" class="btn btn-info btn-fill pull-right">??????</button></div>
									<div class="col-md-2">
										<input type="button" value="????????????"
											class="btn btn-info btn-fill pull-right" onclick="auto()">
									</div>
								</div>
								<div class="clearfix"></div>
							</form>
						</fieldset>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<script>
		$("#twzipcode").twzipcode();
	</script>
	<script>
		function auto() {
			document.getElementById("name").value = "?????????";
			document.getElementById("email").value = "ryan4165@gmail.com";
			document.getElementById("man").checked = true;
			document.getElementById("birth").value = "1993-06-29";
			document.getElementById("phone").value = "0910272835";
			document.getElementById("zipcode").value = "238";
			document.getElementById("address").value = "?????????410???27???";
			document.getElementById("expirationdate").value = "2021-12-15";
			document.getElementById("emergencyContact").value = "?????????";
			document.getElementById("emergencyPhone").value = "0987654321";
		}
	</script>
</body>
</html>