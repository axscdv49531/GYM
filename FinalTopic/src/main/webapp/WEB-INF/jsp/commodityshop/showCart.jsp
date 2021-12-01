<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping Cart</title>
</head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
	body{
		background-color: #f2f2f2;
	}
</style>
<body>
<div class='container'>
	<h3>--------[購物車]-------</h3>
	${orderErrMsg }
	<div id="cartMain">
		<table class="table">
			<thead><tr><th><button type="button" class="btn btn-secondary btn-sm" onclick="remove()">刪除</button></th><th>產品編號 | 名稱</th><th>單價</th><th>數量</th><th>小計 SubToal</th></tr></thead>
			<tbody id="tb"></tbody>
		</table>
	</div>
	<button id='btnCheckOut' type="button" class="btn btn-danger" onclick="checkOut()">結帳</button>
	<p><a href="list">繼續購物</a></p>
	
	<div id='checkOut'>
		<table class="table caption-top">
		<caption>訂購人資料</caption>
		<tr><td>姓名: </td><td>*誥*</td></tr>
		<tr><td>E-mail: </td><td>後續串接會員帶入資料</td></tr>
		<tr><td>手機號碼: </td><td>****-******</td></tr>
		</table>
		<form action="order/processOrder2" method="POST">
		<table class="table caption-top"><caption>提貨資訊</caption>
		<tr><td>會員編號</td><td><input type="text" name="memberId"/></td></tr>
		<tr><td>提貨日: </td><td><input type="datetime" name="pickUpDate" pattern="[0-9]{4}-[0-9]{2}-[0-9]{2} [0-9]{2}:[0-9]{2}" required/><p class="form-text">格式: 2021-11-30 10:30</p></td></tr>
		</table>
		<div>
			<p>本次訂單金額</p>
		</div>
		<button type="submit" value="send" class="btn btn-danger">確認結帳</button>
		</form>
	</div>
</div>



<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">

$(document).ready(function(){
	$("#checkOut").css("display", "none");
	$.ajax({
		url:"showCart",
		type:"GET",
		success: function(data){
			let arr = Object.values(data);
			console.log(arr);
			console.log(arr.length);
			showData(arr);
	     }
	})
})

function showData(data){
	if (data.length == 0){
		$("#btnCheckOut").css("display", "none");
		$("#cartMain").html("<p>購物車內無商品，請至商場選購。</P>");
		return;
	}
	
    let rowFrag = document.createDocumentFragment();
    let eleTBody = document.getElementById("tb");

    $.each(data, function(idx, value){
    	$("#checkOut").css("display", "none");
        let eleTr = document.createElement("tr");
        let str = "<td><input type='checkbox' value='"+ value.itemId +"' /></td class='itemId'><td># "+ value.itemId + " | "+ value.itemName + "</td><td class='uP'>" + value.unitPrice + "</td><td><select class='orderQty'>";
        let subamt = value.orderQty*value.unitPrice;
        for (let i =1 ; i <= 10; i++){
        	if (i == value.orderQty){
        		str+= "<option value='"+ i +"' selected>" + i + "</option>";
        	}else{
        		str+= "<option value='"+ i +"'>" + i + "</option>";
        	}
        }
        str += "</select></td><td class='subAmt'>"+ subamt +"</td>";
        eleTr.innerHTML=str;
        
        rowFrag.appendChild(eleTr);
        eleTBody.appendChild(rowFrag);
        
    })
    let eleTr = document.createElement("tr");
    eleTr.innerHTML="<tr><td colspan=4>總計</td><td class='total'></td></tr>";
    rowFrag.appendChild(eleTr);
    eleTBody.appendChild(rowFrag);
    
    setTotal();
}

$("#tb").on("change", ".orderQty", function(){
	console.log("chg");
	let qty = $(this).val();
	console.log($(this).closest("tr").find("input").val());
	let id = $(this).closest("tr").find("input").val();
	console.log(id);
	$.ajax({
		url:"addToCart",
		type:"POST",
		data: {id: id,
				qty: qty},
		success: function(data){
			let arr = Object.values(data);
			if (arr.length == 0){
				alert("抱歉, 庫存不足"+qty+"個, 請重新選擇數量");
			}else{
				console.log(arr);
				$("#tb>tr").remove();
				showData(arr);	
			}	
	     }
	})
	
	updateTotal($(this), qty);
})

function updateTotal(ele, num){
	let itemtr = ele.closest("tr");
	console.log(itemtr);
	let price = itemtr.find(".uP").text();
	let amt = price*num;
	console.log(amt)
	console.log(itemtr.find(".subAmt"));
	itemtr.find(".subAmt").text(amt);
	setTotal();
}

function setTotal(){
	let total=0;
	$(".subAmt").each(function(){
		total += Number($(this).text());
	})
	
	$(".total").text(total);
}

function remove(){
	if(window.confirm('是否刪除')){
		let removeIds = $(":checked").map(function(){
			return $(this).val();
		}).get();
		console.log(removeIds);
		$.ajax({
			url: "removeItem",
			type: "POST",
			data: {ids: removeIds},
			success: function(data){
					$("#tb>tr").remove();
					let arr = Object.values(data);			
					showData(arr);
			}
		})
		
	}
}

$("#cartMain").on("click", function(){
	$("#checkOut").css("display", "none");
})

function checkOut(){
	$("#checkOut").css("display", "block");
}

</script>
</body>
</html>