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
	
	public void insert(SqlSession mapper, FreeboardVO fb_vo) {
		System.out.println("FreeboardDAO의 insert() 메소드");
		mapper.insert("fbInsert", fb_vo);
	}
	public int selectCount(SqlSession mapper) {
		System.out.println("FreeboardDAO의 selectCount() 메소드");
		return (int) mapper.selectOne("selectCount");
	}
	public ArrayList<FreeboardVO> selectList(SqlSession mapper, HashMap<String, Integer> hmap) {
		System.out.println("FreeboardDAO의 selectList() 메소드");
		return (ArrayList<FreeboardVO>) mapper.selectList("selectList", hmap);
	}
	public void increment(SqlSession mapper, int fb_idx) {
		System.out.println("FreeboardDAO의 increment() 메소드");
		mapper.update("increment", fb_idx);		
	}
	public FreeboardVO selectByIdx(SqlSession mapper, int fb_idx) {
		System.out.println("FreeboardDAO의 selectByIdx() 메소드");
		return (FreeboardVO) mapper.selectOne("selectByIdx", fb_idx);
	}
}
