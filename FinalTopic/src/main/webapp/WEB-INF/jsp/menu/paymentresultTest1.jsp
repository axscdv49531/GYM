<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"
		integrity="sha256-/xUj+3OJU5yExlq6GSYGSHk7tPXikynS7ogEvDej/m4="
		crossorigin="anonymous"></script>
	<script type="text/javascript">
		$(document).ready(function() {
			load();
		});

		function load() {
			$.ajax({
				url:"https://payment-stage.ecpay.com.tw/bank/PaymentCenter/cntnotlogin/credit/result",
				type : "POST",
				dataType : text,
				success : function(data) {
					console.log(data);
				}

			});
		}
	</script>

</body>
</html>