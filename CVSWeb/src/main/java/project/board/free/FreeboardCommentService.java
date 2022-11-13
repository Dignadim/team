package project.board.free;

import org.apache.ibatis.session.SqlSession;

import project.mybatis.MySession;

public class FreeboardCommentService {

	private static FreeboardCommentService instance = new FreeboardCommentService();
	private FreeboardCommentService() { }
	public static FreeboardCommentService getInstance() {
		return instance;
	}
	
	public boolean insertComment(FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentService의 insertComment() 메소드");
		SqlSession mapper = MySession.getSession();
		int result = FreeboardCommentDAO.getInstance().insertComment(mapper, fbc_vo);
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
	public int fb_commentCount (int fbc_idx) {
		System.out.println("FreeboardCommentService의 commentCount() 메소드");
		SqlSession mapper = MySession.getSession();
		int fb_commentCount = FreeboardCommentDAO.getInstance().fb_commentCount(mapper, fbc_idx);
		return fb_commentCount;
	}		
	
	public FreeboardCommentList selectCommentList(int fbc_idx) {
		System.out.println("FreeboardCommentService의 selectCommentList() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentList freeboardCommentList = new FreeboardCommentList();
		freeboardCommentList.setList(FreeboardCommentDAO.getInstance().selectCommentList(mapper, fbc_idx));
		mapper.close();
		return freeboardCommentList;
	}
	
	public boolean updateComment(FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentService의 updateComent() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentDAO dao = FreeboardCommentDAO.getInstance();

		try {
			dao.updateComment(mapper, fbc_vo);
			mapper.commit();
			mapper.close();
			return true;
		} catch(NullPointerException e) {
			mapper.close();
			return false;
		}
	}
	
	public boolean deleteComment(FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentService의 updateComent() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardCommentDAO dao = FreeboardCommentDAO.getInstance();
		
		try {
			dao.deleteComment(mapper, fbc_vo);
			mapper.commit();
			mapper.close();
			return true;
		} catch(NullPointerException e) {
			mapper.close();
			return false;
		}
	}
	
}
