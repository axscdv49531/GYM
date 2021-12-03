<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html>
<head>
<meta charset="UTF-8">
<title>Login</title>

<!-- Bootstrap CSS -->
<link href="/docs/5.1/dist/css/bootstrap.min.css" rel="stylesheet">

<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap.theme.css">
<link rel="stylesheet" href="../css/bootstrap.min.css">
<link rel="stylesheet" href="../css/bootstrap.thememin.css">
<!-- Custom styles for this template -->
<link rel="stylesheet" href="../css/signin.css">

<style>
.bd-placeholder-img {
	font-size: 1.125rem;
	text-anchor: middle;
	-webkit-user-select: none;
	-moz-user-select: none;
	user-select: none;
}

@media ( min-width : 768px) {
	.bd-placeholder-img-lg {
		font-size: 3.5rem;
	}
}
</style>
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css"
	rel="stylesheet" type="text/css">
<script src="js/3dslider.js"></script>
<meta name="theme-color" content="#7952b3">


</head>
<body class="text-center">

	<main class="form-signin">
		<form action="/login/Coach" method="post">
			<h1 class="h3 mb-3 fw-normal">請輸入帳號密碼</h1>

			<div class="form-floating">
				 <label
					for="floatingInput">帳號</label><input type="text" class="form-control" id="floatingInput"
					placeholder="name@example.com" name="username">
			</div>
			<div class="form-floating">
				 <label
					for="floatingPassword">密碼</label><input type="password" class="form-control" id="floatingPassword"
					placeholder="Password" name="password">
			</div>

			<div class="checkbox mb-3">
				<label> <input type="checkbox" value="remember-me">
					記住我
				</label>
			</div>
			<button class="w-100 btn btn-lg btn-primary" type="submit">登入</button>
		</form>
	</main>

</body>
</html>