<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<script src="/js/Timetables.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

<script>

var now = new Date(); //當前日期
var nowDayOfWeek = now.getDay(); //今天本週的第幾天
var nowDay = now.getDate(); //當前日
var nowMonth = now.getMonth(); //當前月
var nowYear = now.getYear(); //當前年


function oneweekCourse() {

	var now = new Date(); //當前日期
	var nowDayOfWeek = now.getDay(); //今天本週的第幾天
	var nowDay = now.getDate(); //當前日
	var nowMonth = now.getMonth(); //當前月
	var nowYear = now.getFullYear(); //當前年

	var mondayDate;
	var sundayDate;
	if(nowDayOfWeek==0){
	    mondayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek+1-7);
	    sundayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek+1);
	   
	}else{
		mondayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek+1);
		sundayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek+1+7);
	}
	console.log(mondayDate);
  console.log(sundayDate);
	var month = mondayDate.getMonth() + 1;
	var mondaystr = mondayDate.getFullYear() + "-" + month + "-" + mondayDate.getDate(); //格式化後，本周一的日期
	month = sundayDate.getMonth() + 1;
	var sundaystr = sundayDate.getFullYear() + "-" + month + "-" + sundayDate.getDate(); //格式化後，本周日的日期
	console.log(mondaystr);
	console.log(sundaystr);
	
	var params = {
		"monday":mondaystr;
		"sunday":sundaystr;
	}
	
	$.ajax({
		type : 'post',
		url : '/course/sendqueryform.controller/' ,
		data : JSON.stringify(params),
		dataType : 'JSON',
		contentType : 'application/json;charset=utf-8',
		success : function(data) {
			
			//showCourseList(data);
		}
	});
}

</script>



</head>
<body>

</body>
</html>