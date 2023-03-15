<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script type="text/javascript">
function checkValue()
{
    inputForm = eval("document.loginInfo");
    if(!inputForm.memId.value)
    {
        alert("아이디를 입력하세요");    
        inputForm.memId.focus();
        return false;
    }
    if(!inputForm.memPw.value)
    {
        alert("비밀번호를 입력하세요");    
        inputForm.memPw.focus();
        return false;
    }
    
    
    
}
</script>
<title>Insert title here</title>
<style type="text/css">
.title {
	text-align: center;
	padding: 20px 0;
}

.title > h2 {
	color:#black;
}

.wrapper_box {
	text-align: center;
}

table {
	margin: 30px auto;
	background-color: #f3f5f6;
	border-radius: 10px;
	text-align: left;
	padding-top: 70px;
	padding-bottom: 60px;
	padding-left: 100px;
	padding-right: 100px;
}

.wrapper_button {
	text-align: center;
	padding-top: 50px;
}

.id_wrap {
	padding: 10px 0;
}

.id_text {
	padding-right: 15px;
}

.pw_wrap {
	padding: 10px 0;
}


</style>
</head>
<body>
	<table>
		<tr>
			<td>
			<div class="title">
				<h2>Login To Your Acoount</h2>
			</div>
			<form action="login.me" name="loginInfo" method="post" onsubmit="return checkValue()">
					<div class="wrapper_box">
						<div class="id_wrap">
							<span> 
								<input class="input_box" type="text" name="memId" id="memId" placeholder="ID">
							</span>
						</div>
						<div class="pw_wrap">
							<span> 
								<input class="input_box" type="password" name="memPw" id="memPw" placeholder="PASSWORD">
							</span>
						</div>
					</div>
				<div class="wrapper_button">
					<span class="login"><input class="btn" type="submit" value="로그인"></span>
				</div>
			</form>
		</td>
		</tr>
	</table>
</body>
</html>