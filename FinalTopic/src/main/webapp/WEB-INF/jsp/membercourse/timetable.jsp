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
      font-size: 18px;
      line-height: 36px;
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
      color: red !important;
      font-weight : bold;
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
//??????toISOString????????????????????????????????????YY-MM-dd?????????
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
  
//  ??????????????????????????????????????????????

// var??formatDate??=??function(date)??{
// 	return??date.toISOString().slice(0,10);
// ??};

// ??var??addDate??=??function(date,??n)??{
// 	date.setDate(date.getDate()??+??n);
// 	return??date;
// };

// var??setDate??=??function(date)??{
// 	var??week??=??date.getDay()??-??1;
// 	date??=??addDate(date,??week??*??-1);
// 	var??weekList??=??[];
// 	for??(var??i??=??0;??i??<??7;??i++)??{
// 		weekList[i]??=??formatDate(i??==??0?????date??:??addDate(date,??1));
// 	}
// 	return??weekList;
// };


// var??today??=??formatDate(new??Date());??//????????????
// console.log('today: '+today);

  
//??????????????????????????????????????????


  var now = new Date(new(Date)); //????????????
  var nowDayOfWeek = now.getDay(); //????????????????????????
  var nowDay = now.getDate(); //?????????
  var nowMonth = now.getMonth(); //?????????
  var nowYear = now.getFullYear(); //?????????

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

  var mondaystr = mondayDate.toISOString().slice(0,10); //?????????????????????????????????
  var tuesdaystr = tuesdayDate.toISOString().slice(0,10); //?????????????????????????????????
  var wednesdaystr = wednesdayDate.toISOString().slice(0,10); //?????????????????????????????????
  var thursdaystr = thursdayDate.toISOString().slice(0,10); //?????????????????????????????????
  var fridaystr = fridayDate.toISOString().slice(0,10); //?????????????????????????????????
  var saturdaystr = saturdayDate.toISOString().slice(0,10); //?????????????????????????????????
  var sundaystr = sundayDate.toISOString().slice(0,10); //?????????????????????????????????
  
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
 
  
  const highlightWeek = new Date().getDay();
  const styles = {
    Gheight: 50,
    leftHandWidth: 50,
    //palette: ['#ff6633', '#eeeeee']
  palette:false
  };    

//??????????????????7X13?????????????????????
const testtimtables =new Array(7);
for(let i=0;i<7;i++){
testtimtables[i]=new Array(13);
}

//??????????????????7X13?????????????????????????????????
const categoryTB =new Array(7);
for(let i=0;i<7;i++){
	categoryTB[i]=new Array(13);
}

/////////////??????????????????//////////////////////////////////
var classroom='A'
//var??thisWeek??=??setDate(addDate(new??Date(),??0));??//??????
//var lastWeek=setDate(addDate(new??Date(),-7));
//var dayStr = lastWeek;
console.log(dayStr)

var week = [
	dayStr[0].substring(5)+' ??????', 
	dayStr[1].substring(5)+' ??????', 
	dayStr[2].substring(5)+' ??????', 
	dayStr[3].substring(5)+' ??????', 
	dayStr[4].substring(5)+' ??????', 
	dayStr[5].substring(5)+' ??????', 
	dayStr[6].substring(5)+' ??????'];
console.log(week)

$(document).ready(function() {
	showTimeTable(classroom,week);
});

function changeclassroom(room) {
    for(let i=0;i<7;i++){
	 for(let j=0;j<13;j++){ testtimtables[i][j]="";}
	 }
	
	classroom = room;
	showTimeTable(classroom,week)
}



//??????????????????????????????
function changeweek(chosenweek){
	
	if(chosenweek=='lastWeek'){
		var??lastWeek??=??setDate(addDate(new??Date(),-7));??//??????
		dayStr = lastWeek;
	}else if(chosenweek=='thisWeek'){
		var??thisWeek??=??setDate(addDate(new??Date(),??0));??//??????
		dayStr = thisWeek;
	}else if(chosenweek=='nextWeek'){
		var??nextWeek??=??setDate(addDate(new??Date(),??+7));??//??????
		dayStr = nextWeek;
	} 
	week = [
		dayStr[0].substring(5)+' ??????', 
		dayStr[1].substring(5)+' ??????', 
		dayStr[2].substring(5)+' ??????', 
		dayStr[3].substring(5)+' ??????', 
		dayStr[4].substring(5)+' ??????', 
		dayStr[5].substring(5)+' ??????', 
		dayStr[6].substring(5)+' ??????'];
	
	showTimeTable(classroom,week)
}


function showTimeTable(classroom,week){
	console.log('classroom: '+ classroom);
	console.log('week: ' +week);
	
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
			              testtimtables[i][timetableType[j][0].index-1] =n.courseName+' ('+n.coach.coachName +') '
			              //+n.category;
			              categoryTB[i][timetableType[j][0].index-1] =n.category;

			            }else{
			            }
			            //console.log(testtimtables[i][j]); 
			          }
			        }else{
			          for(let j=0;j<13;j++){
			          }
			        }
			      }
			    });//$.each??????
			    
			    for(let i=0;i<7;i++){
			      for(let j=0;j<13;j++){
			        if(null==testtimtables[i][j]){
			          testtimtables[i][j]="";
		              categoryTB[i][j]="";
			        }
			      }
			    }
			    console.log(testtimtables)
			    // ?????????(???????????????)
			    const timetable = new Timetables({
			    category:categoryTB,
			      el: '#coursesTable',
			      timetables: testtimtables,
			      week: week,
			      timetableType: timetableType,
			      highlightWeek: highlightWeek,
// 			      gridOnClick: function (e) {
// 			        alert(e.name + '  ' + e.week + ', ???' + e.index + '??????, ??????' + e.length + '???')
// 			        console.log(e)
// 			      },
			      styles: styles
			    });
			    
			    //?????????????????????????????????
			    $(".course-hasContent").each(function (i, n) {
			    	//console.log("hello:" + n);
			    	
			    	var classindex =$(this).parent("ul").attr('class').substring(6)-1;
			    	var dayindex = $(this).index();
			    	var category =categoryTB[dayindex][classindex];
			    	if(category=='???????????????'){
				    	$(this).css({"background-color":"#FFA1A1"}); //??????
			    	}else if(category=='????????????'){
			    		$(this).css({"background-color":"#00FF00"}); //???
			    	}else if (category=='??????????????????'){
			    		$(this).css({"background-color":"#FFC14F"});//???
			    	}else if (category=='??????'){
			    		$(this).css({"background-color":"#00F5F5"});//???
			    	}else{
			    		$(this).css({"background-color":"white"});
			    	}
			    
			    });
			    
			}//success??????
		});//ajax??????
	 } 

</script>
  
  
</head>
<body>


<div id="coursesTable" style="width:60%"></div>
  
<fieldset style="width:20%">
<legend>????????????</legend>
<button onclick="changeclassroom('A')" style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none">
A????????????
</button>
<button onclick="changeclassroom('B')" style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none ">B????????????</button>
<button onclick="changeclassroom('C')" style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none ">C????????????</button>
</fieldset>


<!-- <fieldset style="width:20%"> -->
<!-- <legend>????????????</legend> -->
<!-- <button onclick="changeweek('lastWeek')" style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none"> -->
<!-- ???????????? -->
<!-- </button> -->
<!-- <button onclick="changeweek('thisWeek')" style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none "> -->
<!-- ????????????</button> -->
<!-- <button onclick="changeweek('nextWeek')" style="background-color: #00a2ae; color: #fff; padding: 5px 10px; border-radius: 4px;border: none "> -->
<!-- ????????????</button> -->
<!-- </fieldset> -->


<fieldset style="width:20%">
<legend>??????????????????</legend>
<table>
<tr>
<td style="background-color:#FFA1A1">???????????????</td>
<td style="background-color:#00FF00">????????????</td>
<td style="background-color:#FFC14F">??????????????????</td>
<td style="background-color:#00F5F5">??????</td>
</tr>
</table>
</fieldset>

</body>

</html>