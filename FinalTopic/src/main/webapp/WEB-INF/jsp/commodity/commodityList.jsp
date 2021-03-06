<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Commodity List</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<style>
#showComm{
	font-size: 12px;
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
	<div>
		<h4>商品管理</h4><a class="btn btn-primary" href='commodityForm?id=1'>新增商品</a>
	</div>
	
	<c:if test="${not empty successMsg }">
		<div class="alert alert-success alert-dismissible fade show" role="alert">
  		<strong>${successMsg}</strong>
  		<button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
		</div>
	</c:if>
	
	<br>
	<div id='mySearch' class="row row-cols-2 row-cols-lg-5 g-2 g-lg-3">
		<div class="col form-floating">
			<input type='text' id='itemId' class='searchinput form-control'>
			<label>商品編號</label>
		</div>
		<div class="col form-floating">
			<input type='text' id='itemName' class='searchinput form-control'>
			<label>商品名稱</label>
		</div>
		<div class="col form-floating">
			<select id='itemType' class='searchinput form-select'></select>
			<label>商品類別</label>
		</div>
		<div class="col form-floating">
			<select id='onSale' class='searchinput form-select'><option label='請選擇' value='' /><option label='是' value='true'/><option label='否' value='false'/></select>
			<label>是否上架</label>
		</div>
		<div class="col form-floating">
			<input type='date' id='lastUpdated' class='searchinput form-control'>
			<label>建立日期</label>
		</div>
		<div class="col form-floating ui-widget">
			<input type='text' id='vendorName' class='searchinput form-control'>
			<label for='vendorName'>供應商</label>
		</div>
		<div class="col">
			<button class='btn btn-primary mt-1' onclick='search()'>套用搜尋</button>
			<button class="btn btn-secondary mt-1" onclick='clearout()'>清除篩選</button>
		</div>
	</div>
	<hr>
	<div class='row align-middle'>
	   <p>共<strong id='eleTTL'></strong>筆資料, 頁數<strong id='pgTTL'></strong><span id='pages' class='float-end'></span></p>
	</div>
	<div class='table-responsive'>
		<table id='showComm' border='1' style="table-layout:fixed;" class="table table-hover">
		<thead class="table-light"><tr><th style='width:5%'>#</th><th>商品名稱</th><th style='width:5%'>庫存數量</th><th style='width:5%'>單價</th><th style='width:5%'>商品類別</th><th style='width:35%'>商品描述</th><th style='width:8%'>建立日期</th><th style='width:5%'>供應商</th><th style='width:10%'>狀態</th><th>操作</th></tr></thead>
		<tbody id='tb'></tbody>
		</table>
	</div>
	
</div>
</div>
</div>
</div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script type="text/javascript">
	let currentPage = 1;
	let maxPage = 0;
	$(document).ready(function(){
		loadAllTypesAndVendors();
		load(currentPage);
	});
	
	function loadAllTypesAndVendors(){
		$.ajax({
			type: 'get',
			url: 'commodity/queryAllTypesAndVendors',
			success: function (data){

				let typeSelect = $('#itemType');
				$("<option label='請選擇' value=''/>").appendTo(typeSelect);
				let record = '';
				let group, str;
				$.each(data[0], function(idx, value){
					if (record != value.groups){
						if (record !=''){
							group.appendTo(typeSelect);
							str ='';
						}
						record = value.groups;
						group = $("<optgroup label='"+ value.groups+ "'/>");
					}
					str+="<option value='"+ value.typeId+ "' label='"+ value.typeName +"' />";
					group.html(str);
				})
				group.appendTo(typeSelect);
				$("#vendorName").autocomplete({source: data[1]})
			}
		})
	}
	
	function move(pace){
		let targetPage = currentPage+pace;
		if (targetPage > maxPage || targetPage==0){
			alert("no next page");
			return;
		}
		change(targetPage);
	}
	
	function change(page){
		currentPage = page;
		load();
	}
	
	function del(id){
		if(!window.confirm('是否刪除商品 #'+ id)){
			return;
		}
		$.ajax({
			type:'delete',
			url: 'commodity/'+id,
			success: function (msg){
				alert(msg);
				load();
			},
			error: function (xhr){
				alert(xhr.responseText);
			}
		})
	}
	
	function checkValue(value){
		return (value=='' ? null: value);
	}
	
	function search(){
		currentPage = 1;
		load();
	}
	
	function load(){
		let data = {
				'itemId': checkValue($('#itemId').val()),
				'itemName': checkValue($('#itemName').val()),
				'lastUpdated': checkValue(document.getElementById("lastUpdated").value),
				'onSale': $('#onSale').val(),
				'vendorName': checkValue($('#vendorName').val()),
				'itemType': {'typeId': checkValue($('#itemType').val())}
			};
		$.ajax({
			type: 'post',
			url: 'commodity/'+currentPage,
			contentType: 'application/json',
			dataTyp: 'json',
			data: JSON.stringify(data),
			success: function (data){
				let eleTTL = data.pageInfo[1];
				var tBody = $('#tb');
				tBody.empty("");
				if (eleTTL == null || eleTTL == 0){
					tBody.prepend("<tr><td colspan='10'>暫無資料, 請新增</td></tr>")
				}else{
					maxPage = data.pageInfo[0];
					let arr = Object.values(data)[1];
					
					$('#pgTTL').text(currentPage+"/"+maxPage);
					$('#eleTTL').text(eleTTL);
					
					$('#pages').empty("");
					let pageStr = "<nav aria-label='Page navigation example'><ul class='pagination'><li class='page-item' onclick='move(-1)'><a class='page-link' href='javascript:void(0);' aria-label='Previous'><span aria-hidden='true'>&laquo;</span></a></li>";
					for (let i=1; i < (maxPage+1); i++){
						pageStr += "<li class='page-item' onclick='change("+ i +")'><a class='page-link' href='javascript:void(0);'>"+ i +"</a></li>";
					}
					pageStr += "<li class='page-item' onclick='move(1)'><a class='page-link' href='javascript:void(0);' aria-label='Next'><span aria-hidden='true'>&raquo;</span></a></li></ul></nav>";
					$('#pages').append(pageStr);
					
				    let trFrag = document.createDocumentFragment();
				    let eleTb = document.getElementById("tb");
					$.each(arr, function(idx, value){
						let eleTr = document.createElement("tr");
						let str = "<td>"+ value.itemId+ "</td><td>"+ value.itemName +"</td><td>"+ value.itemStock +"</td><td>"+ value.unitPrice +"</td><td>"+ 
						value.itemType.typeName +"</td><td style='word-wrap:break-word;'>"+ value.itemDesc +"</td><td>"+ value.lastUpdated + "</td><td>"+ value.vendorName +"</td>";
						if (value.onSale == true){
							str += "<td><span class='badge rounded-pill bg-success'>上架中</span></td>";
						}else{
							str += "<td><span class='badge rounded-pill bg-secondary'>停售</span></td>";
						}
						
						str += "<td><button class='btn btn-primary btn-sm mx-1' onclick=\"location.href='commodityForm?id="+ value.itemId +"';\">編輯</button><button class='btn btn-danger btn-sm mx-1' onclick='del("+ value.itemId +")'>刪除</button>";
						eleTr.innerHTML=str;
						trFrag.appendChild(eleTr);
						eleTb.appendChild(trFrag);
					})
				}			
			}
		})
	}
	
	function clearout(){
		$('#mySearch').find('.searchinput').val('');
		currentPage = 1;
		search();
	}
	
	$(".alert>button").on("click", function(){
		$(this).parent(".alert").remove();
	})

</script>
</body>
</html>