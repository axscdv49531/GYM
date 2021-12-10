<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>課程管理系統</title>

 <meta charset="utf-8" />
    <link rel="apple-touch-icon" sizes="76x76" href="../admintemplate/img/apple-icon.png">
    <link rel="icon" type="image/png" href="../admintemplate/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <!-- CSS Files -->
    <link href="../admintemplate/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../admintemplate/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />
    <!-- CSS Just for demo purpose, don't include it in your project -->
    <link href="../admintemplate/css/demo.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>


<script src="../admintemplate/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="../admintemplate/js/core/popper.min.js" type="text/javascript"></script>
<script src="../admintemplate/js/core/bootstrap.min.js" type="text/javascript"></script>
<!--  Plugin for Switches, full documentation here: http://www.jque.re/plugins/version3/bootstrap.switch/ -->
<script src="../admintemplate/js/plugins/bootstrap-switch.js"></script>
<!--  Google Maps Plugin    -->
<script type="text/javascript" src="https://maps.googleapis.com/maps/api/js?key=YOUR_KEY_HERE"></script>
<!--  Chartist Plugin  -->
<script src="../admintemplate/js/plugins/chartist.min.js"></script>
<!--  Notifications Plugin    -->
<script src="../admintemplate/js/plugins/bootstrap-notify.js"></script>
<!-- Control Center for Light Bootstrap Dashboard: scripts for the example pages etc -->
<script src="../admintemplate/js/light-bootstrap-dashboard.js?v=2.0.0 " type="text/javascript"></script>
<!-- Light Bootstrap Dashboard DEMO methods, don't include it in your project! -->
<script src="../admintemplate/js/demo.js"></script>


<script type="text/javascript">


$(function load() {
    $
            .ajax({
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
                    	$('#showCoach').prepend("<tr><td colspan='2'>暫無資料</td></tr>");
                        ;
                    } else {
                        var div = $('#showCoach');
                                           div.append("<thead style='text-align:center'><th style='text-align:center'>名稱</th><th style='text-align:center'>性別</th><th style='text-align:center'>生日</th><th style='text-align:center'>信箱</th><th style='text-align:center'>手機</th><th style='display:block!important;'>年資</th></thead>");

                        $.each(data,function(i, n) {
                                            var div2 = "<tr align='center'>" + "<td style='text-align:left'>" + n.coachName + "</td>" +"<td style='text-align:left'>" + n.coachGender + "</td>" +"<td style='text-align:left'>" + n.coachBirth + "</td>" + "<td style='text-align:left'>" + n.coachEmail + "</td>" +"<td style='text-align:left'>" + n.coachPhone + "</td>" +"<td style='text-align:left'>" + n.coachExp+ "</td>" +"</tr>" ;
                                            div.append(div2);
                                        });
                    }
                        
                }
            });
})
</script>
</head>
<body>
	<div class="wrapper">
		<c:import url="/adminCoursesidebar"></c:import>
		<div class="main-panel">
			<c:import url="/adminnavbar"></c:import>
			<div class="content">
				<div class="container-fluid"></div>
				
				
				
    <div class="col-md-12">
       <div class="card card-plain table-plain-bg">
            <div class="card-header ">
               <h4 class="card-title">課程學生列表</h4>
                <p class="card-category">顯示該課程學生清單</p>
            </div>
            <div class="card-body table-full-width table-responsive">
                <table id="showCoach" class="table table-hover"></table>
            </div>
       </div>
    </div>
    
</div>
				
				</div>
				
			</div>
</body>
</html>