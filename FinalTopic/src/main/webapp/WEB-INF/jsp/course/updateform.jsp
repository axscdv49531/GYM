<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>更新課程</title>

<link rel="stylesheet" href="/css/coursesystem.css">
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">


$(document).ready(function(){
    $('#category option[value=${onecourse.category}]').attr('selected', 'selected');
    $('#period option[value="${onecourse.period}"]').attr('selected', 'selected');
    $('#classroom option[value=${onecourse.classroom}]').attr('selected', 'selected');
    $('#coachId option[value=${onecourse.coach.coachId}]').attr('selected', 'selected');

});


//function ResetForm(){
	 //$('#form1 input[name="courseID"]').attr("disabled",false);
	 //$('#form1').find(".form-control").val("").end().find(".form-select").val("");
//}



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

   function updateCourse(){
	var formArray = $("form").serializeArray()
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

</script>


</head>

<body>

<header>
	<a href="<c:url value='/courseQuery' />">查詢課程</a>
	<a href="<c:url value='/courseform' />">新增課程</a>
	<a href="<c:url value='/' />">回首頁</a>
	<br>
</header>

	<div align="center">
		<form id="form">
			<fieldset class="fieldset-auto-width">
				<legend>更新課程資料</legend>
				<table>
				
					<input type = "hidden" name="id" id="id" value="${onecourse.id}">
					<tr>
						<td align='right'>課程名稱：<br>&nbsp;
						</td>
						<td><input name="courseName" id="courseName" value="${onecourse.courseName}"/><br>&nbsp;</td>
					</tr>

					<tr>
						<td align='right'>課程總類：<br>&nbsp;
						</td>
						<td><select name="category" id="category">
								<option value="NOENE" label="請選擇課程種類"></option>
								<option value="舞蹈類課程">舞蹈類課程</option>
								<option value="瑜珈課程">瑜珈課程</option>
								<option  value="心肺肌力課程">心肺肌力課程</option>
								<option  value="其他">其他</option>
							</select> </td>
					</tr>

					<tr>
						<td align='right'>日期：<font size='-3' color='blue'>(yyyy-MM-dd)</font><br>&nbsp;
						</td>
						<td><input type ="date" name="date" id="date" value="${onecourse.date}" /><br>&nbsp; </td>
					</tr>

					<tr>
						<td align='right'>課程時間：: <br>&nbsp;
						</td>
						<td><select name="period" id="period">
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
						<td align='right'>教室編號:<br>&nbsp;
						</td>
						<td><select name="classroom" id="classroom">
								<option value="NOENE" label="請選擇教室"></option>
								<option  value="A">A教室</option>
								<option value="B">B教室</option>
								<option  value="C">C教室</option>
							</select> </td>
					</tr>

					<tr>
						<td align='right'>授課老師:：<br>&nbsp;
						</td>
						<td><select name="coachId" id="coachId">
								<option value="NONE" label="請選擇授課老師" />
								<c:forEach var="oneCoach" items="${coachList}">
									<option  value="${oneCoach.coachId}">${oneCoach.coachName}</option>
								</c:forEach>
							</select> </td>

					</tr>

					<tr>
						<td align='right'>目前學生人數：<br>&nbsp;
						</td>
						<td><input name="studentNum" id="studentNum" value="${onecourse.studentNum}"/><br>&nbsp; </td>
					</tr>

					<tr>
						<td align='right'>學生人數上限：<br>&nbsp;
						</td>
						<td><input name="maxStudentNum" id="maxStudentNum" value="${onecourse.maxStudentNum}"/><br>&nbsp; 
						</td>
					</tr>

					<tr>
						<td align='right'>課程狀態：<br>&nbsp;
						</td>
						<td><input name="state" id="state" value="${onecourse.state}" /><br>&nbsp; </td>
					</tr>

					<td colspan='2' align='center'><input type="button" value='更新課程' onclick="updateCourse()"></td>
					
				</table>
			</fieldset>
		</form>
		</div>
		<br> <a href="<c:url value='/' />">回首頁</a>


</body>
</html>