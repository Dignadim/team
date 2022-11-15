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
	
	
	
}
