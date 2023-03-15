package session_test;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import dto.BoardDTO;
import dto.MemberDTO;

@WebServlet("/session01")
public class SessionServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    public SessionServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setAttribute("name1", "java");
		
		//데이터를 세션에 저장
		//1. 세션 객체를 생성
		HttpSession session = request.getSession();
		
		//세션에 저장된 데이터의 유효시간 설정(단위는 초이다)
		session.setMaxInactiveInterval(60 * 60 * 24);
		
		//2. 세션에 데이터 저장
		session.setAttribute("name2", "python");
		session.setAttribute("age", 20);
		session.setAttribute("member", new MemberDTO());
		session.setAttribute("board", new BoardDTO());
		
		//3. 세션에 저장된 데이터를 읽어오는 방법
		//session.getAttribute의 자료형은 Object라서 MemberDTO 자료형으로 못받는다.
		//MemberDTO m = session.getAttribute("member");
		//따라서 아래와 같이 형변환을 한다.
		MemberDTO m = (MemberDTO)session.getAttribute("member");
		BoardDTO b = (BoardDTO)session.getAttribute("board");
		
		//4. 세션에 저장된 데이터를 삭제하는 방법
		session.removeAttribute("name2");	//세션에 "name2"로 저장된 데이터 삭제
		session.invalidate();				//세션에 저장된 모든 데이터 삭제
		
		//jsp 파일을 찾는 기준 위치는 webapp폴더!
		RequestDispatcher dispatcher = request.getRequestDispatcher("view/test/session1.jsp");
		dispatcher.forward(request, response);	
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
