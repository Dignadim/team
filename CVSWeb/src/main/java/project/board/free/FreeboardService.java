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
	
	public void fbInsert(FreeboardVO fb_vo) {
		System.out.println("FreeboardService의 fbInsert() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().fbInsert(mapper, fb_vo);
		mapper.commit();
		mapper.close();
	}
	
	public FreeboardList fbSelectList(int currentPage) {
		System.out.println("FreeboardService의 fbSelectCount() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO fb_dao = FreeboardDAO.getInstance();
		
		int pageSize = 10;
		int totalCount = fb_dao.fbSelectCount(mapper);
		
		FreeboardList freeboardList = new FreeboardList(pageSize, totalCount, currentPage);
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", freeboardList.getStartNo());
		hmap.put("endNo", freeboardList.getEndNo());
		freeboardList.setList(fb_dao.fbSelectList(mapper, hmap));
		
		mapper.close();
		return freeboardList;
	}
	
	public void fbIncrement(int fb_idx) {
		System.out.println("FreeboardService의 fbIncrement() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().fbIncrement(mapper, fb_idx);
		mapper.commit();
		mapper.close();
	}
	
	public FreeboardVO fbSelectByIdx(int fb_idx) {
		System.out.println("FreeboardService의 fbSelectByIdx() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardVO vo = FreeboardDAO.getInstance().fbSelectByIdx(mapper, fb_idx);
		mapper.close();
		return vo;
	}
	
	public void fbDelete(int fb_idx) {
		System.out.println("FreeboardService의 fbDelete() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().fbDelete(mapper, fb_idx);
		mapper.commit();
		mapper.close();
	}
	
	public void fbUpdate(FreeboardVO fb_vo) {
		System.out.println("FreeboardService의 fbUpdate() 메소드");
		SqlSession mapper = MySession.getSession();
		FreeboardDAO.getInstance().fbUpdate(mapper, fb_vo);
		mapper.commit();
		mapper.close();
	}
	
	public ArrayList<FreeboardVO> fbSelectNotice() {
		System.out.println("FreeboardService의 fbSelectNotice() 메소드");
		SqlSession mapper = MySession.getSession();
		ArrayList<FreeboardVO> fb_notice = FreeboardDAO.getInstance().fbSelectNotice(mapper);
		mapper.close();
		return fb_notice;
	}
	
	
	
}
