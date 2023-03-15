<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<c:choose>
	<c:when test="${idCheck == false}">
		<body onload="setmemIdAndClose()">
		<script type="text/javascript" >
			function setmemIdAndClose() {
				var memId = "${memId}";
				alert('아이디사용 가능합니다.');
				window.opener.document.getElementById("memId").value = memId;
                window.close();
            }
		</script>
		</body>
	</c:when>
	<c:otherwise>
		<script type="text/javascript">
			alert('아이디가 중복입니다.')
			location.href = 'view/content/id_check_form.jsp';
		</script>
	</c:otherwise>	
</c:choose>
</body>
</html>