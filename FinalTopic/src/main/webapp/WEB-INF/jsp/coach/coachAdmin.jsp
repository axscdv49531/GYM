<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>課程管理系統</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
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
                    $('#showCoach').append('#showCoacha');

                    if (data == null) {
                    	$('#showCoach').prepend("<tr><td colspan='2'>暫無資料</td></tr>");
                        ;
                    } else {
                        var div = $('#showCoach');
                                           div.append("<thead><tr><th>教練名稱</th><th>教練信箱</th></tr></thead>");

                        $.each(data,function(i, n) {
                                            var div2 = "</thead><tr><td>" + n.coachName + "</td><td>" + n.coachEmail + "</td>"
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
				<div id="showCoach">
				<div id="showCoacha" class="col-md-12">
                        <div class="card">
                            <div class="header">
                                <h4 class="title">教練清單</h4>
                                <p class="category">Coach List</p>
                            </div>
                            <div class="content table-responsive table-full-width">
                                <table class="table table-hover table-striped">
                                
                                </table>

                            </div>
                        </div>
                    </div>
				
				</div>
				
			</div>
		</div>
	</div>
</body>
</html>