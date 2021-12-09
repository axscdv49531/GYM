<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload File</title>
<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
</head>
<body>



<div class="wrapper">
<c:import url="/adminsidebarMenu"></c:import> 
<div class="main-panel">
<c:import url="/adminnavbarMenu"></c:import> 
<div class="content">
<div class="container-fluid">

	
	
	<form class="was-validated"  action="upload.controller" method="post"
		enctype="multipart/form-data">
		<div class="mb-3">
    	<input type="text" class="form-control is-invalid" id="validationTextarea" placeholder="menu:" required style="width: 700px;color: black" name="menuName" id="name" >
  		</div>
  		<div class="mb-3">
    	<input type="text" class="form-control is-invalid" id="validationTextarea" placeholder="price:" required style="width: 700px;color: black" name="menuPrice" id="price">
  		</div>
  		<div class="mb-3">
    	<input type="text" class="form-control is-invalid" id="validationTextarea" placeholder="quanty:" required style="width: 700px;color: black" name="menuQty" id="qty">
  		</div>
  		<div class="mb-3">
    
    	<textarea class="form-control is-invalid" id="validationTextarea" placeholder="detail:" required style="width: 700px;color: black"  name="detail" id="detail"></textarea>
   
  		</div>




 

  <div class="mb-3">
    <input type="file" class="form-control" aria-label="file example" required  name="myFiles"  id="file" style="width: 700px;color: black">
  </div>

  <div class="mb-3">
    <button class="btn btn-primary" type="submit" id="button" >upload</button>
  </div>
</form>
</div>
</div>
</div>
</div>
<script>

</script>

</body>
</html>