package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.membership.MemberImpl;

import dto.MemberDTO;
import dto.ReplyDTO;
import service.ReplyService;
import service.ReplyServiceImpl;


@WebServlet("*.re")
public class ReplyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private ReplyService replyService = new ReplyServiceImpl();
	
    public ReplyController() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doProcess(request, response);
	}
	
	public void doProcess(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//한글 인코딩
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		
		//어떤 페이지에서 요청이 왓는지 확인
		String requestURI = request.getRequestURI();
		String contextPath = request.getContextPath();
		String command = requestURI.substring(contextPath.length());
		System.out.println(command);
		
		
		//응답 페이지
		String page = "view/template/template.jsp";
		boolean isRedirect = false;
		
		//내용부 페이지
		String contentPage = "";
		
		//댓글 목록 조회
		if(command.equals("/replyList.re")) {
			List<ReplyDTO> replyList = null;
			
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			
			replyList = replyService.selectReplyList(boardNum);
			
			//댓글 목록 전송
			request.setAttribute("replyList", replyList);
		}
		
		//댓글 등록
		if(command.equals("/regBoardReply.re")) {
			//세션 데이터 사용을 위해 객체를 생성
			HttpSession session = request.getSession();
			
			//세션 로그인 정보 받기
			MemberDTO member = (MemberDTO)session.getAttribute("loginInfo");
			
			//댓글을 저장할 객체 생성
			ReplyDTO replyDTO = new ReplyDTO();
			
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String content = request.getParameter("content");
			String memId = member.getMemId();

			replyDTO.setWriter(memId);
			replyDTO.setContent(content);
			replyDTO.setBoardNum(boardNum);
		
			replyService.regBoardReply(replyDTO);
			
			request.setAttribute("boardNum", boardNum);
			
			isRedirect = true;
			page = "boardToDetail.bo?boardNum=" + boardNum;
		}
		
		//게시글 특정 댓글 삭제
		if(command.equals("/deleteReply.re")) {
			//데이터 받기
			int replyNum = Integer.parseInt(request.getParameter("replyNum"));
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			
			System.out.println(replyNum);
			System.out.println(boardNum);
			//특정 댓글 삭제 쿼리 실행
			replyService.deleteReply(replyNum);
			
			isRedirect = true;
			page = "boardToDetail.bo?boardNum=" + boardNum;
		}
		
		
		//template.jsp로 이동하면서 핵심적으로 보여질 페이지 정보를 전달
		request.setAttribute("contentPage", contentPage);
		
		//페이지 이동
		if(isRedirect) {
			response.sendRedirect(page);
		}
		
		else if(!isRedirect){
			RequestDispatcher dispatcher = request.getRequestDispatcher(page);
			dispatcher.forward(request, response);	
		}
	}
}



