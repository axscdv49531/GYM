<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%@ page language="java" import="java.net.InetAddress" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>餐點出貨</title>

<style>
.qr-code {
	max-width: 200px;
	margin: 10px;
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"
	integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
	crossorigin="anonymous"></script>
	<script>
	var ip="${ip}";
	
	</script>
</head>
<body>

	<div class="wrapper">
		<c:import url="/adminsidebarMenu"></c:import>
		<div class="main-panel">
			<c:import url="/adminnavbarMenu"></c:import>
			<div class="content">
				<div class="container-fluid">
					<div class="input-group mb-3" style="width: 700px">
						<div style="width: 800px; display: none;" id="shipment">
							<table class="table">
								<thead>
									<tr>
										<th scope="col">#</th>
										<th scope="col">id</th>
										<th scope="col">數量</th>
										<th scope="col">價錢</th>
										<th scope="col">出貨QRCODE</th>
									</tr>
								</thead>
								<tbody id="shipmentTable">
								</tbody>


							</table>

						</div>


						<div class="container-fluid">
							<div style="display: none" id="qrcode">

								<!-- Get a Placeholder image initially,
	this will change according to the
	data entered later -->
								<img
									src="https://chart.googleapis.com/chart?cht=qr&chl=Hello+World&chs=160x160&chld=L|0"
									class="qr-code img-thumbnail img-responsive" />
								<button type="button" id="generate"
									style="display: none; margin-left: 10px;">Generate</button>
							</div>

							<div class="form-horizontal" style="width: 500px">
								<div class="form-group">

									<div class="col-sm-10">

										<!-- Input box to enter the
			required data -->
										<input type="text" size="100" width="100px" maxlength="100"
											class="form-control" id="content"
											value="http://192.168.50.26:8080/changeStatus.controller?id="
											style="display: none;" />
									</div>
								</div>
								<div class="form-group">
									<div class="col-sm-offset-2 col-sm-10">

										<!-- Button to generate QR Code for
		the entered data -->

									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>




		<script>
			$(document).ready(function() {
				$("#shipment").css("display", "block");
				searchid();
				var timeoutID = window.setInterval(searchid, 3000);
			});
			var orderIdArr=[];

			function searchid() {

				$
						.ajax({
							type : 'Get',
							url : 'queryOrderId.controller',
							dataType : 'JSON',
							contentType : 'application/json',
							success : function(data) {
								function createQR(orderId){
									var url = "https://chart.googleapis.com/chart?cht=qr&chl=http://"
												+ip+":8080/changeStatus.controller?id=" 
												+ orderId + "&chs=160x160&chld=L|0";
									image = "<img src=" + url + " class='qr-code img-thumbnail img-responsive' />";
									button = "<a href='http://"+ip+":8080/changeStatus.controller?id=" 
												+ orderId + "' style='margin:20px;padding:10px 20px;font-size:24px;background-color:white;'>出貨</a>"	
									return image+button;
								}
								function compare(a, b) {
									if(a.length != b.length) {
										return false;
									}
									for(var i=0; i < a.length; i++) {
										if(!b.includes(a[i])) {
											return false;
										}
									}
									return true;
								}
								console.log('success:' + data);
								var json = JSON.stringify(data);
								console.log('json:' + json);
								//$('#shipmentTable').empty("");
								var table = $("#shipmentTable");
								var number = 1;
								var totalQuanty = 0;
								var totalprice = 0;
								var orderId = 0;
								var tr = "";
								var tQuanty = "";
								var new_orderIdArr = [];
										
										$.each(
											data,
											function(i, n) {
												if(!new_orderIdArr.includes(n.orderId)){
													new_orderIdArr.push(n.orderId);
												}
											});
										if(orderIdArr.length > 0 && compare(orderIdArr, new_orderIdArr) ) {
											return;
										}
										orderIdArr=new_orderIdArr.slice();
										$("#shipmentTable").empty();
										$.each(
												data,
												function(i, n) {
													console.log(i+"-->"+n.orderId);
													if (orderId != 0
															&& orderId != n.orderId) {
														number = number + 1;
														table.append(tr);
														totalQuanty = 0;
														totalprice = 0;
														tr = "";
														tQuanty = "";
													}
													
													
													orderId = n.orderId;
													var price = Number(n.qty)
															* Number(n.price);
													totalQuanty = totalQuanty
															+ n.qty;
													totalprice = totalprice
															+ price;
													tQuanty += n.food+" : "+n.qty+"<br>";

													if (data.length == 0) {
														tr = ('<tr><th scope="row">'
																+ number
																+ '</th><td>'
																+ "無紀錄" + "</td><td></td><td></td><td></td></tr>");

													} else {
														//console.log("1-->"+n.orderId);
														tr = ('<tr><th scope="row">'
																+ number
																+ '</th><td id="QRCODENumber">'
																+ orderId
																+ "</td>"
																+ "<td>"
																+ tQuanty
																//+totalQuanty
																+ "</td>"
																+ "<td>"
																+ totalprice
																+ "</td>" 
																+ "<td id='creatCode" +number+ "'>"
																//+ "<td id='creatCode'>"
																+ createQR(orderId)
																+ "</td></tr>");

													}

												});
										table.append(tr);

							}
						});

			}

			$("#shipmentTable").on("click", "#creatCode", function() {

				$("#qrcode").css("display", "block");
				$("#generate").css("display", "block");
				console.log("creatCode");
				var number = "";
				number = $("#QRCODENumber").text();
				console.log(number + "=number");
				var content = $("#content").val();
				console.log(content + number);
				$("#content").val(content + number);

			});

			function htmlEncode(value) {
				return $('<div/>').text(value).html();
			}

			$(function() {

				// Specify an onclick function
				// for the generate button
				$('#generate')
						.click(
								function() {

									// Generate the link that would be
									// used to generate the QR Code
									// with the given data
									let finalURL = 'https://chart.googleapis.com/chart?cht=qr&chl='
											+ htmlEncode($('#content').val())
											+ '&chs=160x160&chld=L|0'

									// Replace the src of the image with
									// the QR code image
									$('.qr-code').attr('src', finalURL);
									console.log(finalURL);
								});
			});
			
			
		</script>
</body>
</html>