<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">

function idCheck() {
	window.open("view/content/id_check_form.jsp", "idwin", "width=500, height=350")	
}

function checkPassword() {
	var password = document.getElementById("password").value;

	var passwordStrength = 0;
	if (password.match(/[a-zA-Z]/)) {
		passwordStrength += 1;
	}
	if (password.match(/[0-9]/)) {
		passwordStrength += 1;
	}
	if (password.match(/[@!#$%^&+=]/)) {
		passwordStrength += 1;
	}

	if (passwordStrength < 2) {
		document.getElementById("passwordWarning").style.color = "#ff0000";
		document.getElementById("passwordWarning").innerHTML = "비밀번호가 취약합니다.";
	} else if (passwordStrength < 3) {
		document.getElementById("passwordWarning").style.color = "#c6b300";
		document.getElementById("passwordWarning").innerHTML = "비밀번호가 취약할 수 있습니다.";
	} else {
		document.getElementById("passwordWarning").style.color = "#00891a";
		document.getElementById("passwordWarning").innerHTML = "비밀번호가 강력합니다.";
	}
}

function nullInputCheck(event) {
	var memId = document.getElementById("memId").value.toString()
		,memName = document.getElementById("memName").value.toString()
		,memTell = document.getElementById("memTell").value.toString()
		,memEmail = document.getElementById("memEmail").value.toString()
		,hasError = false;
	
	if(memId == ""){
		document.getElementById("idWarning").style.color = "#ff0000";
		document.getElementById("idWarning").innerHTML = "아이디가 입력되지 않았습니다.";
		hasError = true;
	}
	else {
		memId = document.getElementById("memId").value.toString()
		document.getElementById("idWarning").innerHTML = "";
	}
	if(memName == ""){
		document.getElementById("nameWarning").style.color = "#ff0000";
		document.getElementById("nameWarning").innerHTML = "이름이 입력되지 않았습니다.";
		hasError = true;
	}
	else {
		document.getElementById("nameWarning").innerHTML = "";		
	}
	if(memTell == ""){
		document.getElementById("tellWarning").style.color = "#ff0000";
		document.getElementById("tellWarning").innerHTML = "전화번호가 입력되지 않았습니다.";
		hasError = true;
	}
	else {
		document.getElementById("tellWarning").innerHTML = "";		
	}
	if(memEmail == ""){
		document.getElementById("emailWarning").style.color = "#ff0000";
		document.getElementById("emailWarning").innerHTML = "이메일이 입력되지 않았습니다.";
		hasError = true;
	}
	else {
		document.getElementById("emailWarning").innerHTML = "";		
	}
	if(hasError){
		event.preventDefault();
	}
}

</script>
<title>Insert title here</title>
<style type="text/css">
.reg_wrap .title{
	text-align: center;
	padding-bottom: 20px;
	color:black;
}

table{
	margin: 30px auto;
	text-align: left;
	background-color: #f3f5f6;
	border-radius: 10px;
	padding-top: 70px;
	padding-bottom: 90px;
	padding-left: 100px;
	padding-right: 100px;
}

.input_info > td{
	padding: 5px 0;
}

.input_info > input{
	display: inline-block;
	min-width: 30px;
	margin-left: 10px;
	padding: 5px;
	border: 1px solid black;
	border-radius: 5px;
	font-size: 1rem;
	background: white;	
	color: black;
}

.input_box{
	border: none;
	border-bottom: 1px solid silver;
	height: 25px;
	width: 200px;
}

.input_info > td:first-child{
	padding-right: 5px;
}

.reg_wrap{
	text-align: center;
}

.input_warning{
	font-size: 0.6rem;
	font: red;
}
.wrapper_button{
	text-align: center;
	padding-top: 10px;
}


.input_info .admin{
	text-align: center;
	padding-top: 50px;
}

.select_admin{
	padding-right: 2rem;
}

</style>
</head>
<body onload="nullInputCheck(event)">
<div class="reg_wrap">
	<form action="joinMember.me" name="joininfo" method="post" >
	<table>
		<tr>
			<td colspan="2">
				<div>
				<h2 class="title">Join Account</h2>
				</div>
			</td>
		</tr>
		<tr class="input_info">
			<td>아이디</td>
			<td>
				<input class="input_box" type="text" name="memId" id="memId" oninput="nullInputCheck(event);" readonly="readonly"> 
				<input class="btn" type="button" onclick="idCheck()" name="dbCheckId" value="중복 확인">
				<div class="input_warning" id="idWarning"></div>
			</td>
		</tr>
		<tr class="input_info">
			<td><span>비밀번호</span></td>
			<td><input class="input_box" type="password" id="password" name="memPw" onkeyup="checkPassword();" required><br>
			<div class="input_warning" id="passwordWarning"></div>
			</td>
		</tr>
		<tr class="input_info">
			<td><span>비밀번호 확인</span></td>
			<td><input class="input_box" type="password" id="confirm_password" name="confirm_memPw" required></td>
		</tr>
		<tr class="input_info">
			<td>이름</td>
			<td>
				<input class="input_box" type="text" name="memName" id="memName" oninput="nullInputCheck(event);" required>
				<div class="input_warning" id="nameWarning"></div>
			</td>
		</tr>
		<tr class="input_info">
			<td>전화번호</td>
			<td>
				<input class="input_box" type="text" name="memTell" id="memTell" oninput="nullInputCheck(event);" required>
				<div class="input_warning" id="tellWarning"></div>
			</td>
		</tr>
		<tr class="input_info">
			<td>EMAIL</td>
			<td>
				<input class="input_box" type="email" name="memEmail" id="memEmail" oninput="nullInputCheck(event);" required>
				<div class="input_warning" id="emailWarning"></div>
			</td>
		</tr>
		<tr class="input_info">
			<td>성별</td>
			<td>
				<input type="radio" name="gender" value="남" checked>남자
				<input type="radio" name="gender" value="여">여자
			</td>
		</tr>
		<tr class="input_info">
			<td class="admin" colspan="2">
				<span class="select_admin" ><input type="radio" name="isAdmin" value="Y" >관리자</span>
				<span><input type="radio" name="isAdmin" value="N" checked>일반유저</span>
			</td>
		</tr>
		<tr>
			<td class="wrapper_button" colspan="2">
				<input class="btn" type="submit" value="등 록">
			</td>
		</tr>
	</table>
	</form>
</div>
</body>
</html>