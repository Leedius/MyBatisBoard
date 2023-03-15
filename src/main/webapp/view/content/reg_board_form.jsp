<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function goBoardList() {
		location.href = 'boardList.bo'
	}
</script>
<style type="text/css">

.page_wrap{
	margin-top: 20px;
}
.board_title > input{
	width: 50%;
	height: 1.5rem;
}

.board_content > textarea{
	margin-top: 20px;
	resize: none;
	width: 50%;
	height: 5rem;
}

.page_wrap .btn_wrap{
	margin-top: 20px;
}

.btn_wrap > div{
	display: inline-block;
}


</style>
</head>
<body>
<div class="page_wrap">
	<form action="regBoard.bo" method="post">
	<div class="board_title">
		<input type="text" name="title" class="title_box" placeholder="제목을 입력해 주세요." maxlength="30">
	</div>
	<div class="board_content">
		<textarea name="content" class="textarea_box"></textarea>
	</div>
	<div class="btn_wrap">
		<div>
			<input type="submit" class="btn" value="등록">
		</div>

		<div>
			<input type="button" class="btn" value="뒤로가기" onclick="goBoardList()">
		</div>
	</div>
	</form>
</div>
</body>
</html>