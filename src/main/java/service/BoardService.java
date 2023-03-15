package service;

import java.util.List;

import dto.BoardDTO;
import dto.SearchDTO;

public interface BoardService {
	
	//게시글 목록 조회
	List<BoardDTO> selectBoardList(SearchDTO seachDTO);
	
	//게시글 등록
	int regBoard(BoardDTO boardDTO);
	
	//게시글 상세 조회
	BoardDTO selectBoardDetail(int boardNum);
	
	//게시글 상세 조회시 조회수 증가
	int increaseReadCnt(int boardNum);
	
	//게시글 삭제
	int deleteBorad(int boardNum);
	
	//게시글 수정
	int updateBoardDetail(BoardDTO boardDTO);
	
	//게시글 조회
	List<BoardDTO> searchBoardList(BoardDTO boardDTO);
}
