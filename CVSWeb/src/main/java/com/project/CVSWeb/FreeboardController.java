package com.project.CVSWeb;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

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

import com.project.board.free.FreeboardCommentList;
import com.project.board.free.FreeboardCommentVO;
import com.project.board.free.FreeboardList;
import com.project.board.free.FreeboardVO;
import com.project.dao.FreeboardDAO;
import com.project.member.MemberVO;

@Controller
@RequestMapping("/free")
public class FreeboardController {

	private static final Logger logger = LoggerFactory.getLogger(FreeboardController.class);

	@Autowired
	private SqlSession sqlSession;

	@RequestMapping("/insert")
	public String insert(HttpServletRequest request, Model model) {
		logger.info("FreeboardController의 insert()");
		return "board/free/insert";
	}

	@RequestMapping("/insertOK")
	public String insertOK(HttpServletRequest request, RedirectAttributes rttr, FreeboardVO freeboardVO, HttpServletResponse response) {
		logger.info("FreeboardController의 insertOK()");
		logger.info("fb_vo" + freeboardVO);
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		메인글을 저장하는 Insert sql 명령을 실행한다.
		mapper.fbInsert(freeboardVO);
		
		rttr.addFlashAttribute("msg", "게시글이 등록되었습니다.");
		
		return "redirect:list";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request, Model model) {
		logger.info("FreeboardController의 list()");
		
//		mapper를 얻어오는 작업
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		한 페이지에 표시할 글의 개수, 브라우저에 표시할 페이지 번호, 전체 글의 개수를 저장한다.
		int pageSize = 10;
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (NumberFormatException e) { }
		int totalCount = mapper.fbSelectCount();
		
		
//		1페이지 분량의 글과 페이징 작업에 사용할 변수를 초기화시킨다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		FreeboardList freeboardList = ctx.getBean("freeboardList", FreeboardList.class);
		freeboardList.initFreeboardList(pageSize, totalCount, currentPage);
		
//		1페이지 분량의 글 목록을 얻어온다.
		HashMap<String, Integer> hmap = new HashMap<String, Integer>();
		hmap.put("startNo", freeboardList.getStartNo());
		hmap.put("endNo", freeboardList.getEndNo());
		freeboardList.setList(mapper.fbSelectList(hmap));
		
//		공지글을 얻어온다.
		ArrayList<FreeboardVO> fb_notice = mapper.fbSelectNotice();
		
//		공지글과 메인글의 댓글 개수를 얻어와서 FreeboardVO 클래스의 commentCount에 저장한다.
		for (FreeboardVO fb_vo : fb_notice) {
			fb_vo.setFb_commentCount(mapper.fbCommentCount(fb_vo.getFb_idx()));
		}
		for (FreeboardVO fb_vo : freeboardList.getList()) {
			fb_vo.setFb_commentCount(mapper.fbCommentCount(fb_vo.getFb_idx()));
		}
		
//		list.jsp로 넘겨줄 데이터를 Model 인터페이스 객체에 넣어준다.
		model.addAttribute("fb_notice", fb_notice);
		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("currentPage", currentPage);
		
		return "board/free/list";
	}
	
	@RequestMapping("/increment")
	public String increment(HttpServletRequest request, Model model) {
		logger.info("FreeboardController의 increment()");
		
//		mapper를 얻어오는 작업
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		조회수를 증가시킬 글 번호를 받는다.
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		
//		조회수를 증가시키는 메소드를 실행한다.
		mapper.fbIncrement(fb_idx);
		
		model.addAttribute("fb_idx", fb_idx);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		
		return "redirect:contentView";
	}
	
	@RequestMapping("/contentView")
	public String contentView(HttpServletRequest request, Model model) {
		logger.info("FreeboardController의 contentView()");
		
//		mapper를 얻어오는 작업
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		조회수를 증가시킨 (화면에 표시할) 글 번호를 받는다.
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		
//		조회수를 증가시킨 글 1건을 얻어와서 freeboardVO 클래스 객체에 저장한다.
		FreeboardVO freeboardVO = mapper.fbSelectByIdx(fb_idx);
		
//		조회수를 증가시킨 글의 댓글 목록을 읽어온다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		FreeboardCommentList freeboardCommentList = ctx.getBean("freeboardCommentList", FreeboardCommentList.class);
		freeboardCommentList.setList(mapper.fbSelectCommentList(fb_idx));
		
//		조회수를 증가시킨 글, 글의 댓글, 작업 후 돌아갈 페이지 번호, 줄바꿈에 사용할 "\r\n"을 Model 인터페이스 객체에
//		넣어주는 작업
		model.addAttribute("fb_vo", freeboardVO);
		model.addAttribute("freeboardCommentList", freeboardCommentList);
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		model.addAttribute("enter", "\r\n");
		
		return "board/free/contentView";
	}
	
	@RequestMapping("/update")
	public String update(HttpServletRequest request, Model model) {
		logger.info("FreeboardController의 update()");
		
//		mapper를 얻어오는 작업
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		수정하고자 하는 글 번호를 받는다.
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		
//		수정하고자 하는 글 1건을 얻어와서 freeboardVO 클래스 객체에 저장한다.
		FreeboardVO freeboardVO = mapper.fbSelectByIdx(fb_idx);
		
//		조회수를 증가시킨 글, 줄바꿈에 사용할 "\r\n"을 Model 인터페이스 객체에 넣어주는 작업
		model.addAttribute("fb_vo", freeboardVO);
		model.addAttribute("enter", "\r\n");
		model.addAttribute("currentPage", request.getParameter("currentPage"));
		
		return "board/free/update";
	}
	
	@RequestMapping("/updateOK")
	public String updateOK(HttpServletRequest request, RedirectAttributes rttr, FreeboardVO freeboardVO, HttpServletResponse response) {
		logger.info("FreeboardController의 updateOK()");
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		
		String url = "contentView?currentPage="+currentPage+"&fb_idx="+fb_idx;
		
//		mapper를 얻어오는 작업
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		글을 수정하는 메소드를 실행한다.
		mapper.fbUpdate(freeboardVO);
		
//		글 수정 작업 후 돌아갈 페이지 번호를 Model 인터페이스 객체에 저장한다.
		
		rttr.addFlashAttribute("msg", "게시글이 성공적으로 수정되었습니다.");
		
		rttr.addAttribute("fb_idx", fb_idx);
		rttr.addAttribute("currentPage", currentPage);
		
		return "redirect:contentView";
	}
	
	@RequestMapping("/deleteOK")
	public String deleteOK(HttpServletRequest request, RedirectAttributes rttr, FreeboardVO freeboardVO, HttpServletResponse response) {
		logger.info("FreeboardController의 deleteOK()");
		
//		mapper를 얻어오는 작업
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		삭제할 글의 글 번호를 가져온다.
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
//		글 1건을 삭제하는 메소드를 실행한다.
		mapper.fbDelete(fb_idx);
		
		rttr.addFlashAttribute("msg", "게시글이 성공적으로 수정되었습니다.");
		
//		글 삭제 작업 후 돌아갈 페이지 번호를 Model 인터페이스 객체에 저장한다.
		rttr.addAttribute("currentPage", currentPage);
		
		return "redirect:list";
	}
	
	@RequestMapping("/commentOK")
	public String commentOK(HttpServletRequest request, RedirectAttributes rttr, FreeboardCommentVO freeboardCommentVO, HttpServletResponse response) {
		logger.info("FreeboardController의 commentOK()");
		logger.info("fbc_vo: " + freeboardCommentVO);
		
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		int mode = Integer.parseInt(request.getParameter("mode"));
		logger.info("mode: " + mode);
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		
		String url = "contentView?currentPage="+currentPage+"&fb_idx="+fb_idx;
		
//		댓글을 저장하는 insert sql 명령을 실행한다.
		if(mode == 1) {
			mapper.fbInsertComment(freeboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 저장에 성공했습니다.");
		} else if (mode == 2) {
			mapper.fbUpdateComment(freeboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 수정에 성공했습니다.");
		} else {
			mapper.fbDeleteComment(freeboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 삭제에 성공했습니다.");
		}
		
		rttr.addAttribute("fb_idx", fb_idx);
		rttr.addAttribute("currentPage", currentPage);
		
		return "redirect:contentView";
	}
	
	@RequestMapping("/insertEmptyChk")
	@ResponseBody
	public String insertEmptyChk(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("FreeboardController의 insertEmptyChk()");
		
		String fb_subject = request.getParameter("fb_subject").trim();
		String fb_content = request.getParameter("fb_content").trim();
		
		if(fb_subject == null || fb_subject.equals("")) {
			response.getWriter().write("1");
			return null;
		}
		
		if(fb_content == null || fb_content.equals("")) {
			response.getWriter().write("2");
			return null;
		}
		if(fb_subject != null || !fb_subject.equals("") || fb_content != null || !fb_content.equals("")) {
			response.getWriter().write("3");
		}
		
		return null;
	}
	
	@RequestMapping("/commentEmptyChk")
	@ResponseBody
	public String commentEmptyChk(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("FreeboardController의 commentEmptyChk()");
		
		String fbc_content = request.getParameter("fbc_content").trim();
		
		if(fbc_content == null || fbc_content.equals("")) {
			response.getWriter().write("1");
			return null;
		} else {
			response.getWriter().write("2");
		}
		
		return null;
	}
	
	

}












