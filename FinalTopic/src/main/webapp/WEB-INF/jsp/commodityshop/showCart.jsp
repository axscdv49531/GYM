<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Shopping Cart</title>
</head>

<link rel="stylesheet" href="https://code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
	body{
		background-color: #f2f2f2;
	}
</style>
<body>

<div class='container'>
	<h3>購物車</h3>
	<c:if test="${not empty orderErrMsg }">
		<div class="alert alert-warning alert-dismissible fade show" role="alert">
	  		<strong id="failMsg">${orderErrMsg }</strong>
	  		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</c:if>
	<hr>
	<div id="cartMain">
		<table class="table table-sm">
			<thead><tr><th><button type="button" class="btn btn-secondary btn-sm" onclick="remove()">刪除</button></th><th>產品編號 | 名稱</th><th>單價</th><th>數量</th><th>小計</th></tr></thead>
			<tbody id="tb"></tbody>
		</table>
		<table id="appliedDiscount" class="table table-sm caption-top ">
			<caption>優惠活動折扣金額</caption>
			<thead><tr><th colspan='2'>項目</th><th width='15%'>金額</th></tr></thead>
			<tbody id="appliedDiscount_tb"></tbody>
		</table>

	</div>
	<table class="table table-sm">
		<tbody><tr><td align='right'><span id="checkOutAmt" class="fw-bolder" style='color:red'></span><button id='btnCheckOut' type="button" class="btn btn-danger" onclick="checkOut()">結帳</button></td></tr></tbody>
	</table>
	
	<p><a href="<c:url value='/commodity'/>">繼續購物</a></p>

	<div id='checkOut'>
		<table class="table caption-top">
		<caption>訂購人資料</caption>
		<tr><td>姓名: </td><td>${MemberName}</td></tr>
		<tr><td>E-mail: </td><td>${MemberEmail}</td></tr>
		<tr><td>手機號碼: </td><td>${MemberPhone}</td></tr>
		</table>
		<form action="<c:url value='commorder/processOrder'/>" method="POST">
		<table class="table caption-top"><caption>付款/提貨資訊</caption>
		<tr><td>提貨日: </td><td>
			<div style='width:200px'><input id='datepicker' name='pickUpDate' type="text" class="form-control" required/></div>
			</td></tr>
		<tr><td>付款方式: </td><td>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="payTerm" id="inlineRadio1" value="1" checked>
			  <label class="form-check-label" for="inlineRadio1">到店取貨付款</label>
			</div>
			<div class="form-check form-check-inline">
			  <input class="form-check-input" type="radio" name="payTerm" id="inlineRadio2" value="2">
			  <label class="form-check-label" for="inlineRadio2">信用卡一次付清</label>
			</div>
		</td></tr>
		</table>
		<div>
			<p id='finalPrice' class="fw-bolder" style='color:red'></p>
		</div>
		<button type="submit" value="send" class="btn btn-danger">確認結帳</button>
		</form>
	</div>
	
</div>


<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="js/bootstrap-datetimepicker.min.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript">
let arr;
$(document).ready(function(){
	$("#checkOut").css("display", "none");
	$.ajax({
		url:"commcart/showCart",
		type:"GET",
		success: function(data){
			showData(data);
	    }
	})
})

$("#datepicker").datepicker({
	dateFormat: 'yy-mm-dd',
	minDate: 1, 
	maxDate: "+10D",
	beforeShowDay: $.datepicker.noWeekends
});



$("#cartMain").on("click", function(){
	$("#checkOut").css("display", "none");
})

function remove(){
	if(window.confirm('是否刪除')){
		let removeIds = $(":checked").map(function(){
			return $(this).val();
		}).get();
		console.log(removeIds);
		$.ajax({
			url: "commcart/removeItem",
			type: "POST",
			data: {ids: removeIds},
			success: function(data){
				console.log(data);
					showData(data);
			}
		})
	}
}

function showData(data){
	
	if (data.volume == null || data.volume == 0){
		$("#btnCheckOut").css("display", "none");
		$("#checkOutAmt").empty("");
		$("#cartMain").html("<p>購物車內無商品，請至商場選購。</P>");
		return;
	}
	
	/** cart content **/
    let rowFrag = document.createDocumentFragment();
    let eleTBody =$("#tb").empty("");
    let eleTr;
   	let sum =0;
	arr = Object.values(data.content);
    $.each(arr, function(idx, value){
        eleTr = document.createElement("tr");
        let str = "<td><input type='checkbox' value='"+ value.commodity.itemId +"' /></td class='itemId'><td># "+ value.commodity.itemId + " | "+ value.commodity.itemName + "</td><td class='uP'>" + value.commodity.unitPrice + "</td><td>";
        str += "<nav><ul class='pagination pagination-sm'><li class='page-item' aria-current='page' onclick='addToCart("+ idx+","+value.commodity.itemId+",-1)'><a class='page-link' href='javascript:void(0);'>-</a></li><li class='page-item'><span class='page-link'>"+ value.orderQty+"</span></li><li class='page-item' onclick='addToCart("+ idx+","+value.commodity.itemId+",1)'><a class='page-link' href='javascript:void(0);'>+</a></li></ul></nav></td>";
        str += "<td align='right'>"+ value.subTotal +"</td>";        
        sum += value.subTotal;
        
        eleTr.innerHTML=str;
        rowFrag.appendChild(eleTr);
        eleTBody.append(rowFrag);
    })
    eleTr = document.createElement("tr");
    eleTr.innerHTML="<tr><td colspan=4 align='right'>總計</td><td class='total' align='right'>"+ sum +"</td></tr>";
    rowFrag.appendChild(eleTr);
    eleTBody.append(rowFrag);
    
    
    /** show discounts **/
    let ad_tb = $("#appliedDiscount_tb").empty("")
    if (data.appliedDiscount.length != 0){
    	let discount_sum = 0;
    	$.each(data.appliedDiscount, function(idx, val){
    		discount_sum += val.amount;
    		let cid = '';
    		if (val.commodity != null){
    			cid = "優惠商品 #"+val.commodity[0].itemId;
    		}
    		let disTr = document.createElement("tr");
        	disTr.innerHTML="<tr><td>"+ getDate(val.rule.startTime)+"-"+getDate(val.rule.endTime)+" | "+ val.rule.name+"&#160;&#160;"+ cid +"<td></td></td><td align='right'>-"+ val.amount+"</td></tr>";
        	rowFrag.appendChild(disTr);
        	ad_tb.append(rowFrag);
    	})
    	eleTr = document.createElement("tr");
    	eleTr.innerHTML="<tr><td colspan=2 align='right'>總計</td><td align='right'>-"+ discount_sum+"</td></tr>";
        rowFrag.appendChild(eleTr);
        ad_tb.append(rowFrag);
    }
   	$("#checkOutAmt").html("結帳總金額NT$:"+ data.totalPrice+"&#160;&#160;");
   	$("#finalPrice").html("本次訂單金額NT$:"+ data.totalPrice)
}

function getDate(data){
	let d = new Date(data);
   	return d.getFullYear()+'/'+(d.getMonth()+1)+'/'+d.getDate();
}

function addToCart(idx, cid, qty){
	if ((arr[idx].orderQty + qty) <= 0){
		alert("訂購數量0, 請刪除該筆商品");
		return;
	}
	if (arr[idx].commodity.itemStock < (arr[idx].orderQty + qty)){
		alert("抱歉, 庫存不足");
		return;
	}
	$.ajax({
		url: "../addToCart",
		type: "POST",
		data: {id: cid,
				qty: qty},
		success: function(data){
			showData(data);
		}	
	})
}

function checkOut(){
	$("#checkOut").css("display", "block");
}

$(".alert>button").on("click", function(){
	$(this).parent(".alert").remove();
})


</script>
</body>
</html>