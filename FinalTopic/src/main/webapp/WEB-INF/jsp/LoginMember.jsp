<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!doctype html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
<meta charset="UTF-8">
<title>Login</title>

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

.form-signin {
	width: 100%;
	max-width: 330px;
	padding: 15px;
	margin: auto;
}

.error {
	color: red;
	display: inline-block;
	font-size: 10pt;
}
</style>


</head>
<body>
	<div class="top">
		<c:import url="/top_nologin"></c:import>
	</div>
	<main class="form-signin text-center">
		<%-- 		<form action="/login/Member" th:action="@{/login/Member}" --%>
		<%-- 			th:method="post"> --%>
		<form action="/login/Member" method="post">
			<h1 class="h3 mb-3 fw-normal">請輸入帳號密碼</h1>

			<div class="form-floating">
				<label for="floatingInput">帳號</label><input type="text"
					class="form-control" id="floatingInput"
					placeholder="name@example.com" name="username">
			</div>
			<div class="form-floating">
				<label for="floatingPassword">密碼</label><input type="password"
					class="form-control" id="floatingPassword" placeholder="Password"
					name="password" />
				<p class="error">${errorMsg}</p>
<%-- 									 <span th:unless="${param.error == null}" th:text="登入失敗">登入失敗</span> --%>
<%-- 									<span th:if="${param.error}" class="error">帳號或密碼錯誤，請重新輸入</span> --%>
			</div>

			<div class="checkbox mb-3">
				<label> <input type="checkbox" value="remember-me">
					記住我
				</label>
			</div>
			<button class="w-100 btn btn-lg btn-primary" type="submit">登入</button>
			<input class="w-100 btn btn-lg btn-primary" type="button"
				value="忘記密碼" onclick="location.href='/forgetPwd'">
		</form>
	</main>

</body>
</html>