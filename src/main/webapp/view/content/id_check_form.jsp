<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>id_Check_result.jsp</title>
</head>
<body>
	<div style="text-align: center">
	<h3>* 아이디 중복확인 *</h3>
    <form method="post" action="../../idCheck.me" onsubmit="return blankCheck(this)">
    아이디 : <input type="text" name="memId" maxlength="10" autofocus>
    <input type="submit" value="중복확인">
    </form>
    </div>
    
<script>
    function blankCheck(f){
    	var memId=f.memId.value;
        if(memId.length<2){
        	alert("아이디는 3자 이상 입력해주십시오.");
            return false;
        }//if end
        return true;
    }//blankCheck() end
 </script>
 </body>
 </html>