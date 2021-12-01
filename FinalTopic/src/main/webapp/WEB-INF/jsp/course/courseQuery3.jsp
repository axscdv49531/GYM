<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product List</title>
<link rel="stylesheet" href="/css/coursesystem.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
   var indexPage=1;
  
   $(document).ready(function(){
	   //load(indexPage);
	   //sendQuery();
   });
   
   function change(page){
	   indexPage = page;
	   //load(indexPage);
	   sendQuery();
   }
   
  
   function confirmDelete(courseId){	  
	if(confirm("確實要刪除"+courseId+"嗎?")){
 		$.ajax({
			   type:'delete',
			   url:'/course/deletecourse.controller/' + courseId, 
			   dataType:'JSON',
			   contentType:'application/json;charset=utf-8',
			   success: function(data){
					alert("已經刪除"+courseId+"！"); 
			   }
			   });
	}else{
		alert("已經取消刪除"+courseId+"的操作");
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
//多條件查詢   
function sendQuery(){
	var formArray = $("form").serializeArray()
	var json = arrayToJson(formArray);
	console.log(formArray);
	console.log("json:"+json);
	$.ajax({
		type:'post',
		url:'/course/sendqueryform.controller/'+indexPage, 
		data:json,
		dataType:'JSON',
		contentType:'application/json;charset=utf-8',
		success: function(data){
			
			console.log('success:' + data);
			var json = JSON.stringify(data,null,4);
			console.log('json:' + json);
			//console.log(data.totalElements)
			
			alert("查詢成功！");
			////////////
			$('#showcourse').empty("");
			   
			   if(data==null){
				   alert("無符合查詢結果！");
				   $('#showcourse').append("<tr><td colspan='2'>暫無資料</td></tr>");;
			   }else{
				   var table = $('#showcourse');
				   table.append("<tr id='ptitle'><th>課程編號</th><th>課程名稱</th><th>課程總類</th><th>日期</th><th>課程時間</th><th>教室編號</th><th>授課老師</th><th>目前學生人數</th><th>學生人數上限</th><th>課程狀態</th><th>查詢學生</th><th>修改</th><th>刪除</th></tr>");
				   
				   $.each(data, function(i,n){
					   
					   var tr = "<tr align='center'>" + "<td>" + n.id + "</td>" +
					            "<td>" + n.courseName + "</td>" + "<td>" + n.category + "</td>" +
					            "<td>" + n.date + "</td>" + "<td>" + n.period + "</td>" + 
					            "<td>" + n.classroom + "</td>" + "<td>" + n.coach.coachName + "</td>" +"<td>" + n.studentNum + "</td>" +
					            "<td>" + n.maxStudentNum + "</td>" + "<td>" + n.state + "</td>"  +
					        	"<td><a href='/course/showStudentQuery.controller?courseId="+ n.id +"'><button id='' type='button' class=''>查詢選課學生</button></a></td>"+
					        	"<td><a href='/course/showUpdateForm.controller?courseId="+ n.id +"'><button id='' type='button' class=''>修改</button></a></td>"+
					        	"<td><a href='<c:url value=""/>'><button id='' type='button' class='' onclick='confirmDelete(" + n.id + ")'>刪除</button></a></td>"+
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
	
	
	<header>
		<a href="<c:url value='/courseQuery' />">查詢所有課程(作廢)</a>
		<a href="<c:url value='/courseform' />">新增課程</a>
		<a href="<c:url value='/' />">回首頁</a>
		<br>
	</header>
	
	<div id="productListTitle">Course Query</div>
	
<div>
<fieldset>	
	<legend>課程查詢表單</legend>
		<a href="<c:url value='/thisweekcourse' />">本週課程</a>
		<a href="<c:url value='/todaycourse' />">當日課程</a>
		<button onclick='load(1)'>查詢所有課程</button>
		
	<br>
	<br>
	<form>

	<select name="category">
		<option value="" label="請選擇課程種類" selected="selected"></option>
		<option value="舞蹈類課程" >舞蹈類課程</option>
		<option value="瑜珈課程">瑜珈課程</option>
		<option  value="心肺肌力課程">心肺肌力課程</option>
		<option  value="其他">其他</option>
	</select>

	<select name="classroom">
		<option value="" label="請選擇教室"selected="selected"></option>
		<option  value="A" >A教室</option>
		<option value="B">B教室</option>
		<option  value="C">C教室</option>
	</select>
	
	<select name="date" >
		<option value="" label="請選擇課程日期" selected="selected"/>
		<c:forEach var="onedate" items="${dateList}">
			<option  value="${onedate}" >${onedate}</option>
		</c:forEach>
	</select>
	
	<select name="coachId">
		<option value="" label="請選擇授課老師" selected="selected"/>
		<c:forEach var="oneCoach" items="${coachList}">
			<option  value="${oneCoach.id}" >${oneCoach.coachName}</option>
		</c:forEach>
	</select>
	
	<input type="button" value="查詢" onclick='sendQuery()'>
	
	

</form>

</fieldset>


</div>
	
	
	
	
	<table id="showcourse" border="1"></table>
	<table id="showpage">

		<tr>
			<td>Total Pages:${totalPages} Total Records:${totalElements}</td>
			<td colspan="3" align="right">Previous 
			<c:forEach var="i"
					begin="1" end="${totalPages}" step="1">
					<button id="myPage" value="${i}" onclick="change(${i})">${i}</button>
			</c:forEach>Next
			</td>
		</tr>

	</table>
	<table id="showstudent" border="1"></table>
	<br>
<a href="<c:url value='/' />">回首頁</a>
</body>
</html>