<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
//    var indexPage=1;
//    $(document).ready(function(){
//        load(indexPage);
//    });
   
//    function change(page){
//        indexPage = page;
//        load(indexPage);
//    }
   
   $(function load(){
       $.ajax({
           type:'post',
           url:'/coach/listAllClass/',
           dataType:'JSON',
           contentType:'application/json',
           success: function(data){
               
               console.log('success:' + data);
               var json = JSON.stringify(data,null,4);
               console.log('json:' + json);
               
               $('#showclasslist').empty("");
               
               if(data==null){
                   $('table').prepend("<tr><td colspan='2'>暫無資料</td></tr>");;
               }else{
                   var table = $('#showclasslist');
                   table.append("<tr id='ptitle'><th>課程名稱</th><th>開課日期</th><th>課程時數</th></tr>");
                   
                   $.each(data, function(i,n){
                       var tr = "<tr align='center'>" +  "<td>" + n.className + "</td>" +"<td>" + n.classDate + "</td>"+ "<td>" + n.classDuration + "</td>"+ "</tr>";
//                        "<td><img width='50' height='50' src=" + "<c:url value='/administrator/getCoachPicture?coachAccount=' />" + n.coachAccount + " /></td>" +
                       table.append(tr);
                   });             
               }
           }
       });
   })
</script>
</head>
<body>
<div id="Title">課程清單</div>
<table id="showclasslist" border="1"></table>
</body>
</html>