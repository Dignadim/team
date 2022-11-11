package com.tjoeun.service;

import org.apache.ibatis.session.SqlSession;

import com.tjoeun.dao.ItemCommentDAO;
import com.tjoeun.mybatis.MySession;
import com.tjoeun.vo.ItemCommentList;
import com.tjoeun.vo.ItemCommentVO;

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
	
}













