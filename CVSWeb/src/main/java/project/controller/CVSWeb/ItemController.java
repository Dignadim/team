package project.controller.CVSWeb;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

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

import project.item.ItemAvgVO;
import project.item.ItemCommentList;
import project.item.ItemCommentVO;
import project.item.ItemDAO;
import project.item.ItemList;
import project.item.ItemVO;

@Controller
public class ItemController 
{
	private static final Logger logger = LoggerFactory.getLogger(MainCotroller.class);

	@Autowired
	private SqlSession sqlSession;
	
//	아이템목록을 요청하면 아이템 리스트뷰로 넘겨준다.
	@RequestMapping("/itemList")
	public String itemList(HttpServletRequest request, Model model)
	{
		int currentPage = 1;
		String job = "";
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));	
		} catch (Exception e) {
			
		}
		try
		{
			job = request.getParameter("job");
			if(job.equals("alert")) {}
		}
		catch(Exception e) { job = "";}
					
		int pageSize = 12;
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		
		int totalCount = mapper.selectItemCount();
		
//		만약 job으로 받은 값이 alert이면
		if(job.equals("alert"))
		{
//			msg가 있다는 뜻이니 msg를 받아와서 model에 담아준다.
			model.addAttribute("msg", request.getParameter("msg"));
		}
		
		

//		1페이지 분량의 글과 페이징 작업에 사용할 변수를 초기화시킨다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList itemList = ctx.getBean("itemList", ItemList.class);
		itemList.initMvcboardList(pageSize, totalCount, currentPage);
		
//		1페이지 분량의 글 목록을 얻어온다.
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", itemList.getStartNo());
		hmap.put("endNo", itemList.getEndNo());
		itemList.setList(mapper.selectItemList(hmap));
		
		
		// 상품의 목록을 model 영역에 저장해서 메인 글을 화면에 표시하는 페이지(itemListView.jsp)로 넘겨준다.
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("itemList", itemList);
		return "item/itemListView";
	}
	
	@RequestMapping("/itemListSort")
	public String itemListSort(HttpServletRequest request, Model model)
	{
		// 이전 페이지에서 넘어오는 화면에 표시할 페이지 번호를 받는다.
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));		
		// 실행할 번호(mode)를 받는다.
		int mode = 1;
		try
		{
			mode = Integer.parseInt(request.getParameter("mode"));
		}
		catch(Exception e)
		{
			
		}
	
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		// 1페이지 분량의, mode대로 정렬된 상품을 얻어온다.
		
		int pageSize = 12;
		int totalCount = mapper.selectItemCount(mapper);
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList itemList = ctx.getBean("itemList", ItemList.class);
		itemList.initMvcboardList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
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
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("itemList", itemList);
		
		return "item/itemListView";
	}
	
	
//	상품의 점수를 입력해주는 녀석
	@RequestMapping("/updateAverscore")
	@ResponseBody
	public String updateAverscore(HttpServletRequest request, Model model)
	{
//		logger.info("일단 ajax타고 들어옴");
		double averscore = Double.parseDouble(request.getParameter("averscore"));
//		logger.info("설마 처음부터 터짐?");
		int itemIdx = Integer.parseInt(request.getParameter("itemIdx"));
//		logger.info("updateScore 내가 범인???-오타;;");
		double updateScore = Double.parseDouble(request.getParameter("updateScore"));
		String id = request.getParameter("ID");
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
//		logger.info("그럼 currentPage는?");
		model.addAttribute("currentPage", currentPage);
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
//		우선 평점 VO를 빈 bean으로 만들어준뒤
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemAvgVO ao = ctx.getBean("itemAvgVO", ItemAvgVO.class);
//		logger.info("평점VO를 만들었다.");
//		빈(empty) 빈(bean)에다가 js에서 넘겨준 값을 이용해 초기화를 해준다.
		ao.init(averscore, itemIdx, updateScore, id);
//		js로 돌아가서 어떤걸 할지 체크해줄 값
		String result;
		
//		logger.info("넘겨준 값들을 일단 다 받음ㅇㅇ");
		
//		들어온값 VO를 기반으로 DB에 있는 평점중에 VO로 들어온 값이 DB에서 ID도 존재하고 itemIdx도 같은게 있다면
		String avgID = mapper.selectAvgID(ao);
//		이미 그 ID는 해당 itemIdx에 평점을 준적이 있으므로
		if (avgID != null) 
		{
//			logger.info("이미 평점준아이디였다");
//			내보낸다.
			return result = "0";
		} 
//		아니라면 평점을 준적없는것이므로 들어온 값을 평점DB에 등록해주고
		else 
		{
//			logger.info("평점을 새로 주겠다.");
			mapper.insertUpdateScore(ao);
			// idx가 일치하는 평점들의 새 평균을 가져온다.
			double newAvg = mapper.selectNewAvg(ao.getItemIdx());
			ao.setNewAvg(newAvg);
			
			// 새 평점을 item 테이블의 averscore 칼럼에 입력한다.
			mapper.UpdateScore(ao);
//			logger.info("모든 DB작업을 끝냈다");
//				내보낸다.
			return result = "1";
		}  
							
	}
	
//	아이템을 입력해주는 페이지로 가는 용도
	@RequestMapping("/itemInsert")
	public String itemInsert(HttpServletRequest request, Model model)
	{
		
		return "item/itemInsert";
	}
	
//	아이템을 수정해주는 페이지로 가는 용도
	@RequestMapping("/itemUpdate")
	public String itemUpdate(HttpServletRequest request, Model model)
	{
//		넘어온 정보를 받아온뒤
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
//		넘어온 idx에 해당하는 상품을 찾아서 넘겨준다.
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		ItemVO vo = mapper.itemSelectByIdx(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("currentPage", currentPage);
		
		return "item/itemUpdate";
	}
	
//	아이템을 삭제해주는 페이지로 가는 용도
	@RequestMapping("/itemDelete")
	public String itemDelete(HttpServletRequest request, Model model)
	{
//		넘어온 정보를 받아온뒤
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
//		넘어온 idx에 해당하는 상품을 찾아서 넘겨준다.
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		ItemVO vo = mapper.itemSelectByIdx(idx);
		model.addAttribute("vo", vo);
		model.addAttribute("currentPage", currentPage);
		
		return "item/itemDelete";
	}
	
//	itemImageInsert 창의 경로를 불러오기 위한용도
	@RequestMapping("/itemImageInsert")
	public String itemImageInsert()
	{
		
		return "item/itemImageInsert";
	}
	
//	아이템 입력페이지에서 입력완료를 누르면 DB에 접근해서 값을 등록해주고 아이템 리스트 1페이지로 돌아가는 용도
	@RequestMapping("/itemInsertOK")
	public String itemInsertOK(HttpServletRequest request, Model model, ItemVO vo)
	{
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
//		받아온 커맨드 객체로 DB안에 정보를 넣어준다.
		mapper.itemInsert(vo);
//		alert창에 띄울 메시지를 적어서
		model.addAttribute("msg", "상품을 입력했습니다.");
//		alert을 띄워줄거라 job을 alert이라고 보낸다.
		model.addAttribute("job", "alert");
		model.addAttribute("currentPage", "1");
		
//		itemList로 보내준다.
		return "redirect:itemList";
	}
	
//	아이템 수정페이지에서 수정완료를 누르면 DB에 접근해서 값을 수정해주고 해당 아이템 View로 돌아가는 용도
	@RequestMapping("/itemUpdateOK")
	public String itemUpdateOK(HttpServletRequest request, Model model, ItemVO vo)
	{
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
//		상품을 넘겨받은 커맨드 객체로 수정해준다.
		mapper.itemUpdate(vo);
//		성공시 alert창에 띄울 메시지
		model.addAttribute("msg", vo.getIdx() +  "번 글을 수정했습니다.");
		
//		상품과 나중에 돌아올 currentPage 해당상품에 달린 댓글을 가지고 itemView로 이동시켜주는 서버를 호출한다.
		model.addAttribute("vo", vo);
		model.addAttribute("idx", vo.getIdx());
		model.addAttribute("currentPage", currentPage);
//		alert을 띄워줄거라 job을 alert이라고 보낸다.
		model.addAttribute("job", "alert");
		
		return "redirect:itemSelectByIdx";
	}
	
//	아이템 삭제페이지에서 삭제완료를 누르면 DB에 접근해서 값을 삭제해주고 해당 currentPage 리스트로 돌아가는 용도
	@RequestMapping("/itemDeleteOK")
	public String itemDeleteOK(HttpServletRequest request, Model model, ItemVO vo)
	{
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
//		받아온 idx로 DB안에서 해당하는 idx를 가진 값을 지워주고
		mapper.itemDelete(vo.getIdx());
//		alert창에 띄울 메시지를 적어서
		model.addAttribute("msg", vo.getIdx() +  "번 글을 삭제했습니다.");
		model.addAttribute("currentPage", currentPage);
//		alert을 띄워줄거라 job을 alert이라고 보낸다.
		model.addAttribute("job", "alert");
		
//		itemList로 보내준다.
		return "redirect:itemList";
	}
	
	@RequestMapping("itemCommentOK")
	public String itemCommentOK(HttpServletRequest request, Model model, ItemCommentVO co)
	{
		// contentView.jsp에서 넘어오는 데이터를 받는다.
		int currentPage = Integer.parseInt((String) request.getParameter("currentPage"));
		int mode = Integer.parseInt(request.getParameter("mode"));
	
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		if (mode == 1) {
			model.addAttribute("msg","'댓글 저장에 " + (mapper.insertItemComment(co) ? "성공했습니다." : "실패했습니다.") + "'");
		} else if (mode == 2) {
			model.addAttribute("msg","'댓글 수정에 " + (mapper.updateItemComment(co) ? "성공했습니다." : "실패했습니다.") + "'");
		} else {
			model.addAttribute("msg","'댓글 삭제에 " + (mapper.deleteItemComment(co.getIdx()) ? "성공했습니다." : "실패했습니다.") + "'");
		}
		
		model.addAttribute("idx", co.getGup());
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("job", "alert");
		
		return "redirect:itemSelectByIdx";
	}
	
	
	
//	넘어온 job에 따라 처리를 해주고 넘겨받은 idx를 가진 상품페이지로 이동하는 용도
	@RequestMapping("/itemSelectByIdx")
	public String itemSelectByIdx(HttpServletRequest request, Model model)
	{
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String job = request.getParameter("job");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		
//		넘어온 job이 increment면
		if(job.equals("increment"))
		{
//			해당 idx 상품의 조회수를 증가시켜주고
			mapper.itemIncrement(idx);
		}
		else if(job.equals("alert"))
		{
			model.addAttribute("msg", request.getParameter("msg"));
		}
		
//		idx에 해당하는 상품객체VO를 만들고
		ItemVO vo = mapper.itemSelectByIdx(idx);
		
		try {
//			평점 테이블에서 해당 인덱스 번호에 해당하는 점수를 얻어와 상품에 넣어준다.
			vo.setAverscore(mapper.getRealAvg(idx));			
		} catch (Exception e) {
			vo.setAverscore(0);
		}
//		해당 idx번호 상품에 달린 댓글을 얻어온다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemCommentList itemCommentList = ctx.getBean("itemCommentList", ItemCommentList.class);
		itemCommentList.setList(mapper.selectItemCommentList(idx));
		
//		상품과 나중에 돌아올 currentPage 해당상품에 달린 댓글을 가지고 itemView로 이동시켜준다.
		model.addAttribute("vo", vo);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("itemCommentList", itemCommentList);
		
		return "item/itemView";
	}
	
	@RequestMapping(value="/AjaxSearch",produces = "application/text; charset=utf8")
	@ResponseBody
	public String AjaxSearch(HttpServletRequest request, Model model)
	{
		String searchWord = request.getParameter("searchWord");
		int mode = Integer.parseInt(request.getParameter("mode"));
		
		// 검색할 이름을 입력하지 않고 검색 버튼을 클릭했을 때 넘어오는 null을 공백으로 처리한다.
		if (searchWord == null) {
			searchWord = "";
		}
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		ArrayList<ItemVO> list = null;
//		어떤 검색이 들어왔는지 mode로 판별해서 list를 채워준다.
		switch (mode) {
		case 1:
//			특정 검색어가 포함된 상품만 찾는용도
			list = mapper.search(searchWord); 
			break;
		case 2:
//			특정 카테고리가 포함된 상품만 찾는 용도
			list = mapper.categorySearch(searchWord);
			break;
		case 3:
//			특정 편의점 상품만 찾는 용도
			list = mapper.SellCVSSearch(searchWord);
			break;
		case 4:
//			특정 행사별 상품만 찾는 용도
			list = mapper.eventTypeSearch(searchWord);
			break;
		case 5:
//			특정 가격대 상품만 찾는 용도
			if (searchWord == null || searchWord.equals("전체")) {
				searchWord = "99999999";
			} else if (searchWord.equals("~1,000원")) {
				searchWord = "1000";
			} else if (searchWord.equals("~5,000원")) {
				searchWord = "5000";
			} else if (searchWord.equals("~10,000원")) {
				searchWord = "10000";
			} else if (searchWord.equals("~50,000원")) {
				searchWord = "50000";
			}
			list = mapper.itemPriceSearch(Integer.parseInt(searchWord));
			break;
		}
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
//			logger.info(vo.getItemName());
		}
		result.append("]}");
		
		// ajax 방식으로 요청한 곳으로 데이터를 리턴한다.
		// ajax로 서블릿을 호출한 곳에서는 responseText를 사용해서 받는다.
		return result.toString();
		
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
}
