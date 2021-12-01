<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Commodity Main</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css" integrity="sha384-AYmEC3Yw5cVb3ZcuHtOA93w35dYTsvhLPVnYs9eStHfGJvOvKxVfELGroGkvsg+p" crossorigin="anonymous"/>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light sticky-top">
   <div class="container px-4 px-lg-5">
	<a class="navbar-brand" href="#!">Start Bootstrap</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation"><span class="navbar-toggler-icon"></span></button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
    	<form class="d-flex justify-content-center" action='search' method='GET'>
	        <input class="form-control me-2" type="search" placeholder="Search" aria-label="Search" name='q'>
	        <button class="btn btn-outline-success" type="submit">Search</button>
      	</form>
    	<ul class="navbar-nav me-auto mb-2 mb-lg-0 ms-lg-4">
            <li class="nav-item"><a class="nav-link" href="#!">查看訂單歷史</a></li>
         </ul>
         
         <div class="d-flex">
            <a class="btn btn-outline-dark" href='cart'>
            <i class="bi-cart-fill me-1"></i>Cart<span id='cart' class="badge bg-dark text-white ms-1 rounded-pill">0</span>
            </a>
         </div>
     </div>
  </div>
</nav>
<div class='container'>
購物車數量:<p id="cart"></p>
<a href="order/orderHistory">查看訂單歷史</a>
<div id="commList" class="row row-cols-1 row-cols-md-4 g-4"></div>
</div>

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	
	function addToCart(id){
		$.ajax({
			url: "addToCart",
			type: "POST",
			data: {id: id,
					qty: 1},
			success: function(data){
						let arr = Object.values(data);
						let volume = 0;
						$.each(arr, function(idx, value){
							volume += value.orderQty;
						})
						$("#cart").html(volume);
			}	
		})
	}
	
	$(document).ready(function(){
		$.ajax({
			url:"commodity",
			type:"GET",
			success: function(data){
				console.log(data);
				let jsonstr = JSON.stringify(data, null, 4);
				let json = $.parseJSON(jsonstr);
				console.log(json)
				showData(json);
		     }
		})
	})
	
	function showData(data){	    
	    let showList = document.getElementById("commList");
	    let commFrag = document.createDocumentFragment();
	
	    $.each(data, function(idx, value){
	    	let div1 = document.createElement("div");
	    	div1.className = "col";
	        let div2 = document.createElement("div");
	        div2.className = "card h-50";
	        
	        let str = "<div class='card-img-top text-center' style='height:10%'><img src='../imgs/"+ value.itemId+"/"+ value.commodityImgs[0].imgSrc+"' style='max-height:100%; width:auto'></div>";
	        str += "<div class='card-body'><small class='text-muted'># "+ value.itemId +"</small><p class='card-text lh-sm'>"+ value.itemName +"</p><p class='lh-sm fw-light' style='font-size: 0.5rem'>"+ value.itemDesc +"</p>";
	        str += "<h5 class='card-title'>NT$ "+ value.unitPrice +"</h5><a id='addCart' href='#' onclick='addToCart(" + value.itemId + ")' class='btn btn-primary btn-sm'><i class='fas fa-cart-plus'></i></a>";
	
	        div2.innerHTML=str;
	        div1.appendChild(div2);
	        commFrag.appendChild(div1);
	        showList.appendChild(commFrag);
	    })
	}
</script>
</body>
</html>