<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>產品報表</title>
<link rel=stylesheet href="Report.css">
<link rel="stylesheet" href="jquery-ui/jquery-ui.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/charts.css/dist/charts.min.css">
<link rel=stylesheet href="charts.min.css">
<script src="jquery-ui/jquery-ui.js"></script>
 <link href="yummy_css/style.css" rel="stylesheet">
 <script src="https://code.jquery.com/jquery-3.6.0.min.js" integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4=" crossorigin="anonymous"></script>

<script>

$(function() {
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
	
	
	
</script>




</head>
<body>

<div class="wrapper">
<c:import url="/adminsidebarMenu"></c:import> 
<div class="main-panel">
<c:import url="/adminnavbarMenu"></c:import> 
<div class="content">
<div class="container-fluid">

			<div style="margin:0 auto">
					<label for="from" style="font-family: DFKai-sb; font-size: 25px; ">From</label>

					<input type="text" id="setDate" name="setDate" class="date-picker"
						style="font-family: DFKai-sb; font-size: 20px; cursor: pointer"
						autocomplete="off"> 
					<label for="to" style="font-family: DFKai-sb; font-size: 20px">to</label> 
					<input type="text" id="endDate" name="endDate"
						style="font-family: DFKai-sb; font-size: 20px; cursor: pointer"
						autocomplete="off" readonly> 
					<input type="button"  id="button"
						style="font-family: DFKai-sb; font-size: 20px;cursor: pointer;padding:5px 10px;margin-left:10px;background-color:white;border:none" value="查詢">
				

			</div>	
			
		






		<div class="row" style="margin:0 auto;width: 900px;margin-top:300px" >
		<div class="col-md-4 stretch-card grid-margin"  style="padding-right:5px">
			<div class="card bg-gradient-warning text-white"style="background-color: #99CCFF;">
				<div class="card-body">
					<h4 class="font-weight-normal mb-3">monthly Sales</h4>
					<h2 class="font-weight-normal mb-5" id="totalincome"></h2>
				</div>
			</div>
		</div>
		<div class="col-md-4 stretch-card grid-margin" style="" >
			<div class="card bg-gradient-info text-white" style="background-color: #666699;">
				<div class="card-body">
					<h4 class="font-weight-normal mb-3">monthly Orders</h4>
					<h2 class="font-weight-normal mb-5" id="monthlyOrders"></h2>
					
				</div>
			</div>
		</div>
		<div class="col-md-4 stretch-card grid-margin"  style="width:300px">
			<div class="card bg-gradient-info text-white" style="background-color: #99CCCC;">
				<div class="card-body">
					<h4 class="font-weight-normal mb-3">monthly cost</h4>
					<h2 class="font-weight-normal mb-5" id="totalProfitMenuandother"></h2>
				
				</div>
			</div>
		</div>
	</div>





	<table class="charts-css bar show-labels show-heading show-data-axes data-spacing-10" style="height: 350px; width: 900px;clear: both;margin-top: 50px">
        <caption style="height:40px;margin-top:40px">Profit Compared</caption>
        <thead>
          <tr>
            <th>Year</th>
            <th>Progress</th>
          </tr>
        </thead>
        <tbody>
			<c:forEach var="menuList" items="${MenuList}" varStatus="x">
						<tr>
							<th scope="row">${menuList.getMenuName()}</th>
							<td style="--size: 0.1;" id="chart${x.index}">0</td>
							

						</tr>


			</c:forEach>
        
          
          
        </tbody>
      </table>
      
      
      
      
          <div class="col-lg-6 grid-margin stretch-card" style="top:100px; margin:0 auto;">
              <div class="card">
                <div class="card-body">
                  <h4 class="card-title" style="margin-top: 5px" >餐飲成本</h4>
                
                  <table class="table table-hover" frame=below>
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
									<td id="Quanty${x.index}"></td>
									<td id="income${x.index}"></td>
									<td id="Cost${x.index}"></td>
									<td id="Profit${x.index}"></td>
								</tr>
							</c:forEach>

						</tbody>
                  </table>
                </div>
              </div>
            </div>





		<div class="col-lg-6 grid-margin stretch-card"
			style="top: 200px; margin: 0 auto;">
			<div class="card">
				<div class="card-body">
					<h4 class="card-title">損益表</h4>

					<table class="table table-hover">
						<tr style="background-color: #CCCCFF">
							<td scope="row">項目</td>
							<td>每月</td>
						</tr>
						<tr>
							<td scope="row">總收入</td>
							<td id="income"></td>
						</tr>
						<tr>
							<td scope="row">食材成本</td>
							<td id="foodCost"></td>
						</tr>							
						<tr>
							<td scope="row">人事成本</td>
							<td id="PeopleCost"></td>
						</tr>
						<tr>
							<td scope="row">房租成本</td>
							<td id="HouseCost"></td>
						</tr>
						<tr>
							<td scope="row">其他成本</td>
							<td id="OtherCost"></td>
						</tr>
						<tr>
							<td scope="row">總利潤</td>
							<td id="TotalProfit"></td>

						</tr>
					</table>
				</div>
			</div>
		</div>
		
		

</div>
</div>
</div>
</div>



	











<script type="text/javascript">
		
	
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
							
							
							$("#totalincome").html("$"+data[13]);
							
							
							
							var total=0;
							var qtotal=0;
							for(var i =0;i<${MenuList.size()};i++){
								$("#Quanty"+i).html(data[i]);
							
								qtotal=qtotal+Number(data[i]);
								
								$("#income"+i).html(data[i+${MenuList.size()}]);	
								
								//var incom=Number($("#income"+i).html());
								//var signalProfit=$("#Profit"+i).html();
								//$("#Profit"+i).html(signalProfit+incom);
								//total=total+Number($("#Profit"+i).html());	
							}
							
							$("#monthlyOrders").html(qtotal);
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
								
								$("#totalProfitMenuandother").html(foodCost+costHosue+peopleCost+otherCost);
								
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
									$("#chart"+i).css('--size', percent);
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
						$("#totalProfitMenuandother").html(foodCost+costHosue+peopleCost+otherCost);
					
						
						
						total=Number(total)-costHosue-peopleCost-otherCost;
						console.log(total+"total");
						
						$("#TotalProfit").html(total);
						$("#income").html(income);
						$("#foodCost").html(foodCost);

						console.log(arrayP);
						for(var i =0;i<${MenuList.size()};i++){
							$("#chart"+i).css('--size', arrayP[i]/foodProfit+0.1);
							$("#chart"+i).html(arrayP[i]+"("+parseInt(arrayP[i]*100/foodProfit)+"%)");
						}
						
					}
					
					
					
				}

			});
			
		
		}
		
</script>
</body>
</html>