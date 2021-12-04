<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員選課系統</title>
<link rel="stylesheet" href="/css/coursesystem.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	var indexPage = 1;
	var queryCondition = 'allCourse';

	$(document).ready(function() {
		showAllCourse(indexPage);
	});

	function change(page) {
		indexPage = page;

		if (queryCondition == 'allCourse') {
			showAllCourse(indexPage)
		}
		if (queryCondition == 'todayCourse') {
			toadyCourse(indexPage)
		}
		if (queryCondition == 'queryForm') {
			sendQuery(indexPage);
		}

	}
	function previous() {
		if (indexPage > 1) {
			indexPage--;
			if (queryCondition == 'allCourse') {
				showAllCourse(indexPage)
			}
			if (queryCondition == 'todayCourse') {
				toadyCourse(indexPage)
			}
			if (queryCondition == 'queryForm') {
				sendQuery(indexPage);
			}
		}
	}

	function next() {
		if (indexPage < $('#nextbutton').val()) {
			indexPage++;
			if (queryCondition == 'allCourse') {
				showAllCourse(indexPage)
			}
			if (queryCondition == 'todayCourse') {
				toadyCourse(indexPage)
			}
			if (queryCondition == 'queryForm') {
				sendQuery(indexPage);
			}
		}

	}

	function selectCourse(courseId, stuNum, maxStuNum) {
		if (confirm("確實要加選" + courseId + "嗎?")) {
			if (stuNum >= maxStuNum) { //檢查選課人數
				alert(courseId + ":課程已額滿");
			} else {
				$.ajax({
					type : 'get',
					url : '/membercourse/selectcourse.controller/' + courseId,
					dataType : 'JSON',
					contentType : 'application/json',
					success : function(data) {
						alert("已經加選" + courseId + "！");
						//showAllCourse(indexPage);
					}
				});
			}
		} else {
			alert("已經取消加選" + courseId + "的操作");
			//showAllCourse(indexPage);
		}
	}

	function arrayToJson(formArray) {
		var dataArray = {};
		$.each(formArray, function() {
			if (dataArray[this.name]) {
				if (!dataArray[this.name].push) {
					dataArray[this.name] = [ dataArray[this.name] ];
				}
				dataArray[this.name].push(this.value || '');
			} else {
				dataArray[this.name] = this.value || '';
			}
		});
		return JSON.stringify(dataArray);
	}

	//共同使用的函式：將查詢課程結果印出  
	function showCourseList(data) {
		console.log('success:' + data);
		var json = JSON.stringify(data, null, 4);
		console.log('json:' + json);
		//console.log(data.totalElements)

		//alert("查詢成功！");
		////////////
		$('#showcourse').empty("");
		$('#showInformation').empty("");

		if (data.pageContent == null) {
			alert("無符合查詢結果！");
			$('#showcourse').append("<tr><td colspan='2'>暫無資料</td></tr>");
			;
		} else {
			var table = $('#showcourse');
			table
					.append("<tr id='ptitle'><th>課程編號</th><th>課程名稱</th><th>課程總類</th><th>日期</th><th>課程時間</th><th>教室編號</th><th>授課老師編號:</th><th>目前學生人數</th><th>學生人數上限</th><th>課程狀態</th><th>課程簡介</th><th>加選課程</th></tr>");

			$
					.each(
							data.pageContent,
							function(i, n) {
								var tr = "<tr align='center'>" + "<td>"
										+ n.id
										+ "</td>"
										+ "<td>"
										+ n.courseName
										+ "</td>"
										+ "<td>"
										+ n.category
										+ "</td>"
										+ "<td>"
										+ n.date
										+ "</td>"
										+ "<td>"
										+ n.period
										+ "</td>"
										+ "<td>"
										+ n.classroom
										+ "</td>"
										+ "<td>"
										+ n.coach.coachName
										+ "</td>"
										+ "<td>"
										+ n.studentNum
										+ "</td>"
										+ "<td>"
										+ n.maxStudentNum
										+ "</td>"
										+ "<td>"
										+ n.state
										+ "</td>"
										+ "<td><button id='' type='button' class='btn'  onclick='showInformation("
										+ n.id
										+ ")'>課程簡介</button></td>"
										+ "<td><button id='' type='button' class='btn'  onclick='selectCourse("
										+ n.id + "," + n.studentNum + ","
										+ n.maxStudentNum
										+ ")'>加選課程</button></td>" + "</tr>";
								table.append(tr);
							});
		}
		//////////

		var tr2 = "Total Pages: " + data.totalPages + " Total Records: " + data.totalElements;

		$('#showpageInfo').empty("");
		$('#showpageInfo').append(tr2);

		$('#showpageButton').append(
				"<button style='float: right;' class='btn' onclick='previous()'>Previous</button>");

		for (var j = 1; j <= data.totalPages; j++) {
			$('#showpageButton').append(
					"<button style='float: right;' class='btn' id='myPage' value='" + j
							+ "' onclick='change(" + j + ")'>" + j
							+ "</button>")
		}

		$('#showpageButton').append(
				"<button style='float: right;' class='btn' id='nextbutton' value='" + data.totalPages
						+ "' onclick='next()'>Next</button>");

	}

	//多條件查詢   
	function sendQuery(indexPage) {

		queryCondition = 'queryForm';
		var formArray = $("form").serializeArray()
		var json = arrayToJson(formArray);
		console.log(formArray);
		console.log("json:" + json);
		$.ajax({
			type : 'post',
			url : '/course/sendqueryform.controller/' + indexPage,
			data : json,
			dataType : 'JSON',
			contentType : 'application/json;charset=utf-8',
			success : function(data) {
				showCourseList(data);
			}
		});
	}

	//查詢當日課程 
	function todayCourse(indexPage) {

		queryCondition = 'todayCourse';
		var today = new Date();
		var month = today.getMonth() + 1;
		var todaystr = today.getFullYear() + "-" + month + "-"
				+ today.getDate();
		console.log(todaystr);
		var params = {
			"date" : todaystr
		}
		$.ajax({
			type : 'post',
			url : '/course/sendqueryform.controller/' + indexPage,
			data : JSON.stringify(params),
			dataType : 'JSON',
			contentType : 'application/json;charset=utf-8',
			success : function(data) {
				showCourseList(data);
			}
		});
	}
	//查詢所有課程
	function showAllCourse(indexPage) {

		queryCondition = 'allCourse';
		var params = {}
		$.ajax({
			type : 'post',
			url : '/course/sendqueryform.controller/' + indexPage,
			data : JSON.stringify(params),
			dataType : 'JSON',
			contentType : 'application/json;charset=utf-8',
			success : function(data) {
				showCourseList(data);
			}
		});
	}

	function showInformation(courseId) {
		//alert(courseId);

		$.ajax({
			type : 'get',
			url : '/course/queryinformation.controller/' + courseId,
			dataType : 'text',
			contentType : 'application/json',
			success : function(str) {

				$('#showInformation').empty("");
				$('#showInformation').append(str);
				//showAllCourse(indexPage);
			}
		});

		//load(indexPage);
	}
</script>

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
<script src="/js/3dslider.js"></script>

<!-- ALL JS FILES -->
<script src="../js/all.js"></script>
<!-- ALL PLUGINS -->
<script src="../js/custom.js"></script>


</head>
<body class="game-info">

	<div style="width: 1205px; height: 194.13px">
		<c:import url="/top"></c:import>
	</div>

	<div id="productListTitle">會員選課系統</div>

	<a href="<c:url value='/courseSelectSystem' />">查詢所有課程</a>
	<a href="<c:url value='/selectCourseRecord' />">查詢選課紀錄</a>
	<a href="<c:url value='/myCourseSchedule' />">我的課表</a>
	<a href="<c:url value='/' />">回首頁</a>
	<br>


	<div class="contanier-fluid">

		<div class="" style="border: 0px #FFAC55 solid; width:720px">
			<fieldset>
				<legend>課程查詢：</legend>
				<a href="<c:url value='/thisweekcourse' />">本週課程</a>
				<button onclick='todayCourse(1)'>當日課程</button>
				<button onclick='showAllCourse(1)'>查詢所有課程</button>
				<br> <br>
				<form>

					<select name="category" class="form-select">
						<option value="" label="請選擇課程種類" selected="selected"></option>
						<option value="舞蹈類課程">舞蹈類課程</option>
						<option value="瑜珈課程">瑜珈課程</option>
						<option value="心肺肌力課程">心肺肌力課程</option>
						<option value="其他">其他</option>
					</select> <select name="classroom" class="form-select">
						<option value="" label="請選擇教室" selected="selected"></option>
						<option value="A">A教室</option>
						<option value="B">B教室</option>
						<option value="C">C教室</option>
					</select> <select name="date" class="form-select">
						<option value="" label="請選擇課程日期" selected="selected" />
						<c:forEach var="onedate" items="${dateList}">
							<option value="${onedate}">${onedate}</option>
						</c:forEach>
					</select> <select name="coachId" class="form-select">
						<option value="" label="請選擇授課老師" selected="selected" />
						<c:forEach var="oneCoach" items="${coachList}">
							<option value="${oneCoach.coachId}">${oneCoach.coachName}</option>
						</c:forEach>
					</select> <input class="form-control" type="button"
						value="查詢" onclick='sendQuery(1)'>
				</form>
			</fieldset>
		</div>
		<br>
		<div>
			<div class="col-sm-8">
				<table class="table table-bordered table-hover" id="showcourse"
					border="1"></table>
				<table class="table">
					<tr >
					<td id="showpageInfo"></td>
					<td id="showpageButton" align="right"></td>
					</tr>
				</table>
			</div>

<div class="col-sm-2 ">

		<div class="content-widget top-story" style="background: url(images/top-story-bg.jpg);">
                     <div class="top-stroy-header">
                        <h2>課程介紹<a href="#" class="fa fa-fa fa-angle-right"></a></h2>
                        <span class="date"></span>
                     </div>
                     <ul class="other-stroies" id='showInformation'></ul>
                  </div>
</div>

</div>
</div>
	<c:import url="/bottom"></c:import>
</body>
</html>