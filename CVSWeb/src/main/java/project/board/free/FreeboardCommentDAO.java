package project.board.free;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

public class FreeboardCommentDAO {

	private static FreeboardCommentDAO instance = new FreeboardCommentDAO();
	private FreeboardCommentDAO () { }
	public static FreeboardCommentDAO getInstance() {
		return instance;
	}
	public int fbInsertComment(SqlSession mapper, FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentDAO의 fbInsertComment() 메소드");
		return mapper.insert("fbInsertComment", fbc_vo);
	}
	public int fbCommentCount(SqlSession mapper, int fb_idx) {
		System.out.println("FreeboardCommentDAO의 fbCommentCount() 메소드");
		return (int) mapper.selectOne("fbCommentCount", fb_idx);
	}
	public ArrayList<FreeboardCommentVO> fbSelectCommentList(SqlSession mapper, int fbc_idx) {
		System.out.println("FreeboardCommentDAO의 fbSelectCommentList() 메소드");
		return (ArrayList<FreeboardCommentVO>) mapper.selectList("fbSelectCommentList", fbc_idx);
	}
	public void fbUpdateComment(SqlSession mapper, FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentDAO의 fbUpdateComment() 메소드");
		mapper.update("fbUpdateComment", fbc_vo);
	}
	public void fbDeleteComment(SqlSession mapper, int fbc_idx) {
		System.out.println("FreeboardCommentDAO의 fbDeleteComment() 메소드");
		mapper.delete("fbDeleteComment", fbc_idx);
	}
}
