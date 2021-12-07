<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width,initial-scale=1,user-scalable=0">
<script src="/js/Timetables.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

  <style>
    #coursesTable {
      padding: 15px 10px;
    }

    .Courses-head {
      background-color: #edffff;
    }

    .Courses-head>div {
      text-align: center;
      font-size: 14px;
      line-height: 28px;
    }

    .left-hand-TextDom,
    .Courses-head {
      background-color: #f2f6f7;
    }

    .Courses-leftHand {
      background-color: #f2f6f7;
      font-size: 12px;
    }

    .Courses-leftHand .left-hand-index {
      color: #9c9c9c;
      margin-bottom: 4px !important;
    }

    .Courses-leftHand .left-hand-name {
      color: #666;
    }

    .Courses-leftHand p {
      text-align: center;
      font-weight: 900;
    }

    .Courses-head>div {
      border-left: none !important;
    }

    .Courses-leftHand>div {
      padding-top: 5px;
      border-bottom: 1px dashed rgb(219, 219, 219);
    }

    .Courses-leftHand>div:last-child {
      border-bottom: none !important;
    }

    .left-hand-TextDom,
    .Courses-head {
      border-bottom: 1px solid rgba(0, 0, 0, 0.1) !important;
    }

    .Courses-content>ul {
      border-bottom: 1px dashed rgb(219, 219, 219);
      box-sizing: border-box;
    }

    .Courses-content>ul:last-child {
      border-bottom: none !important;
    }

    .highlight-week {
      color: #02a9f5 !important;
    }

    .Courses-content li {
      text-align: center;
      color: #666666;
      font-size: 14px;
      line-height: 50px;
    }

    .Courses-content li span {
      padding: 6px 2px;
      box-sizing: border-box;
      line-height: 18px;
      border-radius: 4px;
      white-space: normal;
      word-break: break-all;
      cursor: pointer;
    }

    .grid-active {
      z-index: 9999;
    }

    .grid-active span {
      box-shadow: 0px 2px 4px rgba(0, 0, 0, 0.2);
    }
  </style>
  <script>
//複寫toISOString方法，解決時區問題，列出YY-MM-dd的格式
  Date.prototype.toISOString = function () {
      let pad =(n)=>(n < 10)?'0' + n:n;
      let hours_offset = this.getTimezoneOffset() / 60;
      let offset_date = this.setHours(this.getHours() - hours_offset);
      let symbol = (hours_offset >= 0) ? "-" : "+";
      let time_zone = symbol+pad(Math.abs(hours_offset))+ ":00";
      
      return this.getUTCFullYear() +
          '-' + pad(this.getUTCMonth() + 1) +
          '-' + pad(this.getUTCDate()) +
          'T' + pad(this.getUTCHours()) +
          ':' + pad(this.getUTCMinutes()) +
          ':' + pad(this.getUTCSeconds()) +
          '.' + (this.getUTCMilliseconds() / 1000).toFixed(3).slice(2, 5) +
          time_zone;
  };
  
//獲取當周一到周日的格式化日期

  var now = new Date(); //當前日期
  var nowDayOfWeek = now.getDay(); //今天本週的第幾天
  var nowDay = now.getDate(); //當前日
  var nowMonth = now.getMonth(); //當前月
  var nowYear = now.getFullYear(); //當前年

  var mondayDate;
  var sundayDate;
  if (nowDayOfWeek == 0) {
    mondayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 - 7);
    tuesdayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 - 6);
    wednesdayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 - 5);
    thursdayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 - 4);
    fridayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 - 3);
    saturdayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 - 2);
    sundayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 -1);

  } else {
    mondayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1);
    tuesdayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 +1);
    wednesdayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 +2);
    thursdayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 +3);
    fridayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 +4);
    saturdayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 +5);
    sundayDate = new Date(nowYear, nowMonth, nowDay - nowDayOfWeek + 1 + 6);
  }

  var mondaystr = mondayDate.toISOString().slice(0,10); //格式化後，本周一的日期
  var tuesdaystr = tuesdayDate.toISOString().slice(0,10); //格式化後，本周一的日期
  var wednesdaystr = wednesdayDate.toISOString().slice(0,10); //格式化後，本周一的日期
  var thursdaystr = thursdayDate.toISOString().slice(0,10); //格式化後，本周一的日期
  var fridaystr = fridayDate.toISOString().slice(0,10); //格式化後，本周一的日期
  var saturdaystr = saturdayDate.toISOString().slice(0,10); //格式化後，本周一的日期
  var sundaystr = sundayDate.toISOString().slice(0,10); //格式化後，本周日的日期
  
  var dayStr = [mondaystr,tuesdaystr,wednesdaystr,thursdaystr,fridaystr,saturdaystr,sundaystr]

  const timetableType = [
    [{ index: '1', name: '09:00-09:50' }, 1],
    [{ index: '2', name: '10:00-10:50' }, 1],
    [{ index: '3', name: '11:00-11:50' }, 1],
    [{ index: '4', name: '12:00-12:50' }, 1],
    [{ index: '5', name: '13:00-13:50' }, 1],
    [{ index: '6', name: '14:00-14:50' }, 1],
    [{ index: '7', name: '15:00-15:50' }, 1],
    [{ index: '8', name: '16:00-16:50' }, 1],
    [{ index: '9', name: '17:00-17:50' }, 1],
    [{ index: '10', name: '18:00-18:50' }, 1],
    [{ index: '11', name: '19:00-19:50' }, 1],
    [{ index: '12', name: '20:00-20:50' }, 1],
    [{ index: '13', name: '21:00-21:50' }, 1]
  ];
  const week = ['周一', '周二', '周三', '周四', '周五', '週六', '週日'];
  const highlightWeek = new Date().getDay();
  const styles = {
    Gheight: 50,
    leftHandWidth: 50,
    palette: ['#ff6633', '#eeeeee']
  };    

//宣告二維陣列7X13
const testtimtables =new Array(7);
for(let i=0;i<7;i++){
testtimtables[i]=new Array(13);
}



/////////////顯示時間課表//////////////////////////////////
var classroom='A'

$(document).ready(function() {
	showTimeTable(classroom);
});

function changeclassroom(room) {
    for(let i=0;i<7;i++){
	 for(let j=0;j<13;j++){ testtimtables[i][j]="";}
	 }
	
	classroom = room;
	showTimeTable(classroom)
}


function showTimeTable(classroom){
	$('#coursesTable').empty("");
		$.ajax({
			type : 'get',
			url : '/course/querythisweekcourse.controller/' + classroom,
			//data : JSON.stringify(params),
			dataType : 'JSON',
			contentType : 'application/json;charset=utf-8',
			success : function(data) {
				//showCourseList(data);
				console.log(data);
				

			    $.each(data, function (i, n) {
			      for(let i=0;i<7;i++){
			        if (n.date == dayStr[i]) { 
			          for(let j=0;j<13;j++){
			            if(n.period==timetableType[j][0].name){
			              testtimtables[i][timetableType[j][0].index-1] =n.courseName+' ('+n.coach.coachName +' 老師)';
			            }else{
			            }
			            console.log(testtimtables[i][j]); 
			          }
			        }else{
			          for(let j=0;j<13;j++){
			          }
			        }
			      }
			    })
			    for(let i=0;i<7;i++){
			      for(let j=0;j<13;j++){
			        if(null==testtimtables[i][j]){
			          testtimtables[i][j]="";
			        }
			      }
			    }
			    // 实例化(初始化课表)
			    const timetable = new Timetables({
			      el: '#coursesTable',
			      timetables: testtimtables,
			      week: week,
			      timetableType: timetableType,
			      highlightWeek: highlightWeek,
			      gridOnClick: function (e) {
			        alert(e.name + '  ' + e.week + ', 第' + e.index + '节课, 课长' + e.length + '节')
			        console.log(e)
			      },
			      styles: styles
			    });
			}
		});//ajax結尾
	 } 

</script>
  
  
</head>
<body>


  <div id="coursesTable"></div>
  <button onclick="changeclassroom('A')"
        style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none">
    A教室課表
</button>
<button onclick="changeclassroom('B')" style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none ">B教室課表</button>
<button onclick="changeclassroom('C')" style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none ">C教室課表</button>

  <script>

  
  </script>
</body>

</html>