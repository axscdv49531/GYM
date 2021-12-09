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
<link
    href="https://fonts.googleapis.com/css?family=Poppins:100,100i,200,200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i"
    rel="stylesheet">
<!-- end font family -->
<link rel="stylesheet" href="css/3dslider.css" />
<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
<link href="http://www.jqueryscript.net/css/jquerysctipttop.css"
    rel="stylesheet" type="text/css">
<script src="js/3dslider.js"></script>
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
    $(document).ready(function() {
    });

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
                            history.go(-1)
//                         load();
                        }else{
                            alert("取消失敗")
                            load();
                        }
                     }
                    }
        )
        }
        
        }
    
</script>
</head>
<body>
    <section id="top">
        <div style="width: 1205px; height: 194.13px" class="top">
            <c:import url="/top_memberlogin"></c:import>
        </div>
    </section>

    <!--     <section id="contant" class="contant main-heading team"> -->
    <div class="row">
        <div class="container">
            <div class="col-md-12">
                <div class="feature-post">
                    <div class="feature-img" align='center'>
                        <img
                            src="<c:url value='/getClassPicture?classId='/>${claBean.classId}"
                            class="img-responsives" alt="#" />
                    </div>
                    <div style="background-color: rgb(33, 37, 41);" align='center'
                        class="feature-cont">

                        <div style="width: 960px">
                            <div class="post-people">
                                <div class="left-profile">
                                    <div class="post-info">
                                        <img
                                            src="<c:url value='/administrator/getCoachPicture?coachAccount=' />${coachAccount}"
                                            alt="#" /> <span>
                                            <h4>
                                                by
                                                <c:out value="${claBean.cBean.coachName}"></c:out>
                                            </h4>
                                            <h5>
                                                on
                                                <c:out value="${claBean.classDate}"></c:out>
                                            </h5>
                                        </span>
                                    </div>
                                    <span class="share"></span>
                                </div>
                            </div>
                            <div class="post-heading" align='left'>
                                <h3>
                                    <c:out value="${claBean.className}"></c:out>
                                </h3>
                                <p style="color: #E0E0E0" align="left">
                                    <c:out value="${claBean.classDescription}"></c:out>
                                </p>
                                <div class="full">
                                    <button class='btn' name="${claBean.classAvaliable}"
                                        onclick="cancelConfirm(${claBean.classId})">取消預約</button>
                                    <!--                               <a class="btn" href="#">Read More</a> -->
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
    <!--       </section> -->
    <%--     <c:out value="${claBean.classDescription}"></c:out> --%>

</body>
</html>