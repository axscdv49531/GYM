s<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>會員選課系統</title>
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="../css/bootstrap.min.css">
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
	//if(	${loginUser.number} == null )
		
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
						console.log(data);
						if(null != data && "" != data){ 
							alert("加選成功" + courseId + "！");
							
						}else{//表示已加選
							alert("您已經加選" + courseId + "請勿重複選課！");
						//showAllCourse(indexPage);	
						}
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
		$('#showpageButton').empty("");

		

		if (data.pageContent == null) {
			alert("無符合查詢結果！");
			$('#showcourse').append("<tr><td colspan='2'>暫無資料</td></tr>");
			;
		} else {
			var table = $('#showcourse');
			table.append("<tr id='ptitle'><th>課程編號</th><th>課程名稱</th><th>課程總類</th><th>日期</th><th>課程時間</th><th>教室編號</th><th>授課老師</th><th>目前學生人數</th><th>學生人數上限</th><th>課程簡介</th><th>加選課程</th></tr>");

			$.each(data.pageContent,function(i, n) {
				if(n.studentNum == n.maxStudentNum){
					var tr = "<tr align='center' id='"+ n.id+ "'><td>"+ n.id+ "</td>"+ "<td>"+ n.courseName + "</td>"+ "<td>"+ n.category
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
					+ "<td><button id='' type='button' class='btn'  onclick='showInformation("
					+ n.id
					+ ")'>課程簡介</button></td>"
					+"<td>課程已額滿</td>" + "</tr>";}
				else{
						
								var tr = "<tr align='center' id='"+ n.id+ "'><td>"
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
										+ "<td><button id='' type='button' class='btn'  onclick='showInformation("
										+ n.id
										+ ")'>課程簡介</button></td>"
										+ "<td><button id='' type='button' class='btn' onclick='selectCourse("
										+ n.id + "," + n.studentNum + ","
										+ n.maxStudentNum
										+ ")'>加選課程</button></td>" + "</tr>";
					}
								table.append(tr);
							});
		}
		//////////

		var tr2 = "Total Pages: " + data.totalPages + " Total Records: "
				+ data.totalElements;

		$('#showpageInfo').empty("");
		$('#showpageInfo').append(tr2);

		$('#showpageButton')
				.append(
						"<button style='align: right;' class='btn' onclick='previous()'>Previous</button>");

		for (var j = 1; j <= data.totalPages; j++) {
			$('#showpageButton').append(
					"<button style='align: right;' class='btn' id='myPage' value='"
							+ j + "' onclick='change(" + j + ")'>" + j
							+ "</button>")
		}

		$('#showpageButton').append(
				"<button style='align: right;' class='btn' id='nextbutton' value='"
						+ data.totalPages + "' onclick='next()'>Next</button>");

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

	/*
	//查詢我的課程，並將該課程註記
	function markMyCourse(indexPage) {

		$.ajax({
			type : 'get',
			url : '/course/findbymember.controller/' + indexPage,
			dataType : 'JSON',
			contentType : 'application/json;charset=utf-8',
			success : function(data) {
				console.log("success");
				$.each(data.pageContent,function(i, n) {
					var id =n.id;
					console.log(id);
					
				}
			
			}
		});
	}
*/
	
	
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
	
	 <!-- /.modal 模態框--> 
	  $(function() { $('#myModal').modal('hide') } ); 
	  $(function() { $('#myModal').on('hide.bs.modal', function() { alert('嘿，我聽說您喜歡模態框...'); }) });
	
</script>


</head>

<body class="game-info">
	<div style="width: 1205px; height: 194.13px">
		<c:import url="/top_memberlogin"></c:import>
	</div>

		<div class="row" style="margin-left:15px;margin-top:150px">
			<div class="container-fluid">

				<div class="col-md-1"></div>
				<div  class="col-md-7">

					<fieldset>
						<legend>課程查詢：</legend>
						<a href="<c:url value='/timetable' />" target="_blank">顯示本週課表</a><br>
						<button onclick='todayCourse(1)'>當日課程</button>
						<button onclick='showAllCourse(1)'>查詢所有課程</button>
						<br> <br>
						<form>

							<select  name="category" class="">
								<option value=""  selected="selected">請選擇課程種類</option>
								<option value="舞蹈類課程">舞蹈類課程</option>
								<option value="瑜珈課程">瑜珈課程</option>
								<option value="心肺肌力課程">心肺肌力課程</option>
								<option value="其他">其他</option>
							</select> <select name="classroom" class="">
								<option value=""  selected="selected">請選擇教室</option>
								<option value="A">A教室</option>
								<option value="B">B教室</option>
								<option value="C">C教室</option>
							</select> <select name="date" class="">
								<option value=""  selected="selected">請選擇課程日期</option>
								<c:forEach var="onedate" items="${dateList}">
									<option value="${onedate}">${onedate}</option>
								</c:forEach>
							</select> <select name="coachId" class="">
								<option value="" selected="selected">請選擇授課老師</option>
								<c:forEach var="oneCoach" items="${coachList}">
									<option value="${oneCoach.coachId}">${oneCoach.coachName}</option>
								</c:forEach>
							</select> <input style = "color:black" class="" type="button" value="查詢"
								onclick='sendQuery(1)'>
						</form>
					</fieldset>
				</div>
				<div class="col-md-4"></div>
			</div>
			</div>
			<div class="row">
				<div class="container">
				<div class="col-md-1"></div>
					<div class="col-md-7">
						<table class="table table-bordered" id="showcourse" border="1"></table>
						<table class="table">
							<tr>
								<td id="showpageInfo"></td>
								<td id="showpageButton" style="float : right"></td>
							</tr>
						</table>
					</div>
					<div class="col-md-3">
						<div class="content-widget top-story" style="background-color:rgba(255,255,255,0.2)">
							<div class="top-stroy-header" style="background-color:rgba(255,255,255,0.2)">
								<h2 style="color:white">
									課程介紹<a href="#" class="fa fa-fa fa-angle-right" ></a>
								</h2>
								<span class="date"></span>
								<br>
							</div>
							<ul class="other-stroies" id='showInformation'></ul>
						</div>
						
						
<!-- 模態框（Modal） --> 
 <h2 > 模態框（Modal）插件事件 </h2 > 
 <!-- 按鈕觸發模態框 --> 
 <button  class = "btn btn-primary btn-lg"   data-toggle = "modal"  data-target = "#myModal" > 開始演示模態框 </button > 
 <!-- 模態框（Modal） --> 
 <div   class = "modal fade"   id = "myModal"   tabindex = " -1 "   role = "dialog"   aria-labelledby = " myModalLabel "   aria-hidden = " true " > 
     <div   class = "modal-dialog" > 
         <div   class = "modal-content" > 
             <div   class = "modal-header" > 
                 <button  type = "button"   class = "close"   data-dismiss = "modal"  aria-hidden = "true" > × </button > 
                 <h4  class = "modal-title"   id = "myModalLabel" > 模態框（Modal）標題 </h4 > 
             </div > 
             <div   class = "modal-body" > 按下ESC按鈕退出。 </div > 
             <div   class = "modal-footer" > 
                 <button  type = "button"   class = " btn btn-default "   data-dismiss = " modal " > 關閉 </button > 
                 <button  type = "button"   class = " btn btn-primary " > 提交更改 </button > 
             </div > 
         </div > <!-- /.modal-content --> 
     </div > <!-- /.modal-dialog --> 
 </div > 

						
					</div>
				<div class="col-md-1"></div>
				</div>
			</div>




	<c:import url="/bottom"></c:import>
</body>
</html>