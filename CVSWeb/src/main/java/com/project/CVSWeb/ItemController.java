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
import com.project.item.ItemAvgList;
import com.project.item.ItemAvgVO;
import com.project.item.ItemCommentList;
import com.project.item.ItemCommentVO;
import com.project.item.ItemList;
import com.project.item.ItemManager;
import com.project.item.ItemParam;
import com.project.item.ItemVO;
import com.project.item.MyItemList;
import com.project.item.MyItemVO;
import com.project.item.SearchKeywordList;
import com.project.map.MapManager;

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
		String hashTag = itemVO.getHashTag();
		String[] hashTagArr = hashTag.split(" ");
		
		String addedTag = "";
		for (String s : hashTagArr) {
			addedTag += '#' + s + ' ';
		}
		
		itemVO.setHashTag(addedTag);		
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
		
		// 인기 검색어 TOP 5를 얻어온다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		SearchKeywordList searchList = ctx.getBean("searchList", SearchKeywordList.class);
		searchList.setList(mapper.selectHotKeyword());

		int pageSize = 12;
		int totalCount = mapper.selectItemCount();
		
		logger.info("mode: "+mode);
		
		ItemList itemList = ctx.getBean("itemList", ItemList.class);
		itemList.initItemList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", itemList.getStartNo());
		hmap.put("endNo", itemList.getEndNo());		
		
		itemList.setList(mapper.selectItemList(hmap));
		
		model.addAttribute("mode", mode);
		model.addAttribute("itemList", itemList);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("searchList", searchList);
		
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
		model.addAttribute("job", "itemView");
		return "redirect:itemView";
	}
	
	@RequestMapping("/itemView")
	public String itemView(HttpServletRequest request, Model model, ItemVO itemVO) {
		logger.info("ItemController의 itemView()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		String hashTag = request.getParameter("hashTag");
		String job = request.getParameter("job");		
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		itemVO = mapper.itemSelectByIdx(idx);
		
		if (hashTag != null) {
			ItemList itemList = ctx.getBean("itemList", ItemList.class);
			itemList.setList(mapper.hashTagSearch(hashTag));
			
			model.addAttribute("itemList", itemList);
		}		
		
		try {
			String[] hasharr = itemVO.getHashTag().split(" ");
			String newArr = "";
			for (String h : hasharr) {
				newArr += "<a class='hashTag' href='" + "hashTagSearch?idx=" + idx + "&currentPage=" + request.getParameter("currentPage") + "&hashTag=" + h.substring(1) + "'>" + h + "</a> ";
			}
			itemVO.setHashTag(newArr);					
		} catch (Exception e) {
			
		}

		// itemview 페이징 작업을 위해 idx의 최댓값을 얻어온다. 
		int maxidx = mapper.getMaxIdx();		
		
		double avg = 0;
		try {
			avg = mapper.getRealAvg(idx);
		} catch (BindingException e) { }
		itemVO.setAverscore(avg);			
		
//		글의 댓글 목록을 읽어온다.
		ItemCommentList itemCommentList = ctx.getBean("itemCommentList", ItemCommentList.class);
		itemCommentList.setList(mapper.selectItemCommentList(idx));
		
		model.addAttribute("itemCommentList", itemCommentList);
		model.addAttribute("vo", itemVO);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("enter", "\r\n");
		model.addAttribute("maxidx", maxidx);
		
// 		댓글 작성자가 해당 상품에 평점을 입력한 적 있으면 해당 정보를 넘겨준다.
		ItemAvgList itemAvgList = ctx.getBean("itemAvgList", ItemAvgList.class);
		itemAvgList.setList(mapper.getAvgInfo(idx));
		model.addAttribute("ao", itemAvgList);
		
		return "item/itemView";
	}

	@RequestMapping("/hashTagSearch")		
	public String hashTagSearch(HttpServletRequest request, Model model) {
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String hashTag = request.getParameter("hashTag");

		model.addAttribute("hashTag", hashTag);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("idx", idx);
		model.addAttribute("job", "itemView");
		
		return "redirect:itemView";
	}

	@RequestMapping("/itemSearch")
	public String itemSearch(HttpServletRequest request, Model model) {
		
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) {
			
		}		

		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList itemList = ctx.getBean("itemList", ItemList.class);	

		int pageSize = 12;
		int totalCount = mapper.selectItemCount();
		String itemName = request.getParameter("itemName");
		if (itemName == null || itemName.equals("전체")) {
			itemName = "";
		} else {
			// (인기 검색어 확인용) 검색한 내용이 null이 아닐 경우 검색한 키워드를 SEARCHKEYWORD 테이블에 저장한다.
			mapper.saveKeyword(itemName); 			
		}
		itemList.initItemList(pageSize, totalCount, currentPage);
		
		ItemParam itemParam = ctx.getBean("itemParam", ItemParam.class);
		itemParam.setStartNo(itemList.getStartNo());
		itemParam.setEndNo(itemList.getEndNo());
		itemParam.setValue(itemName);		
		
		itemList.setList(mapper.isearch(itemParam));
		 
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("itemList", itemList);		
		
		return "/item/itemListView";
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

		String hashTag = itemVO.getHashTag();
		String[] hashTagArr = hashTag.split(" ");
		
		String addedTag = "";
		for (String s : hashTagArr) {
			addedTag += '#' + s + ' ';
		}
		itemVO.setHashTag(addedTag);
		
		try {
			mapper.itemUpdate(itemVO);
			rttr.addFlashAttribute("msg", idx+"번 글을 수정했습니다.");
		} catch (Exception e) {
			
		}
		
		rttr.addAttribute("currentPage", currentPage);
		rttr.addAttribute("idx", idx);
		rttr.addAttribute("job", "itemView");
		
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
			rttr.addFlashAttribute("msg", "댓글 저장에 성공했습니다.");
		} else if (mode == 2) {
			mapper.updateItemComment(itemCommentVO);
			rttr.addFlashAttribute("msg", "댓글 수정에 성공했습니다.");
		} else {
			mapper.deleteItemComment(itemCommentVO.getIdx());
			rttr.addFlashAttribute("msg", "댓글 삭제에 성공했습니다.");
		}
		
		rttr.addAttribute("currentPage", currentPage);
		rttr.addAttribute("idx", itemIdx);
		
		return "redirect:itemView";
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
		} else if (mode == 6) {
			itemList.setList(mapper.selectItemListWorse(hmap));						
		} else if (mode == 7) {
			
			String category = request.getParameter("category");
			if (category == null || category.equals("전체")) {
				category = "";
			}
			itemList.initItemList(pageSize, totalCount, currentPage);

			ItemParam itemParam = ctx.getBean("itemParam", ItemParam.class);
			itemParam.setStartNo(itemList.getStartNo());
			itemParam.setEndNo(itemList.getEndNo());
			itemParam.setValue(category);
			
			// 테이블에서 입력한 문자열이 category 필드에 포함된 데이터를 얻어온다.
			itemList.setList(mapper.categorySearch(itemParam));

			// 페이징 작업을 위해 category 값을 넘긴다.
			model.addAttribute("category", category);
			
		} else if (mode == 8) {
			String sellCVS = request.getParameter("sellCVS");
			
			if (sellCVS == null || sellCVS.equals("전체")) {
				sellCVS = "";
			}		
			
			itemList.initItemList(pageSize, totalCount, currentPage);
			
			ItemParam itemParam = ctx.getBean("itemParam", ItemParam.class);
			itemParam.setStartNo(itemList.getStartNo());
			itemParam.setEndNo(itemList.getEndNo());
			itemParam.setValue(sellCVS);	

			// 테이블에서 입력한 문자열이 category 필드에 포함된 데이터를 얻어온다.
			itemList.setList(mapper.SellCVSSearch(itemParam));
			
			// 페이징 작업을 위해 sellCVS 값을 넘긴다.
			model.addAttribute("sellCVS", sellCVS);
			
		} else if (mode == 9) {
			String eventType = request.getParameter("eventType");
			
			// 페이징 작업을 위해 eventType 값을 넘긴다.
			model.addAttribute("eventType", eventType);

			if (eventType.equals("원플러스원")) {
				eventType = "1+1";
			} else if (eventType.equals("투플러스원")) {
				eventType = "2+1";
			} else if (eventType == null || eventType.equals("전체")) {
				eventType = "";
			}
			
			itemList.initItemList(pageSize, totalCount, currentPage);
			
			ItemParam itemParam = ctx.getBean("itemParam", ItemParam.class);
			itemParam.setStartNo(itemList.getStartNo());
			itemParam.setEndNo(itemList.getEndNo());
			itemParam.setValue(eventType);
			
			// 테이블에서 입력한 문자열이 category 필드에 포함된 데이터를 얻어온다.
			itemList.setList(mapper.eventTypeSearch(itemParam));			
			
		} else {
			
			String itemPrice = request.getParameter("itemPrice");
			
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
			
			itemList.initItemList(pageSize, totalCount, currentPage);
		
			hmap.put("itemPrice", Integer.parseInt(itemPrice));				
			
			itemList.setList(mapper.itemPriceSearch(hmap));
			
			// 페이징 작업을 위해 eventType 값을 넘긴다.
			model.addAttribute("itemPrice", itemPrice);
			
		}
		
		// 상품의 목록을 request 영역에 저장해서 메인 글을 화면에 표시하는 페이지(itemListView.jsp)로 넘겨준다.
		model.addAttribute("mode", mode);
		model.addAttribute("items", items);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("itemList", itemList);
		
		return "item/itemListView";
	}
	
	@ResponseBody
	@RequestMapping("/myItem")
	public String myItem(HttpServletRequest request, Model model, HttpServletResponse response) {
		logger.info("ItemController의 myItem()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);		

		// 아이템을 찜하기 위해 현재 접속한 아이디와 상품의 idx를 얻어온다.
		String id = request.getParameter("id");
		int itemIdx = Integer.parseInt(request.getParameter("idx"));
		int mit = Integer.parseInt(request.getParameter("mit"));
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MyItemVO myItemVO = ctx.getBean("myItemVO", MyItemVO.class);
		myItemVO.setId(id);
		myItemVO.setItemIdx(itemIdx);
		
		// 만약 같은 아이디로 같은 상품을 찜한 적이 있는지 확인한다.
		int isMyItem = mapper.isMyItem(myItemVO);
		
		if (isMyItem >= 1) {
			// 찜한 적 있음 => 그냥 돌아간다.
		} else {
			// 찜한 적 없음		
			if (mit == 1) {	
				// 찜한 아이디와 상품 정보를 DB에 저장한다.
				mapper.setMyItem(myItemVO);		
			} else if (mit == 2) {
				// 찜을 취소한 아이디와 상품 정보를 DB에서 삭제한다.
				mapper.cancelMyItem(myItemVO);		 			
			}
		}		

		return "";
	}
	
	@ResponseBody
	@RequestMapping("/isMyItem")	
	public String isMyItem(HttpServletRequest request, Model model, MyItemVO myItemVO) {
		logger.info("ItemController의 isMyItem()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);	
		
//		현재 로그인한 아이디가 해당 상품에 찜을 한 적 있으면 그 정보를 넘겨준다.
		int isMyItem = mapper.isMyItem(myItemVO);
		
		if (isMyItem >= 1) {
			// 이미 찜한 적 있음
			return "2";
		} else {
			// 찜한 적 없음
			return "1";
		}

	}
	
	@RequestMapping("/itemCrawling")	
	public String itemCrawling(HttpServletRequest request, Model model, MyItemVO myItemVO) {
		logger.info("ItemController의 itemCrawling()");
		
		return "";
	}	




}








