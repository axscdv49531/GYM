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


var index=0;
var data=[
	{'courseName':'流行舞蹈','category':'舞蹈類課程','date':'2021-12-16'},
	{'courseName':'伸展瑜珈','category':'瑜珈課程','date':'2021-12-18'},
	{'courseName':'階梯有氧','category':'心肺肌力課程','date':'2021-12-17'},
	{'courseName':'飛輪進階','category':'其他','date':'2021-12-15'},
]


function quickInput(){
	console.log(data[index])
	document.getElementById('courseName').value = data[index].courseName;
	document.getElementById('category').value = data[index].category;
	document.getElementById('date').value = data[index].date;
	$('#period option[value="14:00-14:50"]').attr('selected', 'selected');
	$('#classroom option[value="A"]').attr('selected', 'selected');
	$('#coachId option[value=3]').attr('selected', 'selected');
	document.getElementById('studentNum').value = '0';
	document.getElementById('maxStudentNum').value = '20';
	document.getElementById('state').value = '0';
	index++;
    if (index >= data.length) {
    	index = 0 ;
	}
}

/*
   function insertCourse(){
	   $.ajax({
		   type:'post',
		   url:'/course/insertcourse.controller', 
		   dataType:'JSON',
		   contentType:'application.json',
		   success: function(data){
			   
			   console.log('success:' + data);
			   var json = JSON.stringify(data,null,4);
			   console.log('json:' + json);
			   
			   $('#insertsuccess').append(data.courseName+"新增成功")
		   }
		});			   
	}

   
*/
   
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
		<form:form action="/course/insertcourse.controller" method='POST'
			modelAttribute="courseBean">

			<fieldset class="fieldset-auto-width">
				<legend>課程資料</legend>
				<table>
					<tr>
						<td align='right'>課程名稱：<br>&nbsp;
						</td>
						<td><form:input path="courseName" id="courseName"/><br>&nbsp; <form:errors
								path="courseName" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>課程總類：<br>&nbsp;
						</td>
						<td><form:select path="category" id="category">
								<form:option value="NOENE" label="請選擇課程種類"></form:option>
								<form:option path="category" value="舞蹈類課程">舞蹈類課程</form:option>
								<form:option path="category" value="瑜珈課程">瑜珈課程</form:option>
								<form:option path="category" value="心肺肌力課程">心肺肌力課程</form:option>
								<form:option path="category" value="其他">其他</form:option>
							</form:select> <form:errors path="category" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>日期：<font size='-3' color='blue'>(yyyy-MM-dd)</font><br>&nbsp;
						</td>
						<td><form:input path="date" id="date"/><br>&nbsp; <form:errors
								path="date" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>課程時間：: <br>&nbsp;
						</td>
						<td><form:select path="period" id="period">
								<form:option value="NOENE" label="請選擇上課時段"></form:option>
								<form:option path="period" value="09:00-10:00">09:00-09:50</form:option>
								<form:option path="period" value="10:00-10:50">10:00-10:50</form:option>
								<form:option path="period" value="11:00-11:50">11:00-11:50</form:option>
								<form:option path="period" value="12:00-12:50">12:00-12:50</form:option>
								<form:option path="period" value="13:00-13:50">13:00-13:50</form:option>
								<form:option path="period" value="14:00-14:50">14:00-14:50</form:option>
								<form:option path="period" value="15:00-15:50">15:00-15:50</form:option>
								<form:option path="period" value="16:00-16:50">16:00-16:50</form:option>
								<form:option path="period" value="17:00-17:50">17:00-17:50</form:option>
								<form:option path="period" value="18:00-18:50">18:00-18:50</form:option>
								<form:option path="period" value="19:00-19:50">19:00-19:50</form:option>
								<form:option path="period" value="20:00-20:50">20:00-20:50</form:option>
								<form:option path="period" value="21:00-21:50">21:00-21:50</form:option>
							</form:select> <form:errors path="period" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>教室編號:<br>&nbsp;
						</td>
						<td><form:select path="classroom" id="classroom">
								<form:option value="NOENE" label="請選擇教室"></form:option>
								<form:option path="classroom" value="A">A教室</form:option>
								<form:option path="classroom" value="B">B教室</form:option>
								<form:option path="classroom" value="C">C教室</form:option>
							</form:select> <form:errors path="classroom" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>授課老師編號:：<br>&nbsp;
						</td>
						<td><form:select path="coachId" id="coachId">
								<form:option value="NONE" label="請選擇授課老師" />
								<c:forEach var="oneCoach" items="${coachList}">
									<form:option path="coachId" value="${oneCoach.id}">${oneCoach.coachName}</form:option>
								</c:forEach>
							</form:select> <form:errors path="coachId" cssClass="error" /></td>

					</tr>

					<tr>
						<td align='right'>目前學生人數：<br>&nbsp;
						</td>
						<td><form:input path="studentNum" id="studentNum"/><br>&nbsp; <form:errors
								path="studentNum" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>學生人數上限：<br>&nbsp;
						</td>
						<td><form:input path="maxStudentNum" id="maxStudentNum"/><br>&nbsp; 
						<form:errors path="maxStudentNum" cssClass="error" /></td>
					</tr>

					<tr>
						<td align='right'>課程狀態：<br>&nbsp;
						</td>
						<td><form:input path="state" id="state"/><br>&nbsp; <form:errors
								path="state" cssClass="error" /></td>
					</tr>

					<td colspan='2' align='center'><input type='submit' value='新增課程' onclick="insertCourse()"></td>
					<input type="button" value="神奇小幫手" onclick='quickInput();'>
				</table>
			</fieldset>
		</form:form>
		<br> <a href="<c:url value='/' />">回首頁</a>


		<!--		
		
<form   method="POST">
				
<label for="" class="form-label"></label> 
<input type="hidden" name="courseId" id="courseId" value="${courseOnForm.id}" class="form-control" placeholder="" aria-describedby="helpId" ">
<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.courseId}</div>

<label for="" class="form-label">課程名稱</label> <input type="text" name="courseName" id="courseName" value="${courseOnForm.courseName}"
						class="form-control" placeholder="" aria-describedby="helpId">

				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.courseName}</div>
				
				<div class="col-md-4">
					<label for="" class="form-label">課程總類</label> <input type="text"
						name="category" id="category" value="${courseOnForm.category}"
						class="form-control" placeholder="" aria-describedby="helpId">
				</div>
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.category}</div>
				
				
				<div class="col-md-4">
					<label for="" class="form-label">授課老師編號</label> 
					
					<select
						class="form-select" name="coachId" id="coachId" size="3">
						<c:forEach var="oneCoache" items="${coaches}" >
						<option value="${oneCoache.id}">${oneCoache.coachName}</option>
						</c:forEach>
					</select>		
				</div>
				
				
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.teacherName}</div>

				<div class="col-md-4">
					<label for="" class="form-label">教室編號：</label> 
					<select
						class="form-select" name="classroom" id="classroom" size="3">
						<option value="A">A 教室</option>
						<option value="B">B 教室</option>
						<option value="C">C 教室</option>
					</select>
				</div>
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.classroomID}</div>

				<div class="col-md-4">
					<label for="" class="form-label">星期：</label> <select
						class="form-select" name="weekday" id="weekday" size="3">
						<option value=7>星期日</option>
						<option value=1>星期一</option>
						<option value=2>星期二</option>
						<option value=3>星期三</option>
						<option value=4>星期四</option>
						<option value=5>星期五</option>
						<option value=6>星期六</option>
					</select>
				</div>
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.day}</div>

				<div class="col-md-4">
					<label for="" class="form-label">時段：</label> <select
						class="form-select" name="period" id="period" size="3">
						<option value="09:00-10:00">09:00-10:00</option>
						<option value="10:00-11:00">10:00-11:00</option>
						<option value="14:00-15:00">14:00-15:00</option>
						<option value="15:00-16:00">15:00-16:00</option>
						<option value="19:00-20:00">19:00-20:00</option>
						<option value="20:00-21:00">20:00-21:00</option>
					</select>
				</div>
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.period}</div>

				<div class="col-md-4">
					<label for="" class="form-label">日期</label> <input type="text"
						name="date" id="date" value="${courseOnForm.date}"
						class="form-control" placeholder="" aria-describedby="helpId">
				</div>
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.date}</div>

				<div class="col-md-4">
					<label for="" class="form-label">目前學生人數</label> <input type="text"
						name="studentNum" id="studentNum" value="${courseOnForm.studentNum}"
						class="form-control" placeholder="" aria-describedby="helpId">
				</div>
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.studentNum}</div>


				<div class="col-md-4">
					<label for="" class="form-label">學生人數上限</label> <input type="text"
						name="maxStudentNum" id="maxStudentNum" value="${courseOnForm.maxStudentNum}"
						class="form-control" placeholder="" aria-describedby="helpId">
				</div>
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.maxStudentNum}</div>
				
				<div class="col-md-4">
					<label for="" class="form-label">課程狀態</label> <input type="text"
						name="state" id="state" value="${courseOnForm.state}"
						class="form-control" placeholder="" aria-describedby="helpId">
				</div>
				<div style="color: #FF0000; font-size: 60%; display: inline">${ErrorMsg.state}</div>
				

				<div>
					<input type="button" value="新增課程"
						onclick="submitYouFrom('<c:url value='/insertCourse.controller' />')" />
					<input type="button" value="更新課程"
						onclick="submitYouFrom('<c:url value='/updateCourse.controller/${courseOnForm.id}' />')" />
					<input type="button" value="清除表單" onclick="ResetForm()">
				</div>
				<div style="color: #FF0000; display: inline">${ErrorMsg.exception}</div>
			</form>
-->

		<div id="productListTitle">Course Query</div>
		<div id="insertsuccess"></div>
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
</body>
</html>