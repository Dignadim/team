package project.controller.CVSWeb;

import java.util.ArrayList;

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
import org.springframework.web.bind.annotation.ResponseBody;

import project.board.admin.AdminDAO;
import project.board.event.EventboardDAO;
import project.board.event.EventboardVO;
import project.board.free.FreeboardDAO;
import project.board.free.FreeboardVO;
import project.item.ItemDAO;
import project.item.ItemVO;
import project.member.MemberVO;
import project.util.calendar.ScheduleManager;

@Controller
public class MainCotroller 
{
	private static final Logger logger = LoggerFactory.getLogger(MainCotroller.class);

	@Autowired
	private SqlSession sqlSession;
	
//	처음 실행되면 main페이지로 가게 해준다.
	@RequestMapping("/")
	public String home(HttpServletRequest request, Model model) 
	{
//		logger.info("main()");
		return "redirect:main";
	}
	
//	main 호출을 받으면 필요한 정보들을 저장해서 model로 넘겨준다.
	@RequestMapping("/main")
	public String main(HttpServletRequest request, Model model)
	{
		// 현재 행사 목록을 찾아와서 저장한다.
//		EventboardList evList = sqlSession.getMapper(EventboardDAO.class).selectEVList();
		ArrayList<EventboardVO> evList = sqlSession.getMapper(EventboardDAO.class).selectEVList();
		
		// 현재 행사 상품 최신순으로 10개를 찾아와서 저장한다.
		ArrayList<ItemVO> eventItemList = sqlSession.getMapper(ItemDAO.class).selectEventItemList();
		
		// 인기상품 탑 5를 가져와서 저장한다.
		ArrayList<ItemVO> itemTOP5 = sqlSession.getMapper(ItemDAO.class).selectItemTOP5();
		
		// 인기 게시글 탑 3을 가져와서 저장한다.
		ArrayList<FreeboardVO> freeHitList = sqlSession.getMapper(FreeboardDAO.class).selectFreeHitList();
		
		// 데이터를 model로 넘긴다.
		model.addAttribute("evList", evList);
		model.addAttribute("eventItemList", eventItemList);
		model.addAttribute("itemTOP5", itemTOP5);
		model.addAttribute("freeHitList", freeHitList);
		
		return "main";
	}
	
//	달력을 요청하면 달력페이지를 위한 정보를 담아서 넘겨준다.
	@RequestMapping("/calendar")
	public String calendar(Model model)
	{
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);
		
//		logger.info("달력을 요청함");
		ScheduleManager scheduleManager = ScheduleManager.getInstance();
		scheduleManager.setList(mapper.initSchedList());
//		logger.info("스케줄 매니저를 받아옴");
		
		model.addAttribute("list", scheduleManager.getList());
		
		return "util/calendar/calendar";
	}
	
//	로그인 창으로 이동한다.
	@RequestMapping("/login_form")
	public String login_form(HttpServletRequest request, Model model, MemberVO meberVO)
	{
//		넘어온 곳의 url을 저장한다.
		String ogUrl = request.getHeader("referer");
		
		try
		{
//			ogUrl이 request에 담겨져있었다는건 로그인이 실패해서 넘어온거니 받아서 넣어준다.
			String url = request.getParameter("ogUrl").trim();
			ogUrl = url;
		}
		catch (Exception e) 
		{
		}
		
		
		model.addAttribute("ogUrl", ogUrl);
		
		return "logRegi/login_form";
	}
	
//	로그인 창으로 이동한다.
	@RequestMapping("/login_control")
	public String login_control(HttpServletRequest request, Model model)
	{
		
//		logger.info("로그인창" + request.getParameter("ogUrl"));
		
//		세션과 입력한 id password 돌아갈 ogUrl등을 미리 받아둔다.
		HttpSession session = request.getSession();
		String ogUrl = request.getParameter("ogUrl").trim();
		String id = request.getParameter("id").trim();
		String password = request.getParameter("password").trim();
		model.addAttribute("ogUrl", ogUrl);
			
//		아이디 비번체크를 해서
		if(id != null && id != "")
		{
			AdminDAO mapper = sqlSession.getMapper(AdminDAO.class);
//			입력받은 id로 DB에 있는지 찾고
			MemberVO vo = mapper.mbSearch(id);
//			id가 존재하면
			if(vo != null)
			{
		 		if(vo.getId().equals(id))
		 		{
//			 			아이디 비번이 둘다 DB에 있으면
					if(vo.getPassword().trim().equals(password))
					{
						model.addAttribute("msg", "로그인되었습니다.");
						model.addAttribute("result", "success");
						session.setAttribute("id", vo.getId());
						session.setAttribute("nickname", vo.getNickname());
						session.setAttribute("email", vo.getEmail());
						session.setAttribute("password", vo.getPassword());
						session.setAttribute("signupdate", vo.getSignupdate());
						session.setAttribute("grade", vo.getGrade());
						return "logRegi/login_result";
					}
					else
					{
						model.addAttribute("msg", "비밀번호가 틀렸습니다.");
						model.addAttribute("result", "fail");
						return "logRegi/login_result";
					}
				}
			}
//			아이디가 없으면
			else
			{
				model.addAttribute("msg", "아이디가 틀렸습니다.");
				model.addAttribute("result", "fail");
				return "logRegi/login_result";
			}
		}
//		입력한 아이디칸이 비어있으면
		else
		{
			model.addAttribute("msg", "아이디를 입력해주세요.");
			model.addAttribute("result", "fail");
			return "logRegi/login_result";
		}
		
		return "";
		
	}
	
	@RequestMapping("/login_out")
	public String login_out(HttpServletRequest request, Model model)
	{
		HttpSession session = request.getSession();
		
//		넘어온 곳의 url을 저장한다.
		String ogUrl = request.getHeader("referer");
		
//		session에 저장된 회원정보를 지워준다.
		session.removeAttribute("id");
		session.removeAttribute("nickname");
		session.removeAttribute("password");
		session.removeAttribute("signupdate");
		session.removeAttribute("email");
		session.removeAttribute("grade");
		
//		alert 창에 띄울 메시지랑 돌아갈 주소를 넣어서
		model.addAttribute("msg", "로그아웃되었습니다.");
		model.addAttribute("ogUrl", ogUrl);
		model.addAttribute("result", "logout");
		
//		jsp로 돌려보낸다.
		return "logRegi/login_result";
	}
	
	@RequestMapping("/register")
	@ResponseBody
	public String register(HttpServletRequest request, Model model)
	{
//		 logger.info("register");
			
		//	어떤일을 할지 넘겨받는다.
		String kind = request.getParameter("SvtKind");
		String result;
		String userID;
		String userPSS;
		String userNick;
		String userEmail;
		
//		logger.info("kind: " + kind);
		
		AdminDAO mapper = sqlSession.getMapper(AdminDAO.class);
		MemberVO vo = null;
//			넘겨받은 아이디를 받는다.
		userID = request.getParameter("userID");
		
		//	아이디 체크를 해달라고 정보를 넘겨온 케이스다.
		if(kind.equals("idChk"))
		{
//			logger.info("idChk 처리문");
//			넘겨받은 아이디로 db에 정보가 있는지 확인
			vo = mapper.mbSearch(userID);
			
			//	vo가 null이 아니란건 넘겨받은 userID가 DB안에 있었다는 뜻
			//	중복된 아이디가 존재한다는 뜻이다.
			if(vo != null )
			{
				result = "0";
			}
			else
			{
//				logger.info("사용가능한 아이디라고 판별함");
				result = "1";
			}
			
//			결과에 대해서 js로 넘겨줌
			
			return result;
		}
			
	//	회원가입을 위해 넘어온 체크이다.
		else if(kind.equals("regiChk"))
		{
			vo = mapper.mbSearch(userID);
			
			//	vo가 null이 아니란건 넘겨받은 usertID가 DB안에 있었다는 뜻
			//	중복된 아이디가 존재한다는 뜻이다.
			if(vo != null )
			{
				result = "0";
			}
			else
			{
				result = "1";
			}
			
			//	해당 아이디가 존재하는 경우
			if(result == "0")
			{
				return result;
			}
			
			//	중복된 아이디가 존재하지 않으면 나머지 값도 받아서 넣어줌
			userPSS = request.getParameter("userPSS");
			userNick = request.getParameter("userNick");
			userEmail = request.getParameter("userEmail");
			AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
			vo = ctx.getBean("memberVO", MemberVO.class);
//			나머지 값들을 꽂은 memberVO를 만들어서
			vo.init(userID, userPSS, userNick, userEmail);
//			DB로 넘겨서 추가해주라고 한다.
			mapper.mbInsert(vo);
//			회원가입에 성공했으니 해당 result를 넘겨준다.
			return result;
			
		}
		return "";
			
				
				
				
			
	}

	
}
