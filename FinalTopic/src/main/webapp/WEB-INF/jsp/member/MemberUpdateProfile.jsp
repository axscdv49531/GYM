<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>編輯會員資料</title>
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
<script type="text/javascript">
	function confirmUpdate(number) {
		var result = confirm("確定送出此筆記錄(會員編號:" + number.trim() + ")?");
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
<body>
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
									href="/updatePassword/<c:out value='${loginUser.number}' />"
									class="login"> <svg xmlns="http://www.w3.org/2000/svg"
											width="16" height="16" fill="currentColor"
											class="bi bi-lock-fill" viewBox="0 0 16 16">
                                                    <path
												d="M8 1a2 2 0 0 1 2 2v4H6V3a2 2 0 0 1 2-2zm3 6V3a3 3 0 0 0-6 0v4a2 2 0 0 0-2 2v5a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V9a2 2 0 0 0-2-2z" />
                                                </svg><i class="fa fa-user"></i>密碼變更
								</a></li>
								<li class="logout-modal"><a
									href="<c:url value='/logout' />" class="login"><svg
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
																<li><a class="dropdown-item"
																	href="/updateDeposite/<c:out value='${loginUser.number}' />">我要儲值</a>
																</li>
															</ul>
														</li>
													</ul></li>
												<li><a href="<c:url value= '/member/showCoachList'/>">教練師資</a></li>
												<li class="dropdown mega-dropdown"><a href="#"
													class="dropdown-toggle" data-toggle="dropdown ">預約私人課程<span
														class="caret"></span></a>
													<ul class="dropdown-menu mega-dropdown-menu coach">
														<li class="col-sm-12">
															<ul>
																<li class="dropdown-header">一對一課程</li>
																<li><a class="dropdown-item"
																	href="/member/classReservation">課程預約</a></li>
																<li><a class="dropdown-item"
																	href="/classIntroduction">課程介紹</a></li>
																<li><a class="dropdown-item"
																	href="/member/memberViewClassLists">我的課程 </a></li>
																<li><a class="dropdown-item"
																	href="/member/memberClassListHistory">我的課程(歷史紀錄) </a></li>
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

												<li><a href="/Menumain.controller">健康餐盒</a></li>
												<li><a href="<c:url value= '/commodity'/>">周邊商品</a></li>

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
	<div class="content">
		<div class="full-slider">
			<div class="form">
				<form:form method='POST' modelAttribute="memberBean"
					enctype='multipart/form-data'>
					<input type="hidden" name="noname" id='putOrDelete' value="">
					<c:if test='${memberBean.number != null}'>
						<form:hidden path="number" />
						<form:hidden path="password" />
						<form:hidden path="deposite" />
						<form:hidden path="status" />
					</c:if>
					<fieldset class="fieldset-auto-width">
						<legend>會員資料</legend>
						<form>
							<div class="row">
								<div class="col-md-4 px-1">
									<div class="form-group">
										<label>姓名：</label>
										<form:input path="name" class="form-control" placeholder="姓名" />
										<form:errors path="name" cssClass="error" />
									</div>
								</div>
								<div class="col-md-8 pl-1">
									<div class="form-group">
										<label for="exampleInputEmail1">Email：</label>
										<form:input path="email" class="form-control"
											placeholder="name@example.com" />
										<form:errors path="email" cssClass="error" />
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-4 pr-1">
									<div class="form-group" align="center">
										<form:label path="gender">性別：</form:label>
										<br>
										<form:radiobutton path="gender" value="男" label="男" />
										<form:radiobutton path="gender" value="女" label="女" />
										<form:errors path="gender" cssClass="error" />
									</div>
								</div>
								<div class="col-md-4 pl-1">
									<div class="form-group">
										<label>生日 <font size='-3' color='blue'>(yyyy-MM-dd)</font>：
										</label>
										<form:input type="date" path="birthday" class="form-control" />
										<form:errors path="birthday" cssClass="error" />
									</div>
								</div>
								<div class="col-md-4 pl-1">
									<div class="form-group">
										<label>手機：</label>
										<form:input path="phone" class="form-control"
											placeholder="phone" />
										<form:errors path="phone" cssClass="error" />
									</div>
								</div>
							</div>
							<div class="row">
								<div class="col-md-12">
									<div class="form-group">
										<label>地址；</label>
										<div id="twzipcode" class="form-row">
											<div class="form-group col-sm-4">
												<div data-role="county" data-style="form-control"
													data-name="county" data-value="${memberBean.county}"></div>
											</div>
											<div class="form-group col-sm-4">
												<div data-role="district" data-style="form-control"
													data-name="district" data-value="${memberBean.district}"></div>
											</div>
											<div class="form-group col-sm-4">
												<div data-role="zipcode" data-style="form-control"
													data-name="zipcode" data-value=""></div>
											</div>
											<form:input type="text" size="40" id="twzipcode"
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
										<label>入會時間:</label>
										<form:input type="date" path="expirationdate"
											class="form-control" />
										<form:errors path="expirationdate" cssClass="error" />
									</div>
								</div>
								<div class="col-md-4 pl-1">
									<div class="form-group">
										<label>緊急聯絡人：</label>
										<form:input path="emergencyContact" class="form-control"
											placeholder="緊急聯絡人" />
										<form:errors path="emergencyContact" cssClass="error" />

									</div>
								</div>
								<div class="col-md-4 pl-1">
									<div class="form-group">
										<label>緊急聯絡人電話：</label>
										<form:input type="number" path="emergencyPhone"
											class="form-control" placeholder="phone" />
										<form:errors path="emergencyPhone" cssClass="error" />
									</div>
								</div>
							</div>

							<div class="row">
								<div class="col-md-4">
									<label>大頭照：</label>
									<form:input path="mPhoto" type="file" />
									<br>
									<form:errors path="mPhoto" cssClass="error" />
								</div>
								<div class="col-md-6"></div>
								<button type="submit" class="btn btn-info btn-fill pull-right"
									value='送出' name='updateBtn'
									onclick="return confirmUpdate('${memberBean.number}');">送出
								</button>
							</div>
							<div class="clearfix"></div>
						</form>
					</fieldset>
				</form:form>
				<a href="/MemberProfile">回前頁</a>
			</div>
		</div>
	</div>

	<script>
		$("#twzipcode").twzipcode();
	</script>

</body>
</html>