package project.item;

import org.apache.ibatis.session.SqlSession;
import project.mybatis.MySession;

public class ItemCommentService {

	private static ItemCommentService instance = new ItemCommentService();
	private ItemCommentService() {
	
	}
	public static ItemCommentService getInstance() {
		return instance;
	}
	
	public void insertItemComment(ItemCommentVO co) {
		System.out.println("ItemCommentService의 insertItemComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		
		ItemCommentDAO.getInstance().insertItemComment(mapper, co);
		
		mapper.commit();
		mapper.close();
	}
	
	public ItemCommentList selectItemCommentList(int idx) {
		System.out.println("ItemCommentService의 selectItemCommentList() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		
		ItemCommentList itemCommentList = new ItemCommentList();
		itemCommentList.setList(ItemCommentDAO.getInstance().selectItemCommentList(mapper, idx));
		
		mapper.close();
		return itemCommentList;
	}
	
	public void updateItemComment(ItemCommentVO co) {
		System.out.println("ItemCommentService의 updateItemComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		
		ItemCommentDAO dao = ItemCommentDAO.getInstance();
		dao.updateItemComment(mapper, co);
		
		mapper.commit();
		mapper.close();
	}
	
	public void deleteItemComment(int idx) {
		System.out.println("ItemCommentService의 deleteItemComment() 메소드 실행");
		SqlSession mapper = MySession.getSession();
		
		ItemCommentDAO dao = ItemCommentDAO.getInstance();
		dao.deleteItemComment(mapper, idx);
		
		mapper.commit();
		mapper.close();
	}
	
}













