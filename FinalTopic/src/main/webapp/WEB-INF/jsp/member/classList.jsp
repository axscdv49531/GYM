<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<<<<<<< HEAD
<meta charset="UTF-8">
<title>Insert title here</title>
 <title>Workout &mdash; Website Template by Colorlib</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

  
  <link href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900" rel="stylesheet">
  <link rel="stylesheet" href="fonts/icomoon/style.css">

  <link rel="stylesheet" href="css/bootstrap.min.css">
  <link rel="stylesheet" href="css/jquery-ui.css">
  <link rel="stylesheet" href="css/owl.carousel.min.css">
  <link rel="stylesheet" href="css/owl.theme.default.min.css">
  <link rel="stylesheet" href="css/owl.theme.default.min.css">

  <link rel="stylesheet" href="css/jquery.fancybox.min.css">

  <link rel="stylesheet" href="css/bootstrap-datepicker.css">

  <link rel="stylesheet" href="fonts/flaticon/font/flaticon.css">

  <link rel="stylesheet" href="css/aos.css">
  <link href="css/jquery.mb.YTPlayer.min.css" media="all" rel="stylesheet" type="text/css">

  <link rel="stylesheet" href="css/style.css">

</head>
<body data-spy="scroll" data-target=".site-navbar-target" data-offset="300">
=======
<title>Workout &mdash; Website Template by Colorlib</title>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">


<link
	href="https://fonts.googleapis.com/css?family=Muli:300,400,700,900"
	rel="stylesheet">
<link rel="stylesheet" href="fonts_classlist/icomoon/style.css">

<link rel="stylesheet" href="css_classlist/bootstrap.min.css">
<link rel="stylesheet" href="css_classlist/jquery-ui.css">
<link rel="stylesheet" href="css_classlist/owl.carousel.min.css">
<link rel="stylesheet" href="css_classlist/owl.theme.default.min.css">
<link rel="stylesheet" href="css_classlist/owl.theme.default.min.css">

<link rel="stylesheet" href="css_classlist/jquery.fancybox.min.css">

<link rel="stylesheet" href="css_classlist/bootstrap-datepicker.css">

<link rel="stylesheet" href="fonts_classlist/flaticon/font/flaticon.css">

<link rel="stylesheet" href="css_classlist/aos.css">
<link href="css_classlist/jquery.mb.YTPlayer.min.css" media="all"
	rel="stylesheet" type="text/css">

<link rel="stylesheet" href="css_classlist/style.css">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		load();
	});

	//     function search() {
	//         var className = document.getElementById("searchByClassName").value;
	//         var startDate = document.getElementById("searchByDateStart").value;
	//         var endDate = document.getElementById("searchByDateEnd").value;
	//         var skillTemp = document.getElementById("searchBySkillName");
	//         var skillName = skillTemp.value;
	//         var coachNameTemp = document.getElementById("searchByCoachName");
	//         var coachName = coachNameTemp.value;
	//         var statusTemp = document.getElementById("searchByClassStatus");
	//         var status = statusTemp.value;

	//         $
	//                 .ajax({
	//                     type : 'post',
	//                     url : '/searchClass/',
	//                     data : {
	//                         cName : className,
	//                         coaName : coachName,
	//                         sName : skillName,
	//                         sDate : startDate,
	//                         eDate : endDate,
	//                         cStatus : status
	//                     },
	//                     dataType : 'JSON',
	//                     success : function(data) {
	//                         console.log('success:' + data);
	//                         var json = JSON.stringify(data, null, 4);
	//                         console.log('json:' + json);

	//                         $('#showclasslist').empty("");

	//                         if (data == null) {
	//                             $('table').prepend(
	//                                     "<tr><td colspan='2'>暫無資料</td></tr>");
	//                             ;
	//                         } else {
	//                             var table = $('#showclasslist');
	//                             table
	//                                     .append("<tr id='ptitle'><th>課程名稱</th><th>教練姓名</th><th>開課日期</th><th>課程開始時間</th><th>課程結束時間</th><th>課程時數</th><th>價格</th><th>訓練部位</th><th>報名狀況</th></tr>");

	//                             $
	//                                     .each(
	//                                             data,
	//                                             function(i, n) {
	//                                                 var status = null;
	//                                                 if (n.classAvaliable == 0) {
	//                                                     status = "未額滿"
	//                                                 } else {
	//                                                     status = "已額滿"
	//                                                 }
	//                                                 var a = [];
	//                                                 for (i in n.sBean) {
	//                                                     a
	//                                                             .push(n.sBean[i].skillName)
	//                                                 }
	//                                                 var tr = "<tr align='center'>"
	//                                                         + "<td>"
	//                                                         + n.className
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + n.cBean.coachName
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + n.classDate
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + n.classStartTime
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + n.classEndTime
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + n.classDuration
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + n.classPrice
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + a
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + status
	//                                                         + "</td>"
	//                                                         + "<td>"
	//                                                         + "<input type='button' value='查看' onclick=\"location.href='" + "/member/viewClass/" + n.classId +"'\"></td>"
	//                                                         + "</tr>";
	//                                                 table.append(tr);
	//                                             });
	//                         }
	//                     }
	//                 });

	//     }

	//     function show(asd) {
	//         var s;
	//         var ss = [];
	//         for (var i = 0; i < asd.length; i++) {
	//             s = asd[i]['skillName'];
	//             console.log(s)
	//             ss.push(s)
	//         }
	//         return 'aaa';
	//     }

	function load(a, startDate, endDate) {
		$
				.ajax({
					type : 'post',
					url : '/listAllClass/',
					dataType : 'JSON',
					//                  contentType : 'application/json',
					success : function(data) {
						console.log('success:' + data);
						var json = JSON.stringify(data, null, 4);
						console.log('json:' + json);
>>>>>>> mark_1201

<div class="site-section" id="classes-section">
      <div class="container">
        <div class="row justify-content-center text-center mb-5">
          <div class="col-md-8  section-heading">
            <span class="subheading">Fitness Class</span>
            <h2 class="heading mb-3">Our Classes</h2>
            <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quis consequatur cum neque?
            Separated they live in Bookmarksgrove right at the coast of the Semantics, a large language ocean.</p>
          </div>
        </div>
<!--         <div class="row"> -->
<!--           <div class="col-lg-6"> -->
<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_1.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #1</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->

<<<<<<< HEAD
<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_2.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #2</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->

<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_3.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #3</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->
            
<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_4.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #4</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->

<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_1.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #5</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->
            
           
<!--           </div> -->
<!--           <div class="col-lg-6"> -->
<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_1.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #1</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->
            
<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_2.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #2</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->
            
<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_3.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #3</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->
            
<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_4.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #4</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
<!--               </div> -->
<!--             </div> -->
            
<!--             <div class="class-item d-flex align-items-center"> -->
<!--               <a href="single.html" class="class-item-thumbnail"> -->
<!--                 <img src="images/img_1.jpg" alt="Image"> -->
<!--               </a> -->
<!--               <div class="class-item-text"> -->
                
<!--                 <h2><a href="single.html">Fitness Class Name #5</a></h2> -->
<!--                 <span>By Justin Daniel</span>, -->
<!--                 <span>30 minutes</span> -->
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

=======
						if (data == null) {
							$('table').prepend(
									"<tr><td colspan='2'>暫無資料</td></tr>");
							;
						} else {
							var div = $('#showclasslist');

							$
									.each(
											data,
											function(i, n) {
												var status = null;
												if (n.classAvaliable == 0) {
													status = "未額滿"
												} else {
													status = "已額滿"
												}
												var a = [];
												for (i in n.sBean) {
													a
															.push(n.sBean[i].skillName)
												}
												var div2 = "<div style='width:1115px' class='class-item d-flex align-items-center'><a href='single.html' class='class-item-thumbnail'><img src=" + "<c:url value='/getClassPicture?classId=' />" + n.classId + " alt='Image'></a><div class='class-item-text'>"
														+ "<h2><a href='single.html'>"
														+ n.className
														+ "</a></h2><div><span>By "
														+ n.cBean.coachName
														+ "</span></div><div><span>Date："
														+ n.classDate
														+ "</span></div><div><span>Start At：" + n.classStartTime + "</span></div><div><span>Duration：" + n.classDuration + " hours</span></div></div></div>"
														
// 														<span style='position:absolute;right:0px;bottom:0px'>"
//                                                         + n.classDate
//                                                         + "</span>
														
												//                                                         + "<td>"
												//                                                         + n.className
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + n.cBean.coachName
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + n.classDate
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + n.classStartTime
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + n.classEndTime
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + n.classDuration
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + n.classPrice
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + a
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + status
												//                                                         + "</td>"
												//                                                         + "<td>"
												//                                                         + "<input type='button' value='查看' onclick=\"location.href='" + "/viewClass/" + n.classId +"'\"></td>"
												//                                                         + "</tr>";
												div.append(div2);
											});
						}
					}
				});
	}
</script>

</head>
<body>

	<div class="site-section" id="classes-section">
		<div class="container">
			<div class="row justify-content-center text-center mb-5">
				<div class="col-md-8  section-heading">
					<span class="subheading">Fitness Class</span>
					<h2 class="heading mb-3">Our Classes</h2>
					<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
						Quis consequatur cum neque? Separated they live in Bookmarksgrove
						right at the coast of the Semantics, a large language ocean.</p>
				</div>
			</div>


			<div class="row">
				<div class="col-lg-6">
					<div id="showclasslist" border="1"></div>
				</div>
			</div>
		</div>
	</div>

>>>>>>> mark_1201
</body>
</html>