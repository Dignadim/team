package project.controller.CVSWeb;

import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
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

import project.board.admin.AdminDAO;
import project.board.event.EventboardList;
import project.board.free.FreeboardList;
import project.member.MemberList;
import project.member.MemberVO;


@Controller
public class placemanController 
{
	private static final Logger logger = LoggerFactory.getLogger(placemanController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/adminView")
	public String connectadmin(HttpServletRequest request, Model model)
	{
		
		int mode = 1;
		try {
			mode = Integer.parseInt(request.getParameter("mode"));
		} catch (NumberFormatException e){
			
		}
		AdminDAO mapper = sqlSession.getMapper(AdminDAO.class);
//		logger.info("mode: " + mode);

		// 모든 멤버 목록 얻어옴
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");		
		MemberList memberListSort = ctx.getBean("memberList", MemberList.class);
		
		memberListSort.setList(mapper.amSelectList());
		
		if (mode == 2) {
//			logger.info("관리자 회원만");
			memberListSort.setList(mapper.amSelectAdmin());
//			logger.info(memberListSort.getList().toString());
		} else if (mode == 3) {
			memberListSort.setList(mapper.amSelectNomal());
		} else if (mode == 4){
//			logger.info("경고회원");
			memberListSort.setList(mapper.amSelectWarning());
		} else if (mode == 5){ 
			memberListSort.setList(mapper.amSelectBlock());
		}

//		logger.info(memberListSort.getList().toString());

		
		//freeboard 데이터를 freeboardList에 담음
		FreeboardList freeboardList = ctx.getBean("freeList", FreeboardList.class);
		freeboardList.setList(mapper.abSelectList());
	  

		// eventboard 데이터를 eventboardList에 담음
		EventboardList eventboardList = ctx.getBean("eventList", EventboardList.class);
		eventboardList.setList(mapper.aebSelectList());		


//		데이터를 화면에 표시하는 페이지(adminView.jsp)로 넘겨준다.
		model.addAttribute("memberListSort", memberListSort);
		model.addAttribute("freeboardList", freeboardList);
		model.addAttribute("eventboardList", eventboardList);
		model.addAttribute("mode", mode);
		
		return "admin/adminView";
	}
	
	
	
	
	
	@RequestMapping("/connectAdminPageView")
	public String connectAdminPageView(HttpServletRequest request, Model model)
	{
		AdminDAO mapper = sqlSession.getMapper(AdminDAO.class);

		//id 피라메터값 받아옴
		String id = request.getParameter("id");

		//id랑 맞는 정보 가져옴
		MemberVO vo = mapper.selectById(id);

		model.addAttribute("vo", vo);
		
		
		return "admin/adminPageView";
	}
	
	@RequestMapping("/adminBlock")
	public String adminBlock(HttpServletRequest request, Model model)
	{
		String banType = request.getParameter("banType");

		AdminDAO mapper = sqlSession.getMapper(AdminDAO.class);

		//id 피라메터값 받아옴
		String id = request.getParameter("id");
		
		HashMap<String, String> hmap = new HashMap<String, String>();
		hmap.put("id", id);
		hmap.put("banType", banType);
		mapper.adminBlock(hmap);

		// 수정된 vo값을 얻어온다.
		MemberVO vo = mapper.selectById(id);


		model.addAttribute("msg", "수정되었습니다.");
		model.addAttribute("vo", vo);
		
		return "admin/adminPageView";
	}
	
	
	

	@RequestMapping("/myPage")
	public String myPage(HttpServletRequest request, Model model)
	{
		String msg = request.getParameter("msg");
		
		model.addAttribute("msg", msg);
		
		return "myPage/myPageView";
	}
	
	@RequestMapping("/changeInformation")
	public String changeInformation()
	{
		return "myPage/changeInformation";
	}
	
	@RequestMapping("/changeInformationOK")
	public String changeInformationOK(HttpServletRequest request, Model model, MemberVO vo)
	{
		AdminDAO mapper = sqlSession.getMapper(AdminDAO.class);	
		
		mapper.memberUpdate(vo);
		
		HttpSession session = request.getSession();
		session.setAttribute("nickname", vo.getNickname());
		session.setAttribute("email", vo.getEmail());
		session.setAttribute("password", vo.getPassword());
		
		model.addAttribute("msg", vo.getId() + "님의 정보가 수정되었습니다.");
		
//		바로 이동하면 로그아웃시 이전 주소를 요청하는것때문에 changeInformationOK를 요청하게 되고
//		터져버리기에 로그아웃된 경우를 대비해둔 myPage를 요청하게 redirect로 한번 거쳐들어간다.
//		return "myPage/myPageView";
		return "redirect:myPage";
	}
	
}
