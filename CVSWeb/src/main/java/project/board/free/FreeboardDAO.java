package project.board.free;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

public class FreeboardDAO {

	private static FreeboardDAO instance = new FreeboardDAO();
	private FreeboardDAO() { }
	public static FreeboardDAO getInstance() {
		return instance;
	}
	
	public void fbInsert(SqlSession mapper, FreeboardVO fb_vo) {
		System.out.println("FreeboardDAO의 fbInsert() 메소드");
		mapper.insert("fbInsert", fb_vo);
	}
	public int fbSelectCount(SqlSession mapper) {
		System.out.println("FreeboardDAO의 fbSelectCount() 메소드");
		return (int) mapper.selectOne("fbSelectCount");
	}
	public ArrayList<FreeboardVO> fbSelectList(SqlSession mapper, HashMap<String, Integer> hmap) {
		System.out.println("FreeboardDAO의 fbSelectList() 메소드");
		return (ArrayList<FreeboardVO>) mapper.selectList("fbSelectList", hmap);
	}
	public void fbIncrement(SqlSession mapper, int fb_idx) {
		System.out.println("FreeboardDAO의 fbIncrement() 메소드");
		mapper.update("fbIncrement", fb_idx);		
	}
	public FreeboardVO fbSelectByIdx(SqlSession mapper, int fb_idx) {
		System.out.println("FreeboardDAO의 fbSelectByIdx() 메소드");
		return (FreeboardVO) mapper.selectOne("fbSelectByIdx", fb_idx);
	}
	public void fbDelete(SqlSession mapper, int fb_idx) {
		System.out.println("FreeboardDAO의 fbDelete() 메소드");
		mapper.delete("fbDelete", fb_idx);
	}
	
	public void fbUpdate(SqlSession mapper, FreeboardVO fb_vo) {
		System.out.println("FreeboardDAO의 fbUpdate() 메소드");
		mapper.update("fbUpdate", fb_vo);
	}
	
	public ArrayList<FreeboardVO> fbSelectNotice(SqlSession mapper) {
		System.out.println("FreeboardDAO의 fbSelectNotice() 메소드");
		return (ArrayList<FreeboardVO>) mapper.selectList("fbSelectNotice");
	}
	
	
	
	
	
	
	// 어드민List로가는 코드
	
	
	
	public ArrayList<FreeboardVO> abSelectList(SqlSession mapper) {
		System.out.println("AdminboardDAO의 abSelectList() 메소드");
		return (ArrayList<FreeboardVO>) mapper.selectList("abSelectList");
	}

	
}
