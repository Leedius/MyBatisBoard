<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
session1.jsp파일입니다.<br>
name1 = ${name1 }<br>
name2 = ${sessionScope.name2 }<br>
<a href="view/test/session2.jsp">페이지 이동</a>
</body>
</html>