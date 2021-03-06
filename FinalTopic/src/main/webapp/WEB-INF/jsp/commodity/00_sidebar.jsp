<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>


	<link rel="apple-touch-icon" sizes="76x76" href="../admintemplate/img/apple-icon.png">
    <link rel="icon" type="image/png" href="../admintemplate/img/favicon.ico">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
    <title>Light Bootstrap Dashboard - Free Bootstrap 4 Admin Dashboard by Creative Tim</title>
    <meta content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0, shrink-to-fit=no' name='viewport' />
    <!--     Fonts and icons     -->
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700,200" rel="stylesheet" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/latest/css/font-awesome.min.css" />
    <!-- CSS Files -->
    <link href="../admintemplate/css/bootstrap.min.css" rel="stylesheet" />
    <link href="../admintemplate/css/light-bootstrap-dashboard.css?v=2.0.0 " rel="stylesheet" />

<!--   Core JS Files   -->
<script src="../admintemplate/js/core/jquery.3.2.1.min.js" type="text/javascript"></script>
<script src="../admintemplate/js/core/popper.min.js" type="text/javascript"></script>
<script src="../admintemplate/js/core/bootstrap.min.js" type="text/javascript"></script>


        <div class="sidebar" data-image="../admintemplate/img/sidebar-0.jpg" data-color="red">
            <!--
        Tip 1: You can change the color of the sidebar using: data-color="purple | blue | green | orange | red"

        Tip 2: you can also add an image using data-image tag
    -->
            <div class="sidebar-wrapper">
                <div class="logo">
                    <a href="#" class="simple-text">
                        周邊商品專區
                    </a>
                </div>
                
                <ul class="nav">
                	 <li class="nav-item active">
                        <a class="nav-link" href="<c:url value='/adminindex' />">
                            <i class="nc-icon nc-chart-pie-35"></i>
                            <p>回管理者首頁</p>
                        </a>
                    </li>
                    
                    <li>
                        <a class="nav-link" href="<c:url value='/admin/itemType'/>">
                            <i class="nc-icon nc-layers-3"></i>
                            <p>分類管理</p>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="<c:url value='/admin/commodity'/>">
                            <i class="nc-icon nc-grid-45"></i>
                            <p>商品管理</p>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="<c:url value='/admin/ordersys'/>">
                            <i class="nc-icon nc-single-copy-04"></i>
                            <p>訂單管理</p>
                        </a>
                    </li>
                    <li>
                        <a class="nav-link" href="<c:url value='/admin/discountrule'/>">
                            <i class="nc-icon nc-bulb-63"></i>
                            <p>折扣管理</p>
                        </a>
                    </li>
                    <li class="nav-item active active-pro">
                        <a class="nav-link active" href="/">
                            <i class="nc-icon nc-alien-33"></i>
                            <p>Back to Spring Fitness</p>
                        </a>
                    </li>
                </ul>
            </div>
        </div>
