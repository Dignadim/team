package project.ajax;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import project.item.ItemDAO;
import project.item.ItemVO;
import project.mybatis.MySession;


@WebServlet("/AjaxPriceClick")
public class AjaxPriceClick extends HttpServlet {
	private static final long serialVersionUID = 1L;
 
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("AjaxPriceClick 서블릿이 get 방식으로 요청됨");
		actionDo(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("AjaxPriceClick 서블릿이 post 방식으로 요청됨");
		actionDo(request, response);
	}

	protected void actionDo(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("AjaxPriceClick 서블릿의 actionDo() 메소드 실행");
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String itemPrice = request.getParameter("itemPrice");
		
		response.getWriter().write(getJSON(itemPrice));
	}
	

	private String getJSON(String itemPrice) {
		if (itemPrice == null || itemPrice.equals("전체")) {
			itemPrice = "99999999";
		} else if (itemPrice.equals("~1,000원")) {
			itemPrice = "1000";
		} else if (itemPrice.equals("~5,000원")) {
			itemPrice = "5000";
		} else if (itemPrice.equals("~10,000원")) {
			itemPrice = "10000";
		} else if (itemPrice.equals("~50,000원")) {
			itemPrice = "50000";
		}
		
		SqlSession mapper = MySession.getSession();
		ItemDAO dao = ItemDAO.getInstance();
		  
		// 테이블에서 입력한 문자열이 itemPrice 필드에 포함된 데이터를 얻어온다.
		ArrayList<ItemVO> list = dao.itemPriceSearch(mapper, Integer.parseInt(itemPrice));
		mapper.close();
		
		// 테이블에서 검색해서 얻어온 데이터를 json 형식의 문자열로 만든다.
		StringBuffer result = new StringBuffer(); 
		result.append("{\"result\": ["); // json 시작
		// 데이터의 개수만큼 반복하며 json 형태의 문자열을 만든다.
		for (ItemVO vo : list) {
			result.append("[{\"value\": \"" + vo.getIdx() + "\"},");
			result.append("{\"value\": \"" + vo.getSellCVS().trim() + "\"},");
			result.append("{\"value\": \"" + vo.getCategory().trim() + "\"},");
			result.append("{\"value\": \"" + vo.getItemName().trim() + "\"},");
			result.append("{\"value\": \"" + vo.getItemPrice() + "\"},");
			result.append("{\"value\": \"" + vo.getEventType().trim() + "\"}],");
		}
		result.append("]}");
		return result.toString(); 
	}
	
}