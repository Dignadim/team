package com.project.CVSWeb;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
//		logger.info(freeboardCommentVO+"");
		
//		mapper를 얻어오는 작업
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		조회수를 증가시킨 (화면에 표시할) 글 번호를 받는다.
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		int fbc_idx = 0;
		
//		조회수를 증가시킨 글 1건을 얻어와서 freeboardVO 클래스 객체에 저장한다.
		FreeboardVO freeboardVO = mapper.fbSelectByIdx(fb_idx);
		
//		조회수를 증가시킨 글의 댓글 목록을 읽어온다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		FreeboardCommentList freeboardCommentList = ctx.getBean("freeboardCommentList", FreeboardCommentList.class);
		freeboardCommentList.setList(mapper.fbSelectCommentList(fb_idx));
		// logger.info(freeboardCommentList+"");
		
		
//		댓글 목록에 있는 댓글의 idx만 따로 빼서 해당 댓글의 대댓글 목록을 읽어온다.
		AbstractApplicationContext ctx2 = new GenericXmlApplicationContext("classpath:applicationCTX.xml"); //  freeboardCommentList와 겹쳐지게 될 수 있으므로 ctx를 새로 만들어 사용한다.
		FreeboardCommentList replyCommentList = ctx2.getBean("freeboardCommentList", FreeboardCommentList.class); 
		
		for(FreeboardCommentVO freeboardCommentVO : freeboardCommentList.getList()) {
			fbc_idx = freeboardCommentVO.getFbc_idx();
			replyCommentList.addList(mapper.fbReplyCommentList(fbc_idx));
			// 댓글의 대댓글 개수를 얻어와서 FreeboardVO 클래스의 commentCount에 저장한다.
			freeboardCommentVO.setReplyCount(mapper.fbReplyCount(fbc_idx));
		}
		
		
//		조회수를 증가시킨 글, 글의 댓글, 작업 후 돌아갈 페이지 번호, 줄바꿈에 사용할 "\r\n"을 Model 인터페이스 객체에
//		넣어주는 작업
		model.addAttribute("fb_vo", freeboardVO);
		model.addAttribute("freeboardCommentList", freeboardCommentList);
		model.addAttribute("replyCommentList", replyCommentList);
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
		
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		int mode = Integer.parseInt(request.getParameter("mode"));
		// logger.info("mode: " + mode);
		
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		int fb_idx = Integer.parseInt(request.getParameter("fb_idx"));
		
		freeboardCommentVO.setId(request.getParameter("id"));
		freeboardCommentVO.setNickname(request.getParameter("nickname"));
		
//		댓글을 저장하는 insert sql 명령을 실행한다.
		if(mode == 1) {
			mapper.fbInsertComment(freeboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 저장에 성공했습니다.");
		} else if (mode == 2) {
			mapper.fbUpdateComment(freeboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 수정에 성공했습니다.");
		} else if (mode == 3) {
			mapper.fbDeleteComment(freeboardCommentVO);
			rttr.addFlashAttribute("msg", "댓글이 삭제에 성공했습니다.");
		} else {
			mapper.fbReplyInsert(freeboardCommentVO);
			rttr.addFlashAttribute("msg", "답글 저장에 성공했습니다.");
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
	
//	답글 버튼을 누르면 토글처럼 대댓글리스트, 대댓글 입력창이 나오게 해주는 함수
	@RequestMapping("/commentReply")
	@ResponseBody
	public String commentReply(HttpServletRequest request, Model model, HttpServletResponse response) throws IOException {
		logger.info("FreeboardController의 commentReply()");
		
		String replySwitch = request.getParameter("replySwitch").trim();
		
		if(replySwitch.equals("off")) {
			response.getWriter().write("1");
			return null;
		} else {
			response.getWriter().write("2");
		}
		
		return null;
	}
	
//	대댓글을 칸에 빈칸이 있는지 확인하는 함수
	@RequestMapping("/replyInsert")
	@ResponseBody
	public String replyInsert(HttpServletRequest request, RedirectAttributes rttr, HttpServletResponse response, FreeboardCommentVO freeboardCommentVO) throws IOException {
		logger.info("FreeboardController의 replyInsert()");
		
		FreeboardDAO mapper = sqlSession.getMapper(FreeboardDAO.class);
		
//		대댓글 입력칸이 공란인지 확인하기 위해 reply_content를 받아온다.
		String reply_content = request.getParameter("reply_content");
		
		// 대댓글이 null 또는 아무것도 입력 안될 시
		if(reply_content == null || reply_content.equals("")) {
			response.getWriter().write("1");
			return null;
		} else {
			response.getWriter().write("2");
		}
		
		return null;
	}
	

}












