package com.project.CVSWeb;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.board.event.EventboardList;
import com.project.board.free.FreeboardList;
import com.project.dao.EventboardDAO;
import com.project.dao.FreeboardDAO;
import com.project.dao.ItemDAO;
import com.project.dao.MemberDAO;
import com.project.item.ItemList;
import com.project.item.ItemVO;
import com.project.item.MyItemList;
import com.project.member.MemberList;
import com.project.member.MemberVO;
import com.project.member.MsgList;
import com.project.member.MsgVO;
import com.project.util.report.ReportList;


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
	@RequestMapping(value = "/loginOK", method = RequestMethod.POST)
	public String loginOK(HttpServletRequest request, RedirectAttributes rttr, MemberVO memberVO) {
		logger.info("MemberController의 loginOK()");
		
		String ogUrl = request.getParameter("ogUrl");
		String userID = request.getParameter("userID"); // 이용자가 입력한 아이디
		String userPW = request.getParameter("userPW"); // 이용자가 입력한 비밀번호
		
		HttpSession session = request.getSession();
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		
		memberVO = mapper.mbSearch(userID.trim());
		
		logger.info("로그인 성공");
		session.setAttribute("id", memberVO.getId());
		session.setAttribute("nickname", memberVO.getNickname());
		session.setAttribute("email", memberVO.getEmail());
		session.setAttribute("password", memberVO.getPassword());
		session.setAttribute("signupdate", memberVO.getSignupdate());
		session.setAttribute("grade", memberVO.getGrade());
		session.setAttribute("image", memberVO.getImage());
		session.setAttribute("introduce", memberVO.getIntroduce());
		rttr.addFlashAttribute("msg", "로그인되었습니다.");
		
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
		session.removeAttribute("image");
		session.removeAttribute("introduce");
		
		rttr.addFlashAttribute("msg", "로그아웃되었습니다.");
		
		if(ogUrl.indexOf("myPage") != -1 || ogUrl.indexOf("admin") != -1
				|| ogUrl.indexOf("updateInfo") != -1) {
			return "redirect:../";
		}
		
		return "redirect:"+ogUrl;
	}
	
	@RequestMapping("/myPage")
	public String myPage(HttpServletRequest request, Model model) {
		logger.info("MemberController의 myPage()");
		
		return "myPage/myPageView";
	}
	
	@ResponseBody

	@RequestMapping(value="/myPageMyItem", produces="application/text; charset=UTF-8")


	public String myPageMyItem(HttpServletRequest request, Model model) {
		logger.info("MemberController의 myPageMyItem()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		String id = request.getParameter("id");
		
		// 얻어온 id에 해당하는 상품 idx 목록을 얻어온다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MyItemList myItemList = ctx.getBean("myItemList", MyItemList.class);
		myItemList.setList(mapper.getMyItem(id));
		
		// 얻어온 상품 idx를 list에 넣어준다.
		List<Integer> idxList = new ArrayList<Integer>();
		
		for (int i = 0; i < myItemList.getList().size(); i++) {
			idxList.add(myItemList.getList().get(i).getItemIdx());
		}
		
		// idx 배열을 가지고 상품 목록들을 얻어온다.
		ItemList itemList = ctx.getBean("itemList", ItemList.class);
		itemList.setList(mapper.getMyItemList(idxList));

		// 테이블에서 검색해서 얻어온 데이터를 json 형식의 문자열로 만든다.
		StringBuffer result = new StringBuffer();
		result.append("{\"result\": ["); // json 시작
		// 데이터의 개수만큼 반복하며 json 형태의 문자열을 만든다.
		for (ItemVO vo : itemList.getList()) {
			result.append("[{\"value\": \"" + vo.getIdx() + "\"},");

//			result.append("{\"value\": \"" + vo.getItemName().trim() + "\"},");

//			result.append("{\"value\": \"" + vo.getItemName().trim() + "\"},"); // 한글 깨짐

			result.append("{\"value\": \"" + vo.getItemImage().trim() + "\"}],");
		}
		result.append("]}"); // json 끝
		
		// StringBuffer 타입의 객체를 String 타입으로 리턴시키기 위해 toString() 메소드를 실행해서 리턴시킨다.
		return result.toString();		
	}
	
	
	



	@RequestMapping(value = "/updateInfo", method = RequestMethod.POST)

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
			
			mapper.updateInfo(memberVO);
			session.setAttribute("nickname", memberVO.getNickname());
			session.setAttribute("email", memberVO.getEmail());
			session.setAttribute("password", memberVO.getPassword());
			session.setAttribute("image", memberVO.getImage());
			session.setAttribute("introduce", memberVO.getIntroduce());
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
		ReportList reportList = ctx.getBean("reportList", ReportList.class);
		
		logger.info("mode: " + mode);
		
		String id = request.getParameter("id");
		
//		회원관리란에서 mode대로 memberListSort를 얻어옴.
		if (mode == 1) {
			memberListSort.setList(mapperMember.amSelectList());
		} else if (mode == 2) {
			memberListSort.setList(mapperMember.amSelectAdmin());
		} else if (mode == 3) {
			memberListSort.setList(mapperMember.amSelectNomal());
		} else if (mode == 4){
			memberListSort.setList(mapperMember.amSelectBlock());
		} else if (mode == 5) {
			memberListSort.setList(mapperMember.msrch(id));			
		}
		
//		신규가입란에 넣을 memberList를 얻어옴
		memberList.setList(mapperMember.amSelectList());
		
//		공지란에 넣을 freeboardList와 eventboardList를 얻어옴
		freeboardList.setList(mapperFree.abSelectList());
		eventboardList.setList(mapperEvent.aebSelectList());
		
		reportList.setList(mapperMember.rpSelectList());
		
		model.addAttribute("mode", mode);
		model.addAttribute("memberListSort", memberListSort);
		model.addAttribute("memberList", memberList);
		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("eventboardList", eventboardList);
		model.addAttribute("reportList", reportList);
		
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
		
//		id 파라미터값 받아옴
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
			mapper.adminBlockBlock(memberVO);	
		} else {
			logger.info("2번실행");
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
	
	@RequestMapping("/loginChk")
	@ResponseBody
	public String loginChk(HttpServletRequest request, Model model, HttpServletResponse response, MemberVO memberVO) throws IOException {
		logger.info("MemberController의 loginChk()");
		
		String userID = request.getParameter("userID").trim();
		String userPW = request.getParameter("userPW").trim();
		
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		
		// 입력창에 아이디 또는 비밀번호가 입력되지 않은 경우
		if(userID == null || userID.equals("") || userPW == null || userPW.equals("")) {
			response.getWriter().write("1");
			return null;
		} else { // 입력창에 아이디, 비밀번호가 입력이 된 경우
			memberVO = mapper.mbSearch(userID.trim()); // 입력한 아이디와 같은 아이디가 VO 안에 있는지 검색
			// VO 안에 입력한 아이디가 없는 경우 즉, 회원가입된 아이디가 아닌 경우
			if (memberVO == null) {
				response.getWriter().write("2");
				return null;
			} else { // VO 안에 입력한 아이디가 존재하는 경우 즉, 회원가입이 되어있는 아이디인 경우
				// 검색한 아이디로 select한 VO의 비밀번호와 입력한 비밀번호가 다른 경우 
				if (!memberVO.getPassword().trim().equals(userPW.trim())) {
					response.getWriter().write("3");
					return null;	
				} else { // 검색한 아이디로 select한 VO의 비밀번호와 일치한 경우
					response.getWriter().write("4");
				}
			}
		}
		
		return null;
	}

	
	@RequestMapping("/profileUpdate")
	@ResponseBody
	public String profileUpdate(HttpServletRequest request, HttpServletResponse response, MultipartHttpServletRequest mRequest) throws Exception {
		MultipartFile image = mRequest.getFile("image");
		String fileRealname = image.getOriginalFilename();
		long size = image.getSize();
		
//		System.out.println("파일명: " + fileRealname);
//		System.out.println("용량크기(byte): " + size);
		
		String fileExtension = fileRealname.substring(fileRealname.lastIndexOf("."),fileRealname.length()); // 파일확장자명
		String uploadFolder = "/Users/mac/STS/workspace/CVSWeb/src/main/webapp/WEB-INF/userProfile"; // 업로드할 폴더 위치
		
//		System.out.println("파일 확장자명: " + fileExtension);
		
		UUID uuid = UUID.randomUUID();
		String uuids[] = uuid.toString().split("-");
		
		String uniqueName = uuids[0];
//		System.out.println("생성된 파일이름: " + uniqueName);
		
		File saveFile = new File(uploadFolder + "/" + uniqueName + fileExtension);
//		System.out.println(saveFile);
		
		String link = "../userProfile/"+uniqueName+fileExtension;
		
		try {
			image.transferTo(saveFile); // transferTo(): 파일 저장 메서드
			response.getWriter().write(link);
		} catch (IllegalStateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}	
		
		return null;
	}



	@RequestMapping("/profileView")
	public String profileView(HttpServletRequest request, Model model) {
		logger.info("MemberController의 profileView()");
		
		String id = request.getParameter("id");
		
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		MemberVO vo = mapper.mbSearch(id);
		
		model.addAttribute("vo", vo);
		return "myPage/profileView";
	}
	
	@RequestMapping("/goMsg")
	public String goMsg(HttpServletRequest request, Model model, MsgVO msgVO) {
		logger.info("MemberController의 goMsg()");
		
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		mapper.goMsg(msgVO);
		
		model.addAttribute("id", msgVO.getFid());
		return "redirect:profileView";
	}

	@RequestMapping("/msgBox")
	public String msgBox(HttpServletRequest request, Model model) {
		logger.info("MemberController의 msgBox()");
		
		String id = request.getParameter("id");

		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		AbstractApplicationContext ctx2 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		AbstractApplicationContext ctx3 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");

		// 현재 로그인한 아이디로 온 쪽지 목록을 받아온다.
		MsgList msgList = ctx.getBean("msgList", MsgList.class);
		msgList.setList(mapper.getMsg(id));
		
		// 현재 로그인한 아이디로 보낸 쪽지 목록을 받아온다.
		MsgList toList = ctx2.getBean("msgList", MsgList.class);
		toList.setList(mapper.getToMsg(id));

		// 현재 로그인한 아이디의 휴지통 목록을 받아온다.
		MsgList trashList = ctx3.getBean("msgList", MsgList.class);
		trashList.setList(mapper.getTrashMsg(id));
		
		model.addAttribute("msgList", msgList);
		model.addAttribute("toList", toList);
		model.addAttribute("trashList", trashList);
		
		return "myPage/msgBox";
	}
	
	@RequestMapping("/goTrash")
	public String goTrash(HttpServletRequest request, Model model, MsgVO msgVO) {
		logger.info("MemberController의 goTrash()");
		String id = request.getParameter("id");
		int mode = Integer.parseInt(request.getParameter("mode"));
		
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		
		// 먼저 누군가가 해당 메시지를 휴지통에 넣은 적 있는지 확인한다.
		int ifTrash = mapper.getIfTrash(msgVO.getMsgIdx());
		if (ifTrash > 0) {
			// 누군가가 휴지통에 넣은 적 있으므로 trash 컬럼에서 id 값만은 가져온다.
			String trashId = mapper.getTrashId(msgVO.getMsgIdx());
			trashId = trashId.replace(id, "").replace("(", "").replace(")", "").replace(",", "").trim();
			
			// 얻어온 trashId와 jsp에서 넘어온 id를 배열로 만든다.
			List<String> list = new ArrayList<String>();
			list.add(trashId);
			list.add(id);
			
			msgVO.setList(list);
			
			// 배열로 만든 id를 다시 넣어준다.
			mapper.goTrashList(msgVO);
			
		} else {
			// 아무도 휴지통에 넣은 적 없으므로 바로 id값을 데이터에 넣어준다.	
			// mode가 1이면 받은 편지함에서 휴지통에 넣는 것이므로 id를 fid에, 2면 보낸 편지함에서 휴지통에 넣는 것이므로 id를 mid에 넣는다. 
			if (mode == 1) {
				msgVO.setFid(id);
			} else {
				msgVO.setMid(id);				
			}
			
			mapper.goTrash(msgVO);
		}
		
		model.addAttribute("id", id);
		
		return "redirect:msgBox";
	}
	
	@RequestMapping("/recover")
	public String recover(HttpServletRequest request, Model model, MsgVO msgVO) {
		logger.info("MemberController의 recover()");
		
		String id = request.getParameter("id");
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);

		// 해당 메시지를 휴지통에 넣은 적 있는 닉네임들을 가져온다.
		String ifTrash2 = mapper.getTrashId2(msgVO.getMsgIdx());
		
		// 가져온 닉네임 목록에서, 지울 id값을 replace로 지우고 값을 다시 넣어준다.
		msgVO.setTrash(ifTrash2.replace(id, "").replace("(", "").replace(")", "").replace(",", "").trim());
		mapper.recover(msgVO);
		
		model.addAttribute("id", id);
		
		return "redirect:msgBox";
	}
	
	@ResponseBody
	@RequestMapping("/isAdmin")
	public String isAdmin(HttpServletRequest request, Model model) {
		logger.info("MemberController의 isAdmin()");

		String id = request.getParameter("id");
		System.out.println(id);
		MemberDAO mapper = sqlSession.getMapper(MemberDAO.class);
		
		// 만약 얻어온 아이디의 grade 권한이 관리자면 1, 아니면 2를 보낸다.
		String isAdmin = mapper.isAdmin(id);
		if (isAdmin.equals("y")) {
			return "1";
		} else {
			return "2";			
		}

	}
	
}