<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {
		load();
	});

	function search() {
		var className = document.getElementById("searchByClassName").value;
		var startDate = document.getElementById("searchByDateStart").value;
		var endDate = document.getElementById("searchByDateEnd").value;
		var skillTemp = document.getElementById("searchBySkillName");
		var skillName = skillTemp.value;
		var coachNameTemp = document.getElementById("searchByCoachName");
		var coachName = coachNameTemp.value;
		var statusTemp = document.getElementById("searchByClassStatus");
		var status = statusTemp.value;

		$
				.ajax({
					type : 'post',
					url : '/searchClass/',
					data : {
						cName : className,
						coaName : coachName,
						sName : skillName,
						sDate : startDate,
						eDate : endDate,
						cStatus : status
					},
					dataType : 'JSON',
					success : function(data) {
						console.log('success:' + data);
						var json = JSON.stringify(data, null, 4);
						console.log('json:' + json);

						$('#showclasslist').empty("");

						if (data == null) {
							$('table').prepend(
									"<tr><td colspan='2'>暫無資料</td></tr>");
							;
						} else {
							var table = $('#showclasslist');
							table
									.append("<tr id='ptitle'><th>課程名稱</th><th>教練姓名</th><th>開課日期</th><th>課程開始時間</th><th>課程結束時間</th><th>課程時數</th><th>價格</th><th>訓練部位</th><th>報名狀況</th></tr>");

							$
									.each(
											data,
											function(i, n) {
												var status = null;
												if (n.classAvaliable == 0) {
													status = "未額滿"
												} else {
													status = "已額滿"
												}
												var a = [];
												for (i in n.sBean) {
													a
															.push(n.sBean[i].skillName)
												}
												var tr = "<tr align='center'>"
														+ "<td>"
														+ n.className
														+ "</td>"
														+ "<td>"
														+ n.cBean.coachName
														+ "</td>"
														+ "<td>"
														+ n.classDate
														+ "</td>"
														+ "<td>"
														+ n.classStartTime
														+ "</td>"
														+ "<td>"
														+ n.classEndTime
														+ "</td>"
														+ "<td>"
														+ n.classDuration
														+ "</td>"
														+ "<td>"
														+ n.classPrice
														+ "</td>"
														+ "<td>"
														+ a
														+ "</td>"
														+ "<td>"
														+ status
														+ "</td>"
														+ "<td>"
														+ "<input type='button' value='查看' onclick=\"location.href='" + "/member/viewClass/" + n.classId +"'\"></td>"
														+ "</tr>";
												table.append(tr);
											});
						}
					}
				});

	}

	function show(asd) {
		var s;
		var ss = [];
		for (var i = 0; i < asd.length; i++) {
			s = asd[i]['skillName'];
			console.log(s)
			ss.push(s)
		}
		return 'aaa';
	}

	function load(a, startDate, endDate) {
		$
				.ajax({
					type : 'post',
					url : '/listAllClass/',
					// 					data : {
					// 						searchaa : a,
					// 						sd : startDate,
					// 						ed : endDate
					// 					},
					dataType : 'JSON',
					// 					contentType : 'application/json',
					success : function(data) {
						console.log('success:' + data);
						var json = JSON.stringify(data, null, 4);
						console.log('json:' + json);

						$('#showclasslist').empty("");

						if (data == null) {
							$('table').prepend(
									"<tr><td colspan='2'>暫無資料</td></tr>");
							;
						} else {
							var table = $('#showclasslist');
							table
									.append("<tr id='ptitle'><th>課程名稱</th><th>教練姓名</th><th>開課日期</th><th>課程開始時間</th><th>課程結束時間</th><th>課程時數</th><th>價格</th><th>訓練部位</th><th>報名狀況</th></tr>");

							$
									.each(
											data,
											function(i, n) {
												var status = null;
												if (n.classAvaliable == 0) {
													status = "未額滿"
												} else {
													status = "已額滿"
												}
												var a = [];
												for (i in n.sBean) {
													a
															.push(n.sBean[i].skillName)
												}
												var tr = "<tr align='center'>"
														+ "<td>"
														+ n.className
														+ "</td>"
														+ "<td>"
														+ n.cBean.coachName
														+ "</td>"
														+ "<td>"
														+ n.classDate
														+ "</td>"
														+ "<td>"
														+ n.classStartTime
														+ "</td>"
														+ "<td>"
														+ n.classEndTime
														+ "</td>"
														+ "<td>"
														+ n.classDuration
														+ "</td>"
														+ "<td>"
														+ n.classPrice
														+ "</td>"
														+ "<td>"
														+ a
														+ "</td>"
														+ "<td>"
														+ status
														+ "</td>"
														+ "<td>"
														+ "<input type='button' value='查看' onclick=\"location.href='" + "/viewClass/" + n.classId +"'\"></td>"
														+ "</tr>";
												table.append(tr);
											});
						}
					}
				});
	}
</script>
</head>
<body>
	<div id="Title">課程清單</div>
	課程名稱：
	<input type="text" placeholder="輸入內容" id="searchByClassName">
	<!-- 	價格：<input type="text" placeholder="輸入內容" id="searchByClassPrice"> -->
	教練名稱：
	<select name="select" id="searchByCoachName">
		<option selected="selected">請選擇</option>
		<c:forEach items="${coachList}" var="coach">
			<option value="${coach}"><c:out value="${coach}" /></option>
		</c:forEach>
	</select> 訓練部位：
	<select name="select" id="searchBySkillName">
		<option selected="selected">請選擇</option>
		<c:forEach items="${skillList}" var="skill">
			<option value="${skill.skillName}"><c:out
					value="${skill.skillName}" /></option>
		</c:forEach>
	</select> 開課狀況：
	<select name="select" id="searchByClassStatus">
		<option selected="selected">請選擇</option>
		<option value="0">未額滿</option>
		<option value="1">已額滿</option>
	</select> 開課日期：
	<input type="date" id="searchByDateStart"> 至
	<input type="date" id="searchByDateEnd">
	<button onclick="search()">搜尋</button>
	<table id="showclasslist" border="1"></table>
</body>
</html>