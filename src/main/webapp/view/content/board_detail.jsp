<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">

.board_wrap{
	margin: 20px auto;
	width: 70%;
}

.create_wrap > div{
 display: inline-block;
}

.create_wrap{
	border-bottom: 1px solid silver;
	margin-bottom: 30px;
	font-size: 1.5rem;
	color: #97a4c3;
}

.board_wrap > div{
	text-align: left;
}

.board_title{
	margin-bottom: 20px;
	
}

.content_wrap{
	min-height: 10rem;
	max-height: 200rem; 

}

.board_content{
	word-break: break-all;
	font-size: 1.7rem;
}

.btn_wrap{
	margin-top: 20px;
	padding-bottom: 3rem;
}

.btn_wrap > div{
	display: inline-block;
}

.btn_wrap > div > div{
	display: inline-block;
}

.reply_wrap{
	margin: 0 auto;
	width: 70%;
}

.reply_title{
	border-top:1px solid silver;
	text-align: left;
	font-size: 2rem;
}

.not_reply{
	text-align: left;
	font-size: 1.2rem;
}

.reply_info_wrap{
	margin-top: 10px;
	text-align: left;
}

.reply_writer{
	border-top:0.5px solid silver;
	margin-top:1.0rem;
	font-size: 1.5rem;
	font-weight: bold;
}

.reply_writer:first-child{
	border-top: none;
}

.reply_content{
	margin-top: 0.5rem;
	font-size: 1.5rem;
}

.reply_createDate{
	margin-top: 0.2rem;
	font-size: 1.2rem;
	color: #97a4c3;
}

.reg_reply{
	border: 0.5px solid silver;
	border-radius: 5px;
	margin-top: 1rem;
	text-align: left;
}

.reg_reply_box{
	margin-top: 1.0rem;
	border-top: 0.5px solid silver;
}

.reg_reply_writer{
	margin-left: 1rem;
	margin-top: 1rem;
	font-size: 1.5rem;
	text-align: left;
}


.reg_reply textarea{
	box-sizing: border-box;
	width: 90%;
	resize: none;
	border: none;
	font-size: 1.4rem;
	margin-top: 1rem;
	margin-left: 1rem;
}

.reg_reply textarea:focus{
	outline: none;
}

.reg_reply_btn{
	text-align: right;
}

.reg_reply_btn > input{
	border: none;
	background-color: white;
	margin-right: 1rem;
	margin-bottom: 1rem;
}

.reply_btn_wrap{
	font-size: 0.5rem;
}

.reply_btn_wrap:last-child{
	border-bottom: 0.5px solid silver;
}

.reply_btn_wrap > div:nth-child(1),
.reply_btn_wrap > div:nth-child(2){
	display: inline-block;
	font-size: 0.5rem;

}

.r_btn{
	color: #97a4c3;
	font-size:1.3rem;
	background: white;
	border: none;
}

.r_btn:hover {
	text-decoration-line: underline;
	text-shadow: 0 0 3px #fff;
	color: #4294f7;
	cursor: pointer;
}	


</style>
<script type="text/javascript">
function goBoardUpdate(boardNum) {
	location.href = 'updateBoardForm.bo?boardNum='+boardNum;
}
function goBoardDelete(boardNum) {
	if(!confirm('삭제하시면 복구할 수 없습니다. \n 정말로 삭제하시겠습니까??')){
		return false;
	}
	location.href = 'boardDelete.bo?boardNum='+boardNum;
}
function goBoardList() {
	location.href = 'boardList.bo?';
}
function goreplyList() {
	location.href = 'replyList.re';
}
function goReplyDelete(replyNum, boardNum) {
	location.href = 'deleteReply.re?replyNum=' + replyNum + '&boardNum=' + boardNum;
}

function resize(textarea) {
	 textarea.style.height = "auto";
	 textarea.style.height = textarea.scrollHeight + "px";
}

</script>
</head>
<body>
<div>
	<div class="board_wrap">
		<div>
			<div class="board_title"><h2>${boardDetail.title }</h2></div>
			<div class="board_writer">${boardDetail.writer }</div>	
			<div class="create_wrap">
				<div class="board_createDate">${boardDetail.createDate }</div>
				<div id="board_content" class="board_readCnt">조회수 ${boardDetail.readCnt }</div>
			</div>	
		</div>
		<div class="content_wrap">
			<pre class="board_content">${boardDetail.content }</pre>
		</div>
	</div>
	<div class="reply_wrap">
	<div class="reply_title">
		댓글
	</div>
	<div>
		<c:choose>
			<c:when test="${empty replyList }">
				<div class="not_reply">댓글이 없습니다.</div>
				<div class="reg_reply">
				<c:choose>
						<c:when test="${!empty sessionScope.loginInfo }">
							<div class="reg_reply_writer">${sessionScope.loginInfo.memId }</div>
							<form action="regBoardReply.re?boardNum=${boardDetail.boardNum }" method="post">
							<textarea rows="1" name="content" oninput="resize(this)" required></textarea>
							<div class="reg_reply_btn"><input class="r_btn" type="submit" value="등록"></div>
							</form>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</div>
			</c:when>
			<c:otherwise>
			<div class="reply_info_wrap">
				<c:forEach items="${replyList }" var="reply">
				<div class="reply_writer">${reply.writer }</div>
				<div class="reply_content">${reply.content }</div>
				<div class="reply_createDate">${reply.createDate }</div>
				<div class="reply_btn_wrap">
					<c:choose>
						<c:when test="${(!empty sessionScope.loginInfo && sessionScope.loginInfo.memId eq reply.writer) || (!empty sessionScope.loginInfo && sessionScope.loginInfo.isAdmin eq 'Y') }">
							<div class="reply_update"><input class="r_btn" type="button" value="수정" onclick=""></div>
							<div class="reply_delete"><input class="r_btn" type="button" value="삭제" onclick="goReplyDelete(${reply.replyNum}, ${boardDetail.boardNum})"></div>
						</c:when>
						<c:otherwise>
						</c:otherwise>
					</c:choose>
				</div>
				</c:forEach>
				<c:choose>
					<c:when test="${!empty sessionScope.loginInfo }">
					<div class="reg_reply_box">
						<div class="reg_reply">
							<div class="reg_reply_writer">${sessionScope.loginInfo.memId }</div>
							<form action="regBoardReply.re?boardNum=${boardDetail.boardNum }" method="post">
							<textarea rows="1" name="content" oninput="resize(this)" required></textarea>
							<div class="reg_reply_btn"><input class="r_btn" type="submit" value="등록"></div>
							</form>
						</div>
					</div>
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
				</div>
			</c:otherwise>
		</c:choose>
	</div>
	</div>
	<div class="btn_wrap">
		<c:choose>
			<c:when test="${sessionScope.loginInfo.memId eq boardDetail.writer || sessionScope.loginInfo.isAdmin eq 'Y' }">
				<div class="login_view_button">
					<div>
						<input type="button" class="btn" value="수정" onclick="goBoardUpdate(${boardDetail.boardNum})">
					</div>
					<div>
						<input type="button" class="btn" value="삭제" onclick="goBoardDelete(${boardDetail.boardNum})">
					</div>
				</div>
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
		<div>
			<input type="button" class="btn" value="목록" onclick="goBoardList()">
		</div>
	</div>
</div>
</body>
</html>