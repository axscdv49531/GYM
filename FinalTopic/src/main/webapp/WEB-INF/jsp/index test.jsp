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
<!-- Bootstrap CSS -->
<link rel="stylesheet" type="text/css" href="../css/bootstrap.min.css">
<!-- Site CSS -->
<link rel="stylesheet" href="../css/style.css">
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

<!-- ALL JS FILES -->
<script src="../js/all.js"></script>
<!-- ALL PLUGINS -->
<script src="../js/custom.js"></script>

</head>
<body>
	<div class="container">
		<section id="top">
			<header>
				<div class="container">
					<div class="header-top">
						<div class="row">
							<div class="col-md-4">
								<a class="logo" href="<c:url value='/' />">
									<div class="logo-content">
										<img src="../images/springfitnesslogo6.png" alt="index" />
										<h1>SPRINGFITNESS</h1>
									</div>
								</a>
							</div>
							<div class="col-md-8 header-button-container">
								<div class="right_top_section">
									<!-- button section -->
									<ul class="login">
										<li class="login-modal"><a
											href="<c:url value='/login/Member' />" class="login"><svg
													xmlns="http://www.w3.org/2000/svg" width="16" height="16"
													fill="currentColor" class="bi bi-person-fill"
													viewBox="0 0 16 16">
								   <path
														d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
								 </svg><i class="fa fa-user"></i>??????</a></li>

										<li>
											<div class="context-option">
												<a href="#"><svg xmlns="http://www.w3.org/2000/svg"
														width="16" height="16" fill="currentColor"
														class="bi bi-envelope" viewBox="0 0 16 16">
  									  <path
															d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z" />
									</svg><i class="fa fa-envelope"></i>????????????</a>
											</div>
										</li>
									</ul>
									<!-- end button section -->
								</div>
							</div>
						</div>
					</div>
					<div class="header-bottom">
						<div class="row">
							<div class="col-md-12">
								<div class="full">
									<div class="main-menu-section">
										<div class="menu">
											<nav class="navbar navbar-inverse">
												<div class="navbar-header">
													<button class="navbar-toggle" type="button"
														data-toggle="collapse" data-target=".js-navbar-collapse">
														<span class="sr-only">Toggle navigation</span> <span
															class="icon-bar"></span> <span class="icon-bar"></span> <span
															class="icon-bar"></span>
													</button>
													<a class="navbar-brand" href="#">Menu</a>
												</div>
												<div class="collapse navbar-collapse js-navbar-collapse">
													<ul class="nav navbar-nav">
														<li class="active"><a href="<c:url value='/' />">??????</a></li>
														<li><a href="about.html">??????</a></li>
														<li><a href="<c:url value= '/showCoachList'/>">????????????</a></li>
														<li><a href="<c:url value='/login/Member' />">??????????????????</a></li>
														<li><a
															href="/membercourse/nologin_courseSelectSystem.controller">????????????</a></li>
														<li><a href="/nologinMenumain.controller">????????????</a></li>
														<li><a href="<c:url value= '/commodity'/>">????????????</a></li>
													</ul>
												</div>
											</nav>
										</div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</header>
			<div class="full-slider">
				<div id="carousel-example-generic" class="carousel slide">

					<!-- Wrapper for slides -->
					<div class="carousel-inner" role="listbox">
						<!-- First slide -->
						<div class="item active deepskyblue" data-ride="carousel"
							data-interval="5000">
							<div class="carousel-caption">
								<div class="col-lg-7 col-md-7 col-sm-12 col-xs-12"></div>
								<div class="col-lg-5 col-md-5 col-sm-12 col-xs-12">
									<div class="slider-contant"
										data-animation="animated fadeInRight">
										<h3>
											???????????????????????????<br> ????????????!<br> ?????????????????????????????????
										</h3>
										<h3 class="text-yellow">????????????</h3>
										<p>???????????????????????????????????????14???</p>
										<p>??????????????????(02)2777-0168</p>
										<button class="btn btn-primary btn-lg">????????????</button>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</section>
	</div>
<%-- 	<a class="nav-link" href="<c:url value= '/insertMember'/>">??????????????????</a> --%>
<%-- 	<a class="nav-link" href="<c:url value= '/findAllMember'/>">??????????????????</a> --%>
<%-- 	<a class="nav-link" href="<c:url value= '/courseQuery'/>">?????????????????????(???????????????)</a> --%>
<%-- 	<a class="nav-link" href="<c:url value= '/courseSelectSystem'/>">??????????????????(???????????????)</a> --%>
<%-- 	<a class="nav-link" href="<c:url value= '/coach/coachAdd'/>">????????????</a> --%>
<%-- 	<a class="nav-link" href="<c:url value= '/administrator/coachPage'/>">????????????</a> --%>
<%-- 	<a class="nav-link" href="<c:url value= '/testcoach'/>">????????????test</a> --%>

<%-- 	<a class="nav-link" href="<c:url value= '/adminindex'/>">???????????????</a> --%>


</body>
</html>