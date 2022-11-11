package com.tjoeun.service;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.tjoeun.dao.ItemDAO;
import com.tjoeun.mybatis.MySession;
import com.tjoeun.vo.ItemList;
import com.tjoeun.vo.ItemVO;

public class ItemService {

	private static ItemService instance = new ItemService();
	private ItemService() {
	
	}
	public static ItemService getInstance() {
		return instance;
	}
	
	// itemInsertOK.jsp에서 호출되는, 메인글이 저장된 객체를 넘겨받고 mapper를 얻어온 후 메인글을 저장하는 ItemDAO 클래스의 insert sql 명령을 실행하는 메소드를 호출하는 메소드 
	public void insert(ItemVO vo) {
		System.out.println("ItemService의 insert()");
		SqlSession mapper = MySession.getSession();
		
		ItemDAO.getInstance().insert(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}
	
	// itemList.jsp에서 호출되는, mapper를 얻어온 후 모든 공지글을 얻어오는 ItemDAO 클래스의 select sql 명령을 실행하는 메소드를 호출하는 메소드
	public ArrayList<ItemVO> selectItems() {
		System.out.println("ItemService의 selectItems()");
		SqlSession mapper = MySession.getSession();		

		ArrayList<ItemVO> items = ItemDAO.getInstance().selectItems(mapper);
		
		mapper.close();
		return items;
	}	
	
	// itemList.jsp에서 호출되는, 브라우저에 출력할 페이지 번호를 넘겨받고 mapper를 얻어온 후 1페이지 분량의 상품 목록을 얻어오는 ItemDAO 클래스의 select sql 명령을 실행하는 메소드를 호출하는 메소드
	public ItemList selectItemList(int currentPage) {
		System.out.println("ItemService의 selectItemList()");
		SqlSession mapper = MySession.getSession();		
		
		ItemList itemList = null;
		ItemDAO dao = ItemDAO.getInstance();
		
		int pageSize = 10;
		int totalCount = dao.selectCount(mapper);
		
		itemList = new ItemList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", itemList.getStartNo());
		hmap.put("endNo", itemList.getEndNo());		
		
		itemList.setList(dao.selectList(mapper, hmap));
		
		mapper.close();		
		return itemList;
	}
	
	// itemSelectByIdx.jsp에서 호출되는, 상품 번호를 넘겨 받고 mapper를 얻어온 후 상품 1건을 얻어오는 ItemDAO 클래스의 select sql 명령을 실행하는 메소드를 호출하는 메소드
	public ItemVO itemSelectByIdx(int idx) {
		System.out.println("ItemService의 itemSelectByIdx()");
		SqlSession mapper = MySession.getSession();
		
		ItemVO vo = ItemDAO.getInstance().itemSelectByIdx(mapper, idx);
		
		mapper.close();
		return vo;
	}
	
	// itemIncrement.jsp에서 호출되는, 조회수를 증가시킬 상품 번호를 넘겨 받고 mapper를 얻어온 후 상품의 hit를 증가시키는 ItemDAO 클래스의 update sql 명령을 실행하는 메소드를 호출하는 메소드
	public void itemIncrement(int idx) {
		System.out.println("ItemService의 itemIncrement()");
		SqlSession mapper = MySession.getSession();
		
		ItemDAO.getInstance().itemIncrement(mapper, idx);
		
		mapper.commit();
		mapper.close();
	}
	
	// itemUpdate.jsp에서 호출되는, 메인글을 수정할 정보가 저장된 객체를 넘겨 받고 mapper를 얻어온 후 메인글 1건을 수정하는 ItemDAO 클래스의 update sql 명령을 실행하는 메소드를 호출하는 메소드
	public void itemUpdate(ItemVO vo) {
		System.out.println("ItemService의 itemUpdate()");
		SqlSession mapper = MySession.getSession();
		
		ItemDAO.getInstance().itemUpdate(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}
	
	public void itemDelete(int idx) {
		System.out.println("ItemService의 itemDelete()");
		SqlSession mapper = MySession.getSession();
		
		ItemDAO.getInstance().itemDelete(mapper, idx);
		
		mapper.commit();
		mapper.close();
	}
	
	
}













