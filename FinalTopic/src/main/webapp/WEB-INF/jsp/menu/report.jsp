<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>產品報表</title>

<script	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel=stylesheet href="Report.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/charts.css/dist/charts.min.css">
<link rel=stylesheet href="charts.min.css">
<link rel="stylesheet" href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">

<link href="css/bootstrap.min.css" rel="stylesheet">


<script>


	
	
</script>



</head>
<body style="background-color:white;">

<div class="wrapper">
<c:import url="/adminsidebarMenu"></c:import> 
<div class="main-panel">
<c:import url="/adminnavbarMenu"></c:import> 
<div class="content">
<div class="container-fluid">

<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>


	<div style="margin:0px auto" >

			<div style="width:100%;height:40px"></div>

			<div style="width:100%;text-align:center">
					

					<input type="text" id="setDate" name="setDate" class="date-picker"
						style="font-family: DFKai-sb; font-size: 20px; cursor: pointer"
						autocomplete="off"> 
					
					<input type="text" id="endDate" name="endDate"
						style="font-family: DFKai-sb; font-size: 20px; cursor: pointer;display: none"
						autocomplete="off" readonly> 
					<input type="button"  id="button"
						style="font-family: DFKai-sb; font-size: 20px;cursor: pointer;padding:5px 10px;margin-left:10px;background-color:white;border:none" value="查詢日期">
				

			</div>	
			
	</div>	






	<div class="row" style="margin:0 auto;width: 900px;margin-top:100px" >
		<div class="col-md-4 stretch-card grid-margin">
			<div class="card bg-gradient-warning text-white"style="background-color: #99CCFF;text-align:center">
				<div class="card-body" style="padding:20px 10px;">
					<h4 class="font-weight-normal mb-3">monthly Sales</h4>
					<h2 class="font-weight-normal mb-5" id="totalincome"></h2>
				</div>
			</div>
		</div>
		<div class="col-md-4 stretch-card grid-margin" style="" >
			<div class="card bg-gradient-info text-white" style="background-color: #666699;text-align:center">
				<div class="card-body" style="padding:20px 10px;">
					<h4 class="font-weight-normal mb-3">monthly Orders</h4>
					<h2 class="font-weight-normal mb-5" id="monthlyOrders"></h2>
					
				</div>
			</div>
		</div>
		<div class="col-md-4 stretch-card grid-margin"  style="width:300px">
			<div class="card bg-gradient-info text-white" style="background-color: #99CCCC;text-align:center">
				<div class="card-body" style="padding:20px 10px;">
					<h4 class="font-weight-normal mb-3">monthly cost</h4>
					<h2 class="font-weight-normal mb-5" id="totalProfitMenuandother"></h2>
				
				</div>
			</div>
		</div>
	</div>
	
	


	<table class="charts-css bar show-labels show-heading show-data-axes data-spacing-10" style="height: 350px; width: 900px;clear: both;margin-top: 50px">
        <caption style="height:40px;margin-top:40px;font-size:18px">Profit Compared</caption>
        <thead>
          <tr>
            <th>Year</th>
            <th>Progress</th>
          </tr>
        </thead>
        <tbody>
			<c:forEach var="menuList" items="${MenuList}" varStatus="x">
						<tr>
							<th scope="row" style="font-size:16px">${menuList.getMenuName()}</th>
							<td style="--size: 0.1;font-size:16px;" id="chart${x.index}">0</td>
							

						</tr>


			</c:forEach>
        
          
          
        </tbody>
      </table>
      
      
      
      <div class="row" style="margin:0 auto;width:900px;margin-top:100px" >
          <div class="col-lg-10 grid-margin stretch-card">
              <div class="card"  style="width:900px;">
                <div class="card-body" >
                  <h4 class="card-title" style="margin-top: 5px" >餐飲成本</h4>
                
                  <table style="font-size:20px;width:880px;" >
                    <thead>
                      <tr style="background-color: #CCCCFF">
                        <td>產品名稱</td>
                        <td>價格</td>
                        <td>賣出數量</td>
                        <td>產品收入</td>
                         <td>產品成本</td>
                          <td>利潤</td>
                      </tr>
                    </thead>
                    <tbody>
							<c:forEach var="menuList" items="${MenuList}" varStatus="x">
								<tr>
									<td scope="row">${menuList.getMenuName()}</td>
									<td>${menuList.getPrice()}</td>
									<td id="Quanty${x.index}">0</td>
									<td id="income${x.index}">0</td>
									<td id="Cost${x.index}">0</td>
									<td id="Profit${x.index}">0</td>
								</tr>
							</c:forEach>

						</tbody>
                  </table>
                </div>
              </div>
            </div>
		</div>



		<div class="row" style="margin:0 auto;width: 900px;margin-top:100px" >
		<div class="col-lg-10 grid-margin stretch-card">
			<div class="card"  style="width:880px;">
				<div class="card-body" >
					<h4 class="card-title">損益表</h4>

					<table style="font-size:20px;width:850px;">
						<tr style="background-color: #CCCCFF">
							<td scope="row">項目</td>
							<td scope="row">每月</td>
						</tr>
						<tr>
							<td scope="row">總收入</td>
							<td id="income">0</td>
						</tr>
						<tr>
							<td scope="row">食材成本</td>
							<td id="foodCost">0</td>
						</tr>							
						<tr>
							<td scope="row">人事成本</td>
							<td id="PeopleCost">0</td>
						</tr>
						<tr>
							<td scope="row">房租成本</td>
							<td id="HouseCost">0</td>
						</tr>
						<tr>
							<td scope="row">其他成本</td>
							<td id="OtherCost">0</td>
						</tr>
						<tr>
							<td scope="row">總利潤</td>
							<td id="TotalProfit">0</td>

						</tr>
					</table>
				</div>
			</div>
		</div>
		</div>
		

</div>
</div>
</div>
</div>
	











<script type="text/javascript">
		
	
		
		$(document).ready(function() {
			
			$('#setDate').click(function () {
				var el = document.getElementById('ui-datepicker-div');
				//console.log(el);
				//var style = window.getComputedStyle(el, null);
				//console.log(style.getPropertyValue('font-size'));
				el.style.fontSize = '16px';
			
		    });
			
			
			$('.date-picker').datepicker( {
				changeMonth: true,
				changeYear: true,
    			showButtonPanel: true,
    			dateFormat: 'mm/dd/yy',
    			onClose: function(dateText, inst) { 
    				var year = inst.selectedYear;
    				var month = inst.selectedMonth;
					$(this).datepicker('setDate', new Date(year, month, 1));
					var end = new Date(year, month+1, 1);
					var mm = end.getMonth() + 1; // getMonth() is zero-based
					var dd = end.getDate();
					var endDate = [(mm>9 ? '' : '0') + mm, (dd>9 ? '' : '0') + dd, end.getFullYear()].join('/')
					$("#endDate").val(endDate);
				}
			});
		});

		
		$("#button").click(function() {
			var date = $("#setDate").val();
			var date1 = $("#endDate").val();
			if(date.length > 0 && date1.length > 0) {
				load(date, date1);
				searchCost(date1);
				$("#otherCost").css("display","block");
				
			} else {
				alert("輸入正確日期");
			}
			
			
			
		});

		var cost = new Map();
		var food = [
			<c:forEach var="menuList" items="${MenuList}" varStatus="loop">
	            ['${menuList.getMenuName()}', '${menuList.getPrice()}']${!loop.last ? ',' : ''}
	        </c:forEach>
	        ];
		var arrayP=[];
		var foodProfit=0;
		
		function load(date, date1) {
			$
					.ajax({
						type : 'Get',
						url : '/querybyTime?date=' + date + '&date1=' + date1,
						dataType : 'JSON',
						contentType : 'application/json',
						success : function(data) {
							console.log('success:' + data);
							var json = JSON.stringify(data);
							console.log('json:' + json);
							var total=0;
							var qtotal=0;
							for(var i =0;i<${MenuList.size()};i++){
								console.log(data[food[i][0]] +', '+food[i][0]);
								$("#Quanty"+i).html(data[food[i][0]]);
								$("#income"+i).html(Number($("#Quanty"+i).html())*food[i][1]);
								
								total=total+Number($("#income"+i).html());					
								qtotal=qtotal+Number($("#Quanty"+i).html());
								
								
							}
							
							
							
							$("#monthlyOrders").html(qtotal);
							$("#totalincome").html("$"+total);
							console.log(qtotal+"qtotal");
							
							
							if(cost.size > 0) {
								var Price=0;
								var total=0;
								var big=0;
								var foodCost=0;
								var income=0;
								
								for(var i =0;i<${MenuList.size()};i++){
									$("#Cost"+i).html(cost.get(food[i][0]));
									
									
									var n=Number($("#Quanty"+i).html());
									
									var p=(Number(food[i][1]) - Number(cost.get(food[i][0])))*n;
									income+=Number(food[i][1])*n;
									foodCost+=Number(cost.get(food[i][0]))*n;
									arrayP.push(p);
									$("#Profit"+i).html(p);
									total=total+Number($("#Profit"+i).html());
								}
								foodProfit = total;
								$("#totalProfitMenu").html(total);
								
								$("#HouseCost").html(cost.get("房租"));
								$("#PeopleCost").html(cost.get("人事成本"));
								$("#OtherCost").html(cost.get("其他"));
								
								var costHosue=Number($("#HouseCost").html());
								var peopleCost=Number($("#PeopleCost").html());
								var otherCost=Number($("#OtherCost").html());
								
								$("#totalProfitMenuandother").html("$"+(foodCost+costHosue+peopleCost+otherCost));
								
								console.log(costHosue+"costHosue");
								console.log(peopleCost+"peopleCost");
								console.log(otherCost+"otherCost");
								
								total=Number(total)-costHosue-peopleCost-otherCost;
								console.log(total+"total");
								
								$("#TotalProfit").html(total);
								
								$("#income").html(income);
								$("#foodCost").html(foodCost);

								console.log(arrayP);
								for(var i =0;i<${MenuList.size()};i++){
									
									var percent = arrayP[i]/foodProfit+0.1;
									if(percent > 1) {
										percent=1.0;
									}
									$("#chart"+i).css('--size', percent.toString());
									$("#chart"+i).html(arrayP[i]+"("+parseInt(arrayP[i]*100/foodProfit)+"%)");
								}
								
							}
		

						}
					});
		
			
		}
		
		

		function searchCost(date1) {
			var listName = ['checkenCost', 'Banana'];
			
			$.ajax({
				type : 'Get',
				url : '/queryCost.controller?date1=' + date1,
				dataType : 'JSON',
				contentType : 'application/json',
				success : function(data) {
					console.log('cost' + data);
					var json = JSON.stringify(data);
					console.log('json+cost:' + json);
									
					
					for(var i=0;i<data.length;i++){
						cost.set(data[i].costitem,data[i].costprice);
					}
					console.log(cost);
					
					
					
					$("#HouseCost").html(cost.get("房租"));
					$("#PeopleCost").html(cost.get("人事成本"));
					$("#OtherCost").html(cost.get("其他"));
					
					
					var costHosue=Number($("#HouseCost").html());
					var peopleCost=Number($("#PeopleCost").html());
					var otherCost=Number($("#OtherCost").html());
					
					
					console.log(costHosue+"costHosue");
					console.log(peopleCost+"peopleCost");
					console.log(otherCost+"otherCost");
					
					console.log("food: "+food);
					
					var q=$("#Quanty0").html();
					if(q.length > 0) {
						var total=0;
						var foodCost=0;
						var income=0;
						for(var i =0;i<${MenuList.size()};i++){
							$("#Cost"+i).html(cost.get(food[i][0]));
							
							var n=Number($("#Quanty"+i).html());
							income+=Number(food[i][1])*n;
							foodCost+=Number(cost.get(food[i][0]))*n;
							var p=(Number(food[i][1]) - Number(cost.get(food[i][0])))*n;
							arrayP.push(p);
							$("#Profit"+i).html(p);
						
							total=total+Number($("#Profit"+i).html());
						}
						foodProfit = total;
						$("#totalProfitMenuandother").html("$"+(foodCost+costHosue+peopleCost+otherCost));
					
						
						
						total=Number(total)-costHosue-peopleCost-otherCost;
						console.log(total+"total");
						
						$("#TotalProfit").html(total);
						$("#income").html(income);
						$("#foodCost").html(foodCost);

						console.log(arrayP);
						for(var i =0;i<${MenuList.size()};i++){
							var percent = arrayP[i]/foodProfit+0.1;
							if(percent > 1) {
								percent=1.0;
							}
							$("#chart"+i).css('--size', percent.toString());
							$("#chart"+i).html(arrayP[i]+"("+parseInt(arrayP[i]*100/foodProfit)+"%)");
						}
						
					}
					
					
					
				}

			});
			
		
		}
		
</script>
</body>
</html>