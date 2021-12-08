<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Product List</title>
<link rel="stylesheet" href="/css/ordersystem.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
   var indexPage=1;
   $(document).ready(function(){
	   load(indexPage);
   });
   
   function change(page){
	   indexPage = page;
	   load(indexPage);
   }
   
   function load(indexPage){
	   $.ajax({
		   type:'post',
		   url:'/GymProject/memberByPage/' + indexPage,
		   dataType:'JSON',
		   contentType:'application/json',
		   success: function(data){
			   
			   console.log('success:' + data);
			   var json = JSON.stringify(data,null,4);
			   console.log('json:' + json);			   
			   $('#showmember').empty("");			   
			   if(data==null){
				   $('table').prepend("<tr><td colspan='2'>暫無資料</td></tr>");;
			   }else{
				   var table = $('#showproduct');
				   table.append("<tr id='mtitle'><th>會員編號</th><th>會員姓名</th><th>會員性別</th><th>會員生日</th><th>會員Email</th></tr>");
				   
				   $.each(data, function(i,n){
					   var tr = "<tr align='center'>" + "<td>" + n.number + "</td>" +
					            "<td>" + n.name + "</td>" + "<td>" + n.gender + "</td>" +
					            "<td>" + n.birthday + "</td>" + "<td>" + n.email + "</td>" +
					            "</tr>";
					   table.append(tr);
				   });			   
			   }
		   }
	   });
   }
</script>
</head>
<body>
<div id="memberlistTitle">Member Query</div>
<table id="showmember" border="1"></table>
<table id="showpage">
   <tr>
      <td>Total Pages:${totalPages} Total Records:${totalElements}</td>
      <td colspan="3" align="right">Previous
          <c:forEach var="i" begin="1" end="${totalPages}" step="1">
              <button id="myPage" value="${i}" onclick="change(${i})">${i}</button>
          </c:forEach>Next
      </td>
   </tr>
</table>
</body>
</html>