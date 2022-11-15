package project.board.free;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FreeInsertEmptyCheck")
public class FreeInsertEmptyCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public FreeInsertEmptyCheck() {
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// System.out.println("UserRegister 서블릿의 doGet() 메소드 실행");
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// System.out.println("UserRegister 서블릿의 doPost() 메소드 실행");
		actionDo(request, response);
	}
	
	protected void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String fb_subject = request.getParameter("fb_subject").trim();
		String fb_content = request.getParameter("fb_content").trim();
		
		if(fb_subject == null || fb_subject.equals("")) {
			response.getWriter().write("1");
			return;
		}
		
		if(fb_content == null || fb_content.equals("")) {
			response.getWriter().write("2");
			return;
		}
		if(fb_subject != null || !fb_subject.equals("") || fb_content != null || !fb_content.equals("")) {
			response.getWriter().write("3");
			return;
		}
		
	}

}
