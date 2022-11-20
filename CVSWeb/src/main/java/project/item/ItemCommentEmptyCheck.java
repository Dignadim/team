package project.item;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ItemCommentEmptyCheck")
public class ItemCommentEmptyCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	public ItemCommentEmptyCheck() {
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
		String content = request.getParameter("content").trim();
		
		if(content == null || content.equals("")) {
			response.getWriter().write("1");
			return;
		} else {
			response.getWriter().write("2");
			return;
		}
	}
}
