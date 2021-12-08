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
	<div style="width: 1205px; height: 194.13px" class="top">
		<header>
			<div class="container">
				<div class="header-top">
					<div class="row">
						<div class="col-md-6">
							<div class="full">
								<div class="logo">
									<a href="<c:url value='/login/MemberSuccess' />"><img
										src="../images/springfitnesslogo6.png" alt="index" /></a>
								</div>
							</div>
						</div>
						<div class="col-md-6">
							<div class="right_top_section">
								<%-- <c:out value="${loginUser.name },歡迎您" /> --%>
								<!-- button section -->
								<ul class="login">
									<li class="login-modal"><a
										href="/updatePassword/<c:out value='${loginUser.number}' />"
										class="login"> <svg xmlns="http://www.w3.org/2000/svg"
												width="16" height="16" fill="currentColor"
												class="bi bi-lock-fill" viewBox="0 0 16 16">
                                                    <path
													d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z" />
                                                </svg><i class="fa fa-user"></i>密碼變更
									</a></li>
									<li class="logout-modal"><a
										href="<c:url value='/logout' />" class="logout"><svg
												xmlns="http://www.w3.org/2000/svg" width="16" height="16"
												fill="currentColor" class="bi bi-person-fill"
												viewBox="0 0 16 16">
                                                    <path
													d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
                                                </svg><i class="fa fa-user"></i>登出</a></li>
									<li>
										<div class="context-option">
											<a href="#"><i class="fa fa-envelope"><svg
														xmlns="http://www.w3.org/2000/svg" width="16" height="16"
														fill="currentColor" class="bi bi-envelope"
														viewBox="0 0 16 16">
                                                            <path
															d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z" />
                                                        </svg></i>聯絡我們</a>
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
													<li class="active"><a
														href="<c:url value='/login/MemberSuccess' />">主頁</a></li>
													<li><a href="about.html">關於</a></li>

													<li class="dropdown mega-dropdown member"><a href="#"
														class="dropdown-toggle" data-toggle="dropdown ">會員中心<span
															class="caret"></span></a>
														<ul class="dropdown-menu mega-dropdown-menu member">
															<li class="col-sm-12">
																<ul>
																	<li class="dropdown-header">會員中心</li>
																	<li><a class="dropdown-item" href="/MemberProfile">個人資料</a></li>
																	<li><a class="dropdown-item"
																		href="/selectInbody/<c:out value='${loginUser.number}' />">Inbody紀錄</a>
																	</li>
																	<li><a class="dropdown-item"
																		href="/selectPayment/<c:out value='${loginUser.number}' />">會費紀錄
																	</a></li>
																	<li><a class="dropdown-item"
																		href="/findAllDeposite/<c:out value='${loginUser.number}' />">儲值紀錄</a>
																	</li>
																</ul>
															</li>
														</ul></li>
													<li class="dropdown-header"><a
														href="<c:url value= '/showCoachList'/>">教練師資</a></li>
													<!--                                                         <li><a href="/classRes">預約私人課程</a></li> -->

													<li class="dropdown mega-dropdown"><a href="#"
														class="dropdown-toggle" data-toggle="dropdown ">預約私人課程<span
															class="caret"></span></a>
														<ul class="dropdown-menu mega-dropdown-menu member">
															<li class="col-sm-12">
																<ul>
																	<li class="dropdown-header">一對一課程</li>
																	<li><a class="dropdown-item"
																		href="/classReservation">課程預約</a></li>
																	<li><a class="dropdown-item"
																		href="/classIntroduction">課程介紹</a></li>
																	<li><a class="dropdown-item"
																		href="/memberViewClassLists">我的課程 </a></li>
																</ul>
															</li>
														</ul>
													<li class="dropdown mega-dropdown"><a href="#"
														class="dropdown-toggle" data-toggle="dropdown">團體課程<span
															class="caret"></span></a>
														<ul class="dropdown-menu mega-dropdown-menu classRes">
															<li class="col-sm-12">
																<ul>
																	<li class="dropdown-header">團體課程 Cousres</li>
																	<li><a class="dropdown-item"
																		href="/courseSelectSystem">預約課程</a></li>
																	<li><a class="dropdown-item"
																		href="/myCourseSchedule">我的課程</a></li>
																	<li><a class="dropdown-item"
																		href="/pastCourseRecord">上課紀錄</a></li>

																</ul>
															</li>
														</ul></li>

													<li><a href="news.html">健康餐盒</a></li>
													<li><a href="news.html">周邊商品</a></li>

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
							<form:errors path="oldpwd" cssClass="error"></form:errors> <span id="oldpwdsp" class="error"></span></td>
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
							<form:errors path="confirmedPassword" cssClass="error" /><span id="conpwdsp" class="error"></span></td>
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
		document.getElementById("confirmedPassword").addEventListener("blur", checkConPwd);
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
					sp.innerHTML = ""
				} else {
					sp.innerHTML = "<img src='/images/error.png'>密碼需包含英文、數字及特殊符號[!@#$%^&*]"
				}
			} else {
				sp.innerHTML = "<img src='/images/error.png'>請輸入8-15位數密碼"
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
			}else if (thePwdObjVal ==theCPwdObjVal ){
				sp.innerHTML = ""
			}else{
				sp.innerHTML = "<img src='/images/error.png'>和新密碼不相符"
			}
		}
	</script>



</body>
</html>