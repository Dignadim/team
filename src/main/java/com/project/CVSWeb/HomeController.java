package com.project.CVSWeb;

import java.util.ArrayList;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.project.board.event.EventboardList;
import com.project.board.free.FreeboardList;
import com.project.dao.EventboardDAO;
import com.project.dao.ItemDAO;
import com.project.dao.MapDAO;
import com.project.item.ItemList;
import com.project.map.AddressVO;
import com.project.map.MapManager;
import com.project.map.MapParam;
import com.project.map.MapVO;
import com.project.util.calendar.ScheduleManager;
import com.project.util.calendar.ScheduleVO;

@Controller
public class HomeController{
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/")
	public String main(HttpServletRequest request, Model model) {
		logger.info("HomeController의 main()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		AbstractApplicationContext ctx1 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		EventboardList evList = ctx1.getBean("eventboardList", EventboardList.class);
		ItemList eventItemList  = ctx1.getBean("itemList", ItemList.class);
		FreeboardList freeHitList = ctx1.getBean("freeboardList", FreeboardList.class);
		
		AbstractApplicationContext ctx2 = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList itemTOP5  = ctx2.getBean("itemList", ItemList.class);
		
//		현재 행사 목록을 찾아와서 저장한다.
		evList.setList(mapper.selectEVList());
		
//		현재 행사 상품 최신순으로 10개를 찾아와서 저장한다.
		eventItemList.setList(mapper.selectEventItemList());
		
//		인기상품 탑 5를 가져와서 저장한다.
		itemTOP5.setList(mapper.selectItemTOP5());
		
//		인기 게시글 탑 3을 가져와서 저장한다.
		freeHitList.setList(mapper.selectFreeHitList());
		
//		데이터를 model로 넘긴다.
		model.addAttribute("evList", evList);
		model.addAttribute("eventItemList", eventItemList);
		model.addAttribute("itemTOP5", itemTOP5);
		model.addAttribute("freeHitList", freeHitList);
		
		return "main";
	}
	
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
	
	@RequestMapping("/map")
	public String map(Model model) {
		logger.info("HomeController의 map()");
		
		return "map/map";
	}
	
	@RequestMapping("/mapCrawling")
	public String mapCrawling(RedirectAttributes rttr) {
		logger.info("HomeController의 mapCrawling()");
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		MapManager mapManager = ctx.getBean("mapManager", MapManager.class);
		
		// gs25와 세븐일레븐은 리스트까지는 정상적으로 얻어오지만 입력하는 도중에 매장 수가 너무 많아서 DB와의 연결이 끊기는 걸로 추정 
		//		=> 3000개 정도씩 나눠서 입력했더니 정상 입력 확인
		// java.sql.SQLRecoverableException: 소켓에서 읽을 데이터가 없습니다
		
		try {
			
			// 시간 측정을 위한 코드
			long start1 = System.currentTimeMillis();
			
			ArrayList<MapVO> list = mapManager.getCspaceMap(); // 리스트에 cspace 지도 정보를 추가한다.
			System.out.println("씨스페이스 성공");
			list.addAll(mapManager.getCUMap()); // 리스트에 CU 지도 정보를 추가한다.
			System.out.println("씨유 성공");
			list.addAll(mapManager.getGS25Map()); // 리스트에 GS25 지도 정보를 추가한다.
			System.out.println("지에스 성공");
			list.addAll(mapManager.getSevenElevenMap()); // 리스트에 세븐일레븐 지도 정보를 추가한다.
			System.out.println("세븐일레븐 성공");
			list.addAll(mapManager.getMinistopMap()); // 리스트에 ministop 지도 정보를 추가한다.
			System.out.println("미니스톱 성공");
			list.addAll(mapManager.getEmart24Map()); // 리스트에 이마트24 지도 정보를 추가한다.
			System.out.println("이마트24 성공");
			logger.info("지도 정보 크롤링 완료!");
	
			long end1 = System.currentTimeMillis();
			System.out.println("크롤링 시간: " + (end1 - start1)/1000. + "초");		
			
			MapDAO mapper = sqlSession.getMapper(MapDAO.class);
	
			// 리스트의 양이 너무 많으므로 3000개씩 끊은 리스트를 담는 리스트를 만든다.
			ArrayList<ArrayList<MapVO>> blist = new ArrayList<ArrayList<MapVO>>();
			// 반복문으로 blist에 list를 넣어준다.
			for (int i = 0; i < list.size(); i += 3000) {
				if (i + 3000 < list.size()) {
					blist.add(new ArrayList<>(list.subList(i, i+3000)));							
				} else {
					blist.add(new ArrayList<>(list.subList(i, list.size()-1)));							
				}
			}
	
			// 시간 측정을 위한 코드
			long start2 = System.currentTimeMillis();		
			
			for (int i = 0; i < list.size() / 3000 + 1; i++) {
				try {
					// 리스트에 있는 지도 정보를 나눠서 입력한다.
					mapper.autoMapInsert(blist.get(i));		
				} catch (Exception e) {
					break;
				}
			}
	
			long end2 = System.currentTimeMillis();
			System.out.println("DB 입력 시간: " + (end2 - start2)/1000. + "초");
	
			logger.info("모든 지도 정보 입력 완료!");
		} catch (NullPointerException e) {
			System.out.println("NullPointerException 발생! 메소드를 재실행합니다.");
			mapCrawling(rttr);
		}
		
		rttr.addFlashAttribute("msg", "자동 지도 등록에 성공했습니다.");		
		
		return "map/map";
	}
	
	@ResponseBody
	@RequestMapping(value="/selectSido", produces = "application/text; charset=UTF-8")
	public String selectSido(HttpServletRequest request) {
		logger.info("HomeController의 selectSido()");
		String sido = request.getParameter("sido").trim();
		
		MapDAO mapper = sqlSession.getMapper(MapDAO.class);
		ArrayList<AddressVO> list = mapper.getGugun(sido);
		
		// 테이블에서 검색해서 얻어온 데이터를 json 형식의 문자열로 만든다.
		StringBuffer result = new StringBuffer();
		
		result.append("{\"result\": ["); // json 시작
		// 데이터의 개수만큼 반복하며 json 형태의 문자열을 만든다.
		for (AddressVO vo : list) {
			result.append("[{\"value\": \"" + vo.getSido() + "\"},");
			result.append("{\"value\": \"" + vo.getGugun() + "\"}],");
		}
		result.append("]}"); // json 끝
		
		// StringBuffer 타입의 객체를 String 타입으로 리턴시키기 위해 toString() 메소드를 실행해서 리턴시킨다.
		return result.toString();	
	}
	
	@ResponseBody
	@RequestMapping(value="/searchAdd", produces = "application/text; charset=UTF-8")
	public String searchAdd(HttpServletRequest request, MapParam mapParam) {
		logger.info("HomeController의 searchAdd()");
				
		MapDAO mapper = sqlSession.getMapper(MapDAO.class);	
		
		ArrayList<MapVO> list = mapper.searchAdd(mapParam);
		
		StringBuffer result = new StringBuffer();
		
		result.append("{\"result\": [");

		for (MapVO vo : list) {
			result.append("[{\"value\": \"" + vo.getAddress() + "\"},");
			result.append("{\"value\": \"" + vo.getStoreName() + "\"},");
			result.append("{\"value\": \"" + vo.getWhichCVS() + "\"}],");
		}
		result.append("]}");
		
		return result.toString();	
	}

	@ResponseBody
	@RequestMapping(value="/detailedSchedule", produces = "application/text; charset=UTF-8")
	public String detailedSchedule(HttpServletRequest request, ScheduleVO scheduleVO) {
		
		EventboardDAO mapper = sqlSession.getMapper(EventboardDAO.class);

		// 기간이 있는 행사만 가져온다.
		ArrayList<ScheduleVO> list = mapper.detailedSchedule(scheduleVO);
		// 기간이 없는 행사만 가져온다.
		list.addAll(mapper.detailedSchedule2(scheduleVO));
		
		StringBuffer result = new StringBuffer();		
		result.append("{\"result\": [");
		for (ScheduleVO vo : list) {
			result.append("[{\"value\": \"" + vo.getCVS() + "\"},");
			result.append("{\"value\": \"" + vo.getsYear() + "\"},");
			result.append("{\"value\": \"" + vo.getsMonth() + "\"},");
			result.append("{\"value\": \"" + vo.getsDay() + "\"},");
			result.append("{\"value\": \"" + vo.geteYear() + "\"},");
			result.append("{\"value\": \"" + vo.geteMonth() + "\"},");
			result.append("{\"value\": \"" + vo.geteDay()+ "\"},");
			result.append("{\"value\": \"" + vo.getEvent()  + "\"}],");					
		}
		result.append("]}");
		return result.toString();	

	}
	
}
