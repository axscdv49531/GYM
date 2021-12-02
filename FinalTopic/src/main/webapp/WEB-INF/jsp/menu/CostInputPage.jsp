<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel=stylesheet href="editFrom.css">
<link rel=stylesheet href="style.css">
<link rel=stylesheet href="showhidemenu.css">
<link rel=stylesheet href="showMenu.css">
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
	<form:form action="saveCost.controller" method='POST'
		modelAttribute="cost">


		<div class="editFrom">
			<div class="title">新增成本</div>
			<br> <font class="menuName">成本名稱:</font>
			<form:input path="costitem" class="menuName" size="10" id="costName"
				style="border-style:solid;" value="" />

			<br> <font class="price">價格:</font>
			<form:input path="costprice" class="price" size="10" id="price"
				style="border-style:solid" value="" />
			<br> <font class="qty1">新增日期:</font>
			<form:input path="costday" class="qty1" size="10" id="costday"
				style="border-style:solid" placeholder="xxxx/xx/xx" />
			<br> <br> <input type="submit" value="送出資料"
				class="detailDiv01Font1" id="button" />
		</div>

	</form:form>


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