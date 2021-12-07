<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	function confirmDelete(measurementDate) {
		var result = confirm("確定刪除此筆記錄(日期:" + measurementDate.trim() + ")?");
		if (result) {
			document.forms[0].putOrDelete.name = "_method";
			document.forms[0].putOrDelete.value = "DELETE";
			return true;
		}
		return false;
	}
</script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div style="width: 1205px; height: 194.13px">
		<c:import url="/top_memberlogin"></c:import>
	</div>
	<div align='center'>
		<form:form method='POST' modelAttribute="paymentBean">
			<h3>付款紀錄</h3>
			<hr>
			<table border='1'>
				<tr>	
					<th width='160'>付款日期</th>
					<th width='160'>付款金額</th>					
					<th width='60'>刪除</th>
				</tr>
				<c:choose>
					<c:when test="${not empty paymentBeanList}">
						<c:forEach var='payment' items="${paymentBeanList}">
							<tr>
								<td>${payment.paymentDate}</td>
								<td>${payment.paymentAmount}</td>
								<td><a href='deletePayment/${payment.no}'><input
									type='button' value='刪除' onclick="return confirmDelete('${payment.paymentDate}');"></a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
				無付款記錄
			</c:otherwise>
				</c:choose>
			</table>
		</form:form>
		<br>  <a href="<c:url value='/login/MemberSuccess' />">回前頁</a>
	</div>
</body>
</html>