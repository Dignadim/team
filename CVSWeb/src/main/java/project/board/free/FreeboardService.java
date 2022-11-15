package project.board.free;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import project.mybatis.MySession;

public class FreeboardService {

	private static FreeboardService instance = new FreeboardService();
	private FreeboardService() { }
	public static FreeboardService getInstance() {
		return instance;
	}
	
	public void insert(FreeboardVO fb_vo) {
		System.out.println("FreeboardService의 insert() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().insert(mapper, fb_vo);
		mapper.commit();
		mapper.close();
	}
	
	public FreeboardList selectList(int currentPage) {
		System.out.println("FreeboardService의 selectList() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO fb_dao = FreeboardDAO.getInstance();
		
		int pageSize = 10;
		int totalCount = fb_dao.selectCount(mapper);
		
		FreeboardList freeboardList = new FreeboardList(pageSize, totalCount, currentPage);
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", freeboardList.getStartNo());
		hmap.put("endNo", freeboardList.getEndNo());
		freeboardList.setList(fb_dao.selectList(mapper, hmap));
		
		mapper.close();
		return freeboardList;
	}
	
	public void increment(int fb_idx) {
		System.out.println("FreeboardService의 increment() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().increment(mapper, fb_idx);
		mapper.commit();
		mapper.close();
	}
	
	public FreeboardVO selectByIdx(int fb_idx) {
		System.out.println("FreeboardService의 selectByIdx() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardVO vo = FreeboardDAO.getInstance().selectByIdx(mapper, fb_idx);
		mapper.close();
		return vo;
	}
	
	public void delete(int fb_idx) {
		System.out.println("FreeboardService의 delete() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().delete(mapper, fb_idx);
		mapper.commit();
		mapper.close();
	}
	
	public void update(FreeboardVO fb_vo) {
		System.out.println("FreeboardService의 update() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().update(mapper, fb_vo);
		mapper.commit();
		mapper.close();
	}
	
	public ArrayList<FreeboardVO> selectNotice() {
		System.out.println("FreeboardService의 selectNotice() 메소드");
		SqlSession mapper = MySession.getSession();
		ArrayList<FreeboardVO> fb_notice = FreeboardDAO.getInstance().selectNotice(mapper);
		mapper.close();
		return fb_notice;
	}
	
	
	
}