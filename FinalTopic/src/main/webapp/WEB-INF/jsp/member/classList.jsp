<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">


<link
	href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900"
	rel="stylesheet">
<link rel="stylesheet" href="../fonts_classlist/icomoon/style.css">

<link rel="stylesheet" href="../css_classlist/bootstrap.min.css">
<link rel="stylesheet" href="../css_classlist/jquery-ui.css">
<link rel="stylesheet" href="../css_classlist/owl.carousel.min.css">
<link rel="stylesheet" href="../css_classlist/owl.theme.default.min.css">
<link rel="stylesheet" href="../css_classlist/owl.theme.default.min.css">

<link rel="stylesheet" href="../css_classlist/jquery.fancybox.min.css">

<link rel="stylesheet" href="../css_classlist/bootstrap-datepicker.css">

<link rel="stylesheet" href="../fonts_classlist/flaticon/font/flaticon.css">

<link rel="stylesheet" href="../css_classlist/aos.css">
<link href="../css_classlist/jquery.mb.YTPlayer.min.css" media="all"
	rel="stylesheet" type="text/css">

<link rel="stylesheet" href="../css_classlist/style.css">









</head>
<body data-spy="scroll" data-target=".site-navbar-target"
	data-offset="300">

	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			load();
		});
		
		function resvConfirm(y){
			x = confirm("請確認是否要預約課程？");
			console.log(x)
			console.log(y)
			if(x){
			$.ajax({
                        type : 'post',
                        url : '/classReservationCheck/',
                        data : {
                            classConfirm : x,
                            classId : y
                        },
                        dataType : 'JSON',
                        complete: function(data) {
                        	if(data.responseText == 'true'){
                        		alert("預約成功");
                            load();
                        	}else{
                        		alert("預約失敗")
                        		load();
                        	}
                         }
                        //                  contentType : 'application/json',
//                         success : function(data){ 
//                         	load();
//                         }
                        }
			)
			}
			
			}
		
		
		
		function searchDelete(){
			document.getElementById("searchByClassName").value = "";
			document.getElementById("searchByCoachName").selectedIndex=0;
			document.getElementById("searchBySkillName").selectedIndex=0;
			document.getElementById("searchByClassStatus").selectedIndex=0;
			$('input[type=date]').val('');
			load();
		}

		
		function search() {
	        var className = document.getElementById("searchByClassName").value;
	        var startDate = document.getElementById("searchByDateStart").value;
	        var endDate = document.getElementById("searchByDateEnd").value;
	        var skillTemp = document.getElementById("searchBySkillName");
	        var skillName = skillTemp.value;
	        var coachNameTemp = document.getElementById("searchByCoachName");
	        var coachName = coachNameTemp.value;
	        //      var statusTemp = document.getElementById("searchByClassStatus");
	        //      var status = coachNameTemp.value;
	        var statusTemp = document.getElementById("searchByClassStatus");
	        var status = statusTemp.value;
	        
	        if(startDate.length == 0 || endDate.length == 0){
	        	$('input[type=date]').val('');
	        }

	        $.ajax({
	                    type : 'post',
	                    url : '/searchClass/',
	                    data : {
	                        cName : className,
	                        coaName : coachName,
	                        sName : skillName,
	                        sDate : startDate,
	                        eDate : endDate,
	                        cStatus : status
	                    },
	                    dataType : 'JSON',
	                    //                  contentType : 'application/json',
	                    success : function(data) {
	                    	var j = 0;
                            var k = 0;
//                             console.log(data.length);
                            
                            if(data.length%2 == 1){
                                k=(data.length+1)/2;
                            }else{
                                k=data.length/2;
                            }
                            
                            
                            
                            console.log('success:' + data);
                            var json = JSON.stringify(data, null, 4);
                            console.log('json:' + json);
                            $('#showclasslist').empty("");
                            $('#showclasslistsec').empty("");
                            
                            if (data == null) {
                                $('table').prepend(
                                        "<tr><td colspan='2'>暫無資料</td></tr>");
                                ;
                            } else {
                                var div = $('#showclasslist');
                                var div3 = $('#showclasslistsec');

                                $.each(data,function(i, n) {
                                                    var status = null;
                                                    if (n.classAvaliable == 0) {
                                                        status = "未額滿"
                                                    } else {
                                                        status = "已額滿"
                                                    }
                                                    var a = [];
                                                    for (i in n.sBean) {
                                                        a.push(n.sBean[i].skillName)
                                                    }
//                                                  console.log(i);


// $("button[name='1']").each(function() {
//                                                             $(this).prop('disabled', true).text("已額滿");
//                                                         })

                                                    if(j<k){
//                                                     	$("button[name='1']").each(function() {
//                                                             $(this).prop('disabled', true).text("已額滿");
//                                                         })
//                                                      style='width:1115px'
                                                    var div2 = "<div class='class-item d-flex align-items-center'><a href='single.html' class='class-item-thumbnail'><img src="
                                                            + "<c:url value='/getClassPicture?classId=' />"
                                                            + n.classId
                                                            + " alt='Image'></a><div class='class-item-text'>"
                                                            + "<h2><a href='single.html'>"
                                                            + n.className
                                                            + "</a></h2><div><span>By "
                                                            + n.cBean.coachName
                                                            + "</span></div><div><span>Date："
                                                            + n.classDate
                                                            + "</span></div><div><span>Start At："
                                                            + n.classStartTime
                                                            + "</span></div><div><span>Duration："
                                                            + n.classDuration
                                                            + " hours</span></div></div><div><button style='position:absolute; right:0; bottom:1'>查看</button><button name='" + n.classAvaliable+"' style='position:absolute; right:2; bottom:1' onclick='resvConfirm(" + n.classId + ")'>立即預約</button></div></div>"
                                                    div.append(div2);
                                                            j++;
                                                            $("button[name='1']").prop('disabled', true).text("已額滿");
                                                    }else{
//                                                     	$("button[name='1']").each(function() {
//                                                             $(this).prop('disabled', true).text("已額滿");
//                                                         })
//                                                        style='width:1115px'
                                                        var div4 = "<div class='class-item d-flex align-items-center'><a href='single.html' class='class-item-thumbnail'><img src="
                                                                + "<c:url value='/getClassPicture?classId=' />"
                                                                + n.classId
                                                                + " alt='Image'></a><div class='class-item-text'>"
                                                                + "<h2><a href='single.html'>"
                                                                + n.className
                                                                + "</a></h2><div><span>By "
                                                                + n.cBean.coachName
                                                                + "</span></div><div><span>Date："
                                                                + n.classDate
                                                                + "</span></div><div><span>Start At："
                                                                + n.classStartTime
                                                                + "</span></div><div><span>Duration："
                                                                + n.classDuration
                                                                + " hours</span></div></div><div><button style='position:absolute; right:0; bottom:1'>查看</button><button name='" + n.classAvaliable+"' style='position:absolute; right:2; bottom:1' onclick='resvConfirm(" + n.classId + ")'>立即預約</button></div></div>"
                                                        div3.append(div4);
                                                                j++;
                                                                $("button[name='1']").prop('disabled', true).text("已額滿");
                                                        }
                                                });
                            }
	                    }
	                    }
	                )};
	        
		
		

		function load() {
			$.ajax({
						type : 'post',
						url : '/listAllClass/',
						dataType : 'JSON',
						//                  contentType : 'application/json',
						success : function(data) {
							var j = 0;
							var k = 0;
							
							
							if(data.length%2 == 1){
								k=(data.length+1)/2;
							}else{
								k=data.length/2;
							}
							
							
							
							console.log('success:' + data);
							var json = JSON.stringify(data, null, 4);
							console.log('json:' + json);
							
							$('#showclasslist').empty("");
                            $('#showclasslistsec').empty("");
							if (data == null) {
								$('table').prepend(
										"<tr><td colspan='2'>暫無資料</td></tr>");
								;
							} else {
								var div = $('#showclasslist');
								var div3 = $('#showclasslistsec');

								$.each(data,function(i, n) {
													var status = null;
													if (n.classAvaliable == 0) {
														status = "未額滿"
													} else {
														status = "已額滿"
													}
													var a = [];
													for (i in n.sBean) {
														a.push(n.sBean[i].skillName)
													}
// 													console.log(i);

//    $("button[name='1']").each(function() {
//                                                                 $(this).prop('disabled', true).text("已額滿");
//                                                             })
													if(j<k){
														
// 											              $("button[name='1']").each(function() {
// 											                    $(this).prop('disabled', true).text("已額滿");
// 											                })
// 														style='width:1115px'
													var div2 = "<div class='class-item d-flex align-items-center'><a href='single.html' class='class-item-thumbnail'><img src="
															+ "<c:url value='/getClassPicture?classId=' />"
															+ n.classId
															+ " alt='Image'></a><div class='class-item-text'>"
															+ "<h2><a href='single.html'>"
															+ n.className
															+ "</a></h2><div><span>By "
															+ n.cBean.coachName
															+ "</span></div><div><span>Date："
															+ n.classDate
															+ "</span></div><div><span>Start At："
															+ n.classStartTime
															+ "</span></div><div><span>Duration："
// 															+ n.classDuration
															+ " hours</span></div></div><div><button style='position:absolute; right:0; bottom:1'>查看</button><button name='" + n.classAvaliable+"' style='position:absolute; right:2; bottom:1' onclick='resvConfirm(" + n.classId + ")'>立即預約</button></div></div>"
													div.append(div2);
															j++;
															$("button[name='1']").prop('disabled', true).text("已額滿");
													}else{
														
// 											              $("button[name='1']").each(function() {
// 											                    $(this).prop('disabled', true).text("已額滿");
// 											                })
//	                                                      style='width:1115px'
	                                                    var div4 = "<div class='class-item d-flex align-items-center'><a href='single.html' class='class-item-thumbnail'><img src="
	                                                            + "<c:url value='/getClassPicture?classId=' />"
	                                                            + n.classId
	                                                            + " alt='Image'></a><div class='class-item-text'>"
	                                                            + "<h2><a href='single.html'>"
	                                                            + n.className
	                                                            + "</a></h2><div><span>By "
	                                                            + n.cBean.coachName
	                                                            + "</span></div><div><span>Date："
	                                                            + n.classDate
	                                                            + "</span></div><div><span>Start At："
	                                                            + n.classStartTime
	                                                            + "</span></div><div><span>Duration："
	                                                            + n.classDuration
	                                                            + " hours</span></div></div><div><button style='position:absolute; right:0; bottom:1'>查看</button><button name='" + n.classAvaliable+"' style='position:absolute; right:2; bottom:1' onclick='resvConfirm(" + n.classId + ")'>立即預約</button></div></div>"
	                                                    div3.append(div4);
	                                                            j++;
	                                                            $("button[name='1']").prop('disabled', true).text("已額滿");
	                                                    }
												});
							}
						}
					});
		}
	</script>
</head>
<body style="line-height: 1.7;font-weight: 300;font-size: 1.1rem;color: #989898;">
<%-- <jsp:include page="/WEB-INF/jsp/top_memberlogin.jsp" /> --%>
<body data-spy="scroll" data-target=".site-navbar-target"
    data-offset="300">
	<div class="site-section" id="classes-section">
		<div class="container">
			<div class="row justify-content-center text-center mb-5">
				<div class="col-md-8  section-heading">
					<span class="subheading">Fitness Class</span>
					<h2 class="heading mb-3">一對一私人課程清單</h2>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
						Quis consequatur cum neque? Separated they live in Bookmarksgrove
						right at the coast of the Semantics, a large language ocean.</p>
				</div>
			</div>

課程名稱：
    <input type="text" placeholder="輸入內容" id="searchByClassName">
    <!--    價格：<input type="text" placeholder="輸入內容" id="searchByClassPrice"> -->
    教練名稱：
    <select name="select" id="searchByCoachName">
        <option selected="selected">請選擇</option>
        <c:forEach items="${coachList}" var="coach">
            <option value="${coach}"><c:out value="${coach}" /></option>
        </c:forEach>
    </select> 訓練部位：
    <select name="select" id="searchBySkillName">
        <option selected="selected">請選擇</option>
        <c:forEach items="${skillList}" var="skill">
            <option value="${skill.skillName}"><c:out
                    value="${skill.skillName}" /></option>
        </c:forEach>
    </select> 開課狀況：
    <select name="select" id="searchByClassStatus">
        <option selected="selected">請選擇</option>
        <option value="0">未額滿</option>
        <option value="1">已額滿</option>
    </select> <hr>
    開課日期：
    <input type="date" id="searchByDateStart"> 至
    <input type="date" id="searchByDateEnd">
    <button onclick="search()">搜尋</button>
    <button onclick="searchDelete()">清除搜尋</button><hr>

			<div class="row">
				<div class="col-lg-6">
					<div id="showclasslist" border="1"></div>
				</div>
				<div class="col-lg-6">
					<div id="showclasslistsec" border="1"></div>
				</div>
			</div>
		</div>
	</div>
	
<!-- 	<div><button name="1" style="position:absolute; right:0; bottom:0">123</button></div> -->

<!--     <div style="width: 1205px; height: 194.13px" class ="top"> -->
<%--         <c:import url="/top_memberlogin"></c:import> --%>
<!--     </div> -->
</body>
</html>