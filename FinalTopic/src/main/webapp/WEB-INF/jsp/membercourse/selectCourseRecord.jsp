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
	   showAllRecord(indexPage);
});

function change(page){
	   indexPage = page;
	   showAllRecord(indexPage);
}
function previous(){
	   if(indexPage>1){
		   indexPage--;
		   showAllRecord(indexPage)
	   }
}

function next(){
	   if(indexPage < $('#nextbutton').val()){
		  indexPage++;
		  showAllRecord(indexPage)
	   }
	   
}

   function arrayToJson(formArray){
		  var dataArray = {};
		  $.each(formArray,function(){
		    if(dataArray[this.name]){
		      if(!dataArray[this.name].push){
		        dataArray[this.name] = [dataArray[this.name]];
		      }
		      dataArray[this.name].push(this.value || '');
		    }else{
		      dataArray[this.name] = this.value || '';
		    }
		  });
		  return JSON.stringify(dataArray);
		}
	
   
   
   
 //共同使用的函式：將查詢課程結果印出  
   function showRecordList(data){
   	console.log('success:' + data);
   	var json = JSON.stringify(data,null,4);
   	console.log('json:' + json);
   	//console.log(data.totalElements)
   	
   	//alert("查詢成功！");
   	////////////
   	$('#showrecord').empty("");
   	   
   	   if(data.pageContent==null){
   		   alert("無符合查詢結果！");
   		   $('#showrecord').append("<tr><td colspan='2'>暫無資料</td></tr>");;
   	   }else{
		   var table = $('#showrecord');
		   table.append("<tr id='ptitle'><th>課程編號</th><th>課程名稱</th><th>課程總類</th><th>日期</th><th>課程時間</th><th>教室編號</th><th>授課老師</th><th>學生人數上限</th><th>課程狀態</th><th>紀錄時間</th><th>紀錄狀態</th></tr>");
		   
		   $.each(data.pageContent, function(i,n){
			   var tr = "<tr align='center'>" + 
			   			//"<td>" + n.course.id + "</td>" +
			            //"<td>" + n.course.courseName + "</td>" + "<td>" + n.course.category + "</td>" +
			            //"<td>" + n.course.date + "</td>" + "<td>" + n.course.period + "</td>" + 
			            //"<td>" + n.course.classroom + "</td>" + "<td>" + n.course.coach.coachName + "</td>" +"<td>" + n.course.maxStudentNum + "</td>" +
			            //"<td>" + n.course.state + 
			            "</td>" + "<td>" + n.selecttime + "</td>"  + "<td>" + n.state + "</td>"  +
			            "</tr>";
			   table.append(tr);
		   });	
   	   }
   	   //////////

   	   var tr2 ="<td>Total Pages: "+ data.totalPages +
   		    " Total Records: "+data.totalElements+"</td>";
   	   
   	   $('#showpage').empty("");
   	   $('#showpage').append(tr2);
   	   
   	   $('#showpage').append("<button onclick='previous()'>Previous</button>");
   	   
   	   for(var j=1 ; j <= data.totalPages; j++){
   		   $('#showpage').append("<button id='myPage' value='"+j+"' onclick='change("+j+")'>"+j+"</button>")
   	   }
   	   
   	   $('#showpage').append("<button id='nextbutton' value='" + data.totalPages + "' onclick='next()'>Next</button>");
   	
   }



   //查詢所有選課紀錄
   function showAllRecord(indexPage){
   	$.ajax({
   		type:'get',
   		url:'/membercourse/selectcourserecord.controller/'+indexPage, 
   		dataType:'JSON',
   		contentType:'application/json;charset=utf-8',
   		success: function(data){
   			showRecordList(data);
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
	
	
	<table id="showrecord" border="1"></table>
	

	<table><tr id="showpage"></tr></table>
	<br>

	
<a href="<c:url value='/' />">回首頁</a>
</body>
</html>