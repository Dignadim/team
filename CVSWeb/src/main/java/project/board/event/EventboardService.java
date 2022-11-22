package project.board.event;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import project.mybatis.MySession;

public class EventboardService {

	private static EventboardService instance = new EventboardService();
	private EventboardService() { }
	public static EventboardService getInstance() {
		return instance;
	}
	
	public void evInsert(EventboardVO ev_vo) {
		System.out.println("EventboardService의 evInsert() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardDAO.getInstance().evInsert(mapper, ev_vo);
		mapper.commit();
		mapper.close();
	}
	
	public EventboardList evSelectList(int currentPage) {
		System.out.println("EventboardService의 evSelectCount() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardDAO ev_dao = EventboardDAO.getInstance();
		
		int pageSize = 10;
		int totalCount = ev_dao.evSelectCount(mapper);
		
		EventboardList EventboardList = new EventboardList(pageSize, totalCount, currentPage);
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", EventboardList.getStartNo());
		hmap.put("endNo", EventboardList.getEndNo());
		EventboardList.setList(ev_dao.evSelectList(mapper, hmap));
		
		mapper.close();
		return EventboardList;
	}
	
	public void evIncrement(int ev_idx) {
		System.out.println("EventboardService의 evIncrement() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardDAO.getInstance().evIncrement(mapper, ev_idx);
		mapper.commit();
		mapper.close();
	}
	
	public EventboardVO evSelectByIdx(int ev_idx) {
		System.out.println("EventboardService의 evSelectByIdx() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardVO vo = EventboardDAO.getInstance().evSelectByIdx(mapper, ev_idx);
		mapper.close();
		return vo;
	}
	
	public void evDelete(int ev_idx) {
		System.out.println("EventboardService의 evDelete() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardDAO.getInstance().evDelete(mapper, ev_idx);
		mapper.commit();
		mapper.close();
	}
	
	public void evUpdate(EventboardVO ev_vo) {
		System.out.println("EventboardService의 evUpdate() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardDAO.getInstance().evUpdate(mapper, ev_vo);
		mapper.commit();
		mapper.close();
	}
	
	public ArrayList<EventboardVO> evSelectNotice() {
		System.out.println("EventboardService의 evSelectNotice() 메소드");
		SqlSession mapper = MySession.getSession();
		ArrayList<EventboardVO> ev_notice = EventboardDAO.getInstance().evSelectNotice(mapper);
		mapper.close();
		return ev_notice;
	}
	
	public EventboardList evSelectListCategory(int currentPage, String category) {
		System.out.println("EventboardService의 evSelectListCategory() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		int pageSize = 10;
		// 카테고리에 따른 검색어가 포함되었나 조건을 세워야하기 때문에 Param 클래스 객체를 사용한다.
		EventboardDAO dao = EventboardDAO.getInstance();
		Param param = new Param();
		param.setCategory(category.trim());
		// System.out.println(category.trim());
		int totalCount = dao.evSelectCountCategory(mapper, param);
		EventboardList eventboardList = new EventboardList(pageSize, totalCount, currentPage);
		param.setStartNo(eventboardList.getStartNo());
		param.setEndNo(eventboardList.getEndNo());
		eventboardList.setList(dao.evSelectListCategory(mapper, param));
		System.out.println(eventboardList);
		return eventboardList;
	}
	
	public EventboardList evSelectListMulti(int currentPage, String category, String searchText) {
		System.out.println("EventboardService의 evSelectListCategory() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		int pageSize = 10;
		// 검색어 및 카테고리에 따른 검색어가 포함되었나 조건을 세워야하기 때문에 Param 클래스 객체를 사용한다.
		EventboardDAO dao = EventboardDAO.getInstance();
		System.out.println(searchText);
		Param param = new Param();
		param.setCategory(category.trim());
		param.setSearchText(searchText.trim());
		System.out.println(category.trim());
		System.out.println(searchText.trim());
		int totalCount = dao.evSelectCountMulti(mapper, param);
		EventboardList eventboardList = new EventboardList(pageSize, totalCount, currentPage);
		param.setStartNo(eventboardList.getStartNo());
		param.setEndNo(eventboardList.getEndNo());
		eventboardList.setList(dao.evSelectListMulti(mapper, param));
		System.out.println(eventboardList);
		return eventboardList;
	}
	
	
	
}
