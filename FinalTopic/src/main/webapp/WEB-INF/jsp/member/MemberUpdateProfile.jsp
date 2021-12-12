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
	<div class="top">
		<c:import url="/top_memberlogin"></c:import>
	</div>
	<div class="content">
		<div class="full-slider">
			<div class="form">
				<form:form method='POST' modelAttribute="memberBean"
					enctype='multipart/form-data'>
					<input type="hidden" name="noname" id='putOrDelete' value="">
					<c:if test='${memberBean.number != null}'>
						<form:hidden path="number" />
						<form:hidden path="password" />
						<form:hidden path="confirmedPassword" />
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
									name='updateBtn'
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