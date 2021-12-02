<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel=stylesheet href="evaluation.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
</head>
<body>

	<div class="maindiv">
		<div style="float: left;">
			<font id="selectMenu" class="detailDiv01Font1" >${menuList.get(0).getMenuName()}</font>	

		</div>

		<div style="clear: both; margin-top:100px">
			<img src="images/staricon.png" id="i1" class="starimg"> <img src="images/staricon.png"
				id="i2" class="starimg"> <img src="images/staricon.png" id="i3" class="starimg"> <img
				src="images/staricon.png" id="i4" class="starimg"> <img src="images/staricon.png" class="starimg"
				id="i5">
		</div>
		<font>打分中.......</font><font id="showScore"></font> &emsp; &emsp;<font>雙擊可重新打分</font>


		<textarea id="suggestion" rows="10" cols="50" placeholder="意見欄"
			style="margin-top: 50px"></textarea>
			
		<div class="sentbutton">送出評分</div>
		
		<img src="images/iconarrowleft.png" id="leftIcon" style="width: 40px;height: 40px;position:absolute;left:0px;top:250px">
			<img src="images/iconarrowright.png" id="rightIcon"style="width: 40px;height:40px;position:absolute;right:0px;top:250px">
	</div>
	
	





	<script>
	
      
		
	
	
		
		$("#leftIcon").click(function() {
			  $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
			  $("#showScore").html("0分");
			  flag=true;
			
			var name=[];
			<c:forEach var="menuList" items="${menuList}" varStatus="loop">
	          name.push('${menuList.getMenuName()}');
	        </c:forEach>
	        console.log(name);
			var size=${menuList.size()}
			var menu=$("#selectMenu").html();
			var index=Number(name.indexOf(menu));
			if(index==0){
				index=0;
			}else{
				index=index-1;
			}
			
			$("#selectMenu").html(name[index]);		
		});
		
		

		$("#rightIcon").click(function() {
			 $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
			  $("#showScore").html("0分");
			  flag=true;
			var name=[];
			<c:forEach var="menuList" items="${menuList}" varStatus="loop">
	          name.push('${menuList.getMenuName()}');
	        </c:forEach>
	        console.log(name);
			var size=
				Number(${menuList.size()});
			var menu=$("#selectMenu").html();
			var index=Number(name.indexOf(menu));
			if(index==size-1){
				index=size-1;
			}else{
				index=index+1;
			}
			
			$("#selectMenu").html(name[index]);		
		});
	
	
		
	
	

	
			
        let flag = true;
        $("#i1,#i2,#i3,#i4,#i5").hover(function(){
            if(flag==true){
                if(this.id=="i1"){
                    $("#i1").css("filter","none");
                    $("#showScore").html("1分");
                    console.log(this.id);
                }else if(this.id=="i2"){
                    $("#i1,#i2").css("filter","none");
                    $("#showScore").html("2分");
                }else if(this.id=="i3"){
                	$("#i1,#i2,#i3").css("filter","none");
                    $("#showScore").html("3分");
                }else if(this.id=="i4"){
                	$("#i1,#i2,#i3,#i4").css("filter","none");
                    $("#showScore").html("4分");
                }else if(this.id=="i5"){
                	$("#i1,#i2,#i3,#i4,#i5").css("filter","none");
                    $("#showScore").html("5分");
                } 
            }
           
        },function(){
            if(flag==true){
                $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
                $("#showScore").html("0分");
            }  
        });

        $("#i1,#i2,#i3,#i4,#i5").click(function(){
            if(this.id=="i1"){
            	   $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
            	 	$("#i1").css("filter","none");
                    $("#showScore").html("1顆星");
                }else if(this.id=="i2"){
                	   $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
                	 $("#i1,#i2").css("filter","none");
                    $("#showScore").html("2顆星");
                }else if(this.id=="i3"){
                	   $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
                	$("#i1,#i2,#i3").css("filter","none");
                    $("#showScore").html("3顆星");
                }else if(this.id=="i4"){
                	   $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
                	$("#i1,#i2,#i3,#i4").css("filter","none");
                    $("#showScore").html("4顆星");
                }else if(this.id=="i5"){
                	 $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
                	$("#i1,#i2,#i3,#i4,#i5").css("filter","none");
                    $("#showScore").html("5顆星");
                } 
            flag=false;
        });
        
        $("#i1,#i2,#i3,#i4,#i5").dblclick(function(){
            flag=true;

        });
        
        
        
        $(".sentbutton").click(function(){
        
        	var score=$("#showScore").html();
        	var suggestion=$("#suggestion").val();
        	var menuName=$("#selectMenu").html();
        	
        	
        	console.log(score+"score");
        	console.log(suggestion+"suggestion");
        	console.log(menuName+"menuName");
       
        
  
        	var params={
        		"suggestion":suggestion,
        		"score":score,
        		"menuname":menuName
        	}
        	
        	  
        	$.ajax({
         	   type:'post',
         	   url:"insertEvaluation.controller",
         	   dataType:'JSON',
         	   contentType:'application/json',
         	   data:JSON.stringify(params),
         	   success: function(data){
         		   console.log(data);
         			 $("#i1,#i2,#i3,#i4,#i5").css("filter", "grayscale()" );
        			 $("#showScore").html("0分");
        			 $("#suggestion").val(""); 
        			 flag=true;
        			 
         	   }
         	});

        });
        
      
   
       
</script>
</body>
</html>