<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Upload File</title>
</head>
<body>
	<form action="upload.controller" method="post"
		enctype="multipart/form-data">
		<!-- 上傳檔案 的form 需加入multipart/form-data -->
		Please Select Picture to Upload:<br /> <input type="file"
			name="myFiles" /><br /> 請輸入菜名:<input type="text" name="menuName" /><br />
		請輸入價錢:<input type="text" name="menuPrice" /><br /> 請輸入數量:<input
			type="text" name="menuQty" /><br />
		<button type="submit" value="upload">upload</button>
	</form>
</body>
</html>