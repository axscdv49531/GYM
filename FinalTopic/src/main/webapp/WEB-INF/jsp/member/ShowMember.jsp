<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript">
	function confirmDelete(number) {
		var result = confirm("確定刪除此筆記錄(帳號:" + number.trim() + ")?");
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
	<div align='center'>
		<form:form method='POST' modelAttribute="memberBean">
			<h3>會員資料</h3>
			<hr>
			<table border='1'>
				<tr>
					<th width='100'>會員編號</th>
					<th width='160'>姓名</th>
					<th width='160'>性別</th>
					<th width='160'>生日</th>
					<th width='60'>詳細資料</th>
					<th width='60'>編輯</th>
					<th width='60'>刪除</th>
					<th width='60'>輸入會員組成分析</th>
					<th width='60'>會員組成分析查詢</th>
					<th width='60'>輸入會員繳費紀錄</th>
					<th width='60'>會員繳費紀錄查詢</th>
				</tr>
				<c:choose>
					<c:when test="${not empty memberBeanList}">
						<c:forEach var='member' items="${memberBeanList}">
							<tr>
								<td>${member.number}</td>
								<td>${member.name}</td>
								<td>${member.gender}</td>
								<td>${member.birthday}</td>
								<td><a href='selectMember/${member.number}'><input
										type='button' value='詳細資料'></a></td>
								<td><a href='modifyMember/${member.number}'><input
										type='button' value='編輯'></a></td>
								<td><a href='deleteMember/${member.number}'><input
									type='button' value='刪除' onclick="return confirmDelete('${member.number}');"></a></td>
								<td><a href='insertInbody/${member.number}'><input
										type='button' value='Inbody'></a></td>
								<td><a href='selectInbody/${member.number}'><input
										type='button' value='查詢inbody'></a></td>
								<td><a href='insertPayment/${member.number}'><input
										type='button' value='Payment'></a></td>
								<td><a href='selectPayment/${member.number}'><input
										type='button' value='查詢Payment'></a></td>
								<td><a href='updateDeposite/${member.number}'><input
										type='button' value='儲值'></a></td>
								<td><a href='findAllDeposite/${member.number}'><input
										type='button' value='查詢儲值紀錄'></a></td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
				查無Member資料
			</c:otherwise>
				</c:choose>
			</table>
		</form:form>
		<br> <a href="<c:url value='/' />">回首頁</a>
	</div>
</body>
</html>