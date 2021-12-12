<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Search-Commodity</title>
<link rel="stylesheet" href="https://pro.fontawesome.com/releases/v5.10.0/css/all.css"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>

<style>
tr{
	border-bottom: 0.5px lightgrey solid;
}
</style>
</head>
<body>
<jsp:include page="/WEB-INF/jsp/commodityshop/front_header.jsp" />
<div class='container'>
<div class="row">
	<div class="col-2">
		<p class="sresultnum text-muted"></p>
		<div id='sort'>
			<span>排序依據:</span>
			<select id='sortslt' class="form-select"><option value='0' label='關聯性' selected></option>
				<option value='5' label='銷售-由高至低' /><option value='4' label='價格-由高至低' /><option value='3' label='價格-由低至高' /><option value='2' label='上架日期-最新' /><option value='1' label='上架日期-最舊'/></select>
		</div>
		<hr>
		<div>
			<div id='price'><p>價格</p></div><hr>
			<div id='types'><p>類別</p></div><hr>
			<div id='brands'><p>品牌</p></div><hr>
			<div id='button'></div>
			<div><button class='btn btn-primary btn-sm' onclick='search()'>套用篩選</button><button class="btn btn-secondary btn-sm" onclick='clearout()'>清除條件</button></div>
		</div>
	</div>
	<div class="col-10">
		<table class='table table-borderless table-sm'><thead><tr><td style='width:20%'></td><td style='width:80%'></td></tr></thead><tbody id='commList'></tbody></table>
	</div>
</div>

</div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	
	$(document).ready(function(){
		loadResult();
	})
	
	function loadResult(){
		$.ajax({
			type: 'get',
			url: 'searchresult',
			success: function (data){
				if (data.result.length == 0){
					$('#commList').html("&#9888; 抱歉, 查無該商品資料, 請試試其他關鍵字或商品號");
					return;
				}
				
				$('.sresultnum').text("共有 "+ data.result.length + " 項關鍵字搜尋結果")
				console.log(data.types);
				console.log(data.vendors);
				console.log(data.result);
				
				let pStr = "<input id='pmin' class='form-control form-control-sm d-inline' style='width:70px' placeholder='$ 最低價'/> - <input id='pmax' class='form-control form-control-sm d-inline' style='width:70px' placeholder='$ 最高價'/>";
				$('#price').append(pStr);
				
				let typeStr = "";
				$.each(data.types, function(idx, val){
					typeStr += "<div class='form-check'><input class='form-check-input' name='type' type='checkbox' value='"+ val.typeId +"'/><label class='form-check-label'>"+ val.typeName +"</label></div>";
				})
				$('#types').append(typeStr);
				
				let vndrStr = "";
				$.each(data.vendors, function(idx, val){
					vndrStr += "<div class='form-check'><input  class='form-check-input' name='vendor' type='checkbox' value='"+ val +"'/><label class='form-check-label'>"+ val +"</label></div>";
				})
				$('#brands').append(vndrStr);
				
				showData(data.result);
			}
		})
	}
	
	let ft = "pmin:,pmax,ctgy:,vndr:";
	function search(){
		let pmin = $("#pmin").val();
		let pmax = $("#pmax").val();
		
		let ctgy = $("#types input:checked").map(function(){
			return $(this).val();
		}).get();
		
		let vndr = $("#brands input:checked").map(function(){
			return $(this).val();
		}).get();
		
		ft = "pmin:"+pmin+";pmax:"+pmax+";ctgy:"+ctgy+";vndr:"+vndr;
		console.log(ft);
		getResult(ft, $('#sortslt').val());
	}
	
	function clearout(){
		$('#pmin,#pmax').val('');
		$('#types input').removeAttr('checked');
		$('#brands input').removeAttr('checked');
		search();
	}
	
	$('#sortslt').on('change', function(){
		getResult(ft, $(this).val());
	})
	
	function getResult(ft, st){
		$.ajax({
			type:'Get',
			url:'sorter',
			data: {
				'ft': ft,
				'st': st,
			},
			success: function (data){
				if (data.length == 0){
					$('#commList').html("&#9888; 抱歉, 查無商品資料, 請試試其他篩選項");
					return;
				}
				showData(data);
			}
		})
	}
	
	function showData(data){
		let commList = document.getElementById('commList');	
		commList.innerHTML="";
		$.each(data, function(idx, value){
			let rowFrag = document.createDocumentFragment();
			let trEle = document.createElement("tr");
			let str = "<td class='text-center align-middle'><div style='height:100px' class=''><img style='height:100%'src='../imgs/"+ value.itemId+"/"+ value.commodityImgs[0].imgSrc+"'></div></td>";
			str += "<td><p class='text-muted'>#"+ value.itemId +" | "+ value.vendorName+" | "+ value.itemType.typeName+" | 分類:"+value.itemType.groups+"</p><h6>"+
				value.itemName +"</h6><p><small class='text-muted'>"+ value.itemDesc +"</small></p><h5 class='fw-bold d-inline'>NT$"+ value.unitPrice;
			if (value.itemStock == 0){
				str +="<span class='badge bg-secondary float-end'>調貨中</span><h5></td>";
			}else{
				str +="<a id='addCart' onclick='addToCart(" + value.itemId + ")' class='btn btn-primary btn-sm float-end'><i class='fas fa-cart-plus'></i></a><h5></td>";
			}
			
			trEle.innerHTML = str;
			rowFrag.appendChild(trEle);
			commList.appendChild(rowFrag);
		})
	}
	
	function addToCart(id){
		$.ajax({
			url: "addToCart",
			type: "POST",
			data: {id: id,
					qty: 1},
			success: function(data){
				$("#cart").html(data.volume);
			}	
		})
	}
	
	
</script>
</body>
</html>