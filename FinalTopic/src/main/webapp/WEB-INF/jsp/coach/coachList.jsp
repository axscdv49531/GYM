<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
           url:'/administrator/listAllCoach/',
           dataType:'JSON',
           contentType:'application/json',
           success: function(data){
               
               console.log('success:' + data);
               var json = JSON.stringify(data,null,4);
               console.log('json:' + json);
               
               $('#showcoachlist').empty("");
               
               if(data==null){
                   $('table').prepend("<tr><td colspan='2'>暫無資料</td></tr>");;
               }else{
                   var table = $('#showcoachlist');
                   table.append("<tr id='ptitle'><th>教練大頭照</th><th>教練姓名</th></tr>");
                   
                   $.each(data, function(i,n){
                       var tr = "<tr align='center'>" + "<td><img width='50' height='50' src=" + "<c:url value='/administrator/getCoachPicture?coachAccount=' />" + n.coachAccount + " /></td>" + "<td>" + n.coachName + "</td>" +  "</tr>";
                       table.append(tr);
                   });             
               }
           }
       });
   })
</script>
</head>
<body>
<div id="Title">教練清單</div>
<table id="showcoachlist" border="1"></table>
</body>
</html>