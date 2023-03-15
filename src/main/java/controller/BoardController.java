package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.lang.reflect.Member;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.apache.catalina.tribes.membership.MemberImpl;

import dto.BoardDTO;
import dto.MemberDTO;
import dto.PagingDTO;
import dto.ReplyDTO;
import dto.SearchDTO;
import service.BoardService;
import service.BoardServiceImpl;
import service.ReplyService;
import service.ReplyServiceImpl;


@WebServlet("*.bo")
public class BoardController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	//댓글 기능을 사용할 수 있게 객체 생성
	private ReplyService replyService = new ReplyServiceImpl();
	
	//BoardService를 사용할 수 있게 객체 생성
	private BoardService boardService = new BoardServiceImpl();
	
    public BoardController() {
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
		//기본적으로 webapp폴더에서 찾기떄문에 자세한 위치를 지정
		String page = "view/template/template.jsp";	
		boolean isRedirect = false;
		
		//내용부 페이지
		String contentPage = "";
		
		//게시판 목록으로 이동
		if(command.equals("/boardList.bo")) {
			//게시글 목록을 담을 객체 생성
			List<BoardDTO> boardList = null;
			
			//검색 버튼 클릭시 데이터가 전달 됨.
			String selectName = request.getParameter("selectName");
			String searchName = request.getParameter("searchName");
			
			//검색하는 조건과 검색내용을 저장할 객체를 만들고 객체에 저장
			SearchDTO searchDTO = new SearchDTO();
			searchDTO.setSelectName(selectName);
			searchDTO.setSearchName(searchName);
			
			//세션에서 boardReadCheck 속성값 삭제
			HttpSession session = request.getSession();

			Enumeration<String> sessionAttributes = session.getAttributeNames();
			while (sessionAttributes.hasMoreElements()) {
				String attributeName = sessionAttributes.nextElement();
				if (attributeName.startsWith("boardReadCheck")) {
					session.removeAttribute(attributeName);
				}
			}

			//게시글 목록을 저장
			boardList = boardService.selectBoardList(searchDTO);
			
			PagingDTO paging = new PagingDTO();
			
			paging.setTotalCount(boardList.size());
			
			//게시글 목록 전송
			request.setAttribute("boardList", boardList);
			request.setAttribute("paging", paging);
			
			contentPage = "board_list.jsp";
		}
		
		//게시글 등록 페이지로 이동
		if(command.equals("/boardWriteForm.bo")) {
			contentPage = "reg_board_form.jsp";
		}
			
		//게시글 등록
		if(command.equals("/regBoard.bo")) {
			//세션 데이터 사용을 위해 객체를 생성
			HttpSession session = request.getSession();
			
			//member객체를 생성하여 세션에 저장된 로그인 정보 저장
			MemberDTO member = (MemberDTO)session.getAttribute("loginInfo");
			
			//데이터 받기
			String title = request.getParameter("title");
			String memId = member.getMemId();
			String content = request.getParameter("content");
			
			//등록할 게시물의 내용을 담을 객체 생성
			BoardDTO boardDTO = new BoardDTO();
			
			//객체에 등록할 게시물내용들 저장
			boardDTO.setTitle(title);
			boardDTO.setWriter(memId);
			boardDTO.setContent(content);
			
			//게시물 등록 쿼리 실행
			boardService.regBoard(boardDTO);

			//페이지 이동
			isRedirect = true;
			page = "boardList.bo";
		}
		
		//상세 보기 페이지로 이동
		if(command.equals("/boardToDetail.bo")) {
			//세션 데이터 사용을 위해 객체를 생성
			HttpSession session = request.getSession();
			
			//데이터 받기
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			
			//세션에 글번호 저장
			session.setAttribute("boardNum", boardNum);
			
		    //상세 조회 할 때마다 조회수 증가
			//객체 생성
			String boardReadCheck = (String) session.getAttribute("boardReadCheck" + boardNum);

			if (boardReadCheck == null) { 
				
				//처음 접근하는 경우에만 조회수 증가
				boardService.increaseReadCnt(boardNum);

				//세션에 boardReadCheck 속성값을 true로 설정하여 중복 증가 방지
				session.setAttribute("boardReadCheck" + boardNum, "true");
			}
			
			//상세 조회 쿼리 실행
			BoardDTO boardDetail = boardService.selectBoardDetail(boardNum);
			
			//댓글 목록 조회 쿼리 실행
			List<ReplyDTO> replyList = replyService.selectReplyList(boardNum);
			
			//데이터 전달
			request.setAttribute("boardDetail", boardDetail);
			request.setAttribute("replyList", replyList);
			
			//페이지 이동
			contentPage = "board_detail.jsp";
			
		}
		
		//게시글 삭제
		if(command.equals("/boardDelete.bo")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			
			//게시글 삭제 쿼리실행
			boardService.deleteBorad(boardNum);
			
			//페이지 이동
			isRedirect = true;
			page = "boardList.bo";
		}
		
		//게시글 수정 페이지로 데이터가지고 이동
		if(command.equals("/updateBoardForm.bo")) {
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			
			//게시글 정보 조회 쿼리 실행
			BoardDTO boardDTO = boardService.selectBoardDetail(boardNum);
			
			//게시글 수정 페이지로 데이터 전달
			request.setAttribute("boardDetail", boardDTO);
			
			//페이지 이동
			contentPage = "board_update_form.jsp";
		}
		
		//게시글 수정
		if(command.equals("/updateBoard.bo")) {
			//데이터 받기
			int boardNum = Integer.parseInt(request.getParameter("boardNum"));
			String title = request.getParameter("title");
			String content = request.getParameter("content");
			
			//위에 받아온 데이터를 저장할 객체 boardDTO생성
			BoardDTO boardDTO = new BoardDTO();
			
			//생성한 객체 boardDTO에 받아온값들 저장
			boardDTO.setBoardNum(boardNum);
			boardDTO.setTitle(title);
			boardDTO.setContent(content);
			
			//게시글 수정 쿼리 실행
			boardService.updateBoardDetail(boardDTO);
			
			//수정한 글번호 데이터 전달
			request.setAttribute("boardNum", boardNum);
			
			//상세 조회 페이지로 이동
			isRedirect = true;
			page = "boardToDetail.bo?boardNum=" + boardNum;
		}
		
		//페이징 기능
		if(command.equals("/pagingBoardList.bo")) {
			//게시글 목록을 담을 객체 생성
			List<BoardDTO> boardList = null;
			
			PagingDTO paging = new PagingDTO();
			
			
			
			System.out.println(paging.getEndPage());
			System.out.println(paging.getDisplayRow());
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



