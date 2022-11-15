package project.board.event;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

public class EventboardCommentDAO {

	private static EventboardCommentDAO instance = new EventboardCommentDAO();
	private EventboardCommentDAO () { }
	public static EventboardCommentDAO getInstance() {
		return instance;
	}
	public int evInsertComment(SqlSession mapper, EventboardCommentVO evc_vo) {
		System.out.println("EventboardCommentDAO의 evInsertComment() 메소드");
		return mapper.insert("evInsertComment", evc_vo);
	}
	public int evCommentCount(SqlSession mapper, int ev_idx) {
		System.out.println("EventboardCommentDAO의 evCommentCount() 메소드");
		return (int) mapper.selectOne("evCommentCount", ev_idx);
	}
	public ArrayList<EventboardCommentVO> evSelectCommentList(SqlSession mapper, int evc_idx) {
		System.out.println("EventboardCommentDAO의 evSelectCommentList() 메소드");
		return (ArrayList<EventboardCommentVO>) mapper.selectList("evSelectCommentList", evc_idx);
	}
	public void evUpdateComment(SqlSession mapper, EventboardCommentVO evc_vo) {
		System.out.println("EventboardCommentDAO의 evUpdateComment() 메소드");
		mapper.update("evUpdateComment", evc_vo);
	}
	public void evDeleteComment(SqlSession mapper, int evc_idx) {
		System.out.println("EventboardCommentDAO의 evDeleteComment() 메소드");
		mapper.delete("evDeleteComment", evc_idx);
	}
}
