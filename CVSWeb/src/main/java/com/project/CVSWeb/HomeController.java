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

import com.project.board.event.EventManager;
import com.project.board.event.EventboardList;
import com.project.board.free.FreeboardList;
import com.project.dao.EventboardDAO;
import com.project.dao.ItemDAO;
import com.project.item.ItemList;
import com.project.item.ItemVO;
import com.project.map.MapManager;
import com.project.util.calendar.ScheduleManager;

@Controller
public class HomeController {
	
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
		
		
		return "map/map";
	}
	
}
