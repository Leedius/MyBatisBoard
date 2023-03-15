package service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.BoardDTO;
import dto.SearchDTO;
import sqlmap.SqlSessionManager;

public class BoardServiceImpl implements BoardService {
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	//sqlSession 객체로 모든 디비 작업실행.
	SqlSession sqlSession = sqlSessionFactory.openSession();

	//게시글 리스트 조회
	@Override
	public List<BoardDTO> selectBoardList(SearchDTO searchDTO) {
		List<BoardDTO> boadList = sqlSession.selectList("boardMapper.selectBoardList", searchDTO);
		sqlSession.commit();
		return boadList;
	}

	//게시글 등록
	@Override
	public int regBoard(BoardDTO boardDTO) {
		int result = sqlSession.insert("boardMapper.regBoard", boardDTO);
		sqlSession.commit();
		return result;
	}

	//게시글 상세 조회
	@Override
	public BoardDTO selectBoardDetail(int boardNum) {
		BoardDTO boardDetail = sqlSession.selectOne("boardMapper.selectBoardDetail", boardNum);
		sqlSession.commit();
		return boardDetail;
	}

	//게시글 조회 증가
	@Override
	public int increaseReadCnt(int boardNum) {
		int increaseReadCnt = sqlSession.update("boardMapper.increaseReadCnt", boardNum);
		sqlSession.commit();
		return increaseReadCnt;
	}

	//게시글 삭제(여러쿼리를 실행할 수 있음)
	//try문에 1개라도 오류가 나오는 순간 catch문 실행해서 rollback
	@Override
	public int deleteBorad(int boardNum) {
		int deleteBoard = 0;
		try {
			sqlSession.delete("replyMapper.deleteBoardReply", boardNum);
			deleteBoard = sqlSession.delete("boardMapper.deleteBoard", boardNum);
			sqlSession.commit();
		}catch (Exception e) {
			sqlSession.rollback();
			e.printStackTrace();
		}
		return deleteBoard;
	}

	//게시글 수정
	@Override
	public int updateBoardDetail(BoardDTO boardDTO) {
		int updateBoard = sqlSession.update("boardMapper.updateBoardDetail", boardDTO);
		sqlSession.commit();
		return updateBoard;
	}

	//게시글 검색
	@Override
	public List<BoardDTO> searchBoardList(BoardDTO boardDTO) {
		List<BoardDTO> searchBoardList = sqlSession.selectList("boardMapper.searchBoard", boardDTO);
		sqlSession.commit();
		return searchBoardList;
	}
}
