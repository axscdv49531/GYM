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
	<div class="top">
		<c:import url="/top_nologin"></c:import>
	</div>
	<div align="center">
		<form:form method='POST' modelAttribute="memberBean">
			<input type="hidden" name="noname" id='putOrDelete' value="">
			<c:if test='${memberBean.number != null}'>
				<form:hidden path="number" />
				<br>&nbsp;
			</c:if>
			<fieldset class="fieldset-auto-width">
				<legend>會員資料</legend>
				<table>
					<tr>
						<td align='right'>原密碼：<br>&nbsp;
						<td><form:input type="password" path="oldpwd" id="oldpwd" /><br>&nbsp;
							<form:errors path="oldpwd" cssClass="error"></form:errors> <span
							id="oldpwdsp" class="error"></span></td>
					</tr>

					<tr>
						<td align='right'>新密碼：<br>&nbsp;
						<td><form:input type="password" path="password1"
								id="password1" /><br>&nbsp; <form:errors path="password1"
								cssClass="error"></form:errors> <span id="pwdsp" class="error"></span><br /></td>
					</tr>

					<tr>
						<td align='right'>新密碼確認：<br>&nbsp;
						</td>
						<td><form:input type="password" path="confirmedPassword" /><br>&nbsp;
							<form:errors path="confirmedPassword" cssClass="error" /><span
							id="conpwdsp" class="error"></span></td>
					</tr>
					<tr>
						<td colspan='2' align='center'><input class="button"
							type='submit' value='確認變更' name='updateBtn'
							onclick="finction updatePassword()">&nbsp;</td>
					</tr>
				</table>
			</fieldset>
		</form:form>
		<a href="<c:url value='/login/MemberSuccess' />">回前頁</a>
	</div>
	<script type="text/javascript">
		document.getElementById("oldpwd").addEventListener("blur", checkOldPwd);
		document.getElementById("password1").addEventListener("blur", checkPwd);
		document.getElementById("confirmedPassword").addEventListener("blur",
				checkConPwd);
		function checkOldPwd() {
			let thePwdObj = document.getElementById("oldpwd");
			//取得Pwd元素值
			let thePwdObjVal = thePwdObj.value;
			//判斷元素值是否為空白，密碼長度是否大於等於6
			let sp = document.getElementById("oldpwdsp");
			let thePwdObjValLen = thePwdObjVal.length;
			let ch, flag1 = false;
			if (thePwdObjVal == "") {
				sp.innerHTML = "<img src='/images/error.png'>不可空白";
			}
		}
		function checkPwd() {
			let thePwdObj = document.getElementById("password1");
			//取得Pwd元素值
			let thePwdObjVal = thePwdObj.value;
			//判斷元素值是否為空白，密碼長度是否大於等於6
			let sp = document.getElementById("pwdsp");
			let thePwdObjValLen = thePwdObjVal.length;
			let ch, flag1 = false, flag2 = false;
			if (thePwdObjVal == "") {
				sp.innerHTML = "<img src='/images/error.png'>不可空白";
			} else if (thePwdObjValLen >= 8) {
				for (let i = 0; i < thePwdObjValLen; i++) {
					ch = thePwdObjVal.charAt(i).toUpperCase()
					if (ch >= "A" && ch <= "Z") {
						flag1 = true;
					} else if (ch >= "0" && ch <= "9") {
						flag2 = true;
					}
					if (flag1 && flag2) {
						break;
					}
				}//for
				if (flag1 && flag2) {
					sp.innerHTML = "";
				} else {
					sp.innerHTML = "<img src='/images/error.png'>密碼需包含大小寫英文及數字";
				}
			} else {
				sp.innerHTML = "<img src='/images/error.png'>請輸入8-15位數密碼";
			}
		}
		function checkConPwd() {
			let thePwdObj = document.getElementById("password1");
			let theCPwdObj = document.getElementById("confirmedPassword");
			//取得Pwd元素值
			let thePwdObjVal = thePwdObj.value;
			let theCPwdObjVal = theCPwdObj.value;
			//判斷元素值是否為空白
			let sp = document.getElementById("conpwdsp");
			let ch, flag1 = false;
			if (thePwdObjVal == "") {
				sp.innerHTML = "<img src='/images/error.png'>不可空白";
			} else if (thePwdObjVal == theCPwdObjVal) {
				sp.innerHTML = ""
			} else {
				sp.innerHTML = "<img src='/images/error.png'>和新密碼不相符"
			}
		}

		function updatePassword() {

		}
	</script>



</body>
</html>