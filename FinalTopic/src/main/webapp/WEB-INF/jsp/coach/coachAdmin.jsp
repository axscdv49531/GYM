<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>課程管理系統</title>

<meta charset="utf-8" />
<link rel="apple-touch-icon" sizes="76x76"
	href="../admintemplate/img/apple-icon.png">
<link rel="icon" type="image/png"
	href="../admintemplate/img/favicon.ico">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta
	content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no'
	name='viewport' />
<link
	href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200"
	rel="stylesheet" />
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
<link href="../admintemplate/css/bootstrap.min.css" rel="stylesheet" />
<link href="../admintemplate/css/light-bootstrap-dashboard.css?v=2.0.0 "
	rel="stylesheet" />
<link href="../admintemplate/css/demo.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


<!-- <script src="../admintemplate/js/core/jquery.3.2.1.min.js" type="text/javascript"></script> -->
<!-- <script src="../admintemplate/js/core/popper.min.js" type="text/javascript"></script> -->
<!-- <script src="../admintemplate/js/core/bootstrap.min.js" type="text/javascript"></script> -->
<!-- <script src="../admintemplate/js/plugins/bootstrap-switch.js"></script> -->
<!-- <script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script> -->
<!-- <script src="../admintemplate/js/plugins/chartist.min.js"></script> -->
<!-- <script src="../admintemplate/js/plugins/bootstrap-notify.js"></script> -->
<!-- <script src="../admintemplate/js/light-bootstrap-dashboard.js?v=2.0.0 " type="text/javascript"></script> -->
<!-- <script src="../admintemplate/js/demo.js"></script> -->


<script type="text/javascript">

function showClassList(){
    $.ajax({
        type : 'post',
        url : '/administrator/listAllClass/',
        dataType : 'JSON',
        contentType : 'application/json',
        success : function(data) {

            console.log('success:' + data);
            var json = JSON.stringify(data, null, 4);
            console.log('json:' + json);

            $('#showCoach').empty("");

            if (data == null) {
                $('#showCoach').prepend(
                        "<tr><td colspan='2'>暫無資料</td></tr>");
                ;
            } else {
                var div = $('#showCoach');
                div.append("<thead style='text-align:center'><th style='text-align:center'>課程名稱</th><th style='text-align:center'>課程種類</th><th style='text-align:center'>教練名稱</th><th style='text-align:center'>開課日期</th><th style='text-align:center'>開始時間</th><th style='text-align:center'>結束時間</th><th style='text-align:center'>課程時數</th><th style=''>課程價格</th><th style='display:block!important;'>動作</th></thead>");

                $.each(data, function(i, n) {
                	var skName = n.sBean[0].skillName;
                	
                	
                    var div2 = "<tr align='center'>"
                            + "<td style='text-align:left'>"
                            + n.className + "</td>"
                            + "<td style='text-align:left'>"
                            + skName + "</td>"
                            + "<td style='text-align:left'>"
                            + n.cBean.coachName + "</td>"
                            + "<td style='text-align:left'>"
                            + n.classDate + "</td>"
                            + "<td style='text-align:left'>"
                            + n.classStartTime + "</td>"
                            + "<td style='text-align:left'>"
                            + n.classEndTime + "</td>"
                            + "<td style='text-align:left'>"
                            + n.classDuration + "</td>"
                            + "<td style='text-align:left'>"
                            + n.classPrice + "</td>" +"<td style='text-align:left'>"
                            + "<input type='button' class='btn' style='float:none;margin-top:0' value='編輯' onclick=" + "location.href='/administrator/updateClass?id=" + n.classId + "' />" + "</td>" + "</tr>";
                    div.append(div2);
                });
            }

        }
    });
}



	$(function load() {
		$.ajax({
					type : 'post',
					url : '/administrator/listAllCoach/',
					dataType : 'JSON',
					contentType : 'application/json',
					success : function(data) {

						console.log('success:' + data);
						var json = JSON.stringify(data, null, 4);
						console.log('json:' + json);

						$('#showCoach').empty("");

						if (data == null) {
							$('#showCoach').prepend(
									"<tr><td colspan='2'>暫無資料</td></tr>");
							;
						} else {
							var div = $('#showCoach');
							div.append("<thead style='text-align:center'><th style='text-align:center'>名稱</th><th style='text-align:center'>性別</th><th style='text-align:center'>生日</th><th style='text-align:center'>信箱</th><th style='text-align:center'>手機</th><th style='text-align:center'>地址</th><th style=''>年資</th><th style='display:block!important;'>動作</th></thead>");

							$.each(data, function(i, n) {
								var div2 = "<tr align='center'>"
										+ "<td style='text-align:left'>"
										+ n.coachName + "</td>"
										+ "<td style='text-align:left'>"
										+ n.coachGender + "</td>"
										+ "<td style='text-align:left'>"
										+ n.coachBirth + "</td>"
										+ "<td style='text-align:left'>"
										+ n.coachEmail + "</td>"
										+ "<td style='text-align:left'>"
										+ n.coachPhone + "</td>"
										+ "<td style='text-align:left'>"
										+ n.coachAddress + "</td>"
										+ "<td style='text-align:left'>"
										+ n.coachExp + "</td>" +"<td style='text-align:left'>"
                                        + "<input type='button' class='btn' style='float:none;margin-top:0' value='編輯' onclick=" + "location.href='/administrator/updateCoach?ac=" + n.coachAccount + "' />" + "</td>" + "</tr>";
								div.append(div2);
							});
						}

					}
				});
	})
	
// 	//新增教練
// 	function addCoach(){
//     var formArray = $("#addCoach").serializeArray()
//     var json = arrayToJson(formArray);
//     console.log(formArray);
//     console.log("json:"+json);
//     $.ajax({
//            type:'post',
//            url:'/administrator/coachAdd',
//            data:formArray,
//            dataType:'JSON',
// //            contentType:'application/json;charset=utf-8',
//            success: function(data){
//                alert("新增成功");
//                //$('#insertsuccess').html("新增成功");
// //                location.href = '/administrator/listAllCoach';
//            }
//         });            
//     }
	
	
	
	
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



				<div class="col-md-12">
					<div class="card card-plain table-plain-bg">
						<div class="card-header ">
							<h4 class="card-title">教練清單</h4>
							<p class="card-category">顯示所有教練清單</p>
						</div>
						<div class="card-body table-full-width table-responsive">
							<table id="showCoach" class="table table-hover"></table>
							<input type="button" class='btn' value="新增教練" onclick="window.location.href='/administrator/coachAdd'"></input>
							<input type="button" class='btn' value="新增私人課程" onclick="window.location.href='/administrator/coachClassAdd'"></input>
							<div id="changeList"></div>
							<input type="button" id="listChange" class='btn' value="課程清單" onclick="showClassList()"></input>
							</div>
<!-- 							<input type="button" class='btn' value="課程清單" onclick="window.location.href='/administrator/allCoachClasses'"></input> -->
						</div>
					</div>
				</div>

			</div>

		</div>

	</div>
	</div>


<!-- 	<!-- Button trigger modal --> 
<!-- 	<button type="button" class="btn btn-primary" data-toggle="modal" -->
<!-- 		data-target="#staticBackdrop">Launch static backdrop modal</button> -->

<!-- 	<!-- Modal --> 
<!-- 	<div class="modal fade" id="staticBackdrop" data-backdrop="static" -->
<!-- 		data-keyboard="false" tabindex="-1" -->
<!-- 		aria-labelledby="staticBackdropLabel" aria-hidden="true"> -->
<!-- 		<div class="modal-dialog"> -->
<!-- 			<div class="modal-content"> -->
<!-- 				<div class="modal-header"> -->
<!-- 					<h5 class="modal-title" id="staticBackdropLabel">Modal title</h5> -->
<!-- 					<button type="button" class="btn-close" data-dismiss="modal" -->
<!-- 						aria-label="Close"></button> -->
<!-- 				</div> -->
<!-- 				<div class="modal-body"> -->

<%-- 					<form id="addCoach" enctype='multipart/form-data'> --%>
<!-- 						<table> -->
<!-- 							<tr> -->
<!-- 								<td align='right'>姓名：</td> -->
<!-- 								<td><input name="coachName" id="coachName" -->
<!-- 									class="form-control" /></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td align='right'>帳號：</td> -->
<!-- 								<td><input name="coachAccount" id="coachAccount" class="form-control"/></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td align='right'>密碼：</td> -->
<!-- 								<td><input type="password" name="coachPassword" id="coachPassword" class="form-control" /></td> -->
<!-- 							</tr> -->
<!-- <!-- 							readonly="true"  --> 
<!-- 							<tr> -->
<!-- 								<td align='right'>性別：</td> -->
<!--                         <td><select name="coachGender" id="coachGender" class="form-control"> -->
<!--                                 <option value="NONE" label="請選擇"></option> -->
<!--                                 <option value="男生">男生</option> -->
<!--                                 <option value="女生">女生</option> -->
<!--                             </select> </td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td align='right'>信箱：</td> -->
<!-- 								<td><input name="coachEmail" id="coachEmail" class="form-control" /></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td align='right'>經驗：</td> -->
<!-- 								<td><input name="coachExp" id="coachExp" class="form-control" /></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td align='right'>地址：</td> -->
<!-- 								<td><input name="coachAddress" id="coachAddress" class="form-control" /></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td align='right'>生日：</td> -->
<!-- 								<td><input type="date" name="coachBirth" id="coachBirth" class="form-control" /></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td align='right'>大頭照：</td> -->
<!-- 								<td><input type="file" name="coachPhoto" id="coachPhoto" class="form-control" /></td> -->
<!-- 							</tr> -->
<!-- 							<tr> -->
<!-- 								<td><input type='button' class="btn btn-danger" onclick="addCoach()" value='提交'></td> -->
<!-- 							</tr> -->

<!-- 						</table> -->
<%-- 					</form> --%>


<!-- 				</div> -->
<!-- 				<div class="modal-footer"> -->
<!-- 					<button type="button" class="btn btn-secondary" -->
<!-- 						data-bs-dismiss="modal">Close</button> -->
<!-- 					<button type="button" class="btn btn-primary">Understood</button> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 	</div> -->






</body>
</html>