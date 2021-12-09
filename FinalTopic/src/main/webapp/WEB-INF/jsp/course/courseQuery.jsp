<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>課程管理系統</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
   var indexPage=1;
   var queryCondition = 'allCourse';
   var id_list;
  
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
 		window.location.reload();
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
		   table.append("<tr><th>課程編號</th><th>課程名稱</th><th>課程總類</th><th>日期</th><th>課程時間</th><th>教室編號</th><th>授課老師</th><th>目前學生人數</th><th>學生人數上限</th><th>課程狀態</th><th>查詢學生</th><th>修改</th><th>刪除</th><th>全選<input type='checkbox' id='all' value='' onclick='selectAll()'></th></tr>");
		   
		   $.each(data.pageContent, function(i,n){
			   
			   var tr = "<tr align='center'>" + "<td>" + n.id + "</td>" +
			            "<td>" + n.courseName + "</td>" + "<td>" + n.category + "</td>" +
			            "<td>" + n.date + "</td>" + "<td>" + n.period + "</td>" + 
			            "<td>" + n.classroom + "</td>" + "<td>" + n.coach.coachName + "</td>" +"<td>" + n.studentNum + "</td>" +
			            "<td>" + n.maxStudentNum + "</td>" + "<td>" + n.state + "</td>"  +
			        	//"<td><a href='/course/showStudentQuery.controller?courseId="+ n.id +"'><button id='' type='button' class='btn btn-danger'>查詢選課學生</button></a></td>"+
			        	"<td><button id='' type='button' class='btn btn-danger' onclick='showStudent(" + n.id + ")'>查詢選課學生</button></td>"+
			        	"<td><a href='/course/showUpdateForm.controller?courseId="+ n.id +"'><button id='' type='button' class='btn btn-danger'>修改</button></a></td>"+
			        	"<td><button id='' type='button' class='btn btn-danger' onclick='confirmDelete(" + n.id + ")'>刪除</button></td>"+
			        	"<td><input type='checkbox' value='(" + n.id + ")' name='id'></td>"+
			            "</tr>";
			   table.append(tr);
		   });

	   }
	   //////////

	   $('#showcourse').append("<tr id='showpage'></tr>")
	   
	   var tr2 ="<td colspan='9'>Total Pages: "+ data.totalPages +
		    " Total Records: "+data.totalElements+"</td>";
	   
	   $('#showpage').empty("");
	   $('#showpage').append(tr2);
	   $('#showpage').append("<td id='showbutton' colspan='4'></td>")
	   $('#showbutton').append("<button class='btn btn-danger btn btn-danger-danger' onclick='previous()'>Previous</button>");
	   
	   for(var j=1 ; j <= data.totalPages; j++){
		   $('#showbutton').append("<button id='myPage' value='"+j+"' class='btn btn-danger' onclick='change("+j+")'>"+j+"</button>")
	   }
	   
	   $('#showbutton').append("<button id='nextbutton' class='btn btn-danger' value='" + data.totalPages + "' onclick='next()'>Next</button>");
	
	   
	   $('#showpage').append("<td colspan='1'><button id='deleteinBatch' class='btn btn-danger' onclick='deleteinBatch()'>批量删除</button></td>");

   }
//批量刪除//////////

//全選
function selectAll(){
	 var id_list=document.getElementsByName("id");//获取勾选的标签
	 var all_list=document.getElementById("all");;//获取批量操作 标签
	 console.log(id_list)
	 for(let i = 0 ; i<id_list.length;i++){
			//所有的选择框和全选一致
			id_list[i].checked=all_list.checked;
		}
	 
// 	//点击复选框
// 	 for(var i=0;i<id_list.length;i++){
// 	     id_list[i].οnclick=function(){
// 	         //判断是否全部选中,遍历集合
// 	         for(var j=0;j<id_list.length;j++){
// 	           if(id_list[j].checked==false){
// 	             all_list.checked=false;
// 	             break;
// 	           }else{
// 	             all_list.checked=true;
// 	           }
// 	         }
// 	     };
// 	 }
	 
}

/*批量删除*/
function deleteinBatch(){
	console.log("heeeeelloo")
	var ids="";
   	 var id_list=document.getElementsByName("id");//获取勾选的标签
   	 console.log(id_list)
    var n=0;
        //拼接出一个名为ids_list的数组ids_list=1&ids_list=2&ids_list=3&ids_list=4……
        
     for(let i=0 ; i<id_list.length ; i++){
            if(id_list[i].checked==true){//选中为true
                var id = id_list[i].value.substring(1,id_list[i].value.length-1);
            //console.log(typeof(id))
                if(n==0){
                    //ids_list+="ids_list="+id;
                    ids+=id;
                }else{
                    //ids_list+="&ids_list="+id;
                    ids+=","+id;
                }
                n++;
            }
        }
       console.log(ids)

     if(confirm("確實要刪除嗎?")){
    	 var idsJSON = { 'ids' : ids };
    	 console.log(idsJSON)
    		$.ajax({
   			   type:'delete',
   			   url:'/course/deleteinbatch.controller', 
   			  data:idsJSON,
   			   dataType:'JSON',
   			   contentType:'application/x-www-form-urlencoded;charset=utf-8',
   			   success: function(data){
   				 //console.log(data);
   					alert("已經刪除！"); 
   					window.location.reload();
   			   }
   			   });
    	 window.location.reload();
   	}else{
   		alert("已經取消刪除的操作");
   		  }	    
   

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
						        	"<td><a href='/course/showUpdateForm.controller?courseId="+ n.id +"'><button id='' type='button' class='btn btn-danger'>修改</button></a></td>"+
						        	"<td><button id='' type='button' class='btn btn-danger' onclick='confirmDelete(" + n.id + ")'>刪除</button></td>"+
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
	<a href="<c:url value='/allCoursePdf' />"><button class='btn btn-danger'>下載所有課程資訊</button></a>
	</div>
	<br>
		
<div>
<fieldset>	
	<legend>課程查詢表單</legend>
		<a href="<c:url value='/thisweekcourse' />">本週課程</a>		
		<button class='btn btn-danger' onclick='todayCourse(1)'>當日課程</button>
		<button class='btn btn-danger' onclick='showAllCourse(1)'>查詢所有課程</button>
		
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
	
	<input type="button" class='btn btn-danger' value="查詢" onclick='sendQuery(1)'>
	
</form>
</fieldset>

</div>
	
	
<div class="row">
      <div class="col-md-12">
         <div class="card strpied-tabled-with-hover">
              <div class="card-header ">
                 <h4 class="card-title">課程總列表</h4>
                 <p class="card-category">依照日期順序排列</p>
              </div>
              <div class="card-body table-full-width table-responsive">
              	<table id="showcourse" class="table table-hover table-striped"></table>
              </div>
          </div>
    	</div>
    
	
	<div class="col-md-12">
       <div class="card card-plain table-plain-bg">
            <div class="card-header ">
               <h4 class="card-title">課程學生列表</h4>
                <p class="card-category">顯示該課程學生清單</p>
            </div>
        	<div class="card-body table-full-width table-responsive">
            	<table id="showstudent" class="table table-hover"></table>
			</div>
       </div>
    </div>
	
</div>



<!--                 裡面寫東西：結束 -->

           </div>
            </div>
      </div>
</div>

<script>

</script>


</body>
</html>