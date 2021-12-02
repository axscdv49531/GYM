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
   
   function selectCourse(courseId,stuNum,maxStuNum){	  
	if(confirm("確實要加選"+courseId+"嗎?")){
		if(stuNum>=maxStuNum){ //檢查選課人數
			alert(courseId+":課程已額滿");
		}else{
			$.ajax({
				   type:'get',
				   url:'/membercourse/selectcourse.controller/' + courseId, 
				   dataType:'JSON',
				   contentType:'application.json',
				   success: function(data){
						alert("已經加選"+courseId+"！"); 
				   }
				   });
		}
	}else{alert("已經取消加選"+courseId+"的操作");
			  }	
	} 
 		
   
   function load(indexPage){
	   $.ajax({
		   type:'post',
		   url:'/membercourse/queryByPage/' + indexPage, 
		  // url:'/course/findallcoures.controller',
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
				   table.append("<tr id='ptitle'><th>選課紀錄編號</th><th>課程名稱</th><th>課程總類</th><th></th><th>課程時間</th><th>教室編號</th><th>授課老師</th><th>目前學生人數</th><th>學生人數上限</th><th>課程狀態</th><th>查詢學生</th><th>修改</th><th>刪除</th></tr>");
				   
				   $.each(data, function(i,n){
					   var tr = "<tr align='center'>" + "<td>" + n.id + "</td>" +
					            "<td>" + n.courseName + "</td>" + "<td>" + n.category + "</td>" +
					            "<td>" + n.date + "</td>" + "<td>" + n.period + "</td>" + 
					            "<td>" + n.classroom + "</td>" + "<td>" + n.coach.coachName + "</td>" +"<td>" + n.studentNum + "</td>" +
					            "<td>" + n.maxStudentNum + "</td>" + "<td>" + n.state + "</td>"  +
					        	"<td><button id='' type='button' class='' onclick=''>課程簡介</button></td>"+
					        	"<td><button id='' type='button' class='' onclick='selectCourse(" + n.id + "," + n.studentNum + "," + n.maxStudentNum  + ")'>加選課程</button></td>"+
					            "</tr>";
					   table.append(tr);
				   });			   
			   }
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
	<br>
<a href="<c:url value='/' />">回首頁</a>
</body>
</html>