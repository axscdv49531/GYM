<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Commodity Main</title>

<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="../js/bootstrap.min.js"></script>

</head>
<body>

<jsp:include page="/WEB-INF/jsp/commodityshop/front_header.jsp" />

<div class='container'>	
	<div id="carouselExampleCaptions" class="carousel slide" data-bs-ride="carousel"> 
  		<div class="carousel-inner"></div>	
	</div>
	
</div>

<script type="text/javascript">
	
	$(document).ready(function(){
		$.ajax({
			url:"activediscount",
			type:"GET",
			success: function(data){
				console.log(data);
				$.each(data, function(idx, val){
					let docFrag = document.createDocumentFragment();
					let eleDiv = document.createElement("div");
					if (idx == 0){
						eleDiv.setAttribute("class","carousel-item active");
					}else{
						eleDiv.setAttribute("class","carousel-item");
					}
					eleDiv.setAttribute("data-bs-interval","2000");
					let str = "<img src='../discountimg/"+ val.id +"' class='d-block w-100'><div class='carousel-caption d-none d-md-block'><h5>"+ val.name.substring(7)+"</h5><p>"+ val.note+"</p></div>";
					eleDiv.innerHTML = str;
					docFrag.appendChild(eleDiv);
					$(".carousel-inner").append(docFrag);
				})
				$('.carousel').carousel();
		     }
		})
	})
	
</script>
</body>
</html>