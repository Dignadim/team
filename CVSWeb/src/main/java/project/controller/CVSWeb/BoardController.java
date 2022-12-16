package project.controller.CVSWeb;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;

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

import project.board.free.FreeboardCommentList;
import project.board.free.FreeboardCommentVO;
import project.board.free.FreeboardDAO;
import project.board.free.FreeboardList;
import project.board.free.FreeboardVO;
import project.item.ItemDAO;
import project.item.ItemList;
import project.item.ItemVO;
import project.member.MemberVO;

@Controller
public class BoardController 
{
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);

	@Autowired
	private SqlSession sqlSession;
	
//	랭킹게시판으로 이동한다.
	@RequestMapping("/rank")
	public String rank(HttpServletRequest request, Model model, MemberVO meberVO)
	{
		String category = "모두";
		//	카테고리속성을 받아온다.
		String reCategory = (String) request.getParameter("category");
//		한 페이지에 출력할 리스트 개수
		int count = 12;
		
		//	받아온 카테고리 속성이 존재한다면 그걸로 카테고리를 바꿔준다.
		if(reCategory != null) category = reCategory;
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);

		//	받아온 카테고리 속성의 상품만 담은 리스트를 만들어준다.
		ArrayList<ItemVO> list = null;
		if(category.equals("모두"))
		{
			list = (ArrayList<ItemVO>) mapper.selectItems();
		}
		else
		{
			list = (ArrayList<ItemVO>) mapper.selectItemCate(category);
		}

		//	카테고리 속성의 상품만 담은 리스트에서 조회수 상위 ()개의 상품만 가져온다.
		
		// 리스트를 temp에 담아준다.
		ArrayList<ItemVO> tempList = list;
		List<ItemVO> result = null;
		
		//	조회수 기준으로 정렬을 해준다.
		 MiniComparator comp = new MiniComparator();  
	        Collections.sort(tempList, comp); 
		//System.out.println(tempList.size());
		
		//	요구하는 개수보다 리스트 크기가 작은지 큰지 구분해서
		if(tempList.size() <= count)
		{
			result = tempList.subList(0, tempList.size());
		}
		else 
		{
			//	요구하는 크기만큼 리스트를 잘라서 옮겨담아준다.
			result = tempList.subList(0, count);
		}
		//	마지막으로 빈 리스트를 만든뒤
		ArrayList<ItemVO> tempList2 = new ArrayList<ItemVO>();
		tempList2.addAll(result);	//	자른 리스트를 담아주고
		list = tempList2;	//	그 리스트를 list에 담아주고
		
		for(int i = 0; i < list.size(); i++)
		{
			try 
			{
//				평점 테이블에서 해당 인덱스 번호에 해당하는 점수를 얻어와 상품에 넣어준다.
				list.get(i).setAverscore(mapper.getRealAvg(list.get(i).getIdx()));
			}
			catch (Exception e) 
			{
				list.get(i).setAverscore(0);
			}
		}
		
		
		model.addAttribute("itemTOP", list);
		model.addAttribute("category", category);
		    
		return "board/rank/rankView";
	}
	
	
	
	@RequestMapping("/newView")
	public String newView(HttpServletRequest request, Model model)
	{
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));		
		} catch (NumberFormatException e) {
			
		}
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		// 신상품: 등록된지 30일 이내의 상품
		// 모든 신상품 목록을 얻어온다. 
		// ArrayList<ItemVO> newItems = service.selectNewItems();
		
		int pageSize = 12;
		int totalCount = mapper.selectNewItemCount(mapper);
		
//		1페이지 분량의 글과 페이징 작업에 사용할 변수를 초기화시킨다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList newItemList = ctx.getBean("itemList", ItemList.class);
		newItemList.initMvcboardList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", newItemList.getStartNo());
		hmap.put("endNo", newItemList.getEndNo());	
		
		// 1페이지 분량의 신상품을 얻어온다.
		newItemList.setList(mapper.selectNewItemList(hmap));
		
		for(int i = 0; i < newItemList.getList().size(); i++)
		{
			try 
			{
//				평점 테이블에서 해당 인덱스 번호에 해당하는 점수를 얻어와 상품에 넣어준다.
				newItemList.getList().get(i).setAverscore(mapper.getRealAvg(newItemList.getList().get(i).getIdx()));
			}
			catch (Exception e) 
			{
				newItemList.getList().get(i).setAverscore(0);
			}
		}
		
		
		// request.setAttribute("newItems", newItems);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("newItemList", newItemList);
	 
		return "board/new/newView";
	}
	
	
	@RequestMapping("/fbList")
	public String fbList(HttpServletRequest request, Model model)
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
		
//		만약 job으로 받은 값이 alert이면
		if(job.equals("alert"))
		{
//			msg가 있다는 뜻이니 msg를 받아와서 model에 담아준다.
			model.addAttribute("msg", request.getParameter("msg"));
		}
		
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);

		ArrayList<FreeboardVO> fb_notice = mapper.fbSelectNotice();
		
		int pageSize = 10;
		int totalCount = mapper.fbSelectCount();
		
//		1페이지 분량의 글과 페이징 작업에 사용할 변수를 초기화시킨다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		FreeboardList freeboardList = ctx.getBean("freeList", FreeboardList.class);
		freeboardList.initMvcboardList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", freeboardList.getStartNo());
		hmap.put("endNo", freeboardList.getEndNo());
		freeboardList.setList(mapper.fbSelectList(hmap));
		
//		공지글과 메인글의 댓글 개수를 얻어와서 FreeboardVO 클래스의 commentCount에 저장한다.
		for (FreeboardVO fb_vo : fb_notice) {
			fb_vo.setFb_commentCount(mapper.fbCommentCount(fb_vo.getFb_idx()));
		}
		for (FreeboardVO fb_vo : freeboardList.getList()) {
			fb_vo.setFb_commentCount(mapper.fbCommentCount(fb_vo.getFb_idx()));
		}

//		공지글과 메인글의 목록을 request 영역에 저장해서 메인글을 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
		model.addAttribute("fb_notice", fb_notice);
		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("currentPage", currentPage);
		
		
		
		return "board/free/listView";
	}
	
	@RequestMapping("/fbSelectByIdx")
	public String fbSelectByIdx(HttpServletRequest request, Model model)
	{
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String job = request.getParameter("job");
		
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
		
//		넘어온 job이 increment면
		if(job.equals("increment"))
		{
//			해당 idx 게시물의 조회수를 증가시켜주고
			mapper.fbIncrement(idx);
		}
		else if(job.equals("alert"))
		{
			model.addAttribute("msg", request.getParameter("msg"));
		}
		
//		idx에 해당하는 게시판 객체VO를 만들고
		FreeboardVO vo = mapper.fbSelectByIdx(idx);
		
//		해당 idx번호 상품에 달린 댓글을 얻어온다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		FreeboardCommentList freeboardCommentList = ctx.getBean("freeboardCommentList", FreeboardCommentList.class);
		freeboardCommentList.setList(mapper.fbSelectCommentList(idx));
		
//		상품과 나중에 돌아올 currentPage 해당상품에 달린 댓글을 가지고 contentView로 이동시켜준다.
		model.addAttribute("fb_vo", vo);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("freeboardCommentList", freeboardCommentList);
		
		return "board/free/contentView";
	}
	
	
	@RequestMapping("/fbInsert")
	public String fbInsert(HttpServletRequest request, Model model)
	{
		return "board/free/insert";
	}
	
	@RequestMapping("/fbUpdate")
	public String fbUpdate(HttpServletRequest request, Model model)
	{
//		넘어온 정보를 받아온뒤
		int idx = Integer.parseInt(request.getParameter("fb_idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
//		넘어온 idx에 해당하는 상품을 찾아서 넘겨준다.
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		FreeboardVO vo = mapper.fbSelectByIdx(idx);
		
		model.addAttribute("fb_vo", vo);
		model.addAttribute("currentPage", currentPage);
		
		return "board/free/update";
	}
	
	@RequestMapping("/fbDelete")
	public String fbDelete(HttpServletRequest request, Model model)
	{
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		

		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		mapper.fbDelete(fb_idx);
		
		model.addAttribute("msg", "게시글이 성공적으로 삭제되었습니다.");
		model.addAttribute("job", "alert");
		model.addAttribute("currentPage", currentPage);
		
		return "redirect:fbList";
	}
	
	@RequestMapping("/fbInsertOK")
	public String fbInsertOK(HttpServletRequest request, Model model, FreeboardVO vo, MemberVO mb_vo)
	{
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	
		vo.setId(mb_vo.getId());
		vo.setNickname(mb_vo.getNickname());
	
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
//		받아온 커맨드 객체로 DB안에 정보를 넣어준다.
		mapper.fbInsert(vo);
//		alert창에 띄울 메시지를 적어서
		model.addAttribute("msg", "게시글이 등록되었습니다.");
//		alert을 띄워줄거라 job을 alert이라고 보낸다.
		model.addAttribute("job", "alert");
		model.addAttribute("currentPage", currentPage);
		
//		itemList로 보내준다.
		return "redirect:fbList";
	}
	
	@RequestMapping("/fbUpdateOK")
	public String fbUpdateOK(HttpServletRequest request, Model model, FreeboardVO vo)
	{
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
//		받아온 커맨드 객체로 DB안에 정보를 넣어준다.
		mapper.fbUpdate(vo);
//		alert창에 띄울 메시지를 적어서
		model.addAttribute("msg", "게시글이 성공적으로 수정되었습니다.");
//		alert을 띄워줄거라 job을 alert이라고 보낸다.
		model.addAttribute("job", "alert");
		model.addAttribute("currentPage", currentPage);
		
//		itemList로 보내준다.
		return "redirect:fbList";
	}
	
	@RequestMapping("/fbCommentOK")
	public String fbCommentOK(HttpServletRequest request, Model model, FreeboardCommentVO fbc_vo)
	{
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int mode = Integer.parseInt(request.getParameter("mode"));
		
//	 	logger.info(fbc_vo.toString());
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
	  	
		//contentView.jsp에서 넘어온 mode에 따라 1은 댓글 저장, 2는 댓글 수정, 3은 댓글 삭제 작업을 한다.
		switch (mode) {
			case 1:
				model.addAttribute("msg","'댓글 저장에 " + (mapper.fbInsertComment(fbc_vo) ? "성공했습니다." : "실패했습니다.") + "'");
				break;
	 		case 2:
				model.addAttribute("msg","'댓글 수정에 " + (mapper.fbUpdateComment(fbc_vo) ? "성공했습니다." : "실패했습니다.") + "'");
				break;
			case 3:
				model.addAttribute("msg","'댓글 삭제에 " + (mapper.fbDeleteComment(fbc_vo.getFbc_idx()) ? "성공했습니다." : "실패했습니다.") + "'");
				break;
		}

		model.addAttribute("idx", fbc_vo.getFbc_gup());
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("job", "alert");
		
		return "redirect:fbSelectByIdx";
		
	}

    
}

	


















//list안의 조회수 기준으로 정렬해주는 기능
class MiniComparator implements Comparator<ItemVO> 
{  
    @Override  
    public int compare(ItemVO first, ItemVO second) {  
        int firstValue = first.getHit();  
        int secondValue = second.getHit();  
          
        // Order by descending   
        if (firstValue > secondValue) {  
            return -1;  
        } else if (firstValue < secondValue) {  
            return 1;  
        } else {  
            return 0;  
        }  
    }
}
