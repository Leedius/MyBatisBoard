<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 프로젝트에 공통으로 적용될 css파일 로드 -->
<link rel="stylesheet"  type="text/css" href="css/common.css?v=6">
<style type="text/css">
.container{
	width: 80%;
	margin: 0 auto;
	font-size: 20px;
}

.top_page_wrap{
	 margin-top: 30px;
}

.bottom_page_wrap{
	text-align: center;
	margin: 0 auto;
}
</style>
</head>
<body>
<!-- ..은 상위 폴더 접근 문법 -->
<div class="container">
	<div class="top_page_wrap">
		<jsp:include page="header.jsp"></jsp:include>
	</div>
	<div class="bottom_page_wrap">
		<jsp:include page="../content/${contentPage }"></jsp:include>
	</div>
</div>
</body>
</html>