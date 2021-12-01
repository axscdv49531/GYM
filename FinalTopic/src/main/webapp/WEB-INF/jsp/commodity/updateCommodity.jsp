<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Commodity</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<style>
body{
	background-color: #F5F5F5;
	padding: 10px;
}

</style>
</head>
<body>
<a href='commodity'>回上頁</a>
<div><h4>編輯商品</h4></div>
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
				<form:select class="form-select" path="itemType"><form:option value='' label='請挑選'/>
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
				<form:input class="form-control" type="text" path="itemName"/><form:errors class="text-danger" path="itemName"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">商品描述</label>
			<div class="col-sm-10">
				<form:textarea class="form-control" path="itemDesc"/><form:errors class="text-danger" path="itemDesc"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">廠商名稱</label>
			<div class="col-sm-10">
				<form:input class="form-control" type="text" path="vendorName"/><form:errors class="text-danger" path="vendorName"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">庫存量</label>
			<div class="col-sm-3">
				<form:input class="form-control" type="text" path="itemStock"/><form:errors class="text-danger" path="itemStock"/>
			</div>
		</div>
		<div class="row mb-3">
			<label class="col-sm-2 col-form-label">單價(NT$)</label>
			<div class="col-sm-3">
				<form:input class="form-control" type="text" path="unitPrice"/><form:errors class="text-danger" path="unitPrice"/>
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
			//img.className= "img-thumbnail";
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
	
</script>
</body>
</html>