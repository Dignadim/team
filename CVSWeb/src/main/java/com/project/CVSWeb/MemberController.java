package com.project.CVSWeb;

import java.io.IOException;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.board.event.EventboardList;
import com.project.board.free.FreeboardList;
import com.project.dao.EventboardDAO;
import com.project.dao.FreeboardDAO;
import com.project.dao.MemberDAO;
import com.project.member.MemberList;
import com.project.member.MemberVO;

@Controller
@RequestMapping("/member")
public class MemberController {

	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/login")
	public String login(HttpServletRequest request, Model model) {
		logger.info("MemberController의 login()");
		
		return "/logRegi/login_form";
	}
	
	@RequestMapping("/register")
	@ResponseBody
	public String register(HttpServletRequest request, Model model, MemberVO memberVO, HttpServletResponse response) throws IOException {
		logger.info("MemberController의 register()");
		
		String kind = request.getParameter("SvtKind"); // 어떤 일을 할지 넘겨받는다.
		int result;
		String userID;
		String userPSS;
		String userNick;
		String userEmail;
		
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		
//		아이디 체크를 해달라고 정보를 넘겨온 케이스다.
		switch(kind) {
			case "idChk":
				userID = request.getParameter("userID");
			
				memberVO = mapper.mbSearch(userID);
			
//			memberVO가 null이 아니란건 넘겨받은 userID가 DB안에 있었다는 뜻 
//			즉, 중복된 아이디가 존재한다는 뜻이다.
			if(memberVO != null ) {
				result = 0;
			} else {
				result = 1;
			}
			
			if(result == 0) { // 해당 아이디가 존재하는 경우
				response.getWriter().write("0");
			} else if(result == 1) { // 해당 아이디가 존재하지 않는경우
				response.getWriter().write("1");
			}
			break;
			
//			회원가입을 위해 넘어온 체크이다.
			case "regiChk":
				userID = request.getParameter("userID");
				memberVO = mapper.mbSearch(userID);
				
//				vo가 null이 아니란건 넘겨받은 usertID가 DB안에 있었다는 뜻
//				즉, 중복된 아이디가 존재한다는 뜻이다.
				if(memberVO != null) {
					result = 0;
				} else {
					result = 1;
				}
				
//				해당 아이디가 존재하는 경우
				if(result == 0) {
					response.getWriter().write("0");
				}
				
//				중복된 아이디가 존재하지 않으면 나머지 값도 받아서 넣어줌
				userPSS = request.getParameter("userPSS");
				userNick = request.getParameter("userNick");
				userEmail = request.getParameter("userEmail");
				// System.out.println(userPSS);
				memberVO = new MemberVO(userID, userPSS, userNick, userEmail);
				// System.out.println(vo);
				mapper.mbInsert(memberVO);
//				회원가입까지 성공
				response.getWriter().write("1");
				
				break;
		}
	
		return null;
	}
	
	@RequestMapping("/loginOK")
	public String loginOK(HttpServletRequest request, RedirectAttributes rttr, MemberVO memberVO) {
		logger.info("MemberController의 loginOK()");
		
		String action = request.getParameter("action");
		String ogUrl = request.getParameter("ogUrl");
		String referer = request.getHeader("Referer"); // 로그인에 실패했을 때 이동하는 페이지, history.back()과 동일
		String userID = request.getParameter("userID"); // 이용자가 입력한 아이디
		String userPW = request.getParameter("userPW"); // 이용자가 입력한 비밀번호
		
		HttpSession session = request.getSession();
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		
//		login 버튼 클릭 시, 아이디가 입력되었는지 확인하는 과정
		if(action.equals("login") && userID != null && !userID.equals("")) {
			memberVO = mapper.mbSearch(userID.trim());
			if(memberVO != null){
				if(memberVO.getPassword().trim().equals(userPW.trim())) {
					logger.info("로그인 성공");
					session.setAttribute("id", memberVO.getId());
					session.setAttribute("nickname", memberVO.getNickname());
					session.setAttribute("email", memberVO.getEmail());
					session.setAttribute("password", memberVO.getPassword());
					session.setAttribute("signupdate", memberVO.getSignupdate());
					session.setAttribute("grade", memberVO.getGrade());
					rttr.addFlashAttribute("msg", "로그인되었습니다.");
					} else {
						rttr.addFlashAttribute("msg", "비밀번호가 일치하지 않습니다.");
						return "redirect:"+referer;
					}
			} else {
				logger.info("등록되지 않은 아이디");
				rttr.addFlashAttribute("msg", "등록되지 않은 아이디입니다.");
				return "redirect:"+referer;
			}
		} else {
			rttr.addFlashAttribute("msg", "아이디를 입력해주세요.");
			return "redirect:"+referer;
		}
		
		return "redirect:"+ogUrl;
	}
	
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request, RedirectAttributes rttr, MemberVO memberVO) {
		logger.info("MemberController의 logout()");
		
		String ogUrl = request.getHeader("referer");
		// logger.info("ogUrl: " + ogUrl);
		
		HttpSession session = request.getSession();
		
		session.removeAttribute("id");
		session.removeAttribute("nickname");
		session.removeAttribute("password");
		session.removeAttribute("signupdate");
		session.removeAttribute("email");
		session.removeAttribute("grade");
		
		rttr.addFlashAttribute("msg", "로그아웃되었습니다.");
		
		return "redirect:"+ogUrl;
	}
	
	@RequestMapping("/myPage")
	public String myPage(HttpServletRequest request, Model model) {
		logger.info("MemberController의 myPage()");
		
		return "myPage/myPageView";
	}
	
	@RequestMapping("/updateInfo")
	public String updateInfo(HttpServletRequest request, Model model) {
		logger.info("MemberController의 updateInfo()");
		
		return "myPage/changeInformation";
	}
	
	@RequestMapping(value = "/updateInfoOK", method = RequestMethod.POST)
	public String updateInfoOK(HttpServletRequest request, RedirectAttributes rttr, MemberVO memberVO, HttpServletResponse response) throws IOException {
		logger.info("MemberController의 updateInfoOK()");
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		HttpSession session = request.getSession();
		
			String id = request.getParameter("id");
			logger.info("id: " + id);
			mapper.updateInfo(memberVO);
			session.setAttribute("nickname", memberVO.getNickname());
			session.setAttribute("email", memberVO.getEmail());
			session.setAttribute("password", memberVO.getPassword());
			rttr.addFlashAttribute("msg", id + "님의 정보가 수정되었습니다.");
			
		return "redirect:myPage";
	}
	
	@RequestMapping("/admin")
	public String admin(HttpServletRequest request, Model model) {
		logger.info("MemberController의 admin()");
		
		MemberDAO mapperMember = sqlSession.getMapper(MemberDAO.class);
		FreeboardDAO mapperFree = sqlSession.getMapper(FreeboardDAO.class);
		EventboardDAO mapperEvent = sqlSession.getMapper(EventboardDAO.class);
		
		//Adminmember.js 에서 가져온 mode 넘버를 받음
		int mode = 1;
		try{
			mode = Integer.parseInt(request.getParameter("mode"));
		} catch (NumberFormatException e) {
			
		}
		
//		회원관리 memberList 네이밍
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MemberList memberListSort = ctx.getBean("memberList", MemberList.class);
		
		// 신규가입 memberList 네이밍
		AbstractApplicationContext ctx2 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MemberList memberList = ctx2.getBean("memberList", MemberList.class);
		
		FreeboardList freeboardList = ctx.getBean("freeboardList", FreeboardList.class);
		EventboardList eventboardList = ctx.getBean("eventboardList", EventboardList.class);
		
		logger.info("mode: " + mode);
		
//		회원관리란에서 mode대로 memberListSort를 얻어옴.
		if (mode == 1) {
			memberListSort.setList(mapperMember.amSelectList());
		} else if (mode == 2) {
			memberListSort.setList(mapperMember.amSelectAdmin());
		} else if (mode == 3) {
			memberListSort.setList(mapperMember.amSelectNomal());
		} else if (mode == 4){
			memberListSort.setList(mapperMember.amSelectWarning());
		} else { 
			memberListSort.setList(mapperMember.amSelectBlock());
		}
		
//		신규가입란에 넣을 memberList를 얻어옴
		memberList.setList(mapperMember.amSelectList());
		
//		공지란에 넣을 freeboardList와 eventboardList를 얻어옴
		freeboardList.setList(mapperFree.abSelectList());
		eventboardList.setList(mapperEvent.aebSelectList());
		
		model.addAttribute("mode", mode);
		model.addAttribute("memberListSort", memberListSort);
		model.addAttribute("memberList", memberList);
		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("eventboardList", eventboardList);
		
		return "admin/adminView";
	}
	
	@RequestMapping("/management")
	public String management(HttpServletRequest request, Model model, MemberVO memberVO) {
		logger.info("MemberController의 management()");
		
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		
//		모든 멤버 목록을 얻어옴
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MemberList memberList = ctx.getBean("memberList", MemberList.class);
		memberList.setList(mapper.amSelectList());
		
//		id 피라메터값 받아옴
		String id = request.getParameter("id");
		
//		id랑 맞는 정보 가져옴
		memberVO = mapper.mbSearch(id);
		
		model.addAttribute("mb_vo", memberVO);
		
		return "admin/adminPageView";
	}
	
	@RequestMapping("/adminBlock")
	public String adminBlock(HttpServletRequest request, RedirectAttributes rttr, MemberVO memberVO) {
		logger.info("MemberController의 adminBlock()");
		
		int banType = 1;
		try{
			banType = Integer.parseInt(request.getParameter("banType"));
		} catch (NumberFormatException e) {	}
		
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		HttpSession session = request.getSession();
		
//		id 피라메터값 받아옴
		String id = request.getParameter("id");
		
//		id랑 맞는 정보 가져옴
		memberVO = mapper.mbSearch(id);
		
		if(banType == 1) {
			logger.info("1번실행");
			mapper.adminBlockWarning(memberVO);		
		} else if(banType == 2) {
			logger.info("2번실행");
			mapper.adminBlockBlock(memberVO);
		} else if(banType == 3) {
			logger.info("3번실행");
			mapper.adminBlockClear(memberVO);
		}
		
//		수정된 정보를 다시 가져옴
		memberVO = mapper.mbSearch(id);
		
		session.setAttribute("mb_vo", memberVO);
		String url = "management?id="+id.trim();
		
		rttr.addFlashAttribute("msg", "회원 상태가 수정되었습니다.");
		rttr.addAttribute("id", id);
		
		return "redirect:management";
	}
}









