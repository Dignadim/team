package project.board.free;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

public class FreeboardCommentDAO {

	private static FreeboardCommentDAO instance = new FreeboardCommentDAO();
	private FreeboardCommentDAO () { }
	public static FreeboardCommentDAO getInstance() {
		return instance;
	}
	public int insertComment(SqlSession mapper, FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentDAO의 insertComment() 메소드");
		return mapper.insert("insertComment", fbc_vo);
	}
	public int fb_commentCount(SqlSession mapper, int fb_idx) {
		System.out.println("FreeboardCommentDAO의 insertComment() 메소드");
		return (int) mapper.selectOne("fb_commentCount", fb_idx);
	}
	public ArrayList<FreeboardCommentVO> selectCommentList(SqlSession mapper, int fbc_idx) {
		System.out.println("FreeboardCommentDAO의 selectCommentList() 메소드");
		return (ArrayList<FreeboardCommentVO>) mapper.selectList("selectCommentList", fbc_idx);
	}
	public void updateComment(SqlSession mapper, FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentDAO의 updateComment() 메소드");
		mapper.update("updateComment", fbc_vo);
	}
	public void deleteComment(SqlSession mapper, FreeboardCommentVO fbc_vo) {
		System.out.println("FreeboardCommentDAO의 updateComment() 메소드");
		mapper.delete("deleteComment", fbc_vo);
	}
}
