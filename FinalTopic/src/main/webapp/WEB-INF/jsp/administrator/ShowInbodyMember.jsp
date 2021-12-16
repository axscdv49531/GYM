<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	function confirmDelete(number) {
		var result = confirm("確定刪除此筆記錄(帳號:" + number.trim() + ")?");
		if (result) {
			document.forms[0].putOrDelete.name = "_method";
			document.forms[0].putOrDelete.value = "DELETE";
			return true;
		}
		return false;
	}

	(function(document) {
		'use strict';

		// 建立 LightTableFilter
		var LightTableFilter = (function(Arr) {

			var _input;

			// 資料輸入事件處理函數
			function _onInputEvent(e) {
				_input = e.target;
				var tables = document.getElementsByClassName(_input
						.getAttribute('data-table'));
				Arr.forEach.call(tables, function(table) {
					Arr.forEach.call(table.tBodies, function(tbody) {
						Arr.forEach.call(tbody.rows, _filter);
					});
				});
			}

			// 資料篩選函數，顯示包含關鍵字的列，其餘隱藏
			function _filter(row) {
				var text = row.textContent.toLowerCase(), val = _input.value
						.toLowerCase();
				row.style.display = text.indexOf(val) === -1 ? 'none'
						: 'table-row';
			}

			return {
				// 初始化函數
				init : function() {
					var inputs = document
							.getElementsByClassName('light-table-filter');
					Arr.forEach.call(inputs, function(input) {
						input.oninput = _onInputEvent;
					});
				}
			};
		})(Array.prototype);

		// 網頁載入完成後，啟動 LightTableFilter
		document.addEventListener('readystatechange', function() {
			if (document.readyState === 'complete') {
				LightTableFilter.init();
			}
		});

	})(document);
</script>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="apple-touch-icon" sizes="76x76"
	href="../admintemplate/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="../admintemplate/img/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>會員查詢</title>
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
					<li><a class="nav-link"
						href="<c:url value= '/findAllMember'/>"> <i
							class="nc-icon nc-circle-09"></i>
							<p>查詢會員</p>
					</a></li>
					<li><a class="nav-link"
						href="<c:url value= '/insertMember'/>"> <i
							class="nc-icon nc-circle-09"></i>
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
							<li class="nav-item"><a class="nav-link" href="<c:url value='/logout' />">
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
			<form class="form-inline search-bar">
				<div class="form-group">
					<label for="exampleInputEmail2">會員查詢</label> <input type="search"
						class="form-control light-table-filter" data-table="order-table"
						placeholder="請輸入關鍵字">
				</div>
			</form>
			<div align='center'>
				<form:form method='POST' modelAttribute="memberBean">
					<h3>會員Inbody</h3>
					<hr>
					<table border='1' class="order-table">
						<thead>
							<tr>
								<th width='120'>會員編號</th>
								<th width='100'>姓名</th>
								<th width='60'>性別</th>
								<th width='160'>生日</th>
								<th width='360'>Email</th>
								<th width='60'>詳細資料</th>
								<th width='120'>Inbody</th>
								<th width='120'>Inbody紀錄</th>
							</tr>
						</thead>
						<c:choose>
							<c:when test="${not empty memberBeanList}">
								<c:forEach var='member' items="${memberBeanList}">
									<tr>
										<td>${member.number}</td>
										<td>${member.name}</td>
										<td>${member.gender}</td>
										<td>${member.birthday}</td>
										<td>${member.email}</td>
										<td><a href='selectMember/${member.number}'><input
												type='button' value='詳細資料' class="btn btn-danger"></a></td>
										<td><a href='insertInbody/${member.number}'><input
												type='button' value='輸入' class="btn btn-danger"></a></td>
										<td><a href='adminFindInbody/${member.number}'><input
												type='button' value='查詢' class="btn btn-danger"></a></td>
									</tr>
								</c:forEach>
							</c:when>
							<c:otherwise>
				查無Member資料
			</c:otherwise>
						</c:choose>
					</table>
				</form:form>
			</div>
</body>
</html>