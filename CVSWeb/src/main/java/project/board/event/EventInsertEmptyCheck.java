package project.board.event;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/EventInsertEmptyCheck")
public class EventInsertEmptyCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public EventInsertEmptyCheck() {
		super();
	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		actionDo(request, response);
	}
	
	protected void actionDo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		String ev_sellcvs = request.getParameter("ev_sellcvs").trim();
		String ev_subject = request.getParameter("ev_subject").trim();
		String ev_content = request.getParameter("ev_content").trim();
		
		if(ev_sellcvs.equals("-머리말선택-")) {
			response.getWriter().write("1");
			return;
		}
		
		if(ev_subject == null || ev_subject.equals("")) {
			response.getWriter().write("2");
			return;
		}
		
		if(ev_content == null || ev_content.equals("")) {
			response.getWriter().write("3");
			return;
		}
		if(ev_subject != null || !ev_subject.equals("") || ev_content != null || !ev_content.equals("")
				|| !ev_sellcvs.equals("-머리말선택-")) {
			response.getWriter().write("4");
			return;
		}
		
		

	}
}
