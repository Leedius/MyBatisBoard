<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.menu_wrap{
	text-align: right;
	font-size: 1.3rem;
}

.title_wrap{
	text-align: center;
}

.menu_wrap > a{
	text-decoration-line: none;
	color: black;
}

.menu_wrap > a:hover{
	text-decoration-line: underline;
	text-shadow: 0 0 3px #fff;
	color: #4294f7;
}
</style>
</head>
<body>
	<div class="menu_wrap">
		<c:choose>
			<c:when test="${not empty sessionScope.loginInfo }">
				${sessionScope.loginInfo.memName }님 반갑습니다.
				<a href="logout.me">LOGOUT</a>
			</c:when>
			<c:otherwise>		
				<a href="loginPage.me">LOGIN</a>
				<a href="join.me">JOIN</a>
			</c:otherwise>
		</c:choose>
	</div>
	<div class="title_wrap">
		<h1> B O A R D </h1>	
	</div>
</body>
</html>