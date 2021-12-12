<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member's Order Log</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

<jsp:include page="/WEB-INF/jsp/commodityshop/front_header.jsp" />

<div class='container'>
	<h4>交易紀錄</h4>
	
	<div class="alert alert-success alert-dismissible fade show" role="alert">
  		<strong id="successMsg"></strong>
  		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
	</div>
	
	<form>
	<div id='mySearch' class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
	
		<div class="col form-floating">
			<input type='text' id='orderId' class='searchinput form-control' name='orderId'>
			<label>訂單編號</label>
		</div>
		<div class="col form-floating">
			<select class='searchinput form-select' name='status'><option label='請選擇' value='' /><option label='未付款' value='0'/><option label='已付款/待提貨' value='1'/><option label='結案' value='2'/></select>
			<label>訂單狀態</label>
		</div>
		<div class="col">
			<input type='button' class='btn btn-outline-primary' onclick='search()' value='套用搜尋'>
			<button class="btn btn-outline-secondary" onclick='clearout()'>清除篩選</button>
		</div>
	</div>
	</form>
	<hr>
	
	<table id="orderlog" class='table table-sm'>
		<thead><tr><th>訂單編號</th><th>訂單日期</th><th>取貨日期(E)</th><th>付款/提貨</th><th>總金額</th><th></th></tr></thead>
		<tbody id="orderlogTb"></tbody>
	</table>
	
	<div id='myModal'class="modal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <table class="table table-sm">
				<thead><tr><th>產品編號 | 名稱</th><th>數量</th><th>單價</th><th>小計</th></tr></thead>
				<tbody id="detailTb"></tbody>
			</table>
			<table id="appliedDiscount" class="table table-sm caption-top ">
				<caption>優惠活動折扣金額</caption>
				<thead><tr><th colspan='2'>項目</th><th>金額</th></tr></thead>
				<tbody id="appliedDiscount_tb"></tbody>
			</table>
	      </div>
	    </div>
	  </div>
	</div>
	
</div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
let allData;

$(document).ready(function(){
	$(".alert").css("display","none");
	load();
})

$(".alert>button").on("click", function(){
	$(this).parent(".alert").css("display", "none");
})

function load(){
	$.ajax({
		type: 'get',
		url: 'queryAllLog',
		success: function (data){
			showData(data);			
		}
	})
}

function search(){
	let query = serializeObj($("form").serializeArray());
	console.log(query);
	$.ajax({
		type: 'post',
		url: 'querylog',
		cache: false,
		contentType:'application/json',
		dataType: 'json',
		data: query,
		success: function (data){
			showData(data);
		}
	})
}

function showDetail(idx){    
	$("#myModal").modal('show');
	$(".modal-title").text("訂單#"+ allData[idx].orderId+" 明細");
	let detailData = allData[idx].orderDetails;
	let detailTb = $("#detailTb").empty("");
	let rowFrag = document.createDocumentFragment();
	let eleTr;
	$.each(detailData, function(idx, value){
		eleTr = document.createElement("tr");
		let str = "<td>"+ value.commodity.itemId+"|"+value.commodity.itemName+"</td><td>"+ value.orderQty +"</td><td>"+ value.unitPrice +"</td><td>"+ value.subTotal +"</td>";
		eleTr.innerHTML=str;
		rowFrag.appendChild(eleTr);
		detailTb.append(rowFrag);
	})    
    
    /** show discounts **/
    let discounts = allData[idx].discount;
    let ad_tb = $("#appliedDiscount_tb").empty("");
    if (discounts.length!=0){
    	let discount_sum = 0;
    	$.each(discounts, function(idx, val){
    		discount_sum += val.amount;
    		let disTr = document.createElement("tr");
        	disTr.innerHTML="<tr><td>"+ val.rule.name+"&#160;&#160;<td></td></td><td align='right'>-"+ val.amount+"</td></tr>";
        	rowFrag.appendChild(disTr);
        	ad_tb.append(rowFrag);
    	})
    	eleTr = document.createElement("tr");
    	eleTr.innerHTML="<tr><td colspan=2 align='right'>折扣總計</td><td align='right'>-"+ discount_sum+"</td></tr>";
        rowFrag.appendChild(eleTr);
        ad_tb.append(rowFrag);
    }
}

function clearout(){
	$('#mySearch').find('.searchinput').val('');
	search();
}

function serializeObj(data){
	let json = {};
	$.each(data, function(){
		json[this.name] = this.value || '';
	})
	return JSON.stringify(json);
}

function showData(data){
	allData = data;
	let orderTb = $('#orderlogTb').empty("");
	if (data == null || data.length == 0){
		orderTb.append("<tr><td colspan='10'>查無資料</td></tr>")
	}else{
		let rowFrag = document.createDocumentFragment();				
		$.each(data, function(idx, value){
	        let eleTr = document.createElement("tr");
	        let str = "<td>"+ value.orderId+ "</td><td>"+ getDate(value.orderDate) + "</td><td>" + getDate(value.pickUpDate) + "</td>";
	        switch (value.status){
        	case 0:
        		str += "<td><span class='badge rounded-pill bg-danger'>未付款</span></td>";
        		break;
        	case 1:
        		str += "<td><span class='badge rounded-pill bg-warning text-dark'>已付款/待提貨</span></td>";
        		break;
        	case 2:
        		str +="<td><span class='badge rounded-pill bg-secondary'>結案</span></td>";
       	 		break;
       		}
	        str += "<td align='right'>"+ value.totalAmt +"</td><td align='left'><button class='btn btn-outline-secondary btn-sm' onclick='showDetail("+ idx +")'>明細</button>";
	        if (value.status != 2 && checkOverTime(value.orderDate)){
	        	str += "<button class='btn btn-outline-secondary btn-sm mx-1' onclick='del("+value.orderId +")'>取消</button>";
	        }
	        str += "</td>";
	        eleTr.innerHTML=str;
	        
	        rowFrag.appendChild(eleTr);
	        orderTb.append(rowFrag);
		})
	}			
}

function checkOverTime(oDate){
	let now = Date.parse(new Date());
	let date = Date.parse(new Date(oDate))+86400000;
	let dif = date - now;
	if (dif > 0){
		return true;
	}
	return false;
}

function getDate(data){
	let d = new Date(data);
	let hour = d.getHours()+"";
	hour = (hour.length == 1)?("0"+hour):hour;
	
	let minutes = d.getMinutes() +"";
	minutes = (minutes.length == 1)?("0"+minutes):minutes;
   	return data.substr(0,10)+" "+hour+":"+minutes;
}

function del(id){
	if(!window.confirm('是否取消訂單 #'+ id)){
		return;
	}
	$.ajax({
		type:'delete',
		url: 'cancel/'+id,
		success: function (msg){
			$(".alert-success").css("display", "block");
			$("#successMsg").text(msg);
			load();
		}
	})
}

</script>
</body>
</html>