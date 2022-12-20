package com.project.CVSWeb;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.binding.BindingException;
import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.dao.ItemDAO;
import com.project.item.ItemAvgVO;
import com.project.item.ItemCommentList;
import com.project.item.ItemCommentVO;
import com.project.item.ItemList;
import com.project.item.ItemVO;

@Controller
@RequestMapping("/item")
public class ItemController {
	
	private static final Logger logger = LoggerFactory.getLogger(ItemController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/insert")
	public String insert(HttpServletRequest request, Model model) {
		logger.info("ItemController의 insert()");
		return "item/itemInsert";
	}
	
	@RequestMapping("/itemImageInsert")
	public String itemImageInsert(HttpServletRequest request, Model model) {
		logger.info("ItemController의 itemImageInsert()");
		return "item/itemImageInsert";
	}
	
	@RequestMapping("/itemImageInsertOK")
	public String itemImageInsertOK(HttpServletRequest request, Model model) {
		logger.info("ItemController의 itemImageInsertOK()");
		return "item/itemImageInsertOK";
	}
	
	@RequestMapping("/insertOK")
	public String insertOK(HttpServletRequest request, RedirectAttributes rttr, ItemVO itemVO) {
		logger.info("ItemController의 insertOK()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		mapper.itemInsert(itemVO);
		
		rttr.addFlashAttribute("msg", "상품등록이 완료되었습니다.");
		
		return "redirect:list";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model) {
		logger.info("ItemController의 list()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		// 이전 페이지에서 넘어오는 화면에 표시할 페이지 번호, sort 이전의 상태를 위해 mode를 받는다.
		int currentPage = 1;
		int mode = 0;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
			mode = Integer.parseInt(request.getParameter("mode"));
		} catch (NumberFormatException e) { }
		int pageSize = 12;
		int totalCount = mapper.selectItemCount();
		
		logger.info("mode: "+mode);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList itemList = ctx.getBean("itemList", ItemList.class);
		itemList.initItemList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", itemList.getStartNo());
		hmap.put("endNo", itemList.getEndNo());		
		
		// 모든 상품 목록을 얻어온다.
		// ArrayList<ItemVO> items = service.selectItems();
		// 1페이지 분량의 상품을 얻어온다.
		itemList.setList(mapper.selectItemList(hmap));
		
		model.addAttribute("mode", mode);
		model.addAttribute("itemList", itemList);
		model.addAttribute("currentPage", currentPage);
		
		return "item/itemListView";
	}
	
	@RequestMapping("/increment")
	public String increment(HttpServletRequest request, Model model) {
		logger.info("ItemController의 increment()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		mapper.itemIncrement(idx);
		
		model.addAttribute("idx", idx);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		
		return "redirect:itemView";
	}
	
	@RequestMapping("/itemView")
	public String itemView(HttpServletRequest request, Model model, ItemVO itemVO) {
		logger.info("ItemController의 itemView()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		itemVO = mapper.itemSelectByIdx(idx);
		
		double avg = 0;
		try {
			avg = mapper.getRealAvg(idx);
		} catch (BindingException e) { }
		itemVO.setAverscore(avg);			
		
//		글의 댓글 목록을 읽어온다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemCommentList itemCommentList = ctx.getBean("itemCommentList", ItemCommentList.class);
		itemCommentList.setList(mapper.selectItemCommentList(idx));
		
		model.addAttribute("vo", itemVO);
		model.addAttribute("itemCommentList", itemCommentList);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("enter", "\r\n");
		
		return "item/itemView";
	}
	
	@RequestMapping("/updateAverscoreOK")
	public String updateAverscoreOK(HttpServletRequest request, RedirectAttributes rttr, ItemAvgVO itemAvgVO) {
		logger.info("ItemController의 updateAverscoreOK()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String avgID = mapper.selectAvgID(itemAvgVO);
		
		logger.info("avgID: "+avgID);
		
		
		if (avgID != null) {
			rttr.addFlashAttribute("msg", "평점을 이미 등록했습니다.");
		} else {
			if (itemAvgVO.getUpdateScore() > 5 || itemAvgVO.getUpdateScore() < 0) {	
				rttr.addFlashAttribute("msg", "0 ~ 5 사이의 값을 입력하세요.");
			} else {
//				새 평점을 itemavg 테이블에 넣는다.
				mapper.insertUpdateScore(itemAvgVO);
				
//				idx가 일치하는 평점들의 새 평균을 가져온다.
				double newAvg = mapper.selectNewAvg(itemAvgVO.getItemIdx());
				itemAvgVO.setNewAvg(newAvg);
				
//				새 평점을 item 테이블의 averscore 칼럼에 입력한다.
				mapper.UpdateScore(itemAvgVO);

				rttr.addFlashAttribute("msg", "평점을 등록했습니다.");
			}	
		}		
		
		rttr.addAttribute("currentPage", currentPage);
		rttr.addAttribute("idx", itemAvgVO.getItemIdx());
		
		return "redirect:itemView";
	}
	
	@RequestMapping("/itemUpdate")
	public String itemUpdate(HttpServletRequest request, Model model, ItemVO itemVO) {
		logger.info("ItemController의 itemUpdate()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));

		itemVO = mapper.itemSelectByIdx(idx);
		
		model.addAttribute("vo", itemVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("enter", "\r\n");
		
		return "item/itemUpdate";
	}
	
	@RequestMapping("/itemUpdateOK")
	public String itemUpdateOK(HttpServletRequest request, RedirectAttributes rttr, ItemVO itemVO) {
		logger.info("ItemController의 itemUpdateOK()");

		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		try {
			mapper.itemUpdate(itemVO);
			rttr.addFlashAttribute("msg", idx+"번 글을 수정했습니다.");
		} catch (Exception e) {
			
		}
		
		rttr.addAttribute("currentPage", currentPage);
		rttr.addAttribute("idx", idx);
		
		return "redirect:itemView";
	}
	
	@RequestMapping("/itemDelete")
	public String itemDelete(HttpServletRequest request, Model model, ItemVO itemVO) {
		logger.info("ItemController의 itemDelete()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));

		itemVO = mapper.itemSelectByIdx(idx);
		
		model.addAttribute("vo", itemVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		
		return "item/itemDelete";
	}
	
	@RequestMapping("/itemDeleteOK")
	public String itemDeleteOK(HttpServletRequest request, RedirectAttributes rttr, ItemVO itemVO) {
		logger.info("ItemController의 itemDelete()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		mapper.itemDelete(itemVO.getIdx());
		rttr.addFlashAttribute("msg", idx+"번 글을 삭제했습니다.");
		
		rttr.addAttribute("currentPage", request.getParameter("currentPage"));
		
		return "redirect:list";
	}
	
	@RequestMapping("/commentEmptyCheck")
	@ResponseBody
	public String commentEmptyCheck(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("ItemController의 commentEmptyChk()");
		
		String content = request.getParameter("content").trim();
		
		if(content == null || content.equals("")) {
			response.getWriter().write("1");
			return null;
		} else {
			response.getWriter().write("2");
		}
		
		return null;
	}
	
	@RequestMapping("/itemCommentOK")
	public String itemCommentOK(HttpServletRequest request, RedirectAttributes rttr, ItemCommentVO itemCommentVO) {
		logger.info("ItemController의 itemCommentOK()");
		logger.info(itemCommentVO+"");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int mode = Integer.parseInt(request.getParameter("mode"));
		
		String url = "itemView?currentPage="+currentPage+"&idx="+itemIdx;
		
		if (mode == 1) {
			mapper.insertItemComment(itemCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 저장에 성공했습니다.");
		} else if (mode == 2) {
			mapper.updateItemComment(itemCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 수정에 성공했습니다.");
		} else {
			mapper.deleteItemComment(itemCommentVO.getIdx());
			rttr.addFlashAttribute("msg", "댓글이 삭제에 성공했습니다.");
		}
		
		rttr.addAttribute("currentPage", currentPage);
		rttr.addAttribute("idx", itemIdx);
		
		return "redirect:itemView";
	}
	
	@RequestMapping("/AjaxCategoryClick")
	@ResponseBody
	public String AjaxCategoryClick(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("ItemController의 AjaxCategoryClick()");
		
		String passJSON = request.getParameter("category");
		logger.info(passJSON);
		
		response.getWriter().write(getJSON(passJSON));
		
		return null;
	}
	
	@RequestMapping("/AjaxCVSClick")
	@ResponseBody
	public String AjaxCVSClick(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("ItemController의 AjaxCVSClick()");
		
		String passJSON = request.getParameter("SellCVS");
		logger.info(passJSON);
		
		response.getWriter().write(getJSON(passJSON));
		
		return null;
	}

	@RequestMapping("/AjaxEventClick")
	@ResponseBody
	public String AjaxEventClick(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("ItemController의 AjaxEventClick()");
		
		String passJSON = request.getParameter("eventType");
		logger.info(passJSON);
		
		response.getWriter().write(getJSON(passJSON));
		
		return null;
	}
	
	@RequestMapping("/AjaxPriceClick")
	@ResponseBody
	public String AjaxPriceClick(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("ItemController의 AjaxPriceClick()");
		
		String passJSON = request.getParameter("itemPrice");
		logger.info(passJSON);
		
		if (passJSON == null || passJSON.equals("전체")) {
			passJSON = "99999999";
		} else if (passJSON.equals("~1,000원")) {
			passJSON = "1000";
		} else if (passJSON.equals("~5,000원")) {
			passJSON = "5000";
		} else if (passJSON.equals("~10,000원")) {
			passJSON = "10000";
		} else if (passJSON.equals("~50,000원")) {
			passJSON = "50000";
		}
		
		response.getWriter().write(getJSON(passJSON));
		
		return null;
	}
	
	@RequestMapping("/AjaxSearch")
	@ResponseBody
	public String AjaxSearch(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("ItemController의 AjaxSearch()");
		
		String passJSON = request.getParameter("itemName");
		logger.info(passJSON);
		
		response.getWriter().write(getJSON(passJSON));
		
		return null;
	}
	
	private String getJSON(String passJSON) {
		logger.info("getJSON()");
		logger.info(passJSON);
		if (passJSON == null || passJSON.equals("전체")) {
			passJSON = "";
		}
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		ArrayList<ItemVO> list = null;
		
		if(passJSON.equals("CU") || passJSON.equals("GS25") || passJSON.equals("세븐일레븐") 
				|| passJSON.equals("ministop") || passJSON.equals("이마트24") || passJSON.equals("기타 편의점")) {
//			테이블에서 입력한 문자열이 SellCVS 필드에 포함된 데이터를 얻어온다.
			list = mapper.SellCVSSearch(passJSON);
		} else if(passJSON.equals("간편식품") || passJSON.equals("가공식품") || passJSON.equals("즉석조리") || passJSON.equals("신선식품") || passJSON.equals("과자/빵") 
				|| passJSON.equals("아이스크림") || passJSON.equals("음료") || passJSON.equals("잡화") || passJSON.equals("기호식품") || passJSON.equals("기타상품")) {
//			테이블에서 입력한 문자열이 category 필드에 포함된 데이터를 얻어온다.
			list = mapper.categorySearch(passJSON);
		} else if(passJSON.equals("1+1") || passJSON.equals("2+1") || passJSON.equals("카드사 할인") || passJSON.equals("포인트 적립")) {
//			테이블에서 입력한 문자열이 eventType 필드에 포함된 데이터를 얻어온다.
			list = mapper.eventTypeSearch(passJSON);
		} else if (passJSON.equals("99999999") || passJSON.equals("1000") || passJSON.equals("5000") || passJSON.equals("10000") || passJSON.equals("50000")) {
//			테이블에서 입력한 문자열이 itemPrice 필드에 포함된 데이터를 얻어온다.
			list = mapper.itemPriceSearch(Integer.parseInt(passJSON));
		} else {
			list = mapper.search(passJSON);
		}
		
//		테이블에서 검색해서 얻어온 데이터를 json 형식의 문자열로 만든다.
		StringBuffer result = new StringBuffer(); 
		result.append("{\"result\": ["); // json 시작
//		데이터의 개수만큼 반복하며 json 형태의 문자열을 만든다.
		
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
	
	@RequestMapping("/itemListSort")
	public String itemListSort(HttpServletRequest request, Model model, HttpServletResponse response, ItemVO itemVO) {
		logger.info("ItemController의 itemListSort()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int currentPage = 1;
		int mode = 1;
		try {
			// 이전 페이지에서 넘어오는 화면에 표시할 페이지 번호를 받는다.
			currentPage = Integer.parseInt(request.getParameter("currentPage"));		
			// 실행할 번호(mode)를 받는다.
			mode = Integer.parseInt(request.getParameter("mode"));
		} catch (NumberFormatException e) {	}
		
		// 모든 상품 목록을 얻어온다.
		ArrayList<ItemVO> items = mapper.selectItems();
		// 1페이지 분량의, mode대로 정렬된 상품을 얻어온다.
		int pageSize = 12;
		int totalCount = mapper.selectItemCount();
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList itemList = ctx.getBean("itemList", ItemList.class);
		itemList.initItemList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", itemList.getStartNo());
		hmap.put("endNo", itemList.getEndNo());	
		
		if (mode == 1) {
			itemList.setList(mapper.selectItemList(hmap));
		} else if (mode == 2) {
			itemList.setList(mapper.selectItemListReverse(hmap));			
		} else if (mode == 3) {
			itemList.setList(mapper.selectItemListHigher(hmap));			
		} else if (mode == 4){
			itemList.setList(mapper.selectItemListLower(hmap));						
		} else if (mode == 5){
			itemList.setList(mapper.selectItemListBetter(hmap));						
		} else {
			itemList.setList(mapper.selectItemListWorse(hmap));						
		}
		
		// 상품의 목록을 request 영역에 저장해서 메인 글을 화면에 표시하는 페이지(itemListView.jsp)로 넘겨준다.
		model.addAttribute("mode", mode);
		model.addAttribute("items", items);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("itemList", itemList);
		
		return "item/itemListView";
	}

}





