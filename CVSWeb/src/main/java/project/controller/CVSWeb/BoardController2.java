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

import project.board.event.EventboardCommentList;
import project.board.event.EventboardCommentVO;
import project.board.event.EventboardDAO;
import project.board.event.EventboardList;
import project.board.event.EventboardVO;
import project.board.free.FreeboardCommentVO;
import project.board.free.FreeboardDAO;
import project.member.MemberVO;
import project.util.calendar.ScheduleManager;
import project.util.calendar.ScheduleVO;

@Controller
public class BoardController2 
{
	private static final Logger logger = LoggerFactory.getLogger(BoardController2.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/evList")
	public String fbList(HttpServletRequest request, Model model)
	{
		
		int currentPage = 1;
		String job = "";
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));	
			
		} catch (Exception e) 
		{
		
		}
		try
		{
			job = request.getParameter("job");
			if(job.equals("alert")) {}
		}
		catch(Exception e) { job = "";}
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
//		검색용을 받는다.
		String category = request.getParameter("category");
		String searchText = request.getParameter("searchText");
	
		
//		logger.info(job);
//		만약 job으로 받은 값이 alert이면
		if(job.equals("alert"))
		{
//			msg가 있다는 뜻이니 msg를 받아와서 model에 담아준다.
			model.addAttribute("msg", request.getParameter("msg"));
		}
		

//		1페이지 분량의 글과 페이징 작업에 사용할 변수를 초기화시킨다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		EventboardList eventboardList = ctx.getBean("eventList", EventboardList.class);
		ArrayList<EventboardVO> ev_notice = mapper.evSelectNotice();
		
		int pageSize = 10;
		int totalCount = mapper.evSelectCount();
		eventboardList.initMvcboardList(pageSize, totalCount, currentPage);
		
		
		
//		카테고리가 없는경우는 검색을 할 생각이 없으니까 그냥 전체 리스트에서 해준다.
		if(category == null || category.trim().length() == 0)
		{
			HashMap<String, Integer> hmap = new HashMap<String, Integer>();
			hmap.put("startNo", eventboardList.getStartNo());
			hmap.put("endNo", eventboardList.getEndNo());
			
			eventboardList.setList(mapper.evSelectList(hmap));
		}
		// 카테고리가 null이 아니거나, 검색어가 null이 아닌 경우에는 검색을 하기위해 입력한 값이 있다는 뜻이고
		else
		{
			// 검색어가 null이고 카테고리가 전체가 아닌경우 카테고리만 가지고 검색해준다.
			if ((searchText == null || searchText.trim().length() == 0) && !category.equals("전체"))
			{
				
				totalCount = mapper.evSelectCountCategory(category.trim());
				eventboardList.initMvcboardList(pageSize, totalCount, currentPage);
				
				HashMap<String, String> hmap = new HashMap<String, String>();
				hmap.put("startNo", Integer.toString(eventboardList.getStartNo()));
				hmap.put("endNo", Integer.toString(eventboardList.getEndNo()));
				hmap.put("category", category);
				
				eventboardList.setList(mapper.evSelectListCategory(hmap));
				model.addAttribute("category", category);
			}
			// 검색어가 null이 아닌 경우 카테고리와 검색어 둘다를 사용해 검색한다.
			else if(searchText.trim().length() != 0)
			{
				
				HashMap<String, String> hmap = new HashMap<String, String>();
				hmap.put("category", category);
				hmap.put("searchText", searchText);
				
				totalCount = mapper.evSelectCountMulti(hmap);
				eventboardList.initMvcboardList(pageSize, totalCount, currentPage);
				
				hmap.put("startNo", Integer.toString(eventboardList.getStartNo()));
				hmap.put("endNo", Integer.toString(eventboardList.getEndNo()));
				
				eventboardList.setList(mapper.evSelectListMulti(hmap));
				model.addAttribute("category", category);
			}
			else
			{
				HashMap<String, Integer> hmap = new HashMap<String, Integer>();
				hmap.put("startNo", eventboardList.getStartNo());
				hmap.put("endNo", eventboardList.getEndNo());
				
				eventboardList.setList(mapper.evSelectList(hmap));
			}
			
		}

		
		
		
		
//		공지글과 메인글의 댓글 개수를 얻어와서 EventboardVO 클래스의 commentCount에 저장한다.
		for (EventboardVO ev_vo : ev_notice) {
			ev_vo.setEv_commentCount(mapper.evCommentCount(ev_vo.getEv_idx()));
		}
		for (EventboardVO ev_vo : eventboardList.getList()) {
			ev_vo.setEv_commentCount(mapper.evCommentCount(ev_vo.getEv_idx()));
		}

//		공지글과 메인글의 목록을 request 영역에 저장해서 메인글을 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
		model.addAttribute("ev_notice", ev_notice);
		model.addAttribute("eventboardList", eventboardList);
		model.addAttribute("currentPage", currentPage);
		
	
		//	스케줄이 들어있는 리스트를 불러온다.
		model.addAttribute("schedList", ScheduleManager.getInstance().getList());
		
		
		return "board/event/listView";
	}
	
	@RequestMapping("/evSelectByIdx")
	public String fbSelectByIdx(HttpServletRequest request, Model model)
	{
		int idx = Integer.parseInt(request.getParameter("ev_idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String job = request.getParameter("job");
		
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
		
//		넘어온 job이 increment면
		if(job.equals("increment"))
		{
//			해당 idx 게시물의 조회수를 증가시켜주고
			mapper.evIncrement(idx);
		}
		else if(job.equals("alert"))
		{
			model.addAttribute("msg", request.getParameter("msg"));
		}
		
//		idx에 해당하는 게시판 객체VO를 만들고
		EventboardVO vo = mapper.evSelectByIdx(idx);
		
//		해당 idx번호 상품에 달린 댓글을 얻어온다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		EventboardCommentList eventboardCommentList = ctx.getBean("eventboardCommentList", EventboardCommentList.class);
		eventboardCommentList.setList(mapper.evSelectCommentList(idx));
		
		//	이동하려는 게시판 idx를 받아서 해당하는 schedVO를 넘겨줌
		model.addAttribute("schedVO", ScheduleManager.getInstance().getFindVOByGup(idx));
		
//		상품과 나중에 돌아올 currentPage 해당상품에 달린 댓글을 가지고 contentView로 이동시켜준다.
		model.addAttribute("ev_vo", vo);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("eventboardCommentList", eventboardCommentList);
		
		return "board/event/contentView";
	}
	
	@RequestMapping("/evInsert")
	public String evInsert()
	{
		return "board/event/insert";
	}
	
	@RequestMapping("/evUpdate")
	public String evUpdate(HttpServletRequest request, Model model)
	{
//		넘어온 정보를 받아온뒤
		int idx = Integer.parseInt(request.getParameter("ev_idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		try
		{
			String msg = request.getParameter("msg");
			model.addAttribute("msg", msg);
		}
		catch (Exception e) {		}
		
//		넘어온 idx에 해당하는 상품을 찾아서 넘겨준다.
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		EventboardVO vo = mapper.evSelectByIdx(idx);
		ScheduleVO schedVO = ScheduleManager.getInstance().getFindVOByGup(idx);
		
		model.addAttribute("ev_vo", vo);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("schedVO", schedVO);
		
		return "board/event/update";
	}
	
	
	
	@RequestMapping("/evDelete")
	public String fbDelete(HttpServletRequest request, Model model)
	{
		int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		

		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		mapper.evDelete(ev_idx);
		mapper.deleteSched(ev_idx);
//		변경된 내용이 있으니 arrayList를 한번 갱신해준다.
		ScheduleManager.getInstance().setList(mapper.initSchedList());
		
		model.addAttribute("msg", "게시글이 성공적으로 삭제되었습니다.");
		model.addAttribute("job", "alert");
		model.addAttribute("currentPage", currentPage);
		
		return "redirect:evList";
	}
	
	@RequestMapping("/evInsertOK")
	public String evInsertOK(HttpServletRequest request, Model model, EventboardVO vo, MemberVO mb_vo)
	{
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		
		vo.setId(mb_vo.getId());
		vo.setNickname(mb_vo.getNickname());
		
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
//		우선 startSch를 받아와서 -기준으로 잘라서 배열에 담아준다.
		String[] startSch = request.getParameter("startSch").split("-");
//		-기준 자른게 배열크기가 3이 아니면 양식이 잘못된거니 alert담아서 내보낸다.
		if(startSch.length != 3)
		{
			model.addAttribute("msg", "행사정보 시작일 칸이 양식과 다르게 입력되었습니다.");
			return "board/event/insert";
		}
		//	endSch는 null 빈칸이 들어올수도 있으니까 먼저 따로 받아서 검사를 해준다.
		String temp = request.getParameter("endSch");
		String[] endSch = {"0", "0", "0"};
		if(temp != null && temp != "")
		{
			endSch = temp.split("-");
//			여기도 -기준 잘랐는데 3이 아니면 양식이 잘못된거니 내쫓는다.
			if(endSch.length != 3)
			{
				model.addAttribute("msg", "행사정보 종료일 칸이 양식과 다르게 입력되었습니다.");
				return "board/event/insert";
			}
		}
		String event = request.getParameter("contentSch");
		
		
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ScheduleVO scheduleVO = ctx.getBean("scheduleVO", ScheduleVO.class);
		//	받아온 값들을 인수로 스케쥴vo를 만들고
		scheduleVO.init(
				Integer.parseInt(startSch[0]),
				Integer.parseInt(startSch[1]),
				Integer.parseInt(startSch[2]),
				Integer.parseInt(endSch[0]),
				Integer.parseInt(endSch[1]),
				Integer.parseInt(endSch[2]),
				event,
				-1
				);
		//	그걸 db에 입력하라고 넘겨준다.
		mapper.insertSched(scheduleVO);
		//	추가된 내용이 있으니 arrayList를 한번 갱신해준다.
		ScheduleManager.getInstance().setList(mapper.initSchedList());
//		받아온 커맨드 객체로 DB안에 정보를 넣어준다.
//		filename은 미구현 안넘겨받기에 임시로 아무 String 값이나 넘겨준다.
		vo.setEv_filename("m");
		mapper.evInsert(vo);
		

//		alert창에 띄울 메시지를 적어서
		model.addAttribute("msg", "게시글이 등록되었습니다.");
//		alert을 띄워줄거라 job을 alert이라고 보낸다.
		model.addAttribute("job", "alert");
		model.addAttribute("currentPage", currentPage);
		
//		itemList로 보내준다.
		return "redirect:evList";
	}
	
	@RequestMapping("/evUpdateOK")
	public String evUpdateOK(HttpServletRequest request, Model model, EventboardVO vo, MemberVO mb_vo)
	{
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		
		vo.setId(mb_vo.getId());
		vo.setNickname(mb_vo.getNickname());
		
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
//		우선 startSch를 받아와서 -기준으로 잘라서 배열에 담아준다.
		String[] startSch = request.getParameter("startSch").split("-");
//		-기준 자른게 배열크기가 3이 아니면 양식이 잘못된거니 alert담아서 내보낸다.
		if(startSch.length != 3)
		{
			model.addAttribute("msg", "행사정보 시작일 칸이 양식과 다르게 입력되었습니다.");
			model.addAttribute("currentPage", currentPage);
			model.addAttribute("ev_idx", vo.getEv_idx());
			return "redirect:evUpdate";
		}
		//	endSch는 null 빈칸이 들어올수도 있으니까 먼저 따로 받아서 검사를 해준다.
		String temp = request.getParameter("endSch");
		String[] endSch = {"0", "0", "0"};
		if(temp != null && temp != "")
		{
			endSch = temp.split("-");
//			여기도 -기준 잘랐는데 3이 아니면 양식이 잘못된거니 내쫓는다.
			if(endSch.length != 3)
			{
				model.addAttribute("msg", "행사정보 종료일 칸이 양식과 다르게 입력되었습니다.");
				model.addAttribute("currentPage", currentPage);
				model.addAttribute("ev_idx", vo.getEv_idx());
				return "redirect:evUpdate";
			}
		}
		String event = request.getParameter("contentSch");
		
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ScheduleVO scheduleVO = ctx.getBean("scheduleVO", ScheduleVO.class);
		//	받아온 값들을 인수로 스케쥴vo를 만들고
		scheduleVO.init(
				Integer.parseInt(startSch[0]),
				Integer.parseInt(startSch[1]),
				Integer.parseInt(startSch[2]),
				Integer.parseInt(endSch[0]),
				Integer.parseInt(endSch[1]),
				Integer.parseInt(endSch[2]),
				event,
				vo.getEv_idx()
				);
		//	그걸 db에 입력하라고 넘겨준다.
		mapper.updateSched(scheduleVO);
		//	추가된 내용이 있으니 arrayList를 한번 갱신해준다.
		ScheduleManager.getInstance().setList(mapper.initSchedList());
//		받아온 커맨드 객체로 DB안에 정보를 넣어준다.
//		filename은 미구현 안넘겨받기에 임시로 아무 String 값이나 넘겨준다.
		vo.setEv_filename("m");
		mapper.evUpdate(vo);
		
		
//		alert창에 띄울 메시지를 적어서
		model.addAttribute("msg", "게시글이 성공적으로 수정되었습니다.");
//		alert을 띄워줄거라 job을 alert이라고 보낸다.
		model.addAttribute("job", "alert");
		model.addAttribute("currentPage", currentPage);
		
//		itemList로 보내준다.
		return "redirect:evList";
	}
	
	
	
	@RequestMapping("/evCommentOK")
	public String fbCommentOK(HttpServletRequest request, Model model, EventboardCommentVO evc_vo)
	{
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int mode = Integer.parseInt(request.getParameter("mode"));
		
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
	  	
		//contentView.jsp에서 넘어온 mode에 따라 1은 댓글 저장, 2는 댓글 수정, 3은 댓글 삭제 작업을 한다.
		switch (mode) {
			case 1:
				model.addAttribute("msg","'댓글 저장에 " + (mapper.evInsertComment(evc_vo) ? "성공했습니다." : "실패했습니다.") + "'");
				break;
	 		case 2:
				model.addAttribute("msg","'댓글 수정에 " + (mapper.evUpdateComment(evc_vo) ? "성공했습니다." : "실패했습니다.") + "'");
				break;
			case 3:
				model.addAttribute("msg","'댓글 삭제에 " + (mapper.evDeleteComment(evc_vo.getEvc_idx()) ? "성공했습니다." : "실패했습니다.") + "'");
				break;
		}

		model.addAttribute("ev_idx", evc_vo.getEvc_gup());
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("job", "alert");
		
		return "redirect:evSelectByIdx";
		
	}
	
	
	
}