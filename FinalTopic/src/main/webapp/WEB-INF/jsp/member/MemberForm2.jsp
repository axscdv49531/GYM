<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script
	src="https://cdn.jsdelivr.net/npm/jquery-twzipcode@1.7.14/jquery.twzipcode.min.js"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript">
	function arrayToJson(formArray) {
		var dataArray = {};
		$.each(formArray, function() {
			if (dataArray[this.name]) {
				if (!dataArray[this.name].push) {
					dataArray[this.name] = [ dataArray[this.name] ];
				}
				dataArray[this.name].push(this.value || '');
			} else {
				dataArray[this.name] = this.value || '';
			}
		});
		return JSON.stringify(dataArray);
	}

	function insertMember() {
		var formArray = $("#form").serializeArray()
		var json = arrayToJson(formArray);
		console.log(formArray);
		console.log("json:" + json);
		$.ajax({
			type : 'post',
			url : 'insertMember',
			data : json.stringify(data),
			dataType : 'JSON',
			contentType : 'application/json;charset=utf-8',
			success : function(data) {
				alert("新增成功");
				$('#insertsuccess').html("新增成功");
			}
		});
	}
</script>
</head>
<body>
	<div align="center">
		<form id="form">
			<fieldset class="fieldset-auto-width">
				<legend>新增會員</legend>
				<table>
					<tr>
						<td align='right'>身分證字號：<br>&nbsp;
						</td>
						<td><input name="id" id="id" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>密碼：<br>&nbsp;
						</td>
						<td><input name="password" id="password" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>確認密碼：<br>&nbsp;
						</td>
						<td><input name="confirmedPassword" id="confirmedPassword" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>姓名：<br>&nbsp;
						</td>
						<td><input name="name" id="name" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>性別 : <br>&nbsp;
						</td>
						<td><input type="radio" name="gender" id="gender" value="男" />男<br>&nbsp;</td>
						<td><input type="radio" name="gender" id="gender" value="女" />女<br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>生日:<br>&nbsp;
						</td>
						<td><input type="date" name="birthday" id="birthday" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>手機：<br>&nbsp;
						</td>
						<td><input name="phone" id="phone" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>Email：<br>&nbsp;
						</td>
						<td><input name="email" id="email" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>地址：<br>&nbsp;
						</td>
						<td><script>
						const twzipcode = new TWzipcode(".twzipcode");
							$("#twzipcode").twzipcode();
							var county = twzipcode.get('county');
							var district = twzipcode.get('district');
							var zipcode = twzipcode.get('zipcode');
							var get = twzipcode.get();
							twzipcode.get(function (data) {
								 data (Array)
								    [
								        {
								            "county": "縣市",
								            "district": "鄉鎮市區",
								            "zipcode": "郵遞區號",
								        }
								        …
								    ]								
								});
							console.log(get);
						</script><input name="address" id="address" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>入會時間: <br>&nbsp;
						</td>
						<td><input type="date" name="expirationdate"
							id="expirationdate" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>緊急聯絡人：<br>&nbsp;
						</td>
						<td><input name="emergencyContact" id="emergencyContact" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td align='right'>緊急聯絡人電話：<br>&nbsp;
						</td>
						<td><input name="emergencyPhone" id="emergencyPhone" /><br>&nbsp;</td>
					</tr>
					<tr>
						<td colspan='2' align='center'><input type="button"
							value='送出' onclick="insertMember()"></td>
					</tr>

				</table>
			</fieldset>
		</form>
	</div>
	<br>
	<a href="<c:url value='/' />">回首頁</a>

</body>
</html>