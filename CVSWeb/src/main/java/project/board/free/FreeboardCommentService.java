package project.board.free;

import org.apache.ibatis.session.SqlSession;

import project.mybatis.MySession;

public class FreeboardCommentService {

	private static FreeboardCommentService instance = new FreeboardCommentService();
	private FreeboardCommentService() { }
	public static FreeboardCommentService getInstance() {
		return instance;
	}
	
	public boolean fbInsertComment(FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentService의 fbInsertComment() 메소드");
		SqlSession mapper = MySession.getSession();
		int result = FreeboardCommentDAO.getInstance().fbInsertComment(mapper, fbc_vo);
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
	public int fbCommentCount (int fbc_idx) {
		System.out.println("FreeboardCommentService의 fbCommentCount() 메소드");
		SqlSession mapper = MySession.getSession();
		int fbCommentCount = FreeboardCommentDAO.getInstance().fbCommentCount(mapper, fbc_idx);
		mapper.close();
		return fbCommentCount;
	}		
	
	public FreeboardCommentList fbSelectCommentList(int fbc_idx) {
		System.out.println("FreeboardCommentService의 fbSelectCommentList() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentList freeboardCommentList = new FreeboardCommentList();
		freeboardCommentList.setList(FreeboardCommentDAO.getInstance().fbSelectCommentList(mapper, fbc_idx));
		mapper.close();
		return freeboardCommentList;
	}
	
	public boolean fbUpdateComment(FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentService의 fbUpdateComment() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentDAO dao = FreeboardCommentDAO.getInstance();

		try {
			dao.fbUpdateComment(mapper, fbc_vo);
			mapper.commit();
			mapper.close();
			return true;
		} catch(NullPointerException e) {
			mapper.close();
			return false;
		}
	}
	
	public boolean fbDeleteComment(int fbc_idx) {
		System.out.println("FreeboardCommentService의 fbDeleteComment() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentDAO dao = FreeboardCommentDAO.getInstance();
		
		try {
			dao.fbDeleteComment(mapper, fbc_idx);
			mapper.commit();
			mapper.close();
			return true;
		} catch(NullPointerException e) {
			mapper.close();
			return false;
		}
	}
	
}
