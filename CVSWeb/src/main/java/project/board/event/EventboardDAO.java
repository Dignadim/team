package project.board.event;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

public class EventboardDAO {

	private static EventboardDAO instance = new EventboardDAO();
	private EventboardDAO() { }
	public static EventboardDAO getInstance() {
		return instance;
	}
	
	public void evInsert(SqlSession mapper, EventboardVO ev_vo) {
		System.out.println("EventboardDAO의 evInsert() 메소드");
		mapper.insert("evInsert", ev_vo);
	}
	public int evSelectCount(SqlSession mapper) {
		System.out.println("EventboardDAO의 evSelectCount() 메소드");
		return (int) mapper.selectOne("evSelectCount");
	}
	public ArrayList<EventboardVO> evSelectList(SqlSession mapper, HashMap<String, Integer> hmap) {
		System.out.println("EventboardDAO의 evSelectList() 메소드");
		return (ArrayList<EventboardVO>) mapper.selectList("evSelectList", hmap);
	}
	public void evIncrement(SqlSession mapper, int ev_idx) {
		System.out.println("EventboardDAO의 evIncrement() 메소드");
		mapper.update("evIncrement", ev_idx);		
	}
	public EventboardVO evSelectByIdx(SqlSession mapper, int ev_idx) {
		System.out.println("EventboardDAO의 evSelectByIdx() 메소드");
		return (EventboardVO) mapper.selectOne("evSelectByIdx", ev_idx);
	}
	public void evDelete(SqlSession mapper, int ev_idx) {
		System.out.println("EventboardDAO의 evDelete() 메소드");
		mapper.delete("evDelete", ev_idx);
	}
	
	public void evUpdate(SqlSession mapper, EventboardVO ev_vo) {
		System.out.println("EventboardDAO의 evUpdate() 메소드");
		mapper.update("evUpdate", ev_vo);
	}
	
	public ArrayList<EventboardVO> evSelectNotice(SqlSession mapper) {
		System.out.println("EventboardDAO의 evSelectNotice() 메소드");
		return (ArrayList<EventboardVO>) mapper.selectList("evSelectNotice");
	}
	public void evUpload(SqlSession mapper, EventboardVO ev_vo) {
		System.out.println("EventboardDAO의 evUpload() 메소드");
		mapper.update("evUpload", ev_vo);
	}
	
}
