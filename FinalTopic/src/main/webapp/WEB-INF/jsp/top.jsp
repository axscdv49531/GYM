<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

            <header>
                <div class="container">
                    <div class="header-top">
                        <div class="row">
                            <div class="col-md-6">
                                <div class="full">
                                    <div class="logo">
                                        <a href="<c:url value='/' />"><img
                                            src="../images/springfitnesslogo1.png" alt="index" /></a> 
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="right_top_section">
                                    <%--                    <c:out value="${loginUser.name },歡迎您" /> --%>
                                    <!-- button section -->
                                    <ul class="login">
                                        <li class="login-modal"><a
                                            href="<c:url value='/login/page' />" class="login"><svg
                                                    xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    fill="currentColor" class="bi bi-person-fill"
                                                    viewBox="0 0 16 16">
                                   <path
                                                        d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
                                 </svg><i class="fa fa-user"></i>密碼變更</a></li>
                                        <li class="logout-modal"><a
                                            href="<c:url value='/logout' />" class="logout"><svg
                                                    xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                    fill="currentColor" class="bi bi-person-fill"
                                                    viewBox="0 0 16 16">
                                   <path
                                                        d="M3 14s-1 0-1-1 1-4 6-4 6 3 6 4-1 1-1 1H3zm5-6a3 3 0 1 0 0-6 3 3 0 0 0 0 6z" />
                                 </svg><i class="fa fa-user"></i>登出</a></li>
                                        <li>
                                            <div class="context-option">
                                                <a href="#"><i class="fa fa-envelope"><svg
                                                            xmlns="http://www.w3.org/2000/svg" width="16" height="16"
                                                            fill="currentColor" class="bi bi-envelope"
                                                            viewBox="0 0 16 16">
                                      <path
                                                                d="M0 4a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2v8a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V4Zm2-1a1 1 0 0 0-1 1v.217l7 4.2 7-4.2V4a1 1 0 0 0-1-1H2Zm13 2.383-4.708 2.825L15 11.105V5.383Zm-.034 6.876-5.64-3.471L8 9.583l-1.326-.795-5.64 3.47A1 1 0 0 0 2 13h12a1 1 0 0 0 .966-.741ZM1 11.105l4.708-2.897L1 5.383v5.722Z" />
                                    </svg></i>聯絡我們</a>
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
                                                    <button class="navbar-toggle" type="button"
                                                        data-toggle="collapse" data-target=".js-navbar-collapse">
                                                        <span class="sr-only">Toggle navigation</span> <span
                                                            class="icon-bar"></span> <span class="icon-bar"></span> <span
                                                            class="icon-bar"></span>
                                                    </button>
                                                    <a class="navbar-brand" href="#">Menu</a>
                                                </div>
                                                <div class="collapse navbar-collapse js-navbar-collapse">
                                                    <ul class="nav navbar-nav">
                                                        <li class="active"><a href="<c:url value='/' />">主頁</a></li>
                                                        <li><a href="about.html">關於</a></li>
                                                        
                                                        <li class="dropdown mega-dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">會員中心<span
                                                                class="caret"></span></a>
                                                            <ul class="dropdown-menu mega-dropdown-menu">
                                                                <li class="col-sm-4">
                                                                    <ul>
                                                                        <li class="dropdown-header">Men Collection</li>
                                                                        <li><a class="dropdown-item" href="#">個人資料</a></li>
                                                                        <li><a class="dropdown-item" href="#">Inbody紀錄</a></li>
                                                                        <li><a class="dropdown-item" href="#">會費紀錄 </a></li>
                                                                        <li><a class="dropdown-item" href="#">儲值紀錄</a></li>
                                                                    </ul>
                                                                </li>
                                                            </ul></li>
                                                            
                                                        <li><a href="<c:url value= '/showCoachList'/>">教練師資</a></li>
                                                        <li><a href="/classRes">預約私人課程</a></li>
                                                        
                                                        <li class="dropdown mega-dropdown"><a href="#" class="dropdown-toggle" data-toggle="dropdown">團體課程<span
                                                                class="caret"></span></a>
                                                            <ul class="dropdown-menu mega-dropdown-menu">
                                                                <li class="col-sm-4">
                                                                    <ul>
                                                                        <li class="dropdown-header">Men Collection</li>
                                                                        <li><a class="dropdown-item" href="/courseSelectSystem">課程表</a></li>
                                                                        <li><a class="dropdown-item" href="/courseSelectSystem">預約課程</a></li>
                                                                        <li><a class="dropdown-item" href="#">課程介紹</a></li>
                                                                        <li><a class="dropdown-item" href="/myCourseSchedule">我的課程</a></li>
                                                                      
                                                                    </ul>
                                                                </li>
                                                            </ul></li>
                                                            
                                                        <li><a href="news.html">健康餐盒</a></li>
                                                        <li><a href="news.html">周邊商品</a></li>

                                                    </ul>
                                                </div>
                                            </nav>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>


