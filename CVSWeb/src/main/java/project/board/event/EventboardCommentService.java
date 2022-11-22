package project.board.event;

import org.apache.ibatis.session.SqlSession;

import project.mybatis.MySession;

public class EventboardCommentService {

	private static EventboardCommentService instance = new EventboardCommentService();
	private EventboardCommentService() { }
	public static EventboardCommentService getInstance() {
		return instance;
	}
	
	public boolean evInsertComment(EventboardCommentVO evc_vo) {
		System.out.println("FreeboardCommentService의 evInsertComment() 메소드");
		SqlSession mapper = MySession.getSession();
		int result = EventboardCommentDAO.getInstance().evInsertComment(mapper, evc_vo);
		System.out.println("result: " + result);
		if(result == 1) {
			mapper.commit();
			mapper.close();
			return true;
		} else {
			mapper.close();
			return false;
		}
		
	}
	public int evCommentCount (int evc_idx) {
		System.out.println("EventboardCommentService의 evCommentCount() 메소드");
		SqlSession mapper = MySession.getSession();
		int evCommentCount = EventboardCommentDAO.getInstance().evCommentCount(mapper, evc_idx);
		mapper.close();
		return evCommentCount;
	}		
	
	public EventboardCommentList evSelectCommentList(int evc_idx) {
		System.out.println("EventboardCommentService의 evSelectCommentList() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardCommentList freeboardCommentList = new EventboardCommentList();
		freeboardCommentList.setList(EventboardCommentDAO.getInstance().evSelectCommentList(mapper, evc_idx));
		mapper.close();
		return freeboardCommentList;
	}
	
	public boolean evUpdateComment(EventboardCommentVO evc_vo) {
		System.out.println("EventboardCommentService의 evUpdateComment() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardCommentDAO dao = EventboardCommentDAO.getInstance();

		try {
			dao.evUpdateComment(mapper, evc_vo);
			mapper.commit();
			mapper.close();
			return true;
		} catch(NullPointerException e) {
			mapper.close();
			return false;
		}
	}
	
	public boolean evDeleteComment(int evc_idx) {
		System.out.println("EventboardCommentService의 evDeleteComment() 메소드");
		SqlSession mapper = MySession.getSession();
		EventboardCommentDAO dao = EventboardCommentDAO.getInstance();
		
		try {
			dao.evDeleteComment(mapper, evc_idx);
			mapper.commit();
			mapper.close();
			return true;
		} catch(NullPointerException e) {
			mapper.close();
			return false;
		}
	}
	
}
