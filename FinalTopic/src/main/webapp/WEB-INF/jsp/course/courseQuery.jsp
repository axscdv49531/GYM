<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>課程管理系統</title>
<link rel="stylesheet" href="/css/coursesystem.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
   var indexPage=1;
   var queryCondition = 'allCourse';
  
   $(document).ready(function(){
	   showAllCourse(indexPage);
   });
   
   function change(page){
	   indexPage = page;
	   
	   if (queryCondition=='allCourse'){showAllCourse(indexPage)}
	   if (queryCondition=='todayCourse'){toadyCourse(indexPage)}
	   if (queryCondition=='queryForm'){sendQuery(indexPage);}
		  
   }
   function previous(){
	   if(indexPage>1){
		   indexPage--;
		   if (queryCondition=='allCourse'){showAllCourse(indexPage)}
		   if (queryCondition=='todayCourse'){toadyCourse(indexPage)}
		   if (queryCondition=='queryForm'){sendQuery(indexPage);}
	   }
   }
   
   function next(){
	   if(indexPage < $('#nextbutton').val()){
		  indexPage++;
		   if (queryCondition=='allCourse'){showAllCourse(indexPage)}
		   if (queryCondition=='todayCourse'){toadyCourse(indexPage)}
		   if (queryCondition=='queryForm'){sendQuery(indexPage);} 
	   }
	   
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
   

   
   //
 //共同使用的函式：將查詢課程結果印出  
function showCourseList(data){
	console.log('success:' + data);
	var json = JSON.stringify(data,null,4);
	console.log('json:' + json);
	//console.log(data.totalElements)
	
	//alert("查詢成功！");
	////////////
	$('#showcourse').empty("");
	$('#showpage').empty("");
	$('#showstudent').empty("");
	   
	   if(data.pageContent==null){
		   alert("無符合查詢結果！");
		   $('#showcourse').append("<tr><td colspan='2'>暫無資料</td></tr>");;
	   }else{
		   var table = $('#showcourse');
		   table.append("<tr id='ptitle'><th>課程編號</th><th>課程名稱</th><th>課程總類</th><th>日期</th><th>課程時間</th><th>教室編號</th><th>授課老師</th><th>目前學生人數</th><th>學生人數上限</th><th>課程狀態</th><th>查詢學生</th><th>修改</th><th>刪除</th></tr>");
		   
		   $.each(data.pageContent, function(i,n){
			   
			   var tr = "<tr align='center'>" + "<td>" + n.id + "</td>" +
			            "<td>" + n.courseName + "</td>" + "<td>" + n.category + "</td>" +
			            "<td>" + n.date + "</td>" + "<td>" + n.period + "</td>" + 
			            "<td>" + n.classroom + "</td>" + "<td>" + n.coach.coachName + "</td>" +"<td>" + n.studentNum + "</td>" +
			            "<td>" + n.maxStudentNum + "</td>" + "<td>" + n.state + "</td>"  +
			        	//"<td><a href='/course/showStudentQuery.controller?courseId="+ n.id +"'><button id='' type='button' class=''>查詢選課學生</button></a></td>"+
			        	"<td><button id='' type='button' class=''onclick='showStudent(" + n.id + ")'>查詢選課學生</button></td>"+
			        	"<td><a href='/course/showUpdateForm.controller?courseId="+ n.id +"'><button id='' type='button' class=''>修改</button></a></td>"+
			        	"<td><button id='' type='button' class='' onclick='confirmDelete(" + n.id + ")'>刪除</button></td>"+
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

   
//多條件查詢   
function sendQuery(indexPage){
	
	queryCondition = 'queryForm';
	
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
			showCourseList(data);
		}
	});		 
}


//查詢當日課程 
function todayCourse(indexPage){
	
	queryCondition = 'todayCourse';
	
	var today = new Date();
	var month = today.getMonth()+1;
	var todaystr = today.getFullYear() +"-"+ month+"-"+today.getDate();
	console.log(todaystr);
	var params = {
			"date":todaystr
        }
	$.ajax({
		type:'post',
		url:'/course/sendqueryform.controller/'+indexPage, 
		data:JSON.stringify(params),
		dataType:'JSON',
		contentType:'application/json;charset=utf-8',
		success: function(data){
			showCourseList(data);
		}
	});	
}
//查詢所有課程
function showAllCourse(indexPage){
	
	queryCondition = 'allCourse';
	var params = {};
	$.ajax({
		type:'post',
		url:'/course/sendqueryform.controller/'+indexPage, 
		data:JSON.stringify(params),
		dataType:'JSON',
		contentType:'application/json;charset=utf-8',
		success: function(data){
			showCourseList(data);
		}
	});	
}

function showStudent(courseId){
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
						        	"<td><button id='' type='button' class='' onclick='confirmDelete(" + n.id + ")'>刪除</button></td>"+
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

<div class="wrapper">
       <c:import url="/adminsidebar"></c:import> 
        <div class="main-panel">
     		<c:import url="/adminnavbar"></c:import> 
            <div class="content">
                <div class="container-fluid">
<!--                 裡面寫東西：開始 -->

	<header>
		<a href="<c:url value='/courseQuery' />">查詢所有課程(作廢)</a>
		<a href="<c:url value='/courseform' />">新增課程</a>
		<br>
	</header>
	
	<div id="productListTitle">Course Query</div>
	
	<div>
	<a href="<c:url value='/allCoursePdf' />"><button>下載所有課程資訊</button></a>
	</div>
	<br>
		
<div>
<fieldset>	
	<legend>課程查詢表單</legend>
		<a href="<c:url value='/thisweekcourse' />">本週課程</a>		
		<button onclick='todayCourse(1)'>當日課程</button>
		<button onclick='showAllCourse(1)'>查詢所有課程</button>
		
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
			<option  value="${oneCoach.coachId}" >${oneCoach.coachName}</option>
		</c:forEach>
	</select>
	
	<input type="button" value="查詢" onclick='sendQuery(1)'>
	
</form>
</fieldset>

</div>
	
	<table id="showcourse" border="1"></table>
	<table><tr id="showpage"></tr></table>
	<table id="showstudent" border="1"></table>
	<br>


<!--                 裡面寫東西：結束 -->

           </div>
            </div>
      </div>
</div>
</body>
</html>