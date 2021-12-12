<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
    My_Date();

});

function My_Date() { 
    var date = new Date();
    var datee = date.getFullYear() +  date.getMonth() + ( date.getDate() + 1);
    var year = date.getFullYear().toString();
    var month = (date.getMonth() +1 ).toString();
    var day = (date.getDate() +1 ).toString();
    var dateee = year + "-" + month + "-" + day;
    console.log(dateee)
    document.getElementById("datee").min = dateee;
} 

function print_value() {

    var startString = (document.getElementById("start").value).substring(2,0);
    var startInt = parseInt(startString)
    var durationString = document.getElementById("show").value;
    var durationInt = parseInt(durationString);
    var endInt = startInt + durationInt;
    var endString = endInt.toString() + ":00";
    document.getElementById("end").value = endString;
}
</script>
</head>
<body>
<div class="wrapper">
<%--        <c:import url="/adminsidebar"></c:import>  --%>
       <c:import url="/adminCoursesidebar"></c:import> 
        <div class="main-panel">
            <c:import url="/adminnavbar"></c:import> 
            <div class="content">
                <div class="container-fluid">

    <form:form method='Post' modelAttribute="classBean"
        enctype='multipart/form-data'>
        <legend>${LoginOK.coachName}編輯課程</legend>
        <form:input type="hidden" path="classId" />
        <table>
            <tr>
                <td align='right'>課程名稱：</td>
                <td><form:input path="className" /><br> <form:errors
                        path="className" />
            </tr>
            <tr>
                <td align='right'>開課日期：</td>
                <td><form:input id="datee" type="date" path="classDate" /> <br> <form:errors
                        path="classDate" />
            </tr>
                    <tr>
                        <td align='right'>開課時間：</td>
                        <td><form:select id="start" onchange="print_value();"
                                path="classStartTimeTemp">
                                <form:options items="${selectData}" />

                            </form:select> <br> <form:errors path="classStartTimeTemp" />
                    </tr>
                             <tr>
                        <td align='right'>課程時長：</td>
                        <td><form:input id="show" type="number" min="1"
                                max="2" step="1" onchange="print_value();" path="classDuration" />小時<br>
                            <form:errors path="classDuration" />
                    </tr>
            <tr>
                        <td align='right'>結束時間：</td>
                        <td><form:input style="width:80px" id="end"
                                path="classEndTimeTemp" readonly="true" /> 

                            <br> <form:errors path="classEndTimeTemp" />
                    </tr>
            <tr>
                <td align='right'>課程價格：</td>
                <td><form:input path="classPrice" /><br> <form:errors
                        path="classPrice" />
            </tr>
            <tr>
                <td align='right'>課程描述：</td>
                <td><form:textarea path="classDescription" /><br> <form:errors
                        path="classDescription" />
            </tr>
            <tr>
                <td align='right'>課程標籤：</td>
                <td><form:checkboxes items="${checkBoxList}" path="classLabel" /><br>
                    <form:errors path="classLabel" />
            </tr>
                             <tr>
                        <td align='right'>課程照片：</td>
                        <td><form:input path="claPhoto" type="file" /><br> <form:errors
                                path="claPhoto" />
                    </tr>
                    <form:input type="hidden" path="classAvaliable" />
            <tr>
                <td colspan='2' align='center'><input type='submit' name="edit"
                    value='提交'><input type='submit' name="delete" value='刪除'></td>
            </tr>

        </table>
    </form:form>
    </div>
    </div>
    </div>
    </div>
</body>
</html>