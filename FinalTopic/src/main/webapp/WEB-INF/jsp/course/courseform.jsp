<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增課程</title>

<link rel="stylesheet" href="/css/coursesystem.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

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
	var formArray = $("form").serializeArray()
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

   

   
</script>


</head>

<body>


<div class="wrapper">
<c:import url="/adminsidebar"></c:import> 
<div class="main-panel">
<c:import url="/adminnavbar"></c:import> 
<div class="content">
<div class="container-fluid">
<!-- 開始!!!!!!!!!!!!!!!!!!!!!!!!!裡面寫你自己的東西!!!!!!!!!!!!!!!!!!!!!!!!!! -->

<header>
	<a href="<c:url value='/courseQuery' />">查詢課程</a>
	<a href="<c:url value='/courseform' />">新增課程</a>
	<a href="<c:url value='/' />">回首頁</a>
	<br>
</header>

<div class="card">
   <div class="card-header">
        <h4 class="card-title">新增課程資料</h4>
   </div>
   <div class="card-body">
   
		<form id="form">
			<fieldset class="fieldset-auto-width">
<!-- 				<legend>課程資料</legend> -->
				<table>
					<tr>
						<td align='right'>課程名稱：
						</td>
						<td><input name="courseName" id="courseName" class="form-control"/></td>
					</tr>

					<tr>
						<td align='right'>課程總類：<br>&nbsp;
						</td>
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
								<option  value="09:00-10:00">09:00-09:50</option>
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
						<input type="button"  class="btn btn-danger" value='新增課程' onclick="insertCourse()" >
						<input type="button" class="btn btn-danger" value="一鍵輸入" onclick='quickInput()'>
					</td>
					</tr>
				</table>
				
				
			</fieldset>
		</form>

   </div>
</div>

<!-- 結束!!!!!!!!!!!!!!!!!!!!!!!!!裡面寫你自己的東西!!!!!!!!!!!!!!!!!!!!!!!!!! -->
</div>
</div>
</div>
</div>

</body>
</html>