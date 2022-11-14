package project.item;

import java.util.ArrayList;

import org.apache.ibatis.session.SqlSession;

public class ItemCommentDAO {
	
	private static ItemCommentDAO instance = new ItemCommentDAO();
	private ItemCommentDAO() {
		
	}
	public static ItemCommentDAO getInstance() {
		return instance;
	}
	
	public void insertItemComment(SqlSession mapper, ItemCommentVO co) {	
		System.out.println("ItemCommentDAO의 insertItemComment() 메소드 실행");
		mapper.insert("insertItemComment", co);
	}
	
	public ArrayList<ItemVO> selectItemCommentList(SqlSession mapper, int idx) {
		System.out.println("ItemCommentDAO의 selectItemCommentList() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("selectItemCommentList", idx);
	}
	
	public void itemCommentUpdate(SqlSession mapper, ItemCommentVO co) {
		System.out.println("ItemCommentDAO의 itemCommentUpdate() 메소드 실행");	
		mapper.update("itemCommentUpdate", co);	
	}
	
	
}
