<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.search_wrap{
	text-align: right;
	margin-top: 20px;
	margin-right: 1rem;
	margin-bottom: 0.5rem;
}

.search_wrap div{
	display: inline-flex;
}

.search_button{
	margin: auto auto;
}

.s_btn{
	height: 2.5rem;
	background-color: black;
	color: white;
	border-radius: 6px;
	padding: 0 0.2rem;
}

.board_wrap{
	margin-top: 0;
	text-align: center;
}

.board_title_wrap{
	border-bottom: 1px solid black;
	width:100%;
	background-color: black;
	color: white;
	font-weight: bolder;
}

.board_list {
	border-bottom: 0.5px solid silver;
}

.board_list:hover{
	background-color: #eeeeee;
}

.board_title_wrap > div{
	display: inline-block;
	padding: 15px 0;
	font-size: 1.4rem;
	text-align: center;
}

.board_list > div{
	display: inline-block;
	padding: 15px 0;
	font-size: 1.4rem;
	text-align: center;
}

.board_list_wrap{
	border-bottom: 0.2rem solid black;
}

.board_wrap .num {
	width: 9%;
}

.board_wrap .name {
	width: 60%;
	text-align: center;
}

.board_wrap .writer {
	width: 9%;
	text-align: center;
}

.board_wrap .readCnt {
	width: 9%;
	text-align: center;
}

.board_wrap .date {
	width: 9%;
	text-align: center;
}

.write_bnt{
	text-decoration-line: none;
	margin-top: 20px;
	text-align: right;
}

.write_bnt > a{
	text-align: center;
}

.board_page{
	margin-top: 1rem;
}

.board_page > a{
	text-decoration: none;
	color: black;
}

.name > a{
	text-decoration: none;
	color: black;
}

.name > a:hover{
	text-decoration: underline;
	text-shadow: 0 0 3px #fff;
	color: #4294f7;
	cursor: pointer;
}

.board_page{
	margin-bottom: 3rem;
}

.board_page > a:hover{
	text-decoration: underline;
	text-shadow: 0 0 3px #fff;
	color: #4294f7;
	cursor: pointer;
}

</style>
<script type="text/javascript">
function goBoardWrite() {
	location.href = 'boardWriteForm.bo'
}
	
function goBoardDetail(boardNum) {
	location.href = 'boardToDetail.bo?boardNum='+boardNum;
}

const selectOption = document.getElementById("selectOption");
	
</script>
</head>
<body>
<div class="search_wrap">
	<form action="boardList.bo" method="post">
	<div class="select_condition">
		<select name="selectName">
			<option value="TITLE">제목</option>
			<option value="WRITER">작성자</option>
		</select>
	</div>
	<div class="search_name">
		<input type="text" name="searchName">
	</div>
	<div class="search_button">
		<input class="s_btn" type="submit" value="검색"> 
	</div>
	</form>
</div>
	<div class="board_wrap">
		<div class="board_title_wrap">
			<div class="num">번호</div>
			<div class="name">제목</div>
			<div class="writer">작성자</div>
			<div class="readCnt">조회</div>
			<div class="date">등록일</div>
		</div>
		<div class="board_list_wrap">
			<c:choose>
				<c:when test="${!empty boardList }">
					<c:forEach items="${boardList }" var="boardList" varStatus="boardStatus">
						<div class="board_list">
							<div class="num">${boardList.boardNum }</div>
							<div class="name"><a href="#" onclick="goBoardDetail(${boardList.boardNum})">${boardList.title }</a></div>
							<div class="writer">${boardList.writer }</div>
							<div class="readCnt">${boardList.readCnt }</div>
							<div class="date">${boardList.createDate }</div>
						</div>
					</c:forEach>
				</c:when>
				<c:otherwise>
					게시글이 없습니다.
				</c:otherwise>
			</c:choose>
		</div>
			<div class="board_page">
				<c:forEach begin="1" step="1" end="${paging.endPage }" var="i">
					<a href="pagingBoardList.bo">${i }</a>
				</c:forEach>
			</div>
		<div>
			<c:choose>
				<c:when test="${not empty sessionScope.loginInfo }">
					<div class="write_bnt"><input type="button" class="btn" value="글쓰기" onclick="goBoardWrite();"></div>
				</c:when>
				<c:otherwise>		
				</c:otherwise>
			</c:choose>
		</div>
	</div>
</body>
</html>