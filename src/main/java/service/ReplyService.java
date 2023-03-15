package service;

import java.util.List;

import dto.ReplyDTO;

public interface ReplyService {

	//게시글 댓글 목록 조회
	List<ReplyDTO> selectReplyList(int boardNum);
	
	//게시글 댓글 등록
	int regBoardReply(ReplyDTO replyDTO);
	
	//해당 게시글 댓글 전체 삭제
	int deleteBoardReply(int boardNum);
	
	//해당 게시글 특정 댓글 삭제
	int deleteReply(int replyNum);
}
