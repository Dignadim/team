package project.item;

import org.apache.ibatis.session.SqlSession;

import project.board.free.FreeboardCommentDAO;
import project.mybatis.MySession;

public class ItemCommentService {

	private static ItemCommentService instance = new ItemCommentService();
	private ItemCommentService() {
	
	}
	public static ItemCommentService getInstance() {
		return instance;
	}
	
	public boolean insertItemComment(ItemCommentVO co) {
		System.out.println("ItemCommentService의 insertItemComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		
		ItemCommentDAO dao = ItemCommentDAO.getInstance();
		
		try {
			dao.insertItemComment(mapper, co);
			mapper.commit();
			mapper.close();
			return true;
		} catch (NullPointerException e) {
			mapper.close();
			return false;
		}
		
	}
	
	public ItemCommentList selectItemCommentList(int idx) {
		System.out.println("ItemCommentService의 selectItemCommentList() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		
		ItemCommentList itemCommentList = new ItemCommentList();
		itemCommentList.setList(ItemCommentDAO.getInstance().selectItemCommentList(mapper, idx));
		
		mapper.close();
		return itemCommentList;
	}
	
	public boolean updateItemComment(ItemCommentVO co) {
		System.out.println("ItemCommentService의 updateItemComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		
		ItemCommentDAO dao = ItemCommentDAO.getInstance();
		
		try {
			dao.updateItemComment(mapper, co);
			mapper.commit();
			mapper.close();
			return true;
		} catch (NullPointerException e) {
			mapper.close();
			return false;
		}
	}
	
	public boolean deleteItemComment(int idx) {
		System.out.println("ItemCommentService의 deleteItemComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		
		ItemCommentDAO dao = ItemCommentDAO.getInstance();
		
		try {
			dao.deleteItemComment(mapper, idx);
			mapper.commit();
			mapper.close();	
			return true;
		} catch(NullPointerException e) {
			mapper.close();
			return false;
		}
	}
	
}













