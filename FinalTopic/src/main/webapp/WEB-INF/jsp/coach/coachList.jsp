<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- Basic -->
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- Mobile Metas -->
<meta name="viewport"
	content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
<!-- Site Metas -->
<title>Game Info</title>
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
<link
	href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- end font family -->
<link rel="stylesheet" href="css/3dslider.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css"
	rel="stylesheet" type="text/css">
<script src="js/3dslider.js"></script>
</head>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">

function showCoachClassList(coachId){
	console.log(coachId)
	$.ajax({
        type : 'post',
        url : '/member/classReservation/',
        data:{
        	coachIdd : coachId
        },
        dataType : 'JSON',
        contentType : 'application/json',
        success : function(data) {
        	
        }
        })
	
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

						$('#showcoachlist').empty("");

						if (data == null) {
							$('table').prepend(
									"<tr><td colspan='2'>暫無資料</td></tr>");
							;
						} else {
							var div = $('#showcoachlist');
							//                    table.append("<tr id='ptitle'><th>教練大頭照</th><th>教練姓名</th></tr>");

							$
									.each(
											data,
											function(i, n) {
												var div2 = "<div class='col-md-3 column' style='padding-right:15px;padding-left:15px'><div style='border-radius:0' class='card'><img class='img-responsive' src="
														+ "<c:url value='/administrator/getCoachPicture?coachAccount=' />"
														+ n.coachAccount
														+ " alt='John' style='width:100%'><div class='center'><h4 style='margin: 20px 0 0 0;'>"
														+ n.coachName
														+ "</h4><p class='title'>性別："
														+ n.coachGender+"</p>"
														+ "<p class='title'>執教經驗："
                                                        + n.coachExp+"年</p>"
                                                        +"<p class='title'>信箱："
                                                        + n.coachEmail+"</p>"
                                                        +"<p><div class='center'><input type='button' style='float:none' class='btn' value='看他的課' onclick=" + "location.href='/member/classReservation?Id=" + n.coachName + "' /></div></p></div></div></div>";
												div.append(div2);
											});
						}
					}
				});
	})
</script>
<body>
    <section id="top">
    <div class ="top">
        <c:import url="/top_memberlogin"></c:import>
    </div>
    </section>
          <section style="background-color:white;" id="contant" class="contant main-heading team">
	<div class="row">
		<div class="container">
			<div id="showcoachlist" border="1"></div>
		</div>
	</div>
	</section>
</body>
</html>