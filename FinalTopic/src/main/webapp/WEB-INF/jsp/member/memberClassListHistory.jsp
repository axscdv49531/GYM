<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   <!-- Site Icons -->
   <link rel="shortcut icon" href="" type="image/x-icon" />
   <link rel="apple-touch-icon" href="">
   <!-- Bootstrap CSS -->
   <link rel="stylesheet" href="css/bootstrap.min.css">
   <!-- Site CSS -->
   <link rel="stylesheet" href="style.css">
   <!-- Colors CSS -->
   <link rel="stylesheet" href="css/colors.css">
   <!-- ALL VERSION CSS --> 
   <link rel="stylesheet" href="css/versions.css">
   <!-- Responsive CSS -->
   <link rel="stylesheet" href="css/responsive.css">
   <!-- Custom CSS -->
   <link rel="stylesheet" href="css/custom.css">
   <!-- font family -->
   <link href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i" rel="stylesheet">
   <!-- end font family -->
   <link rel="stylesheet" href="css/3dslider.css" />
   <script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
   <link href="http://www.jqueryscript.net/css/jquerysctipttop.css" rel="stylesheet" type="text/css">
   <script src="js/3dslider.js"></script>
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
    //    var indexPage=1;
       $(document).ready(function(){
           load();
       });

    //    function change(page){
    //        indexPage = page;
    //        load(indexPage);
    //    }

    function cancelConfirm(y){
            x = confirm("請確認是否要取消課程？");
            console.log(x)
            console.log(y)
            if(x){
            $.ajax({
                        type : 'post',
                        url : '/member/cancelClass/',
                        data : {
                            classId : y
                        },
                        dataType : 'JSON',
                        complete: function(data) {
                            if(data.responseText == 'true'){
                                alert("取消成功");
                                load();
                            load();
                            }else{
                                alert("取消失敗")
                                load();
                            }
                         }
                        }
            )
            }
            
            }
    
    
    function load() {
        $
                .ajax({
                    type : 'post',
                    url : '/member/listRecentClass/',
                    dataType : 'JSON',
                    contentType : 'application/json',
                    success : function(data) {

                        console.log('success:' + data);
                        var json = JSON.stringify(data, null, 4);
                        console.log('json:' + json);

                        $('#showclasslist').empty("");
                        $('#showclasslisthistory').empty("");
                        if (data == null) {
                            $('table').prepend(
                                    "<tr><td colspan='2'>暫無資料</td></tr>");
                            ;
                        } else {
                            var table = $('#showclasslist');
                            var tablehistory = $('#showclasslisthistory');
                            table.append("<thead style='background-color:black'><tr><th style='text-align:center'>課程名稱</th><th style='text-align:center'>開課日期</th><th style='text-align:center'>上課時間</th><th style='text-align:center'>結束時間</th><th style='text-align:center'>課程時數</th><th style='text-align:center'>價格</th><th style='text-align:center'>教練</th><th style='text-align:center'>課程狀態</th><th style='text-align:center'>操作</th></tr></thead>");
                            tablehistory.append("<thead style='background-color:black'><tr><th style='text-align:center'>課程名稱</th><th style='text-align:center'>開課日期</th><th style='text-align:center'>上課時間</th><th style='text-align:center'>結束時間</th><th style='text-align:center'>課程時數</th><th style='text-align:center'>價格</th><th style='text-align:center'>教練</th><th style='text-align:center'>課程狀態</th></tr></thead>");

                            $.each(data, function(i, n) {
                            	
                            	var today = new Date();
                                var year = n.classDate.substring(4,0);
                                var month = n.classDate.substring(5,7);
                                var monthInt = parseInt(month)
                                monthInt = monthInt - 1;
                                var day = n.classDate.substring(8,10);
                                var hour = n.classStartTime.substring(2,0);
                                var min = n.classStartTime.substring(3,5);
                                var sec = n.classStartTime.substring(6,8);
                                var classExpireDay = new Date(year,monthInt,day,hour,min,sec)
                                console.log(classExpireDay)
                            	
                                var status = null;
                                var classDate = new Date(n.classDate + " "
                                        + n.classStartTime).getTime();
                                var today = new Date().getTime();
                                var d = today - classDate
console.log(n.classId)
                                if (d > 0) {
                                    if (n.classAvaliable == 1) {
                                        status = "已完成";
                                    } else {
                                        status = "無人報名，未開課";
                                    }

                                } else {
                                    status = "尚未開課";
                                }
                                if(classExpireDay>today){
                                var tr = "<tbody><tr align='center'>" + "<td>"
                                        + n.className + "</td>" + "<td>"
                                        + n.classDate + "</td>" + "<td>"
                                        + n.classStartTime + "</td>" + "<td>"
                                        + n.classEndTime + "</td>" + "<td>"
                                        + n.classDuration + "</td>" + "<td>"
                                        + n.classPrice + "</td>" + "<td>"
                                        + n.cBean.coachName + "</td>" + "<td>"
                                        + status + "</td>"+"<td><p><input type='button' style='float:none' value='查看' class='btn' onclick=" + "location.href='/member/memberViewClassDetailPerson?Id=" + n.classId + "' /><input type='button' class='btn' style='float:none;margin-top:0' value='取消課程' onclick='cancelConfirm(" + n.classId + ")'" + "/></p></td></tr></tbody>";
                                //                        "<td><img width='50' height='50' src=" + "<c:url value='/administrator/getCoachPicture?coachAccount=' />" + n.coachAccount + " /></td>" +
                                table.append(tr);
                                }else{
                                	 var trhistory = "<tbody><tr align='center'>" + "<td>"
                                     + n.className + "</td>" + "<td>"
                                     + n.classDate + "</td>" + "<td>"
                                     + n.classStartTime + "</td>" + "<td>"
                                     + n.classEndTime + "</td>" + "<td>"
                                     + n.classDuration + "</td>" + "<td>"
                                     + n.classPrice + "</td>" + "<td>"
                                     + n.cBean.coachName + "</td>" + "<td>"
                                     + status + "</td>"+"</tr></tbody>";
//                                      + status + "</td>"+"<td><input type='button' class='btn' style='float:none;margin-top:0' value='取消課程' onclick=" + "location.href='/coach/updateClass?Id=" + n.classId + "' /></td></tr></tbody>";
                                     tablehistory.append(trhistory);
                                	
                                }    });
                        }
                    }
                });
    }
</script>
<style>
tbody:hover{
  background-color: #4F4F4F;
}
</style>
</head>
<body>

    <div class="top">
        <c:import url="/top_memberlogin"></c:import>
    </div>
    <div>
    <div style="text-align:center;"><h1 style="display: inline-block;">尚未開課</h1></div><hr style="border: 1px solid black;">
    <div id="sidebar" class="left-bar" style="background-color:rgb(33, 37, 41);width:95%;margin-left:2.5%">
                     <div class="feature-matchs">
                        <table id="showclasslist" class="table table-bordered" style="font-size:15px;color:white;">
                        
                          </table>
                     </div>
                  </div>
                  
                  </div>
                  
                  
                   <div>
                  <div style="text-align:center;"><h1 style="display: inline-block;">已完成課堂</h1></div><hr style="border: 1px solid black;">
                      <div id="sidebar" class="left-bar" style="background-color:rgb(33, 37, 41);width:95%;margin-left:2.5%">
                     <div class="feature-matchs">
                        <table id="showclasslisthistory" class="table table-bordered" style="font-size:15px;color:white;">
                        
                          </table>
                     </div>
                  </div>
                       </div>

<!--    <div id="Title">課程清單</div> -->
<!--    <table id="showclasslist" border="1"></table> -->
</body>
</html>