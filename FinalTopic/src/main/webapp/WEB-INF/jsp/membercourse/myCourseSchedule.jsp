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

   var indexPage=1;
   $(document).ready(function(){
	   load(indexPage);
   });
   
   function change(page){
	   indexPage = page;
	   load(indexPage);
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
 	
   
   function load(indexPage){
	   $.ajax({
		   type:'get',
		   url:'/course/findbymember.controller', 
		   dataType:'JSON',
		   contentType:'application.json',
		   success: function(data){
			   
			  // console.log('success:' + data);
			  // var json = JSON.stringify(data,null,4);
			   //console.log('json:' + json);
			   
			   $('#showcourse').empty("");
			   
			   if(data==null){
				   $('table').prepend("<tr><td colspan='2'>暫無資料</td></tr>");;
			   }else{
				   var table = $('#showcourse');
				   table.append("<tr id='ptitle'><th>課程編號</th><th>課程名稱</th><th>課程總類</th><th>日期</th><th>課程時間</th><th>教室編號</th><th>授課老師編號:</th><th>目前學生人數</th><th>學生人數上限</th><th>課程簡介</th><th>退選</th></tr>");
				   
				   $.each(data, function(i,n){
					   var tr = "<tr align='center'>" + "<td>" + n.id + "</td>" +
					            "<td>" + n.courseName + "</td>" + "<td>" + n.category + "</td>" +
					            "<td>" + n.date + "</td>" + "<td>" + n.period + "</td>" + 
					            "<td>" + n.classroom + "</td>" + "<td>" + n.coach.coachName + "</td>" +"<td>" + n.studentNum + "</td>" +
					            "<td>" + n.maxStudentNum + "</td>" +
					            "<td><button id='' type='button' class='' onclick='showInformation(" + n.id + ")'>課程簡介</button></td>"+
					        	"<td><button id='' type='button' class='' onclick='dropCourse(" + n.id +")'>退選課程</button></td>"+
					            "</tr>";
					   table.append(tr);
				   });			   
			   }
		   }
	   });
   }
   
   function showInformation(courseId){
		 alert(courseId);
		 
		 $.ajax({
			   type:'get',
			   url:'/course/queryinformation.controller/' + courseId, 
			   dataType:'text',
			   contentType:'application/json',
			   success: function(str){

		 			$('#showInformation').empty("");
		 			$('#showInformation').append("課程簡介："+ str);
		 			//showAllCourse(indexPage);
			   }
		});
   }
   

</script>
</head>
<body>
	<div id="productListTitle">會員選課系統</div>
	
	
	<header>
		<a href="<c:url value='/courseSelectSystem' />">查詢所有課程</a>
		<a href="<c:url value='/selectCourseRecord' />">查詢選課紀錄</a>
		<a href="<c:url value='/myCourseSchedule' />">我的課表</a>
		<a href="<c:url value='/' />">回首頁</a>
		<br>
	</header>
	
	
	
	<table id="showcourse" border="1"></table>
	<table id="showpage">
		<tr>
			<td>Total Pages:${totalPages} Total Records:${totalElements}</td>
			<td colspan="3" align="right">Previous <c:forEach var="i"
					begin="1" end="${totalPages}" step="1">
					<button id="myPage" value="${i}" onclick="change(${i})">${i}</button>
				</c:forEach>Next
			</td>
		</tr>
	</table>
	<a href="<c:url value='/myCourseSchedulePdf' />"><button>下載我的課表</button></a>
	
	<br>
<a href="<c:url value='/' />">回首頁</a>
</body>
</html>