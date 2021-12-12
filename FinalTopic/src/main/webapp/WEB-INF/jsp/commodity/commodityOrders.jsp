<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Commodity Order System</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

<style>
th{
	vertical-align: middle;
}
</style>
</head>
<body>

<div class="wrapper">
<jsp:include page="/WEB-INF/jsp/commodity/00_sidebar.jsp" /> 
<div class="main-panel">
<c:import url="/adminnavbar"></c:import> 
<div class="content">

<div class="container-fluid">
	<h4>訂單管理</h4>
	<button class="btn btn-primary" onclick='pickUp()'>執行取貨</button>
	<hr>
	<div id="liveAlertPlaceholder"></div>
	
	<form>
		<div id='mySearch' class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
			<div class="col form-floating">
				<input type='text' id='orderId' class='searchinput form-control' name='orderId'>
				<label>訂單編號</label>
			</div>
			<div class="col form-floating">
				<input type='text' id='memberId' class='searchinput form-control' name='memberId'>
				<label>會員編號</label>
			</div>
			<div class="col form-floating">
				<select class='searchinput form-select' name='status'><option label='請選擇' value='' /><option label='未付款' value='0'/><option label='已付款/待提貨' value='1'/><option label='結案' value='2'/></select>
				<label>訂單狀態</label>
			</div>
			<div class="col">
				<input type='button' class='btn btn-primary' onclick='search()' value='套用搜尋'>
				<button class="btn btn-secondary" onclick='clearout()'>清除篩選</button>
			</div>
		</div>
	</form>
	<hr>
	
	<table id="orderlog" class='table table-sm'>
		<thead><tr><th>訂單編號</th><th>會員編號</th><th>訂單日期</th><th>取貨日期(E)</th><th>付款/提貨</th><th>逾期天數</th><th>總金額</th><th></th></tr></thead>
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
	       
	      </div>
	    </div>
	  </div>
	</div>
</div>
</div>
</div>	
</div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://unpkg.com/html5-qrcode" type="text/javascript"></script>
<script type="text/javascript">
let allData;

$(document).ready(function(){
	load();
})

$("#liveAlertPlaceholder").on('click', function(){
	$(this).empty('');
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

function serializeObj(data){
	let json = {};
	$.each(data, function(){
		json[this.name] = this.value || '';
	})
	return JSON.stringify(json);
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
	let modalbd = $(".modal-body").empty("");
	let detailData = allData[idx].orderDetails;
	
	let table = $("<table/>").attr('class', 'table table-sm').html("<thead><tr><th>產品編號 | 名稱</th><th>數量</th><th>單價</th><th>小計</th></tr></thead>");
	let tbody = $("<tbody/>");
	let rowFrag = document.createDocumentFragment();
	let eleTr;
	$.each(detailData, function(idx, value){
		eleTr = document.createElement("tr");
		let str = "<td>"+ value.commodity.itemId+"|"+value.commodity.itemName+"</td><td>"+ value.orderQty +"</td><td>"+ value.unitPrice +"</td><td>"+ value.subTotal +"</td>";
		eleTr.innerHTML=str;
		rowFrag.appendChild(eleTr);
		tbody.append(rowFrag);
	})    
	modalbd.append(table.append(tbody));
	
    /** show discounts **/
    let discounts = allData[idx].discount;
    table = $("<table/>").attr('class', 'table table-sm caption-top').html("<thead><tr><td colspan='3' align='left'>優惠活動折扣金額</td></tr><tr><th colspan='2'>項目</th><th>金額</th></tr></thead>");
    if (discounts.length!=0){
    	tbody = $("<tbody/>");
    	let discount_sum = 0;
    	$.each(discounts, function(idx, val){
    		discount_sum += val.amount;
    		let disTr = document.createElement("tr");
        	disTr.innerHTML="<tr><td>"+ val.rule.name+"&#160;&#160;<td></td></td><td align='right'>-"+ val.amount+"</td></tr>";
        	rowFrag.appendChild(disTr);
        	tbody.append(rowFrag);
    	})
    	eleTr = document.createElement("tr");
    	eleTr.innerHTML="<tr><td colspan=2 align='right'>折扣總計</td><td align='right'>-"+ discount_sum+"</td></tr>";
        rowFrag.appendChild(eleTr);
        tbody.append(rowFrag);
        table.append(tbody);
    }
    modalbd.append(table);
    $("#myModal").modal('show');
	$(".modal-title").text("訂單#"+ allData[idx].orderId+" 明細");
}

function clearout(){
	$('#mySearch').find('.searchinput').val('');
	search();
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
	        let str = "<td>"+ value.orderId+ "</td><td>"+ value.memberId+ "</td><td>"+ getDate(value.orderDate) + "</td><td>" + getDate(value.pickUpDate) + "</td>";
	        switch (value.status){
	        	case 0:
	        		str += "<td><span class='badge rounded-pill bg-danger'>未付款</span></td><td>"+ dateDiff(value.pickUpDate)+"</td>";
	        		break;
	        	case 1:
	        		str += "<td><span class='badge rounded-pill bg-warning text-dark'>已付款/待提貨</span></td><td>"+ dateDiff(value.pickUpDate)+"</td>";
	        		break;
	        	case 2:
	        		str +="<td><span class='badge rounded-pill bg-secondary'>結案</span></td><td></td>";
	        		break;
	        }
	        
	        str += "<td align='right'>"+ value.totalAmt +"</td><td align='left'><button class='btn btn btn-light btn-sm mx-1' onclick='showDetail("+ idx +")'>明細</button>";
	        if(value.status != 2){
	        	str += "<button class='btn btn-outline-secondary btn-sm mx-1' onclick='del("+value.orderId +")'>取消</button>";
	        }
	        str += "</td>";
	        	
	        eleTr.innerHTML=str;
	        
	        rowFrag.appendChild(eleTr);
	        orderTb.append(rowFrag);
		})
	}			
}

function dateDiff(pickup){
	let now = new Date();
	let date = new Date(pickup);
	let dif = parseInt((date-now)/1000/60/60/24);
	console.log(dif);
	if (dif<0){
		dif = Math.abs(dif);
		return "<span class='badge rounded-pill bg-danger'>"+ dif+"天</span>";
	}
	return "";
}

function getDate(data){
	let d = new Date(data);
	let hour = d.getHours()+"";
	hour = (hour.length == 1)?("0"+hour):hour;
	
	let minutes = d.getMinutes() +"";
	minutes = (minutes.length == 1)?("0"+minutes):minutes;
   	return data.substr(0,10)+" "+hour+":"+minutes;
}

function update(id){
	$.ajax({
		type:'put',
		url: 'ordersys/'+id,
		success: function (msg){
			alertdiv(msg, 'success');
			load();
		},
		error: function (xhr){
			alertdiv("查無訂單 #"+ id, 'danger');
		}
	})
	
}

function del(id){
	if(!window.confirm('是否刪除訂單 #'+ id)){
		return;
	}
	$.ajax({
		type:'delete',
		url: 'ordersys/'+id,
		success: function (msg){
			alertdiv(msg, 'success');
			load();
		}
	})
}

function alertdiv(message, type) {
	let alertPlaceholder = document.getElementById('liveAlertPlaceholder');
  	let wrapper = document.createElement('div');
  	wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + message + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';

  alertPlaceholder.append(wrapper);
}

function pickUp(){
	let modalbd = $(".modal-body").empty("")
		.append($("<div></div>").html("<p id='reader-results'></p>"))
		.append($("<div id='reader' style='width:300px' align='center'></div>"));
	$(".modal-title").text("執行取貨");
    $("#myModal").modal('show');
    turnon();
}

let html5QrCode;
function turnon(){
	html5QrCode = new Html5Qrcode("reader");
	Html5Qrcode.getCameras().then(devices => {
	let qrresult = $("#reader-results");
	
	if (devices && devices.length) {
		let cameraId = devices[0].id;
		html5QrCode.start(
		   cameraId,
		   {fps: 10,qrbox: 250	},
		   qrCodeMessage => {
				if (qrCodeMessage != ''){
					let id = qrCodeMessage;
					turnoff();
			    	qrresult.text("訂單號碼# "+ id);
			    	update(id);
			    	$("#myModal").modal('hide');
		    	}
		    },
		    errorMessage => { 	//ignore it.
		    }
		 )
		 .catch(err => {// Start failed, handle it. For example,
			console.log(`Unable to start scanning, error: ${err}`);
		 }); 
	}
	}).catch(err => {// handle err
		alert("請授權攝影機功能");
	});
}

function turnoff(){
	html5QrCode.stop();
	html5QrCode.clear();
}


</script>
</body>
</html>