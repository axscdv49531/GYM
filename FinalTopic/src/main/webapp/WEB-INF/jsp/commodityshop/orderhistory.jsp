<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Order History</title>
<style>
body{
background-color: rgb(225,219,208);
}
</style>
</head>
<body>
<a href='../list'>繼續購物</a>
<a href="../../logout">sign-out</a>
<h4>--------[訂單紀錄]-------</h4>
<table id="orderhistory">
<thead><tr><th>訂單編號</th><th>訂單日期</th><th>取貨日(E)</th><th>總金額</th><th>顯示</th><th>刪除</th></tr></thead>
<tbody id="ohtb"></tbody>
</table>

<h5>-------[訂單明細]--------</h5>
<table>
<thead><tr><th>產品編號</th><th>產品名稱</th><th>購買數量</th><th>單價</th><th>金額</th></tr></thead>
<tbody id="odtb"></tbody>
</table>

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
let json;

$(document).ready(function(){
	$.ajax({
		url:"orderList",
		type:"GET",
		dataType:'JSON',
		contentType:'application.json',
		success: function(data){
			console.log(data);
			json = data
			console.log(json);
			
			if (data == null){
				$("#orderhistory").text("無訂單, 請至商場選購, 買起來~");
			}else{
				showData(json);
			}
	     }
	})
})

function showData(data){
    let rowFrag = document.createDocumentFragment();
    let eleTBody = document.getElementById("ohtb");

    $.each(data, function(idx, value){
        let eleTr = document.createElement("tr");
        let str = "<td class='itemId'>"+ value.orderId+ "</td><td>"+ value.orderDate + "</td><td>" + value.pickUpDate + "</td><td>"+ value.totalAmt +"</td>";
        str += "<td><button type='button' onclick='showDetail("+ idx +")'>show detail</button></td><td><a href='deleteorder?id="+ value.orderId +"'>delete</a><td>";
        eleTr.innerHTML=str;
        
        rowFrag.appendChild(eleTr);
        eleTBody.appendChild(rowFrag);
    })
}

function showDetail(idx){
	console.log(idx);
	let details = json[idx].orderDetails;
	console.log(details);
	
	let rowFrag = document.createDocumentFragment();
    let eleTBody = document.getElementById("odtb");
	eleTBody.innerHTML ="";
    $.each(details, function(idx, value){
        let eleTr = document.createElement("tr");
        let str = "<td>"+ value.itemId+ "</td><td>"+ value.itemName + "</td><td>" + value.orderQty + "</td><td>"+ value.unitPrice +"</td><td>"+ value.subTotal + "</td>";
        eleTr.innerHTML=str;
        
        rowFrag.appendChild(eleTr);
        eleTBody.appendChild(rowFrag);
    })
}

</script>
</body>
</html>