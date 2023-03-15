package controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.Writer;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.naming.spi.DirStateFactory.Result;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.catalina.tribes.membership.MemberImpl;

import dto.MemberDTO;
import service.MemberService;
import service.MemberServiceImpl;


@WebServlet("*.me")
public class MemberController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	//멤버 서비스를 사용할 수 있게 만드는 객체 생성
	//자료형을 인터페이스로 만들도록 한다.
	private MemberService memberService = new MemberServiceImpl();
	
    public MemberController() {
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
		
		//로그인 페이지로 이동
		if(command.equals("/loginPage.me")) {
			contentPage = "login.jsp";
		}
		
		//회원 가입 페이지로 이동
		if(command.equals("/join.me")) {
			contentPage = "join.jsp";
		}
		
		//회원 등록 후 로그인 페이지로이동
		if(command.equals("/joinMember.me")) {
			String memId = request.getParameter("memId");
			String memPw = request.getParameter("memPw");
			String memName = request.getParameter("memName");
			String memTell = request.getParameter("memTell");
			String memEmail = request.getParameter("memEmail");
			String gender = request.getParameter("gender");
			String isAdmin = request.getParameter("isAdmin");
			
			MemberDTO memberDTO = new MemberDTO();
			
			memberDTO.setMemId(memId);
			memberDTO.setMemPw(memPw);
			memberDTO.setMemName(memName);
			memberDTO.setMemTell(memTell);
			memberDTO.setMemEmail(memEmail);
			memberDTO.setGender(gender);
			memberDTO.setIsAdmin(isAdmin);
			
			memberService.joinMember(memberDTO);
			
			//회원가입 후 로그인 페이지로 이동
			isRedirect = true;
			page = "loginPage.me";
		}
		
		//아이디 중복 체크
		if(command.equals("/idCheck.me")) {
			String memId = request.getParameter("memId");
			
			boolean idCheck = memberService.idCheck(memId);
			
			request.setAttribute("memId", memId);
			request.setAttribute("idCheck" , idCheck);
			page = "view/content/id_check_result.jsp";
			
		}
		
		
		//로그인 기능
		if(command.equals("/login.me")) {
			String memId = request.getParameter("memId");
			String memPw = request.getParameter("memPw");
			
			MemberDTO memberDTO = new MemberDTO();
			memberDTO.setMemId(memId);
			memberDTO.setMemPw(memPw);
			
			//로그인 쿼리 실행 메소드
			MemberDTO result = memberService.login(memberDTO);
			
			//로그인이 성공했다면 세션에 로그인한 사람의 정보를 저장
			if(result != null) {
				//1. 세션 객체를 생성
				HttpSession session = request.getSession();
				//2. 세션에 데이터 저장
				//세션에 저장을 했기때문에 데이터를 보낼 필요가 없다.
				session.setAttribute("loginInfo", result);
			}
			
			//페이지 결정
			contentPage = "login_result.jsp";
			
		}
		
		//로그아웃 기능
		if(command.equals("/logout.me")) {
			//1. 로그아웃을 하기 위해 세션 객체를 생성
			HttpSession session = request.getSession();
			
			//세션에 저장된 데이터 삭제
			session.removeAttribute("loginInfo");
			
			//세션에 저장된 데이터 삭제후 로그인 페이지로 이동
			isRedirect = true;
			page = "boardList.bo";
			
		}
		
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

