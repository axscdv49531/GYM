<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>新增成本</title>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
<script>
 $(document).ready(function(){
    	load();
    });
 
 function load(){
	 $("#costday").val("");
		
	$("#costName").val("");
		
	$("#price").val("");

 }
</script>
</head>
<body>


<div class="wrapper">
<c:import url="/adminsidebarMenu"></c:import> 
<div class="main-panel">
<c:import url="/adminnavbarMenu"></c:import> 
<div class="content">
<div class="container-fluid">

	
		<form:form action="saveCost.controller" method='POST'
		modelAttribute="cost" class="row g-3 needs-validation" >


		<div class="editFrom">
			<form:select class="form-control"  path="costitem" id="costName" style="width:300px;margin-top:20px;margin-left:15px"  >
				<c:forEach var="menu" items="${menu}">
					<option value="${menu.getMenuName()}">${menu.getMenuName()}</option>
				</c:forEach>
				<option value="其他">其他</option>
				<option value="房租">房租</option>
				<option value="人事成本">人事成本</option>
			</form:select>
			<div class="col-md-4">
				<form:input path="costprice" type="text" placeholder="價格"  id="price"  class="form-control" style="width:200px;margin-top:20px;"/>
			</div>
		 	<div class="col-md-4">

							<div class="input-group has-validation">
								<form:input path="costday"  type="text" class="form-control"
									aria-describedby="inputGroupPrepend"
									placeholder="新增日期:yyy/mm/dd"  id="costday" style="width:300px;margin-top:20px;"/>
							</div>
			</div>
			
			
			<div class="col-12">
							<button class="btn btn-primary" type="submit" id="button" style=" margin-top:20px;">送出資料
							</button>
			</div>

		</div>

	   </form:form>







</div>
</div>
</div>
</div>
	


	<script>
		$("#button").click(function(){
			var regex=/^\d{4}\/\d{1,2}\/\d{1,2}$/;
			
			
			var day=$("#costday").val();
			
			var name=$("#costName").val();
			
			var price=$("#price").val();
			
			if(name==0||name==null){
				alert("成本名稱未輸入");
				return false;
			}
			else if(price==0||price==null){
				alert("價格未輸入");
				return false;
			}else if(day==0||day==null){
				alert("日期未輸入");
				
				return false;
			}else if(regex.test(day)==false){
				alert("日期格式輸入錯誤");
				
				return false;
			}
		});
		

		if("${ok}"!=""){
			alert("資料新增成功");
		}
		
		
		
		
		
	
	</script>
</body>
</html>