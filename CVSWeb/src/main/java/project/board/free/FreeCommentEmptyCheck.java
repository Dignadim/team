package project.board.free;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/FreeCommentEmptyCheck")
public class FreeCommentEmptyCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public FreeCommentEmptyCheck() {
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
		String fbc_content = request.getParameter("fbc_content").trim();
		
		if(fbc_content == null || fbc_content.equals("")) {
			response.getWriter().write("1");
			return;
		} else {
			response.getWriter().write("2");
			return;
		}
	}
}
