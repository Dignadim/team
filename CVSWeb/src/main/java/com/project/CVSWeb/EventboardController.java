package com.project.CVSWeb;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.board.event.EventboardCommentList;
import com.project.board.event.EventboardCommentVO;
import com.project.board.event.EventboardList;
import com.project.board.event.EventboardVO;
import com.project.board.event.SearchTool;
import com.project.dao.EventboardDAO;
import com.project.util.calendar.ScheduleManager;
import com.project.util.calendar.ScheduleVO;

@Controller
@RequestMapping("/event")
public class EventboardController {
	
	private static final Logger logger = LoggerFactory.getLogger(EventboardController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/insert")
	public String insert(HttpServletRequest request, Model model) {
		logger.info("EventboardController의 insert()");
		return "board/event/insert";
	}
	
	@RequestMapping("/insertOK")
	public String insertOK(HttpServletRequest request, RedirectAttributes rttr, EventboardVO eventboardVO) {
		logger.info("EventboardController의 insertOK()");
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		String ev_filename = request.getParameter("ev_filename");
		
		eventboardVO.setEv_filename(ev_filename);
		
//		머리말이 공지일 경우 행사정보를 입력할 필요가 없으니, 공지가 아닐 경우에만 행사정보기입하도록 한다.
		if(!eventboardVO.getEv_sellcvs().trim().equals("공지")) {
			// 우선 startSch를 받아와서 -기준으로 잘라서 배열에 담아준다.
			String[] startSch = request.getParameter("startSch").split("-");
			
			//	endSch는 null 빈칸이 들어올수도 있으니까 먼저 따로 받아서 검사를 해준다.
			String temp = request.getParameter("endSch");
			String[] endSch = {"0", "0", "0"};
			if(temp != null && temp != "") {
				endSch = temp.split("-");
			}
			String event = request.getParameter("contentSch");		
			
			AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			ScheduleVO scheduleVO = ctx.getBean("scheduleVO", ScheduleVO.class);
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
		}
		
//		메인글을 저장하는 Insert sql 명령을 실행한다.
		mapper.evInsert(eventboardVO);
		
		rttr.addFlashAttribute("msg", "게시글이 등록되었습니다.");
		
		return "redirect:list";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model) {
		logger.info("EventboardController의 list()");
		
		HttpSession session = request.getSession();
		
//		mapper를 얻어오는 작업
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
		
//		카테고리와 검색어를 받는다.	
		String category = request.getParameter("category");
		String searchText = request.getParameter("searchText");
		
//		넘어온 카테고리와 검색어가 있으면 세션에 저장한다.
		session.setAttribute("category", category);
		session.setAttribute("searchText", searchText);
		
//		한 페이지에 표시할 글의 개수, 브라우저에 표시할 페이지 번호, 전체 글의 개수를 저장한다.
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) { }
		int totalCount = mapper.evSelectCount();
		
//		1페이지 분량의 글과 페이징 작업에 사용할 변수를 초기화시킨다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		EventboardList eventboardList = ctx.getBean("eventboardList", EventboardList.class);
		eventboardList.initEventboardList(pageSize, totalCount, currentPage);
		
		SearchTool searchTool = ctx.getBean("searchTool", SearchTool.class);
		
//		1페이지 분량의 글 목록을 얻어온다.
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", eventboardList.getStartNo());
		hmap.put("endNo", eventboardList.getEndNo());
		
		// 카테고리, 검색어 값이 null인 경우(검색 버튼 누르기 전), 혹은 category가 "전체"인 경우
		if(category == null && (searchText == null || searchText.trim().length() == 0)	
			|| category.equals("전체") && (searchText == null || searchText.trim().length() == 0)) {
			eventboardList.setList(mapper.evSelectList(hmap));
		// 카테고리가 null이 아니거나, "전체"가 아닌 경우
		} else if (category != null || !category.equals("전체")) {
			// 검색어가 null인 경우
			if (searchText == null || searchText.trim().length() == 0) {
				searchTool.setCategory(category.trim());
				totalCount = mapper.evSelectCountCategory(searchTool);
				searchTool.setStartNo(eventboardList.getStartNo());
				searchTool.setEndNo(eventboardList.getEndNo());
				eventboardList.setList(mapper.evSelectListCategory(searchTool));
			// 검색어가 null이 아닌 경우
			} else {
				searchTool.setCategory(category.trim());
				searchTool.setSearchText(searchText.trim());
				totalCount = mapper.evSelectCountMulti(searchTool);
				searchTool.setStartNo(eventboardList.getStartNo());
				searchTool.setEndNo(eventboardList.getEndNo());
				eventboardList.setList(mapper.evSelectListMulti(searchTool));
			}
		} 
		
//		공지글을 얻어온다.
		ArrayList<EventboardVO> ev_notice = mapper.evSelectNotice();
		
//		공지글과 메인글의 댓글 개수를 얻어와서 EventboardVO 클래스의 commentCount에 저장한다.
		for (EventboardVO ev_vo : ev_notice) {
			ev_vo.setEv_commentCount(mapper.evCommentCount(ev_vo.getEv_idx()));
		}
		for (EventboardVO ev_vo : eventboardList.getList()) {
			ev_vo.setEv_commentCount(mapper.evCommentCount(ev_vo.getEv_idx()));
		}
		
//		list.jsp로 넘겨줄 데이터를 Model 인터페이스 객체에 넣어준다.
		model.addAttribute("ev_notice", ev_notice);
		model.addAttribute("eventboardList", eventboardList);
		model.addAttribute("searchTool", searchTool);
		model.addAttribute("currentPage", currentPage);
		
		return "board/event/list";
	}
	
	@RequestMapping("/increment")
	public String increment(HttpServletRequest request, Model model) {
		logger.info("EventboardController의 increment()");
		
//		mapper를 얻어오는 작업
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
//		조회수를 증가시킬 글 번호를 받는다.
		int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
		
//		조회수를 증가시키는 메소드를 실행한다.
		mapper.evIncrement(ev_idx);
		
		model.addAttribute("ev_idx", ev_idx);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		
		return "redirect:contentView";
	}
	
	@RequestMapping("/contentView")
	public String contentView(HttpServletRequest request, Model model) {
		logger.info("EventboardController의 contentView()");
		
//		mapper를 얻어오는 작업
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
//		조회수를 증가시킨 (화면에 표시할) 글 번호를 받는다.
		int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
		
//		조회수를 증가시킨 글 1건을 얻어와서 freeboardVO 클래스 객체에 저장한다.
		EventboardVO eventboardVO = mapper.evSelectByIdx(ev_idx);
		
//		조회수를 증가시킨 글의 댓글 목록을 읽어온다. >> 코멘트 할때
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		EventboardCommentList eventboardCommentList = ctx.getBean("eventboardCommentList", EventboardCommentList.class);
		eventboardCommentList.setList(mapper.evSelectCommentList(ev_idx));
		
//		이동하려는 게시판 idx를 받아서 해당하는 schedVO를 넘겨줌
		model.addAttribute("schedVO", ScheduleManager.getInstance().getFindVOByGup(ev_idx));
		
//		조회수를 증가시킨 글, 글의 댓글, 작업 후 돌아갈 페이지 번호, 줄바꿈에 사용할 "\r\n"을 Model 인터페이스 객체에
//		넣어주는 작업
		model.addAttribute("ev_vo", eventboardVO);
		model.addAttribute("eventboardCommentList", eventboardCommentList);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("enter", "\r\n");
		
		return "board/event/contentView";
	}
	
	@RequestMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		logger.info("EventboardController의 update()");
		
//		mapper를 얻어오는 작업
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
//		수정하고자 하는 글 번호를 받는다.
		int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
		
//		수정하고자 하는 글 1건을 얻어와서 freeboardVO 클래스 객체에 저장한다.
		EventboardVO eventboardVO = mapper.evSelectByIdx(ev_idx);
		
//		조회수를 증가시킨 글, 줄바꿈에 사용할 "\r\n"을 Model 인터페이스 객체에 넣어주는 작업
		model.addAttribute("ev_vo", eventboardVO);
		model.addAttribute("enter", "\r\n");
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		
		return "board/event/update";
	}
	
//	alert 문구를 띄우기 위해 Model대신 RedirectAttributes를 사용한다.
	@RequestMapping("/updateOK")
	public String updateOK(HttpServletRequest request, RedirectAttributes rttr, EventboardVO eventboardVO, ScheduleVO scheduleVO) {
		logger.info("EventboardController의 updateOK()");
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
		
		logger.info("currentPage: "+currentPage);
		logger.info("ev_idx: "+ev_idx);
		
//		mapper를 얻어오는 작업
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
		/*
//		우선 startSch를 받아와서 -기준으로 잘라서 배열에 담아준다.
		String[] startSch = request.getParameter("startSch").split("-");
//		-기준 자른게 배열크기가 3이 아니면 양식이 잘못된거니 alert담아서 내보낸다.
		if(startSch.length != 3) {
			rttr.addFlashAttribute("msg", "행사정보 시작일 칸이 양식과 다르게 입력되었습니다.");
			rttr.addAttribute("currentPage", currentPage);
			rttr.addAttribute("ev_idx", eventboardVO.getEv_idx());
			return "redirect:update";
		}
		//	endSch는 null 빈칸이 들어올수도 있으니까 먼저 따로 받아서 검사를 해준다.
		String temp = request.getParameter("endSch");
		String[] endSch = {"0", "0", "0"};
		if(temp != null && temp != "")
		{
			endSch = temp.split("-");
//			여기도 -기준 잘랐는데 3이 아니면 양식이 잘못된거니 내쫓는다.
			if(endSch.length != 3) {
				rttr.addFlashAttribute("msg", "행사정보 종료일 칸이 양식과 다르게 입력되었습니다.");
				rttr.addAttribute("currentPage", currentPage);
				rttr.addAttribute("ev_idx", eventboardVO.getEv_idx());
				return "redirect:update";
			}
		}
		String event = request.getParameter("contentSch");
		
		//	받아온 값들을 인수로 스케쥴vo를 만들고
		scheduleVO.init(
				Integer.parseInt(startSch[0]),
				Integer.parseInt(startSch[1]),
				Integer.parseInt(startSch[2]),
				Integer.parseInt(endSch[0]),
				Integer.parseInt(endSch[1]),
				Integer.parseInt(endSch[2]),
				event,
				eventboardVO.getEv_idx()
				);
		
		//	그걸 db에 입력하라고 넘겨준다.
		mapper.updateSched(scheduleVO);
		//	추가된 내용이 있으니 arrayList를 한번 갱신해준다.
		ScheduleManager.getInstance().setList(mapper.initSchedList());
		*/
		
//		글을 수정하는 메소드를 실행한다.
		mapper.evUpdate(eventboardVO);
		
//		글이 수정되었다는 문구를 RedirectAttributes 인터페이스의 addFlashAttribute() 메소드를 이용하여 띄운다.
		rttr.addFlashAttribute("msg", "게시글이 성공적으로 수정되었습니다.");
		
//		글 수정 작업 후 돌아갈 페이지 번호를 RedirectAttributes 인터페이스 객체에 저장한다.
		rttr.addAttribute("ev_idx", ev_idx);
		rttr.addAttribute("currentPage", currentPage);
		
		return "redirect:contentView";
	}
	
//	alert 문구를 띄우기 위해 Model대신 RedirectAttributes를 사용한다.
	@RequestMapping("/deleteOK")
	public String deleteOK(HttpServletRequest request, RedirectAttributes rttr, EventboardVO eventboardVO) {
		logger.info("EventboardController의 deleteOK()");
		
//		mapper를 얻어오는 작업
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
//		삭제할 글의 글 번호를 가져온다.
		int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		String url = "list?currentPage="+currentPage;
		
//		글 1건을 삭제하는 메소드를 실행한다.
		mapper.evDelete(ev_idx);
		mapper.deleteSched(ev_idx);
		
//		글이 삭제되었다는 문구를 RedirectAttributes 인터페이스의 addFlashAttribute() 메소드를 이용하여 띄운다.
		rttr.addFlashAttribute("msg", "게시글이 성공적으로 수정되었습니다.");
		
//		글 삭제 작업 후 돌아갈 페이지 번호를 RedirectAttributes 인터페이스 객체에 저장한다.
		rttr.addAttribute("currentPage", request.getParameter("currentPage"));
		
		return "redirect:list";
	}
	
	@RequestMapping("/eventImageInsert")
	public String eventImageInsert(HttpServletRequest request, Model model) {
		logger.info("EventboardController의 eventImageInsert()");
		return "board/event/eventImageInsert";
	}
	
	// 아직 Alert 해결책 못찾음
	@RequestMapping("/eventImageInsertOK")
	public String eventImageInsertOK(@RequestParam("ev_filename") MultipartFile ev_file, HttpServletResponse response, Model model) {
		logger.info("EventboardController의 eventImageInsertOK()");
		String fileRealname = ev_file.getOriginalFilename(); // 파일명을 얻어낼 수 있는 메서드
		long size = ev_file.getSize(); // 파일 사이즈
		
		System.out.println("파일명: " + fileRealname);
		System.out.println("용량크기(byte): " + size);
		
		if(size > 5 * 1024 * 1024) {
			Alert.alertAndBack(response, "업로드 용량 초과, 5MB까지 업로드 가능");
		}
		
		String fileExtension = fileRealname.substring(fileRealname.lastIndexOf("."),fileRealname.length()); // 파일확장자명
		String uploadFolder = "/Users/mac/STS/workspace/CVSWeb/src/main/webapp/WEB-INF/eventUploadFiles"; // 업로드할 폴더 위치
		
		System.out.println("파일 확장자명: " + fileExtension);
		if(!fileExtension.trim().equals(".png") && !fileExtension.trim().equals(".jpg") && !fileExtension.trim().equals(".gif")) {
			Alert.alertAndBack(response, "업로드할 수 있는 형식의 파일이 아닙니다.\\n*.png, *.jpg, *.gif 파일만 가능합니다.");
		}
		
		UUID uuid = UUID.randomUUID(); // 파일이름이 중복되는 것, 컴퓨터에서 다루지 않는 언어가 나와서 깨지는 것을 방지. 하지만 이름이 쌉랜덤으로 나옴..
		String uuids[] = uuid.toString().split("-");
		
		String uniqueName = uuids[0];
		System.out.println("생성된 파일이름: " + uniqueName);
		String ev_filename = uniqueName+fileExtension;
		
		File saveFile = new File(uploadFolder + "/" + uniqueName + fileExtension);
		System.out.println(saveFile);
		
		try {
			ev_file.transferTo(saveFile); // transferTo(): 파일 저장 메서드
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
		
		model.addAttribute("ev_filename", "../eventUploadFiles/"+ev_filename);
		model.addAttribute("fileRealname", fileRealname);
		return "board/event/eventImageInsertOK";
	}
	
	@RequestMapping("/commentOK")
	public String commentOK(HttpServletRequest request, RedirectAttributes rttr, EventboardCommentVO eventboardCommentVO) {
		logger.info("EventboardController의 commentOK()");
		logger.info("evc_vo: " + eventboardCommentVO);
		
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		int mode = Integer.parseInt(request.getParameter("mode"));
		logger.info("mode: " + mode);
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int ev_idx = Integer.parseInt(request.getParameter("ev_idx"));
		
//		mode가 1일 경우 댓글을 저장하는 insert sql 명령을 실행, 2일 경우 댓글을 수정하는 update sql 명령을 실행,
//		3일 경우 댓글을 삭제하는 delete sql 명령을 실행한다.
		if(mode == 1) {
			mapper.evInsertComment(eventboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 저장에 성공했습니다.");
		} else if (mode == 2) {
			mapper.evUpdateComment(eventboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 수정에 성공했습니다.");
		} else {
			mapper.evDeleteComment(eventboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 삭제에 성공했습니다.");
		}
		
		rttr.addAttribute("ev_idx", ev_idx);
		rttr.addAttribute("currentPage", currentPage);
		return "redirect:contentView";
	}
	
	@RequestMapping("/insertEmptyChk")
	@ResponseBody
	public String insertEmptyChk(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("EventboardController의 insertEmptyChk()");
		
		String ev_sellcvs = request.getParameter("ev_sellcvs").trim();
		String ev_subject = request.getParameter("ev_subject").trim();
		String ev_content = request.getParameter("ev_content").trim();
		String[] startSch = request.getParameter("startSch").split("-");
		String[] endSch = request.getParameter("endSch").split("-");
		String contentSch = request.getParameter("contentSch").trim();	
		String oneday = request.getParameter("oneday").trim();	
		
		if(ev_sellcvs.equals("-머리말선택-")) {
			response.getWriter().write("1");
			return null;
		}
		
		if(ev_subject == null || ev_subject.equals("")) {
			response.getWriter().write("2");
			return null;
		}
		
		if(ev_content == null || ev_content.equals("")) {
			response.getWriter().write("3");
			return null;
		}
		
		// 행사 내용 기입 관련
		// 머릿말이 "공지"가 아닌 경우에만 필터링을 해준다.
		if(!ev_sellcvs.equals("공지")) {
			// 년,월,일 기준으로 나누어지기 때문에 배열의 길이가 3이 아닌 경우 즉, 시작일에 날짜가 기입되지 않은경우
			if(startSch.length != 3) {
				response.getWriter().write("4");
				return null;
			}
			// 일일행사 체크란이 false(체크되지않음)인 경우에만 종료일을 검사한다.
			if(oneday.equals("false")) {
				// 년,월,일 기준으로 나누어지기 때문에 배열의 길이가 3이 아닌 경우 즉, 종료일에 날짜가 기입되지 않은경우
				if(endSch.length != 3) {
					response.getWriter().write("5");
					return null;
				}
			}
			// 행사 내용이 비어있을 경우
			if(contentSch == null || contentSch.equals("")) {
				response.getWriter().write("6");
				return null;
			}
		}
		
		// 모든 내용이 정상적으로 입력되었을 경우
		if(ev_subject != null || !ev_subject.equals("") || ev_content != null || !ev_content.equals("")
				|| !ev_sellcvs.equals("-머리말선택-")) {
			response.getWriter().write("7");
		}
		return null;
	}
	
	@RequestMapping("/commentEmptyChk")
	@ResponseBody
	public String commentEmptyChk(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("EventboardController의 commentEmptyChk()");
		
		String evc_content = request.getParameter("evc_content").trim();
		
		if(evc_content == null || evc_content.equals("")) {
			response.getWriter().write("1");
			return null;
		} else {
			response.getWriter().write("2");
		}
		
		return null;
	}
	
	static class Alert {
		
		public static void alertAndBack(HttpServletResponse response, String msg) {
		    try {
		        response.setContentType("text/html; charset=utf-8");
		        PrintWriter w = response.getWriter();
		        w.write("<script>alert('"+msg+"');history.go(-1);</script>");
		        w.flush();
		        w.close();
		    } catch(Exception e) {
		        e.printStackTrace();
		    }
		}
	}
	
}


















