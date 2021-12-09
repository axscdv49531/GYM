<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Class Info</title>
   <meta name="keywords" content="">
   <meta name="description" content="">
   <meta name="author" content="">
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
</head>
<body>
<section id="top">
    <div style="width: 1205px; height: 194.13px" class ="top">
        <c:import url="/top_memberlogin"></c:import>
    </div>
    </section>
    
<!--     <section id="contant" class="contant main-heading team"> -->
         <div class="row">
            <div class="container">
               <div class="col-md-12">
                  <div class="feature-post">
                     <div class="feature-img" align='center'>
                        <img src="<c:url value='/getClassPicture?classId='/>${Id}" class="img-responsive" alt="#" />
                     </div>
                     <div style="background-color:rgb(33, 37, 41);" align='center' class="feature-cont">
                     
                     <div style="width:980px">
                        <div class="post-people">
                           <div class="left-profile">
                              <div class="post-info">
                                 <img src="<c:url value='/administrator/getCoachPicture?coachAccount=' />${coachAccount}" alt="#" />
                                 <span>
                                    <h4>by George Kvasnikov</h4>
                                    <h5>on Jun 27, 2014</h5>
                                 </span>
                              </div>
                              <span class="share"></span>
                           </div>
                        </div>
                        <div class="post-heading">
                           <h3>Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium</h3>
                           <p>World CupInternational Club football teamSpanish LeagueReal Madrid Vs Barcelona SpanishNext MatchThe Match Result 
                              UpdateWorld CUPFIFA World CUP 2015International Club football teamEngland30 Jun 10:24FranceReal Madrid Vs Barcelona SpanishManchester 
                              City30 Nov 00:00Manchester.
                           </p>
                           <div class="full">
                              <a class="btn" href="#">Read More</a>
                           </div>
                        </div>
                        </div>
                        
                     </div>
                  </div>
               </div>
            </div>
         </div>
<!--       </section> -->
    
    
</body>
</html>