<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link>
<style type="text/css">
.loginDiv{
	width: 30%;
	margin: 0 auto;
	padding: 1rem;
}

.loginDiv > div{
	margin: 0.5rem 0;
}

.myInput{
   outline: none;
   box-sizing: border-box;
   width: 100%;
   height: 3rem;
   border: 1.5px solid #A084DC;  /* 0~F */
   border-radius: 6px;
   padding: 4px;
   font-size: 20px;
}
/* 인풋 태그에 focus 가 있을 때 */
.myInput:focus{
   outline: none;
   border: 2px solid #8051a9;
}

.btn_full{
	display: inline-block;
	width: 100%;
	background-color: #0074e9;
	color: white;
	text-align: center;
	padding: 6px 0;
	border-radius: 6px;
	font-size: 20px;
	-ms-user-select: none; 
    -moz-user-select: -moz-none;
    -khtml-user-select: none;
    -webkit-user-select: none;
    user-select: none;
}

.btn_full:hover {
	cursor: pointer;
	background-color: #4294f7;
}
</style>
</head>
<body>
	<div class="loginDiv">
		<div>Login To Your Account</div>
		<div><input class="myInput" type="text" placeholder="Username"></div>
		<div><input class="myInput" type="password" placeholder="Password"></div>
		<div class="btn_full">login</div>
	</div>
</body>
</html>