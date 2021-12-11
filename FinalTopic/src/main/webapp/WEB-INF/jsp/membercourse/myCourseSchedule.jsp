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
	
	
	
	
<script type="text/javascript">
var indexPage = 1;
var queryCondition = 'allCourse';

$(document).ready(function() {
	showMyCourse(indexPage);
});

function change(page) {
	indexPage = page;

	if (queryCondition == 'allCourse') {
		showMyCourse(indexPage)
	}
	

}
function previous() {
	if (indexPage > 1) {
		indexPage--;
			showMyCourse(indexPage)
		
	}
}

function next() {
	if (indexPage < $('#nextbutton').val()) {
		indexPage++;
			showMyCourse(indexPage)
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
		   table.append("<tr id='ptitle'><th>課程編號</th><th>課程名稱</th><th>課程總類</th><th>日期</th><th>課程時間</th><th>教室編號</th><th>授課老師編號:</th><th>目前學生人數</th><th>學生人數上限</th><th>課程簡介</th><th>退選</th></tr>");
		   
		   $.each(data.pageContent, function(i,n){
			   var tr = "<tr align='center'>" + "<td>" + n.id + "</td>" +
			            "<td>" + n.courseName + "</td>" + "<td>" + n.category + "</td>" +
			            "<td>" + n.date + "</td>" + "<td>" + n.period + "</td>" + 
			            "<td>" + n.classroom + "</td>" + "<td>" + n.coach.coachName + "</td>" +"<td>" + n.studentNum + "</td>" +
			            "<td>" + n.maxStudentNum + "</td>" +
			            "<td><button id='' type='button' class='btn' onclick='showInformation(" + n.id + "," + n.coach.coachId+ ")'>課程簡介</button></td>"+
			        	"<td><button id='' type='button' class='btn' onclick='dropCourse(" + n.id +")'>退選課程</button></td>"+
			            "</tr>";
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
					"<button style='float: right;' class='btn' onclick='previous()'>Previous</button>");

	for (var j = 1; j <= data.totalPages; j++) {
		$('#showpageButton').append(
				"<button style='float: right;' class='btn' id='myPage' value='"
						+ j + "' onclick='change(" + j + ")'>" + j
						+ "</button>")
	}

	$('#showpageButton').append(
			"<button style='float: right;' class='btn' id='nextbutton' value='"
					+ data.totalPages + "' onclick='next()'>Next</button>");

}

//查詢我的課程 
function showMyCourse(indexPage) {

	$.ajax({
		type : 'get',
		url : '/course/findbymember.controller/' + indexPage,
		dataType : 'JSON',
		contentType : 'application/json;charset=utf-8',
		success : function(data) {
			console.log("success");
			showCourseList(data);
		}
	});
}

function showInformation(courseId,coachId) {
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
	$.ajax({
        type:'get',
        url:'/course/showonecoach/'+coachId,
        dataType:'JSON',
        contentType:'application/json',
        success: function(onecoach){
            
            console.log('success:' + onecoach);
            var json = JSON.stringify(onecoach,null,4);
            console.log('json:' + json);
            
            $('#showCoach').empty("");
            $('#showCoach').append("<table><tr>"+onecoach.coachName+"</tr><tr><td id='showCoachPic' style='width:250px;'></td><td id='showCoachInfo'></td></tr></table>");
            $('#showCoachPic').append("<img class='img-responsive' src=" + "<c:url value='/administrator/getCoachPicture?coachAccount=' />" + onecoach.coachAccount + " style='width:220px; text-align:right'>");
            $('#showCoachInfo').append("<tr><td>性別: "+onecoach.coachGender+"</td></tr>"
            							  +"<tr><td>教學資歷: "+onecoach.coachExp+" 年</td></tr>"
            							  //+"<tr><td>教練專長: "+onecoach.coachExp+" 年</td></tr>"
            )   
            
					}
                });
	//load(indexPage);
}
 
   function dropCourse(courseId){	  
	if(confirm("確實要退選"+courseId+"嗎?")){

			$.ajax({
				   type:'get',
				   url:'/membercourse/dropcourse.controller/' + courseId, 
				   dataType:'JSON',
				   contentType:'application.json',
				   success: function(data){
						alert("已經退選"+courseId+"！"); 
						load(indexPage);
				   }
				   });
		
	}else{alert("已經取消退選"+courseId+"的操作");
			  }	
	} 
 	

//    function showInformation(courseId){
// 		 //alert(courseId);
// 		 $.ajax({
// 			   type:'get',
// 			   url:'/course/queryinformation.controller/' + courseId, 
// 			   dataType:'text',
// 			   contentType:'application/json',
// 			   success: function(str){

// 		 			$('#showInformation').empty("");
// 		 			$('#showInformation').append("課程簡介："+ str);
// 		 			//showAllCourse(indexPage);
// 			   }
// 		});
//    }
 
</script>

</head>
<body class="game-info">
	<div style="width: 1205px; height: 194.13px">
		<c:import url="/top_memberlogin"></c:import>
	</div>

		<div class="row" style="margin-left:15px;margin-top:100px">
			<div class="container">

				<div class="col-md-1"></div>
				<div  class="col-md-7">
				<fieldset>
				<legend>我的課表 / 即將開始的課程：</legend>
					<a href="<c:url value='/myCourseSchedulePdf' />"><button class='btn-warning'>下載我的課表</button></a>
				</fieldset>
				</div>
				<div class="col-md-4"></div>
			</div>
			</div>
			<div class="row" style="margin-left:15px;margin-top:30px">
				<div class="container">
				<div class="col-md-1"></div>
					<div class="col-md-7">
						<table class="table table-bordered" id="showcourse" border="1"></table>
						<table class="table">
							<tr>
								<td id="showpageInfo"></td>
								<td id="showpageButton" align="right"></td>
							</tr>
						</table>
					</div>
					<div class="col-md-3">
					 <div class="row">
						<div class="content-widget top-story" >
							<div class="top-stroy-header" >
								<h2 style="color:black">
									課程介紹<a href="#" class="fa fa-fa fa-angle-right" ></a>
								</h2>
								<span class="date"></span>
								<br>
							</div>
							<ul class="other-stroies" id='showInformation'></ul>
						</div>
					 </div>
						<div class="row">
							<div class="content-widget top-story" >
							<div class="top-stroy-header" >
								<h2 style="color:black">
									教練介紹<a href="#" class="fa fa-fa fa-angle-right" ></a>
								</h2>
								<span class="date"></span>
								<br>
							</div>
							<ul class="other-stroies" id='showCoach'></ul>
						</div>
						</div>
					</div>
				
				<div class="col-md-1"></div>
				</div>
			</div>

	<c:import url="/bottom"></c:import>
</body>
</html>