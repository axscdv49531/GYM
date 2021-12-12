<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Commodity</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
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
	<div><h4>更新商品</h4></div>
	<div class=''>
	<form:form method="post" action="updateCommodity" modelAttribute="commodityBean" enctype="multipart/Form-Data">
		<c:if test="${commodityBean.itemId != null }">
			<div class="row mb-3">
				<label class="col-sm-2 col-form-label"># ${commodityBean.itemId}</label>
				<form:input id='itemId' type="hidden" path="itemId" /><form:errors path="itemId"/>
				<div class="col-sm-10">
					<form:checkbox class="form-check-input" path="onSale"/><form:errors path="onSale"/>
					<label class="form-label">是否上架</label>
				</div>
			</div>
		</c:if>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">商品分類</label>
			<div class="col-sm-10">
				<form:select id='itemType' class="form-select" path="itemType"><form:option value='' label='請挑選'/>
				<c:forEach var='typeGroup' items='${itemTypeBean}'>
					<optgroup label='${typeGroup.key}'>
					<form:options items='${typeGroup.value}' itemLabel='typeName' itemValue='typeId'/>
					</optgroup>
				</c:forEach>
				</form:select>
				<form:errors class="text-danger" path="itemType"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">商品名稱</label>
			<div class="col-sm-10">
				<form:input id='itemName' class="form-control" type="text" path="itemName"/><form:errors class="text-danger" path="itemName"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">商品描述</label>
			<div class="col-sm-10">
				<form:textarea id='itemDesc' class="form-control" path="itemDesc"/><form:errors class="text-danger" path="itemDesc"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">廠商名稱</label>
			<div class="col-sm-10">
				<form:input id='vendorName' class="form-control" type="text" path="vendorName"/><form:errors class="text-danger" path="vendorName"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">庫存量</label>
			<div class="col-sm-3">
				<form:input id='itemStock' class="form-control" type="text" path="itemStock"/><form:errors class="text-danger" path="itemStock"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">單價(NT$)</label>
			<div class="col-sm-3">
				<form:input id='unitPrice' class="form-control" type="text" path="unitPrice"/><form:errors class="text-danger" path="unitPrice"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">商品圖片</label>
			<div class="col-sm-7">
				<form:input class="form-control" id='uploadFile' type="file" path="file" name="files" multiple="multiple"/>
				<form:errors class="text-danger" path="file"/>
			</div>
		</div>
		<div class="row mb-3" >
			<label class="col-sm-2 col-form-label"></label>
			<div class="col-sm-10" id='preview'></div>
		</div>
		<c:if test="${not empty commodityBean.commodityImgs or commodityBean.commodityImgs != null}">
			<div class="row mb-3">
				<label class="col-sm-2 col-form-label">已上傳的照片</label>
				<div class="col-sm-10">
					<c:forEach var="entry" items="${commodityBean.commodityImgs}">
						<div style='display:inline-block'>
							<img style='display:block' title="${entry.imgSrc}" src="../imgs/${commodityBean.itemId}/${entry.imgSrc}" height="100">
							<a class="btn btn-danger btn-sm" role='button' >刪除圖片</a>
						</div>
					</c:forEach>
				</div>
			</div>
		</c:if>
		<div class="row mb-3">
	    	<button class="btn btn-primary" type="submit" value="send">更新</button>
	  	</div>
	</form:form>
	<button class="btn btn-info btn-sm" onclick='quickinput()'>一鍵輸入</button>
	</div>
</div>
<!-- end of my page -->
</div>
</div>
</div>
<script src="http://code.jquery.com/jquery-1.12.4.min.js"></script>
<script type="text/javascript">
	let uploadFile = document.getElementById("uploadFile");
	let preview = document.getElementById("preview");
	
	uploadFile.addEventListener("change", function(){
		preview.innerHTML = "";
		let files = this.files;
		for (let file of files){
			let img = new Image;
			img.src = URL.createObjectURL(file);
			img.height = 100;
			preview.appendChild(img);
		}
	})
	
	
	$(".btn-danger").on("click", function(){
		let img = $(this).siblings('img');
		if(window.confirm("是否刪除圖片 "+ img.attr('title')+" ?")){
			let str = img.attr('src').slice(7);
			console.log(str);///100004/2111281104380.jpg
			$.ajax({
				url: "delCommImg"+str,
				type: "delete",
				success: function (msg){
					img.parent().remove();
					alert(msg);
				},
				error: function (xhr){
					alert(xhr.responseText);
				}
			})
		}
		
	})
	
	
	//Datas for present
	inputdatas=[
		{'itemType': 10, 'itemName': '黃金比例分離乳清 (5磅/罐) 巧克力', 'itemDesc':'發展並維持肌肉，蛋白質有助於維持和增加肌肉量。高蛋白質，配方含有80%乳清蛋白。', 'vendorName':'ON', 'itemStock':20, 'unitPrice':2299},
		{'itemType': 10, 'itemName': '支鏈胺基酸膠囊 (60顆裝)', 'itemDesc':'支鏈胺基酸、乳酸鈣、精胺酸、麩醯胺酸、維生素C、氧化鎂、硬脂酸鎂、菸鹼醯胺、維生素D3、維生素B2', 'vendorName':'運能延力生技', 'itemStock':30, 'unitPrice':800},
		{'itemType': 18, 'itemName': "軟木瑜珈墊 5mm - Nature's Jungle", 'itemDesc':"尺寸：68x185cmx5mm; 重量：2.8kg(±0.5%); 材質：100%軟木+天然橡膠", 'vendorName':'Clesign', 'itemStock':20, 'unitPrice':2980},
		{'itemType': 18, 'itemName': '‧TPE環保瑜珈墊 6mm', 'itemDesc':'尺寸：61x173cm; 無毒100%TPE材質可自然裂解。不含有機矽、PVC和鄰苯二甲酸鹽。', 'vendorName':'Clesign', 'itemStock':20, 'unitPrice':2080},
		{'itemType': 13, 'itemName': '‧運動口罩AC480', 'itemDesc':'輕薄涼爽的運動口罩，可水洗重複使用，非醫療用口罩-可抑制飛沫擴散，但無法防止病毒感染', 'vendorName':'YONEX', 'itemStock':30, 'unitPrice':380},
	]
	
	let idx = 0;
	function quickinput(){
		$("#itemType").val(inputdatas[idx].itemType);
		$("#itemName").val(inputdatas[idx].itemName);
		$("#itemDesc").val(inputdatas[idx].itemDesc);
		$("#vendorName").val(inputdatas[idx].vendorName);
		$("#itemStock").val(inputdatas[idx].itemStock);
		$("#unitPrice").val(inputdatas[idx].unitPrice);
		idx++;
		if (idx==inputdatas.length){
			idx=0;
		}
	}
	
	
</script>
</body>
</html>