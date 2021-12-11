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
	//    $(document).ready(function(){
	//        load(indexPage);
	//    });

	//    function change(page){
	//        indexPage = page;
	//        load(indexPage);
	//    }

	function getMember(classId){
		
		var cId = classId;
		var memberName = null;
		$.ajax({
            type : 'post',
            url : '/coach/getClassMember/',
            dataType : 'JSON',
            data:{
            	classId : cId
            },
//             contentType : 'application/json',
            success : function(data) {
            	
            	console.log('success:' + data);
                var json = JSON.stringify(data, null, 4);
                console.log('json:' + json);

            }
		
		})
		
// 		return 
	}
	
	$(function load() {
		$.ajax({
					type : 'post',
					url : '/coach/listAllClass/',
					dataType : 'JSON',
					contentType : 'application/json',
					success : function(data) {

						console.log('success:' + data);
						var json = JSON.stringify(data, null, 4);
						console.log('json:' + json);

						$('#showclasslist').empty("");

						if (data == null) {
							$('table').prepend(
									"<tr><td colspan='2'>暫無資料</td></tr>");
							;
						} else {
							var table = $('#showclasslist');
							table
									.append("<thead style='background-color:black'><tr><th style='text-align:center'>課程名稱</th><th style='text-align:center'>開課日期</th><th style='text-align:center'>上課時間</th><th style='text-align:center'>結束時間</th><th style='text-align:center'>課程時數</th><th style='text-align:center'>價格</th><th style='text-align:center'>教練</th><th style='text-align:center'>學員</th><th style='text-align:center'>課程狀態</th><th style='text-align:center'>操作</th></tr></thead>");

							$.each(data, function(i, n) {
								
								getMember(n.classId);
								
								var status = null;
								var classDate = new Date(n.classDate + " "
										+ n.classEndTime).getTime();
								var today = new Date().getTime();
								var d = today - classDate
								if (d > 0) {
									if (n.classAvaliable == 1) {
										status = "已開課";
									} else {
										status = "無人報名，未開課";
									}

								} else {
									status = "尚未開課";
								}

								var tr = "<tbody><tr align='center'>" + "<td>"
										+ n.className + "</td>" + "<td>"
										+ n.classDate + "</td>" + "<td>"
										+ n.classStartTime + "</td>" + "<td>"
										+ n.classEndTime + "</td>" + "<td>"
										+ n.classDuration + "</td>" + "<td>"
										+ n.classPrice + "</td>" + "<td>"
										+ n.cBean.coachName + "</td>" + "<td>"
// 										--+ n.cBean.coachName + "</td>" + "<td>"
										+ status + "</td>"+"<td><input type='button' class='btn' style='float:none;margin-top:0' value='編輯' onclick=" + "location.href='/coach/updateClass?Id=" + n.classId + "' /></td></tr></tbody>";
								//                        "<td><img width='50' height='50' src=" + "<c:url value='/administrator/getCoachPicture?coachAccount=' />" + n.coachAccount + " /></td>" +
								table.append(tr);
							});
						}
					}
				});
	})
</script>
<style>
tbody:hover{
  background-color: #4F4F4F;
}
</style>
</head>
<body>

	<div style="width: 1205px; height: 194.13px" class="top">
		<c:import url="/top_coachlogin"></c:import>
	</div>
	<div style="text-align:center;"><h1 style="display: inline-block;">開課紀錄</h1></div><hr style="border: 1px solid black;">
	<div id="sidebar" class="left-bar" style="background-color:rgb(33, 37, 41);width:95%;margin-left:2.5%">
                     <div class="feature-matchs">
                        <table id="showclasslist" class="table table-bordered" style="font-size:15px;color:white;">
                        
                          </table>
                     </div>
                  </div>

<!-- 	<div id="Title">課程清單</div> -->
<!-- 	<table id="showclasslist" border="1"></table> -->
</body>
</html>