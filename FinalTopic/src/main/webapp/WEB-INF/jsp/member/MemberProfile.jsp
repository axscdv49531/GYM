<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>基本資料</title>

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
<!-- ProFile CSS -->
<link rel="stylesheet" href="../css/profile.css">
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

</head>
<body>
	<div style="width: 1205px; height: 194.13px" class ="top">
		<c:import url="/top_memberlogin"></c:import>
	</div>
	<div class="col-md-5">
		<div class="profileinfoleft">
			<h3 class="username">
				<c:out value="${loginUser.name}" />
			</h3>
			<small class="textmuted"> <c:out
					value="會員編號：${loginUser.number}" />
			</small>
		</div>
		<img width='203' height='254'
			src="<c:url value='/getMemberPicture?email=' />${loginUser.email}" />
	</div>
	<div class="col-md-7">
		<ul class="personalinfo">
			<li><span class="title">身份證字號:</span> <span class="text"><c:out
						value="${loginUser.id}" /></span></li>
			<li><span class="title">性別:</span> <span class="text"><c:out
						value="${loginUser.gender}" /></span></li>
			<li><span class="title">生日:</span> <span class="text"><c:out
						value="${loginUser.birthday}" /></span></li>
			<li><span class="title">電話:</span> <span class="text"><c:out
						value="${loginUser.phone}" /></span></li>
			<li><span class="title">Email:</span> <span class="text"><c:out
						value="${loginUser.email}" /></span></li>
			<li><span class="title">地址:</span> <span class="text"><c:out
						value="${loginUser.county}${loginUser.district}${loginUser.address}" /></span>
			</li>
			<li><span class="title">入會時間:</span> <span class="text"><c:out
						value="${loginUser.expirationdate}" /></span></li>
			<li><span class="title">緊急連絡人:</span> <span class="text"><c:out
						value="${loginUser.emergencyContact}" /></span></li>
			<li><span class="title">緊急連絡人電話:</span> <span class="text"><c:out
						value="${loginUser.emergencyPhone}" /></span></li>

		</ul>
	</div>
	<ul class="updateMember">
		<li class="update-modal"><a href="<c:url value='/updateMember' />"
			class="login">修改</a></li>
	</ul>
</body>
</html>