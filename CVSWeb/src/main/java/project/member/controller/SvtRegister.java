package project.member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import project.member.MemberService;
import project.member.MemberVO; 

//@WebServlet("/SvtRegister")
public class SvtRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private MemberService service = MemberService.getInstance();
	private MemberVO vo = null;
       
    public SvtRegister() { super();}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException 
	{
		actionDo(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException
	{
		actionDo(request, response);
	}

	protected void actionDo(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException 
	{
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		//	System.out.println("서블릿안으로 들어는 왔음");
		
		//	어떤일을 할지 넘겨받는다.
		String kind = request.getParameter("SvtKind");
		int result;
		String userID;
		String userPSS;
		String userNick;
		String userEmail;
		
		switch(kind)
		{
		//	아이디 체크를 해달라고 정보를 넘겨온 케이스다.
			case "idChk":
				userID = request.getParameter("userID");
				
				vo = service.searchID(userID);
				
				//	vo가 null이 아니란건 넘겨받은 userID가 DB안에 있었다는 뜻
				//	중복된 아이디가 존재한다는 뜻이다.
				if(vo != null )
				{
					result = 0;
				}
				else
				{
					result = 1;
				}
				
				//	해당 아이디가 존재하는 경우
				if(result == 0)
				{
					response.getWriter().write("0");
					return;
				}	//	해당 아이디가 존재하지 않는경우
				else if(result == 1)
				{
					response.getWriter().write("1");
				}
				
			break;
		//	회원가입을 위해 넘어온 체크이다.
			case "regiChk":
				
				userID = request.getParameter("userID");
				vo = service.searchID(userID);
				
				//	vo가 null이 아니란건 넘겨받은 usertID가 DB안에 있었다는 뜻
				//	중복된 아이디가 존재한다는 뜻이다.
				if(vo != null )
				{
					result = 0;
				}
				else
				{
					result = 1;
				}
				
				//	해당 아이디가 존재하는 경우
				if(result == 0)
				{
					response.getWriter().write("0");
					return;
				}
				
				//	중복된 아이디가 존재하지 않으면 나머지 값도 받아서 넣어줌
				userPSS = request.getParameter("userPSS");
				userNick = request.getParameter("userNick");
				userEmail = request.getParameter("userEmail");
				//System.out.println(userPSS);
				vo = new MemberVO(userID, userPSS, userNick, userEmail);
				//System.out.println(vo);
				service.insert(vo);
				//	회원가입까지 성공
				response.getWriter().write("1");
				
			break;
			
			
		
		}
		

		
	}
	
	
}
