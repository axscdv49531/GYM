<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Commodity Type</title>


<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/1.11.3/css/jquery.dataTables.css">
<link rel="stylesheet" type="text/css" href="https://cdn.datatables.net/responsive/2.2.9/css/responsive.dataTables.min.css">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<style>

</style>

</head>
<body>
<div class="wrapper">
<jsp:include page="/WEB-INF/jsp/commodity/00_sidebar.jsp" /> 
<div class="main-panel">
<c:import url="/adminnavbar"></c:import> 
<div class="content">

<div class="container-fluid">
	<div>
		<h4>商品分類</h4>
		<button type='button' onclick='newType()' class='btn btn-primary btn-sm' >新增分類</button>
		<button type='button' onclick='showChart()' class='btn btn-primary btn-sm' >查看分類群組營收</button>
	</div>
	
	<br>
	<div id="liveAlertPlaceholder"></div>	

	<hr>
	<table id='showType' class='table table-striped table-bordered responsive nowrap' style="width:100%"></table>
	
	<div id='myModal'class="modal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title"></h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <form>
	        <div id="typeId" class="mb-3">
            	<label class="col-form-label"></label>
            	<input name='typeId' class="form-control"  type="hidden">
          	</div>
          	<div id="typeName" class="mb-3">
            	<label class="col-form-label">分類名稱</label>
            	<input name='typeName' type="text" class="form-control">
            	<small style='color:red'></small>
          	</div>
          	<div id="groups" class="mb-3">
            	<label class="col-form-label">分類群組</label>
            	<input name='groups' type="text" class="form-control">
            	<small style='color:red'></small>
          	</div>
        	</form>
	      </div>
	      <div class="modal-footer">
	      	<button type='button' onclick='save()' class='btn btn-primary btn-sm' >儲存</button>
	      </div>
	    </div>
	  </div>
	</div>
	
	<div id='myModal2'class="modal" tabindex="-1">
	  <div class="modal-dialog modal-dialog-scrollable">
	    <div class="modal-content">
	      <div class="modal-header">
	        <h5 class="modal-title">分類群組每月營收圖表</h5>
	        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	      </div>
	      <div class="modal-body">
	        <div>
			<label class='form-label'>月份</label>
			<select class='form-select' id="timeframe">
				<option value="" label="請選擇">
				<c:forEach var='month' items="${charMonth}">
				<option value='${month}' label='${month}'>
				</c:forEach>
			</select>
			</div>
			<div id='canvas'>
				<canvas id="myChart" width="200" height="200"></canvas>
				<canvas id="myChart2" width="200" height="200"></canvas>
			</div>
	      </div>
	    </div>
	  </div>
	</div>
</div>

</div>
</div>
</div>


<script type="text/javascript" src="https://cdn.datatables.net/1.11.3/js/jquery.dataTables.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.6.2/dist/chart.min.js"></script>
<script type="text/javascript">

let result;
$(document).ready(function(){
	$.ajax({
		url: 'queryTypes',
		type:'get',
		success: function (data){
			showData(data);
		}
	})
})

$("#liveAlertPlaceholder").on('click', function(){
	$(this).empty('');
})

function newType(){
	$("#myModal .modal-title").text("新增 分類#");
	$("#typeId label").text("# to be updated");
	$("#myModal input").val('');
	$("#myModal small").text('');
	$("#myModal").modal('show');
}

function edit(id){
	$.each(result, function(idx, val){
		if(val.typeId == id){			
			$("#myModal .modal-title").text("編輯 分類#"+ val.typeId);
			$("#typeId label").text("#"+ val.typeId);
			$("#typeId input").val(val.typeId);
			$("#typeName input").val(val.typeName);
			$("#groups input").val(val.groups);
			$("#myModal small").text('');
			$("#myModal").modal('show');
			return;
		}
	})
}

function save(){
	let form = $("form").serializeArray();
	let flag = true;
	let json = {};
	$.each(form, function(){
		json[this.name] = this.value || '';
		
		if (this.name != 'typeId' && this.value==''){
			$("#"+this.name).find("small").text('不得為空，請輸入文字');
			flag = false;
		}
	})
	if (!flag){
		return;
	}
	let data = JSON.stringify(json);
	$.ajax({
		url: 'saveTypes',
		type:'post',
		data: data,
		cache: false,
		contentType:'application/json',
		dataType: 'json',
		success: function (data){
			if (data != null){
				alertdiv("儲存成功", 'success');
				$("#myModal").modal('hide');
				showData(data);
				return;
			}
			alertdiv("儲存失敗, 請聯繫: eeit134019@outlook.com", 'danger');
		}
	})
}

function del(id){
	if (!window.confirm('是否刪除類別 #'+id)){
		return;
	}
	$.ajax({
		url: 'deleteType/'+id,
		type:'delete',
		success: function (data){
			console.log(data);
			if (data !=''){
				alertdiv("刪除 #"+ id +"成功", 'success');
				$("#myModal").modal('hide');
				showData(data);
				return;
			}
			alertdiv("刪除失敗, 該類別已建立關聯商品", 'danger');
		}
	})
}

function showData(data){
	result = data;
	$("#showType").DataTable({
		destroy: true,
		data: data,
		columns: [
			{data: 'typeId', title: "#"},
			{data: 'typeName', title: "分類名稱"},
			{data:'groups', title: "分類群組"},
			{data: null, title: "操作功能", render: function(data, type, row){
				return "<button class='btn btn-primary btn-sm mx-1' onclick='edit("+ data.typeId+")'>編輯</button><button class='btn btn-danger btn-sm mx-1' onclick='del("+ data.typeId +")'>刪除</button>";
			}}
		],
		language: {
			'lengthMenu': '顯示_MENU_筆資料',
			'sProcessing': '處理中',
			'sZeroRecords': '沒有匹配結果',
			'sInfo': '目前有_MAX_筆資料',
			'sInfoEmpty': '目前共有0筆紀錄',
			'sEmptyTable':'查無資料',
			'oPaginate':{
				'sFirst': '首頁',
				'sPrevious':'上一頁',
				'sNext':'下一頁',
				'sLast':'末頁',
			},
			'order':[[0,'desc']],
			'oAria':{
				'oSortAscending': ':升序排列',
				'sSortDescending': ':降序排列'
			}
		}
	})
}

function showChart(){
	$("#myModal2 select").val('');
	$("#canvas").find("canvas").remove();
	$("#canvas").html("<canvas id='myChart' width='200' height='200'></canvas><canvas id='myChart2' width='200' height='200'></canvas>");
	$("#myModal2").modal('show');
}

const CHART_COLORS = {
		  red: 'rgb(255, 99, 132)',
		  orange: 'rgb(255, 159, 64)',
		  yellow: 'rgb(255, 205, 86)',
		  green: 'rgb(75, 192, 192)',
		  blue: 'rgb(54, 162, 235)',
		  purple: 'rgb(153, 102, 255)',
		  grey: 'rgb(201, 203, 207)'
};


$("#timeframe").on('change', function(){
	console.log($(this).val());
	if ($(this).val()==''){
		return;
	}
	getSalePct($(this).val());
})

function getSalePct(time){
	$.ajax({
		url: 'querySalePct/'+time,
		type:'get',
		success: function (data){
			let labels = [];
			let sale = [];
			let qty = [];
			let pct = [];
			$.each(data, function(idx, val){
				labels.push(val.groups);
				sale.push(val.sale);
				qty.push(val.qty);
				pct.push(val.pct);
			})
			
			$("#canvas").find("canvas").remove();
			$("#canvas").html("<canvas id='myChart' width='200' height='200'><hr></canvas><canvas id='myChart2' width='200' height='200'></canvas>");
			
			let ctx = $("#myChart");
			let myChart = new Chart(ctx, {
				type: 'pie',
				data:{
					labels: labels,
					datasets:[{
						label: 'dataset1',
						data: pct,
						backgroundColor: Object.values(CHART_COLORS),
					    hoverOffset: 4
					}]
				},
				options:{
					responsive: true,
					plugins: {
						legend:{
							position: top,
						},
						title:{
							display:true,
							text: '群組分類銷售比例'
						}
					}
				}
			})
			
			let ctx2 = document.getElementById("myChart2").getContext('2d');
			let myChart2 = new Chart(ctx2, {
				type: 'bar',
				data:{
					labels: labels,
					datasets:[{
						label: '營收(仟元)',
						data: sale,
						backgroundColor: [
							CHART_COLORS.red,
					    ],
					    order:1
					},
					{
						label: '銷售量(件)',
						data: qty,
						backgroundColor:CHART_COLORS.blue,
						type: 'line',
						order:0,
					}]
				},
				options:{
					responsive: true,
					plugins: {
						legend:{
							position: 'top',
						},
						title:{
							display:true,
							text: '群組分類營收(未扣除行銷費用)'
						}
					}
				}
			})
			
		}
	})

}

function alertdiv(message, type) {
	let alertPlaceholder = document.getElementById('liveAlertPlaceholder');
  let wrapper = document.createElement('div');
  wrapper.innerHTML = '<div class="alert alert-' + type + ' alert-dismissible" role="alert">' + message + '<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button></div>';

  alertPlaceholder.append(wrapper);
}


</script>
</body>
</html>