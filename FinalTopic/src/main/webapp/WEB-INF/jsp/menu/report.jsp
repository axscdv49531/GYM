
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel=stylesheet href="Report.css">
<link rel="stylesheet"
	href="//code.jquery.com/ui/1.13.0/themes/base/jquery-ui.css">
<link rel="stylesheet" href="/resources/demos/style.css">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/charts.css/dist/charts.min.css">
<link rel=stylesheet href="charts.min.css">
<script src="https://code.jquery.com/ui/1.13.0/jquery-ui.js"></script>
<script>
	$(function() {
		var dateFormat = "mm/dd/yy", from = $("#from").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 3
		}).on("change", function() {
			to.datepicker("option", "minDate", getDate(this));
			$('from').blur();
		}), to = $("#to").datepicker({
			defaultDate : "+1w",
			changeMonth : true,
			numberOfMonths : 3
		}).on("change", function() {
			from.datepicker("option", "maxDate", getDate(this));
			$('to').blur();
		});

		function getDate(element) {
			var date;
			try {
				date = $.datepicker.parseDate(dateFormat, element.value);
			} catch (error) {
				date = null;
			}

			return date;
		}
	});
</script>




</head>
<body>

	<div style="text-align: center; margin-top: 100px;">
		<label for="from" style="font-family: DFKai-sb; font-size: 25px;">From</label>

		<input type="text" id="from" name="from"
			style="font-family: DFKai-sb; font-size: 25px; cursor: pointer" autocomplete="off"> 
		<label
			for="to" style="font-family: DFKai-sb; font-size: 25px">to</label> 
		<input
			type="text" id="to" name="to"
			style="font-family: DFKai-sb; font-size: 25px; cursor: pointer" autocomplete="off">

		<br>
		<div id="button"
			style="font-family: DFKai-sb; font-size: 25px; margin-top: 15px; cursor: pointer; margin-bottom: 15px">查詢</div>
		<br>
		<br>
	</div>




	<div
		style="border-style: solid; border-bottom-width: 1px; border-color: balck; width:1000px; margin: 0 auto;">
		<div style="float: left;">
			<table class="reportTable">
				<caption>餐飲成本</caption>

				<thead>
					<tr>
						<th scope="col">產品名稱</th>
						<th scope="col">價格</th>
						<th scope="col">賣出數量</th>
						<th scope="col">產品收入</th>
						<th scope="col">產品成本</th>
						<th scope="col">利潤</th>
					
					</tr>
				</thead>

				<tbody>
					<c:forEach var="menuList" items="${MenuList}" varStatus="x">
						<tr>
							<th scope="row">${menuList.getMenuName()}</th>
							<td>${menuList.getPrice()}</td>
							<td id="Quanty${x.index}"></td>
							<td id="income${x.index}"></td>
							<td id="Cost${x.index}"></td>
							<td id="Profit${x.index}"></td>


						</tr>


					</c:forEach>



					<tr>
						<th scope="row" style="visibility: hidden">total</th>
						<td style="visibility: hidden"></td>
						<td style="visibility: hidden"></td>
						<td id="totalincome"></td>
						<td style="visibility: hidden"></td>
						<td id="totalProfitMenu"></td>

					</tr>

				</tbody>

			</table>
		</div>
		<div style="float: right;">
			<table class="reportTable" style="float: right;"
				id="otherCost">
				
				<caption>成本</caption>
				<tr>
					<th scope="row">項目</th>
					<td >每月</td>
				</tr>
				<tr>
					<th scope="row">其他成本</th>
					<td id="OtherCost"></td>


				</tr>
				<tr>
					<th scope="row">人事成本</th>
					<td id="PeopleCost"></td>


				</tr>


				<tr>
					<th scope="row">房租成本</th>
					<td id="HouseCost"></td>

				</tr>
				<tr>
					<th scope="row">總利潤</th>
					<td id="TotalProfit"></td>

				</tr>


			</table>

		</div>


	</div>


	<table class="charts-css bar show-labels show-heading show-data-axes data-spacing-10" style="height: 350px; width: 700px;clear: both;">
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




	<script type="text/javascript">
	
	
		$("#button").click(function() {
			var date = $("#from").val();
			var date1 = $("#to").val();
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
							
							
							$("#totalincome").html(data[13]);
							
							
							var total=0;
							for(var i =0;i<${MenuList.size()};i++){
								$("#Quanty"+i).html(data[i]);
								$("#income"+i).html(data[i+${MenuList.size()}]);	
								
								//var incom=Number($("#income"+i).html());
								//var signalProfit=$("#Profit"+i).html();
								//$("#Profit"+i).html(signalProfit+incom);
								//total=total+Number($("#Profit"+i).html());	
							}
							
							
							if(cost.size > 0) {
								var Price=0;
								var total=0;
								var big=0;
								
								for(var i =0;i<${MenuList.size()};i++){
									$("#Cost"+i).html(cost.get(food[i][0]));
									
									
									var n=Number($("#Quanty"+i).html());
									
									var p=(Number(food[i][1]) - Number(cost.get(food[i][0])))*n;
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
								
								
								console.log(costHosue+"costHosue");
								console.log(peopleCost+"peopleCost");
								console.log(otherCost+"otherCost");
								
								total=Number(total)-costHosue-peopleCost-otherCost;
								console.log(total+"total");
								
								$("#TotalProfit").html(total);
								
								

								console.log(arrayP);
								for(var i =0;i<${MenuList.size()};i++){
									
									$("#chart"+i).css('--size', arrayP[i]/foodProfit+0.1);
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
						for(var i =0;i<${MenuList.size()};i++){
							$("#Cost"+i).html(cost.get(food[i][0]));
							
							var n=Number($("#Quanty"+i).html());
							
							var p=(Number(food[i][1]) - Number(cost.get(food[i][0])))*n;
							arrayP.push(p);
							$("#Profit"+i).html(p);
						
							total=total+Number($("#Profit"+i).html());
						}
						foodProfit = total;
						$("#totalProfitMenu").html(total);
						
						total=Number(total)-costHosue-peopleCost-otherCost;
						console.log(total+"total");
						
						$("#TotalProfit").html(total);

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