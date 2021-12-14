<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Front_Header</title>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
   <div class="container px-4 px-lg-5">
	<a class="navbar-brand" href="<c:url value='/login/MemberSuccess' />">Spring Fitness</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
    	<form class="d-flex justify-content-center"style="width:600px" action="<c:url value='/commsearch'/>" method="GET">
	        <input class="form-control me-2" type="search" placeholder="搜尋關鍵字或品號" aria-label="Search" name='q'>
	        <button class="btn btn-success" type="submit">Search</button>
      	</form>
    	<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4 justify-content-end">
            <li class="nav-item"><a class="nav-link" href="<c:url value='/commorder/orderlog'/>">交易紀錄</a></li>
         </ul>
         
         <div class="d-flex">
            <a class="btn btn-outline-light" href="<c:url value='/commcart'/>">
            <i class="bi-cart-fill me-1"></i>Cart<span id='cart' class="badge bg-dark text-white ms-1 rounded-pill">
            	<c:choose>
            		<c:when test="${empty ShoppingCart or ShoppingCart ==null}">0</c:when>
            		<c:otherwise>${ShoppingCart.volume }</c:otherwise>
            	</c:choose>
            	</span>
            </a>
         </div>
         
     </div>
  </div>
</nav>
</body>
</html>