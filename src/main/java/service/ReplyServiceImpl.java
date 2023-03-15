package service;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;

import dto.ReplyDTO;
import sqlmap.SqlSessionManager;

public class ReplyServiceImpl implements ReplyService{
	SqlSessionFactory sqlSessionFactory = SqlSessionManager.getSqlSession();
	
	//sqlSession 객체로 모든 디비 작업실행.
	SqlSession sqlSession = sqlSessionFactory.openSession();

	@Override
	public List<ReplyDTO> selectReplyList(int boardNum) {
		List<ReplyDTO> replyList = sqlSession.selectList("replyMapper.replyList", boardNum);
		sqlSession.commit();
		return replyList;
	}

	@Override
	public int regBoardReply(ReplyDTO replyDTO) {
		int regBoardReply = sqlSession.insert("replyMapper.regBoardReply", replyDTO);
		sqlSession.commit();
		return regBoardReply;
	}

	@Override
	public int deleteBoardReply(int boardNum) {
		int deleteBoardReply = sqlSession.delete("replyMapper.deleteBoardReply", boardNum);
		sqlSession.commit();
		return deleteBoardReply;
	}

	@Override
	public int deleteReply(int replyNum) {
		int deleteReply = sqlSession.delete("replyMapper.deleteReply", replyNum);
		sqlSession.commit();
		return deleteReply;
	}
}
