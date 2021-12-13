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
			        	//"<td><a href='/course/showUpdateForm.controller?courseId="+ n.id +"'><button id='' type='button' class='btn btn-danger'>修改</button></a></td>"+
			        	"<td><button  class = 'btn btn-danger' data-target='#updatemyModal'  data-toggle = 'modal' onclick='showOnUpdateForm(" + n.id + ")'>修改</button></td>"+		
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
	
	var formArray = $("#queryForm").serializeArray()
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
					   stuTable.append("<tr id='ptitle'><th>學生編號</th><th>學生名稱</th><th>學生性別</th><th>學生電話</th><th>學生信箱</th><th>緊急聯絡人</th><th>緊急聯絡人電話</th></tr>");
					   
					   $.each(data, function(i,n){
						   
						  // if()
						   
						   var tr = "<tr align='center'>" + "<td>" + n.number + "</td>" +
						            "<td>" + n.name + "</td>" + "<td>" + n.gender + "</td>" +
						            "<td>" + n.phone + "</td>" + "<td>" + n.email + "</td>" + 
						            "<td>" + n.emergencyContact + "</td>" + "<td>" + n.emergencyPhone + "</td>" + 
						        	//"<td><a href='/course/showUpdateForm.controller?courseId="+ n.id +"'><button id='' type='button' class='btn btn-danger'>修改</button></a></td>"+
						        	//"<td><button id='' type='button' class='btn btn-danger' onclick='confirmDelete(" + n.id + ")'>刪除</button></td>"+
						            "</tr>";
						            stuTable.append(tr);
					   });
				   }
		   }
	   });
}

 
 
//今日日期
var todayISO = new Date().toISOString().slice(0,10);
var index=0;
var data=[
	{'courseName':'流行舞蹈','category':'舞蹈類課程','date':todayISO,'information':'流行街舞課程會由專業的舞蹈老師，先帶領學員暖身，用熱門流行舞曲、或是充滿感染力的節奏音樂，搭配身體律動、舞蹈基本動作反覆演練，達到熱身的效果。'},
	{'courseName':'正位瑜珈','category':'瑜珈課程','date':'2021-12-16','information':'正位瑜珈的理念是由國際瑜珈大師 lyengar 的瑜珈體位教學系統作為基礎，回歸身體的本位，利用最基本的水平正位來進行瑜珈體位法的技巧，達成端正姿態的效果。'},
	{'courseName':'階梯有氧','category':'心肺肌力課程','date':'2021-12-17','information':'階梯有氧運動具有高強度低衝擊的運動特性，階梯有氧運動與一般的有氧舞蹈最大的不同在於踏板的使用，藉由音樂的節奏達到流汗運動效果，運用階梯做有氧舞步變化。'},
	{'courseName':'飛輪進階','category':'其他','date':'2021-12-15','information':'課程中利用自身體重及啞鈴或者彈力繩等健身器材增加負重訓練，可以平衡飛輪課程較少鍛鍊的肌群，能改善心血管健康幫助全面體能提升，是一個全新思維、利用消耗能量系統轉換的高效能燃脂飛輪課程。'},
]


function quickInput(){
	//console.log(data[index].date);
	document.getElementById('courseName').value = data[index].courseName;
	document.getElementById('category').value = data[index].category;
	document.getElementById('date').value = todayISO;
	$('#period option[value="14:00-14:50"]').attr('selected', 'selected');
	$('#classroom option[value="A"]').attr('selected', 'selected');
	$('#coachId option[value=3]').attr('selected', 'selected');
	document.getElementById('studentNum').value = '0';
	document.getElementById('maxStudentNum').value = '20';
	document.getElementById('state').value = '即將開課';
	document.getElementById('information').value = data[index].information;
	index++;
    if (index >= data.length) {
    	index = 0 ;
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

   function insertCourse(){
	var formArray = $("#insertform").serializeArray()
	var json = arrayToJson(formArray);
	console.log(formArray);
	console.log("json:"+json);
	$.ajax({
		   type:'post',
		   url:'/course/insertcourse.controller', 
		   data:json,
		   dataType:'JSON',
		   contentType:'application/json;charset=utf-8',
		   success: function(data){
			   alert("新增成功");
			   //$('#insertsuccess').html("新增成功");
			   location.href = '/course/showcourseQuery.controller';
		   }
		});			   
	}
//更新資料：將選到的課程秀在modal表單上
   function showOnUpdateForm(courseId){
	   console.log(courseId)
	   $.ajax({
		   type:'get',
		   url:'/course/findcoursebyid.controller/'+courseId, 
		   dataType:'JSON',
		   contentType:'application/json;charset=utf-8',
		   success: function(course){
			   console.log(course.courseName);
			   var classroom = course.classroom;
			   console.log(classroom);
			   	$("#updateid").val(course.id);
			   	$("#updatecourseName").val(course.courseName);
			    $("#updatecategory option[value='"+course.category+"']").attr('selected', 'selected');
			    $("#updatedate").val(course.date);
			    $("#updateperiod option[value='"+course.period+"']").attr('selected', 'selected');
			    $("#updateclassroom option[value='"+course.classroom+"']").attr('selected', 'selected');
			    $("#updatecoachId option[value='"+course.coach.coachId+"']").attr('selected', 'selected');
			    $("#updatestudentNum").val(course.studentNum);
			    $("#updatemaxStudentNum").val(course.maxStudentNum);
			    $("#updatestate").val(course.state);
			    $("#updateinformation").val(course.information);
			   
		   }
		});	
   }
   
   
   
   function updateCourse(){
	var formArray = $("#updateform").serializeArray()
	var json = arrayToJson(formArray);
	console.log(formArray);
	console.log("json:"+json);
	$.ajax({
		   type:'post',
		   url:'/course/updatcourse.controller', 
		   data:json,
		   dataType:'JSON',
		   contentType:'application/json;charset=utf-8',
		   success: function(data){
			   //console.log(data);
			   alert("更新成功");
			   //$('#insertsuccess').html("更新成功");
			   location.href = '/course/showcourseQuery.controller';
		   }
		});			   
	}
   <!-- /.modal 模態框--> 
   $(function() { $('#insertmyModal').modal('hide') } ); 
   $(function() { $('#updatemyModal').modal('hide') } ); 
   //$(function() { $('#myModal').on('hide.bs.modal', function() { alert('嘿，我聽說您喜歡模態框...'); }) });
   
</script>
</head>
<body>




<div class="wrapper">
<%--        <c:import url="/adminsidebar"></c:import>  --%>
       <c:import url="/adminCoursesidebar"></c:import> 
        <div class="main-panel">
     		<c:import url="/adminnavbar"></c:import> 
            <div class="content">
                <div class="container-fluid">
<!--     !!!!!!!!!!!!!!!!!!!!!!!!!!!!            裡面寫東西：開始 !!!!!!!!!!!!!!!!!!!!!!!!!-->


 <!-- 新增課程：模態框（Modal） -->
 <div   class = "modal fade text-center"   id = "insertmyModal"   tabindex = " -1 "   role = "dialog"   aria-labelledby = " myModalLabel "   aria-hidden = " true " > 
     <div   class = "modal-dialog" style="width:Auto; margin-top: -200px"> 
         <div   class = "modal-content" style="width:500px ; text-align:center"> 
             <div   class = "modal-header" > 
                 <button  type = "button"   class = "close"   data-dismiss = "modal"  aria-hidden = "true" > × </button> 
                 <h4 class = "modal-title"   id = "myModalLabel" > 新增課程 </h4> 
             </div > 
             <div class = "modal-body" > 
             <form id="insertform">
             	<table style="border-collapse: separate; border-spacing:0 10px;">
					<tr>
						<td align='right'>課程名稱：
						</td>
						<td><input name="courseName" id="courseName" class="form-control"/></td>
					</tr>

					<tr>
						<td align='right'>課程總類：</td>
						<td><select name="category" id="category" class="form-control">
								<option value="NOENE" label="請選擇課程種類"></option>
								<option value="舞蹈類課程">舞蹈類課程</option>
								<option value="瑜珈課程">瑜珈課程</option>
								<option  value="心肺肌力課程">心肺肌力課程</option>
								<option  value="其他">其他</option>
							</select> </td>
					</tr>

					<tr>
						<td align='right'>日期：</td>
						<td><input type ="date" name="date" id="date" class="form-control"/> </td>
					</tr>

					<tr>
						<td align='right'>課程時間：
						</td>
						<td><select name="period" id="period" class="form-control">
								<option value="NONE" label="請選擇上課時段"></option>
								<option  value="09:00-09:50">09:00-09:50</option>
								<option  value="10:00-10:50">10:00-10:50</option>
								<option  value="11:00-11:50">11:00-11:50</option>
								<option  value="12:00-12:50">12:00-12:50</option>
								<option  value="13:00-13:50">13:00-13:50</option>
								<option  value="14:00-14:50">14:00-14:50</option>
								<option  value="15:00-15:50">15:00-15:50</option>
								<option  value="16:00-16:50">16:00-16:50</option>
								<option  value="17:00-17:50">17:00-17:50</option>
								<option  value="18:00-18:50">18:00-18:50</option>
								<option  value="19:00-19:50">19:00-19:50</option>
								<option  value="20:00-20:50">20:00-20:50</option>
								<option  value="21:00-21:50">21:00-21:50</option>
							</select> </td>
					</tr>

					<tr>
						<td align='right'>教室編號:</td>
						<td><select name="classroom" id="classroom" class="form-control">
								<option value="NOENE" label="請選擇教室"></option>
								<option  value="A">A教室</option>
								<option value="B">B教室</option>
								<option  value="C">C教室</option>
							</select> </td>
					</tr>

					<tr>
						<td align='right'>授課老師編號:</td>
						<td><select name="coachId" id="coachId" class="form-control">
								<option value="NONE" label="請選擇授課老師" />
								<c:forEach var="oneCoach" items="${coachList}">
									<option  value="${oneCoach.coachId}">${oneCoach.coachName}</option>
								</c:forEach>
							</select> </td>

					</tr>

					<tr>
						<td align='right'>目前學生人數：</td>
						<td><input name="studentNum" id="studentNum" class="form-control"/></td>
					</tr>

					<tr>
						<td align='right'>學生人數上限：</td>
						<td><input name="maxStudentNum" id="maxStudentNum" class="form-control"/> 
						</td>
					</tr>

					<tr>
						<td align='right'>課程狀態：
						</td>
						<td><input name="state" id="state" value="即將開課" class="form-control"/> </td>
					</tr>
					
					<tr>
						<td align='right'>課程介紹：<br>&nbsp;
						</td>
						<td><textarea style="height:100%;" rows='10' name="information" id="information" class="form-control"></textarea></td>

					</tr>
					<tr>
					<td colspan='2' align='center'>
						<button  type = "button"   class = "btn btn-danger"   data-dismiss = "modal" aria-hidden = "true"> 關閉 </button>
						<input type="button"  class="btn btn-danger" value='新增課程' onclick="insertCourse()" >
						<input type="button" class="btn btn-danger" value="一鍵輸入" onclick='quickInput()'>
					</td>
					</tr>

				</table>
				</form>
             </div > 
         </div > 
     </div > 
 </div > 
<!-- 新增課程：模態框（Modal-->

<!-- 更新課程：模態框（Modal-->
<div   class = "modal fade text-center"   id = "updatemyModal"   tabindex = " -1 "   role = "dialog"   aria-labelledby = " myModalLabel "   aria-hidden = " true " > 
     <div   class = "modal-dialog" style="width:Auto; margin-top: -200px"> 
         <div   class = "modal-content" style="width:500px ; text-align:center"> 
             <div   class = "modal-header" > 
                 <button  type = "button"   class = "close"   data-dismiss = "modal"  aria-hidden = "true" > × </button> 
                 <h4 class = "modal-title"   id = "myModalLabel" > 更新課程 </h4> 
             </div > 
             <div class = "modal-body" > 
           <form id="updateform">
             	<table style="border-collapse: separate; border-spacing:0 10px;">
             	<input type = "hidden" name="id" id="updateid" />
					<tr>
						<td align='right'>課程名稱：
						</td>
						<td><input name="courseName" id="updatecourseName" class="form-control"/></td>
					</tr>

					<tr>
						<td align='right'>課程總類：</td>
						<td><select name="category" id="updatecategory" class="form-control">
								<option value="NOENE" label="請選擇課程種類"></option>
								<option value="舞蹈類課程">舞蹈類課程</option>
								<option value="瑜珈課程">瑜珈課程</option>
								<option  value="心肺肌力課程">心肺肌力課程</option>
								<option  value="其他">其他</option>
							</select> </td>
					</tr>

					<tr>
						<td align='right'>日期：</td>
						<td><input type ="date" name="date" id="updatedate" class="form-control"/> </td>
					</tr>

					<tr>
						<td align='right'>課程時間：
						</td>
						<td><select name="period" id="updateperiod" class="form-control">
								<option value="NONE" label="請選擇上課時段"></option>
								<option  value="09:00-09:50">09:00-09:50</option>
								<option  value="10:00-10:50">10:00-10:50</option>
								<option  value="11:00-11:50">11:00-11:50</option>
								<option  value="12:00-12:50">12:00-12:50</option>
								<option  value="13:00-13:50">13:00-13:50</option>
								<option  value="14:00-14:50">14:00-14:50</option>
								<option  value="15:00-15:50">15:00-15:50</option>
								<option  value="16:00-16:50">16:00-16:50</option>
								<option  value="17:00-17:50">17:00-17:50</option>
								<option  value="18:00-18:50">18:00-18:50</option>
								<option  value="19:00-19:50">19:00-19:50</option>
								<option  value="20:00-20:50">20:00-20:50</option>
								<option  value="21:00-21:50">21:00-21:50</option>
							</select> </td>
					</tr>

					<tr>
						<td align='right'>教室編號:</td>
						<td><select name="classroom" id="updateclassroom" class="form-control">
								<option value="NOENE" label="請選擇教室"></option>
								<option  value="A">A教室</option>
								<option value="B">B教室</option>
								<option  value="C">C教室</option>
							</select> </td>
					</tr>

					<tr>
						<td align='right'>授課老師編號:</td>
						<td><select name="coachId" id="updatecoachId" class="form-control">
								<option value="NONE" label="請選擇授課老師" />
								<c:forEach var="oneCoach" items="${coachList}">
									<option  value="${oneCoach.coachId}">${oneCoach.coachName}</option>
								</c:forEach>
							</select> </td>

					</tr>

					<tr>
						<td align='right'>目前學生人數：</td>
						<td><input name="studentNum" id="updatestudentNum" class="form-control"/></td>
					</tr>

					<tr>
						<td align='right'>學生人數上限：</td>
						<td><input name="maxStudentNum" id="updatemaxStudentNum" class="form-control"/> 
						</td>
					</tr>

					<tr>
						<td align='right'>課程狀態：
						</td>
						<td><input name="state" id="updatestate" value="即將開課" class="form-control"/> </td>
					</tr>
					
					<tr>
						<td align='right'>課程介紹：<br>&nbsp;
						</td>
						<td><textarea style="height:100%;" rows='10' name="information" id="updateinformation" class="form-control"></textarea></td>

					</tr>
					<tr>
					<td colspan='2' align='center'>
						<button  type = "button"   class = "btn btn-danger"   data-dismiss = "modal" aria-hidden = "true"> 關閉 </button>
						<input type="button"  class="btn btn-danger" value='更新課程' onclick="updateCourse()" >
					</td>
					</tr>

				</table>
				</form>
             </div > 
         </div > 
     </div > 
 </div > 

<!-- 更新課程：模態框（Modal)  結束-->



	<div>
	 	<!-- 按鈕觸發模態框  -->
 		<button  class = "btn btn-primary "   data-toggle = "modal"  data-target = "#insertmyModal" > 新增課程 </button> 
		<a href="<c:url value='/allCoursePdf' />"><button class='btn btn-primary'>下載所有課程資訊</button></a>
	</div>
	<br>
		
<div class="form-inline">
<fieldset>	
	<legend>課程查詢表單</legend>
<%-- 		<a href="<c:url value='/thisweekcourse' />">本週課程</a>		 --%>
		<button class='btn btn-danger' onclick='todayCourse(1)'>當日課程</button>
		<button class='btn btn-danger' onclick='showAllCourse(1)'>查詢所有課程</button>
		
	<br>
	<br>
<!-- 多條件查詢表單  -->
	<form id="queryForm">
	<select name="category" class="form-control">
		<option value="" label="請選擇課程種類" selected="selected"></option>
		<option value="舞蹈類課程" >舞蹈類課程</option>
		<option value="瑜珈課程">瑜珈課程</option>
		<option  value="心肺肌力課程">心肺肌力課程</option>
		<option  value="其他">其他</option>
	</select>

	<select name="classroom" class="form-control">
		<option value="" label="請選擇教室"selected="selected"></option>
		<option  value="A" >A教室</option>
		<option value="B">B教室</option>
		<option  value="C">C教室</option>
	</select>
	
	<select name="date" class="form-control">
		<option value="" label="請選擇課程日期" selected="selected"/>
		<c:forEach var="onedate" items="${dateList}">
			<option  value="${onedate}" >${onedate}</option>
		</c:forEach>
	</select>
	
	<select name="coachId" class="form-control">
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