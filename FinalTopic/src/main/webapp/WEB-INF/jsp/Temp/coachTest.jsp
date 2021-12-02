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
   <meta name="viewport" content="width=device-width, minimum-scale=1.0, maximum-scale=1.0, user-scalable=no">
   <!-- Site Metas -->
   <title>Game Info</title>
   
   <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
   
   $(function load(){
       $.ajax({
           type:'post',
           url:'/administrator/listAllCoach/',
           dataType:'JSON',
           contentType:'application/json',
           success: function(data){
               
               console.log('success:' + data);
               var json = JSON.stringify(data,null,4);
               console.log('json:' + json);
               
               $('#showcoachlist').empty("");
               
               if(data==null){
                   $('table').prepend("<tr><td colspan='2'>暫無資料</td></tr>");;
               }else{
                   var div = $('#showcoachlist');
//                    table.append("<tr id='ptitle'><th>教練大頭照</th><th>教練姓名</th></tr>");
                   
                   $.each(data, function(i,n){
                       var div2 = "<div class='col-md-3 column'><div class='card'><img class='img-responsive' src=" + "<c:url value='/administrator/getCoachPicture?coachAccount=' />" + n.coachAccount + " alt='John' style='width:100%'><div class=''><h4>" + n.coachName + "</h4><p class='title'>" + "aaa" +"</p>"+
                    		   "<p><div class='center'><button class='button'>"+"Contact"+"</button></div></p></div></div></div>"
                    		   ;
                       div.append(div2);
                   });             
               }
           }
       });
   })
</script>
   
   <meta name="keywords" content="">
   <meta name="description" content="">
   <meta name="author" content="">
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
   </head>
   <body class="game_info" data-spy="scroll" data-target=".header">
      <!-- LOADER -->
      <div id="preloader">
         <img class="preloader" src="images/loading-img.gif" alt="">
      </div>
      <!-- END LOADER -->
      <section id="top">
         <header>
            <div class="container">
               <div class="header-top">
                  <div class="row">
                     <div class="col-md-6">
                        <div class="full">
                           <div class="logo">
                              <a href="index.html"><img src="images/logo.png" alt="#" /></a>
                           </div>
                        </div>
                     </div>
                     <div class="col-md-6">
                        <div class="right_top_section">
                           <!-- social icon -->
                           <ul class="social-icons pull-left">
                              <li><a class="facebook" href="#"><i class="fa fa-facebook"></i></a></li>
                              <li><a class="twitter" href="#"><i class="fa fa-twitter"></i></a></li>
                              <li><a class="youtube" href="#"><i class="fa fa-youtube-play"></i></a></li>
                              <li><a class="pinterest" href="#"><i class="fa fa-pinterest-p"></i></a></li>
                           </ul>
                           <!-- end social icon -->
                           <!-- button section -->
                           <ul class="login">
                              <li class="login-modal">
                                 <a href="#" class="login"><i class="fa fa-user"></i>Login</a>
                              </li>
                              <li>
                                 <div class="cart-option">
                                    <a href="#"><i class="fa fa-shopping-cart"></i>Register</a>
                                 </div>
                              </li>
                           </ul>
                           <!-- end button section -->
                        </div>
                     </div>
                  </div>
               </div>
               <div class="header-bottom">
                  <div class="row">
                     <div class="col-md-12">
                        <div class="full">
                           <div class="main-menu-section">
                              <div class="menu">
                                 <nav class="navbar navbar-inverse">
                                    <div class="navbar-header">
                                       <button class="navbar-toggle" type="button" data-toggle="collapse" data-target=".js-navbar-collapse">
                                       <span class="sr-only">Toggle navigation</span>
                                       <span class="icon-bar"></span>
                                       <span class="icon-bar"></span>
                                       <span class="icon-bar"></span>
                                       </button>
                                       <a class="navbar-brand" href="#">Menu</a>
                                    </div>
                                    <div class="collapse navbar-collapse js-navbar-collapse">
                                       <ul class="nav navbar-nav">
                                          <li class="active"><a href="index.html">Home</a></li>
                                          <li><a href="about.html">About</a></li>
                                          <li><a href="team.html">Team</a></li>
                                          <li><a href="news.html">News</a></li>
                                          <li class="dropdown mega-dropdown">
                                             <a href="match" class="dropdown-toggle" data-toggle="dropdown">Match<span class="caret"></span></a>                
                                             <ul class="dropdown-menu mega-dropdown-menu">
                                                <li class="col-sm-8">
                                                   <ul>
                                                      <li class="dropdown-header">Men Collection</li>
                                                      <div id="menCollection" class="carousel slide" data-ride="carousel">
                                                         <div class="carousel-inner">
                                                            <div class="item active">
                                                               <div class="banner-for-match"><a href="#"><img class="img-responsive" src="images/match-banner1.jpg" alt="#" /></a></div>
                                                            </div>
                                                            <!-- End Item -->
                                                            <div class="item">
                                                               <div class="banner-for-match"><a href="#"><img class="img-responsive" src="images/match-banner1.jpg" alt="#" /></a></div>
                                                            </div>
                                                            <!-- End Item -->
                                                            <div class="item">
                                                               <div class="banner-for-match"><a href="#"><img class="img-responsive" src="images/match-banner1.jpg" alt="#" /></a></div>
                                                            </div>
                                                            <!-- End Item -->                                
                                                         </div>
                                                         <!-- End Carousel Inner -->
                                                         <!-- Controls -->
                                                         <a class="left carousel-control" href="#menCollection" role="button" data-slide="prev">
                                                         <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                                                         <span class="sr-only">Previous</span>
                                                         </a>
                                                         <a class="right carousel-control" href="#menCollection" role="button" data-slide="next">
                                                         <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                                                         <span class="sr-only">Next</span>
                                                         </a>
                                                      </div>
                                                      <!-- /.carousel -->
                                                   </ul>
                                                </li>
                                                <li class="col-sm-4">
                                                   <ul class="menu-inner">
                                                      <li class="dropdown-header">Next Matchs</li>
                                                      <li><a href="#">Contrary vs classical</a></li>
                                                      <li><a href="#">Discovered vs undoubtable</a></li>
                                                      <li><a href="#">Contrary vs classical</a></li>
                                                      <li><a href="#">Discovered vs undoubtable</a></li>
                                                      <li><a href="#">Contrary vs classical</a></li>
                                                      <li><a href="#">Discovered vs undoubtable</a></li>
                                                      <li><a href="#">Contrary vs classical</a></li>
                                                      <li><a href="#">Discovered vs undoubtable</a></li>
                                                   </ul>
                                                </li>
                                             </ul>
                                          </li>
                                          <li><a href="blog.html">Blog</a></li>
                                          <li><a href="contact.html">contact</a></li>
                                       </ul>
                                    </div>
                                    <!-- /.nav-collapse -->
                                 </nav>
                                 <div class="search-bar">
                                    <div id="imaginary_container">
                                       <div class="input-group stylish-input-group">
                                          <input type="text" class="form-control"  placeholder="Search" >
                                          <span class="input-group-addon">
                                          <button type="submit"><i class="fa fa-search" aria-hidden="true"></i></button>  
                                          </span>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
            </div>
         </header>
         <div class="inner-page-banner">
            <div class="container">
            </div>
         </div>
         <div class="inner-information-text">
            <div class="container">
               <h3>Our Team</h3>
               <ul class="breadcrumb">
                  <li><a href="index.html">Home</a></li>
                  <li class="active">Our Team</li>
               </ul>
            </div>
         </div>
      </section>
      <section id="contant" class="contant main-heading team">
         <div class="row">
            <div id="showcoachlist" class="container">
<!--                <div class="col-md-3 column"> -->
<!--                   <div class="card"> -->
<!--                      <img class="img-responsive" src="images/img-1-4.jpg" alt="John" style="width:100%"> -->
<!--                      <div class=""> -->
<!--                         <h4>John Doe</h4> -->
<!--                         <p class="title">Designer</p> -->
<!--                         <p> -->
<!--                         <div class="center"><button class="button">Contact</button></div> -->
<!--                         </p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
<!--                <div class="col-md-3 column"> -->
<!--                   <div class="card"> -->
<!--                      <img class="img-responsive" src="images/img-1-2.jpg" alt="Mike" style="width:100%"> -->
<!--                      <div class=""> -->
<!--                         <h4>Mike Ross</h4> -->
<!--                         <p class="title">Art Director</p> -->
<!--                         <p> -->
<!--                         <div class="center"><button class="button">Contact</button></div> -->
<!--                         </p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
<!--                <div class="col-md-3 column"> -->
<!--                   <div class="card"> -->
<!--                      <img class="img-responsive" src="images/img-1-3.jpg" alt="John" style="width:100%"> -->
<!--                      <div class=""> -->
<!--                         <h4>John Doe</h4> -->
<!--                         <p class="title">Designer</p> -->
<!--                         <p> -->
<!--                         <div class="center"><button class="button">Contact</button></div> -->
<!--                         </p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
<!--                <div class="col-md-3 column"> -->
<!--                   <div class="card"> -->
<!--                      <img class="img-responsive" src="images/img-1-4.jpg" alt="John" style="width:100%"> -->
<!--                      <div class=""> -->
<!--                         <h4>John Doe</h4> -->
<!--                         <p class="title">Designer</p> -->
<!--                         <p> -->
<!--                         <div class="center"><button class="button">Contact</button></div> -->
<!--                         </p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
<!--                <div class="col-md-3 column"> -->
<!--                   <div class="card"> -->
<!--                      <img class="img-responsive" src="images/img-1-2.jpg" alt="Mike" style="width:100%"> -->
<!--                      <div class=""> -->
<!--                         <h4>Mike Ross</h4> -->
<!--                         <p class="title">Art Director</p> -->
<!--                         <p> -->
<!--                         <div class="center"><button class="button">Contact</button></div> -->
<!--                         </p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
<!--                <div class="col-md-3 column"> -->
<!--                   <div class="card"> -->
<!--                      <img class="img-responsive" src="images/img-1-3.jpg" alt="John" style="width:100%"> -->
<!--                      <div class=""> -->
<!--                         <h4>John Doe</h4> -->
<!--                         <p class="title">Designer</p> -->
<!--                         <p> -->
<!--                         <div class="center"><button class="button">Contact</button></div> -->
<!--                         </p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
<!--                <div class="col-md-3 column"> -->
<!--                   <div class="card"> -->
<!--                      <img class="img-responsive" src="images/img-1-3.jpg" alt="John" style="width:100%"> -->
<!--                      <div class=""> -->
<!--                         <h4>John Doe</h4> -->
<!--                         <p class="title">Designer</p> -->
<!--                         <p> -->
<!--                         <div class="center"><button class="button">Contact</button></div> -->
<!--                         </p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
<!--                <div class="col-md-3 column"> -->
<!--                   <div class="card"> -->
<!--                      <img class="img-responsive" src="images/img-1-4.jpg" alt="John" style="width:100%"> -->
<!--                      <div class=""> -->
<!--                         <h4>John Doe</h4> -->
<!--                         <p class="title">Designer</p> -->
<!--                         <p> -->
<!--                         <div class="center"><button class="button">Contact</button></div> -->
<!--                         </p> -->
<!--                      </div> -->
<!--                   </div> -->
<!--                </div> -->
            </div>
         </div>
      </section>
      <footer id="footer" class="footer">
         <div class="container">
            <div class="row">
               <div class="col-md-4">
                  <div class="full">
                     <div class="footer-widget">
                        <div class="footer-logo">
                           <a href="#"><img src="images/footer-logo.png" alt="#" /></a>
                        </div>
                        <p>Most of our events have hard and easy route choices as we are always keen to encourage new riders.</p>
                        <ul class="social-icons style-4 pull-left">
                           <li><a class="facebook" href="#"><i class="fa fa-facebook"></i></a></li>
                           <li><a class="twitter" href="#"><i class="fa fa-twitter"></i></a></li>
                           <li><a class="youtube" href="#"><i class="fa fa-youtube-play"></i></a></li>
                           <li><a class="pinterest" href="#"><i class="fa fa-pinterest-p"></i></a></li>
                        </ul>
                     </div>
                  </div>
               </div>
               <div class="col-md-2">
                  <div class="full">
                     <div class="footer-widget">
                        <h3>Menu</h3>
                        <ul class="footer-menu">
                           <li><a href="about.html">About Us</a></li>
                           <li><a href="team.html">Our Team</a></li>
                           <li><a href="news.html">Latest News</a></li>
                           <li><a href="matche.html">Recent Matchs</a></li>
                           <li><a href="blog.html">Our Blog</a></li>
                           <li><a href="contact.html">Contact Us</a></li>
                        </ul>
                     </div>
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="full">
                     <div class="footer-widget">
                        <h3>Contact us</h3>
                        <ul class="address-list">
                           <li><i class="fa fa-map-marker"></i> Lorem Ipsum is simply dummy text of the printing..</li>
                           <li><i class="fa fa-phone"></i> 123 456 7890</li>
                           <li><i style="font-size:20px;top:5px;" class="fa fa-envelope"></i> demo@gmail.com</li>
                        </ul>
                     </div>
                  </div>
               </div>
               <div class="col-md-3">
                  <div class="full">
                     <div class="contact-footer">
                        <iframe src="https://www.google.com/maps/embed?pb=!1m14!1m12!1m3!1d120615.72236587871!2d73.07890527988283!3d19.140910987164396!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!5e0!3m2!1sen!2sin!4v1527759905404" width="600" height="350" frameborder="0" style="border:0" allowfullscreen></iframe>
                     </div>
                  </div>
               </div>
            </div>
         </div>
         <div class="footer-bottom">
            <div class="container">
               <p>Copyright © 2018 Distributor: <a href="https://themewagon.com/" target="_blank">ThemWagon</a></p>
            </div>
         </div>
      </footer>
      <a href="#home" data-scroll class="dmtop global-radius"><i class="fa fa-angle-up"></i></a>
      <!-- ALL JS FILES -->
      <script src="js/all.js"></script>
      <!-- ALL PLUGINS -->
      <script src="js/custom.js"></script>
   </body>
</html>