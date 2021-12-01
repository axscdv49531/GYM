<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>課程學生列表</title>
<link rel="stylesheet" href="/css/coursesystem.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
 
   var courseId =${courseId}
   console.log("課程編號："+courseId);
  
   $(document).ready(function(){
	   load(courseId);
   });


   
   function load(courseId){
	   $.ajax({
		   type:'get',
		   url:'/course/querystudent.controller/' + courseId,
		   dataType:'JSON',
		   contentType:'application/json;charset=utf-8',
		   success: function(data){
			   
			  // console.log('success:' + data);
			  // var json = JSON.stringify(data,null,4);
			   //console.log('json:' + json);
			   
				$('#showstudent').empty("");
				   
				   if(data==null){
					   alert("無符合查詢結果！");
					   $('#showstudent').append("<tr><td colspan='2'>暫無資料</td></tr>");;
				   }else{
					   var stuTable = $('#showstudent');
					   stuTable.append("<tr id='ptitle'><th>學生編號</th><th>學生名稱</th><th>學生性別</th><th>學生電話</th><th>學生信箱</th><th>緊急聯絡人</th><th>緊急聯絡人電話</th><th>修改</th><th>刪除</th></tr>");
					   
					   $.each(data, function(i,n){
						   
						  // if()
						   
						   var tr = "<tr align='center'>" + "<td>" + n.number + "</td>" +
						            "<td>" + n.name + "</td>" + "<td>" + n.gender + "</td>" +
						            "<td>" + n.phone + "</td>" + "<td>" + n.email + "</td>" + 
						            "<td>" + n.emergencyContact + "</td>" + "<td>" + n.emergencyPhone + "</td>" + 
						        	"<td><a href='/course/showUpdateForm.controller?courseId="+ n.id +"'><button id='' type='button' class=''>修改</button></a></td>"+
						        	"<td><a href='<c:url value=""/>'><button id='' type='button' class='' onclick='confirmDelete(" + n.id + ")'>刪除</button></a></td>"+
						            "</tr>";
						            stuTable.append(tr);
					   });
				   }
		   }
	   });
   }

</script>
</head>
<body>
	
	
	<header>
		<a href="<c:url value='/courseQuery' />">查詢課程</a>

		<a href="<c:url value='/' />">回首頁</a>
		<br>
	</header>
	
	<div id="productListTitle">課程學生列表</div>
	
<div>
</div>
	
	
	
	
	<table id="showstudent" border="1"></table>


	<br>
<a href="<c:url value='/' />">回首頁</a>
</body>
</html>