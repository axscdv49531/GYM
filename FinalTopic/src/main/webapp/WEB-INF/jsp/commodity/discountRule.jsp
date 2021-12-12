<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Discount Management</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>
<style type="text/css">
table{
	font-size: 13px;
}

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

<h4>折扣管理</h4>
	
	<div id="liveAlertPlaceholder"></div>
	<br>
	<div>
		<h6>[折扣規則]</h6>
		<ul>
		<li>1滿件折扣: 單一商品項折扣檔期不可重疊。若檔期重疊，系統會刪除檔期重疊的商品後，再新增該檔期。</li>
		<li>2滿額折扣: 目前為全館適用，無指定商品亦無折扣排除策略。</li>
		</ul>
	</div>
	<div>
		<label>折扣項目</label>
		<select id="type"><option value="0" label="請選擇"><option value="1" label="1滿件折扣: 同一商品-任X件結帳Y折"><option value="2" label="2滿額折扣: 滿X元折抵Y元"></select>
	</div>
	<br>
	<div id='discount1'>
	<form id='rule1' enctype="multipart/form-data">
		<label>條件(X)</label>
		<input style='width:5em' name="condition" type="number" step="1" min="1" required/>
		<label>折扣%數(100-Y)</label>
		<input style='width:5em' name="discount" type="number" step="1" min="10" max="100" required/>
		<label>開始時間</label>
		<input name="startTime" type='date' required/>
		<label>結束時間</label>
		<input name="endTime" type='date' required/>
		<label>活動圖片</label>
		<input name="photo" type='file' required/>
	</form>
	
	<div id='selectModal' class="modal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>Modal body text goes here.</p>
	      </div>
	      <div class="modal-footer">
        	<button type="button" class="btn btn-primary" onclick='collect()'>確定</button>
      	</div>
	    </div>
	  </div>
	</div>
	<br>
	<button type="button" onclick="selectComm()" class='btn btn-primary btn-sm'>選取適用商品</button>
	<button type="button" onclick="updateDiscount()" class='btn btn-primary btn-sm'>建立折扣規則</button>
	</div>
	
	<div id='discount2'>
	<form id='rule2' >
		<label>條件(X)</label>
		<input name="condition" type="number" step="1" min="0" style='width:5em'/>
		<label>折扣(Y)</label>
		<input name="discount" type="number" min="0" style='width:5em'/>
		<label>開始時間</label>
		<input name="startTime" type='date' required/>
		<label>結束時間</label>
		<input name="endTime" type='date' required/>
		<label>活動圖片</label>
		<input name="photo" type='file' required/>
	</form>
	<br>
	<button type="button" onclick="updateDiscount()" class='btn btn-primary btn-sm' >建立折扣規則</button>
	</div>
	
	<hr>
	<div class="table-responsive">
	<table style="table-layout:fixed;" class="table table-hover caption-top">
		<caption>折扣規則總表</caption>
		<thead><tr><th width='10%'>圖片</th><th width='5%'>#</th><th>名稱</th><th>備註</th><th>開始/結束時間</th><th>狀態</th><th width='25%'>操作</th></tr></thead>
		<tbody id="discountsRulesList"></tbody>
	</table>
	</div>

	<div id='myModal'class="modal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <p>Modal body text goes here.</p>
	      </div>
	    </div>
	  </div>
	</div>
</div>

</div>
</div>
</div>

<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript">
let itemData;
let selectedItems;
let type;
$(document).ready(function(){
	$("#discount1").css("display","none");
	$("#discount2").css("display", "none");
	load();
})

$("#liveAlertPlaceholder").on('click', function(){
	$(this).empty('');
})

function load(){
	$.ajax({
		type: 'get',
		url: 'disountList',
		contentType: 'application/json',
		dataTyp: 'json',
		success: function (data){
			console.log(data);
			let tBody = $('#discountsRulesList');
			tBody.empty("");
			if (data == null){
				tBody.append("<tr><td colspan='6'>暫無資料, 請新增</td></tr>");
			}else{
				
				itemData = data; 
			    let trFrag = document.createDocumentFragment();
				$.each(data, function(idx, value){
					console.log(value.id)
					let eleTr = document.createElement("tr");
					let str = "<td><img src='../discountimg/"+ value.id +"' style='width:80px'></td><td>"+ value.id+ "</td><td>"+ value.name +"</td><td>"+ value.note +"</td><td><p>"+ getDate(value.startTime) +"</p><p>"+ getDate(value.endTime)+"</p></td>";
					switch(getStatus(value.startTime, value.endTime)){
						case 0:
							str += "<td><span class='badge rounded-pill bg-secondary'>過期</span></td>";
							break;
						case 1:
							str += "<td><span class='badge rounded-pill bg-success'>進行中</span></td>";
							break;
						case 2:
							str += "<td><span class='badge rounded-pill bg-warning text-dark'>未開始</span></td>";
							break;
					}
					str += "<td><button class='btn btn-danger btn-sm mx-1' onclick='del("+ value.id +")'>刪除</button><button class='btn btn-danger btn-sm mx-1' onclick='getOff("+ value.id +
							")'>下架</button><button class='btn btn-primary btn-sm mx-1' onclick='showComm("+ idx +")'>適用商品</button></td>";
					eleTr.innerHTML=str;
					trFrag.appendChild(eleTr);
					tBody.append(trFrag);
				})
			}			
		}
	})
}

function getStatus(start, end){
	let sd = new Date(start);
	let ed = new Date(end);
	let now = new Date();
	if (sd < now && ed < now){//off
		return 0;
	}
	if (sd < now){//on
		return 1;
	}
	return 2;
}

function getDate(data){
	let d = new Date(data);
	let hour = d.getHours()+"";
	hour = (hour.length == 1)?("0"+hour):hour;
	
	let minutes = d.getMinutes() +"";
	minutes = (minutes.length == 1)?("0"+minutes):minutes;
   	return d.getFullYear()+"-"+ (d.getMonth()+1)+"-"+d.getDate() +" "+hour+":"+minutes;
}

$("#type").on("change", function(){
	$("#discount1").css("display","none");
	$("#discount2").css("display", "none");
	
	if ($(this).val()==1){	
		type = 1;
		$("#discount1").css("display","block");
		return;
	}
	if ($(this).val()==2){
		type =2;
		$("#discount2").css("display","block");
	}
})


function selectComm(){
	$.ajax({
		type: 'get',
		url: 'commList',
		success: function (data){
			$("#selectModal .modal-title").text("選取適用商品");
			let eleTable = document.createElement("table");
			eleTable.className = "table";
			let tBody = document.createElement("tbody");			
			$.each(data, function(idx, value){
				let trFrag = document.createDocumentFragment();
				let eleTr = document.createElement("tr");
				let str = "<td><input type='checkbox' value='"+ value.itemId +"' /></td><td>"+ value.itemId+ "</td><td>"+ value.itemName +"</td><td>"+ value.itemType.typeName +"</td>";
				eleTr.innerHTML=str;
				trFrag.appendChild(eleTr);
				tBody.append(trFrag);
			})
			eleTable.append(tBody);
			$(".modal-body").empty("").append(eleTable);
			$("#selectModal").modal('show');
		}
	})
}

function collect(){
	let items = $("#selectModal .modal-body input:checked").map(function(){
		return $(this).val();
	}).get();
	selectedItems = [];
	$.each(items, function(idx, val){
		selectedItems.push(val);
	})
	$('#selectModal').modal('hide');
	alertdiv("已選取參加活動的商品: "+ selectedItems, 'success');
}

function updateDiscount(){	
	let form;
	if (type==0){
		alertdiv("請選擇折扣項目", 'danger');
		return;
	}
	if (type==1){
		form = new FormData($("#rule1")[0]);
	}
	if (type ==2){
		form = new FormData($("#rule2")[0]);
	}
	let errMsg =["錯誤訊息, 請修改後再送出: "];
	if (form.get("condition") == ''){
		errMsg.push("折扣條件不得為空");
	}
	if(form.get("discount") == ''){
		errMsg.push("折扣內涵不得為空");
	}else{
		if(type == 2&& form.get("discount")>=form.get("condition") ){
			errMsg.push("折扣金額不得大於折扣條件");
		}
	}
	if(form.get("startTime") == ''){
		errMsg.push("起始日期不得為空");
	}else{
		let start = form.get("startTime").replace(/-/g, "/");
		if (new Date(start+" 23:59:59") < new Date){
			errMsg.push("起始日期需大於今天");
		}
	}
	if(form.get("endTime") == ''){
		errMsg.push("結束日期不得為空");
	}else{
		if (new Date(form.get("endTime")) < new Date(form.get("startTime"))){
			errMsg.push("結束時間不得小於起始時間");
		}
	}
	if (form.get("photo").size == 0){
		errMsg.push("需上傳活動圖片");
	}
	
	if (type ==1 && (selectedItems== null || selectedItems.length == 0)){
		errMsg.push("需選取參加活動的商品");
	}
	
	if(errMsg.length != 1){
		alertdiv(errMsg, 'danger');
		return;
	}
	form.append("commodity", selectedItems);
	form.append("type", type);
	
	$.ajax({
		url: "updateDiscount",
		type: 'post',
		data: form,
		processData : false,
		contentType : false,
		success: function (msg){
			type = 0;
			$("#type").val(type);
			selectedItems=[];
			$("input").val('');
			$("#discount1").css("display","none");
			$("#discount2").css("display", "none");
			alertdiv(msg, 'success');
			load();
		},
		error: function (xhr){
			alertdiv("請聯繫人員: eeit134019@outlook.com", 'danger');
		}
	})	
}

function del(id){
	if (!window.confirm('是否刪除折扣規則 #'+id)){
		return;
	}
	$.ajax({
		type:'delete',
		url: 'discount/'+id,
		success: function (msg){
			alertdiv(msg, 'success');
			load();
		},
		error: function (xhr){
			alertdiv(xhr.responseText, 'danger');
		}
	})
}

function getOff(id){
	if (!window.confirm('是否下架折扣規則 #'+id)){
		return;
	}
	$.ajax({
		type:'post',
		url: 'discount/'+id,
		success: function (msg){
			alertdiv(msg, 'success');
			load();
		},
		error: function (xhr){
			alertdivS(xhr.responseText, 'danger');
		}
	})
}

function showComm(idx){
	console.log(itemData[idx].commodity);
	$("#myModal").modal('show');
	$("#myModal .modal-title").text("折扣#"+ itemData[idx].id+" 檔期商品");
	let data = itemData[idx].commodity;
	let eleTable = document.createElement("table");
	eleTable.className = "table";
	let tBody = document.createElement("tbody");
	if (data.length == 0){
		tBody.innerHTML = "全館適用";
	}
	
	$.each(data, function(idx, value){
		let trFrag = document.createDocumentFragment();
		let eleTr = document.createElement("tr");
		let str = "<td>"+ value.itemId+ "</td><td>"+ value.itemName +"</td><td>"+ value.itemType.typeName +"</td>";
		eleTr.innerHTML=str;
		trFrag.appendChild(eleTr);
		tBody.append(trFrag);
	})
	eleTable.append(tBody);
	$(".modal-body").empty("").append(eleTable);
}

function alertdiv(message, type) {
	let alertPlaceholder = document.getElementById('liveAlertPlaceholder');
	let wrapper = document.createElement('div')
	wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + message + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>'

	alertPlaceholder.append(wrapper);
}

</script>
</body>
</html>