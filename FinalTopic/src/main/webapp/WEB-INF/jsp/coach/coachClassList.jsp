<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix='c' uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<div align='center'>
        <h3>課程清單</h3>
        <hr>
        <table border='1'>
            <tr>
<!--                <th width='60'>編輯</th> -->
                <th width='160'>課程名稱</th>
            </tr>
            <c:forEach var='classes' items='${classBeanList}'>
                <tr>
                    <td> <a href='updateClass/${classes.classId}'>${classes.className}</a></td>
                </tr>
            </c:forEach>
        </table>

    </div>
</body>
</html>