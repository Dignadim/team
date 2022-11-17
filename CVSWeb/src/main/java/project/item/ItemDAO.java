package project.item;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import project.board.event.EventboardVO;
import project.board.free.FreeboardVO;

public class ItemDAO {
	
	private static ItemDAO instance = new ItemDAO();
	private ItemDAO() {
		
	}
	public static ItemDAO getInstance() {
		return instance;
	}
	
	// ItemService 클래스에서 호출되는, mapper와 메인글이 저장된 객체를 넘겨받고, item.xml 파일의 insert.sql 명령을 실행하는 메소드
	public void itemInsert(SqlSession mapper, ItemVO vo) {
		System.out.println("ItemDAO 클래스의 itemInsert() 메소드 실행");
		mapper.insert("itemInsert", vo);			
	}
	
	// ItemService 클래스에서 호출되는, mapper를 넘겨 받고 모든 상품을 얻어오는 item.xml 파일의 select sql 명령을 실행하는 메소드
	public ArrayList<ItemVO> selectItems(SqlSession mapper) {
		System.out.println("ItemDAO 클래스의 select() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("selectItems");
	}
	
	// ItemService 클래스에서 호출되는, mapper를 넘겨 받고 전체 글의 개수를 얻어오는, item.xml 파일의 select sql 명령을 실행하는 메소드
	public int selectItemCount(SqlSession mapper) {
		System.out.println("ItemDAO의 selectItemCount() 메소드 실행");
		return (int) mapper.selectOne("selectItemCount");
	}
	
	// ItemService 클래스에서 호출되는, mapper와 1페이지 분량의 시작 인덱스, 끝 인덱스가 저장된 HashMap 객체를 넘겨 받고 1페이지 분량의 메인 글 목록을 얻어오는 , item.xml 파일의 select sql 명령을 실행하는 메소드
	public ArrayList<ItemVO> selectItemList(SqlSession mapper, HashMap<String, Integer> hmap) {
		System.out.println("ItemDAO의 selectItemList() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("selectItemList", hmap); 
	}
	
	// ItemService 클래스에서 호출되는, mapper와 조회수를 증가시킨 메인 글의 글 번호를 넘겨 받고 조회수를 증가시킨 글 1건을 얻어오는, item.xml 파일의 select sql 명령을 실행하는 메소드
	public ItemVO itemSelectByIdx(SqlSession mapper, int idx) {
		System.out.println("ItemDAO의 itemSelectByIdx() 메소드 실행");
		return (ItemVO) mapper.selectOne("itemSelectByIdx", idx);
	}
	
	
	public void itemIncrement(SqlSession mapper, int idx) {
		System.out.println("ItemDAO의 increment() 메소드 실행");
		mapper.update("itemIncrement", idx);	
	}
	
	public void itemUpdate(SqlSession mapper, ItemVO vo) {
		System.out.println("ItemDAO의 itemUpdate() 메소드 실행");
		mapper.update("itemUpdate", vo);
	}
	
	public void itemDelete(SqlSession mapper, int idx) {
		System.out.println("ItemDAO의 itemDelete() 메소드 실행");
		mapper.delete("itemDelete", idx);		
	}
	
	public ArrayList<ItemVO> selectItemTOP5(SqlSession mapper) {
		System.out.println("ItemDAO의 selectItemTOP5() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("selectItemTOP5");
	}
	
	public ArrayList<ItemVO> search(SqlSession mapper, String itemName) {
		System.out.println("ItemDAO 클래스의 search() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("search", itemName);
	}
	
	public ArrayList<FreeboardVO> selectFreeHitList(SqlSession mapper) {
		System.out.println("ItemDAO의 selectFreeHitList() 메소드 실행");
		return (ArrayList<FreeboardVO>) mapper.selectList("selectFreeHitList");
	}
	
	public ArrayList<ItemVO> categorySearch(SqlSession mapper, String category) {
		System.out.println("ItemDAO 클래스의 categorySearch() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("categorySearch", category);
	}
	
	public ArrayList<ItemVO> SellCVSSearch(SqlSession mapper, String sellCVS) {
		System.out.println("ItemDAO 클래스의 SellCVSSearch() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("SellCVSSearch", sellCVS);
	}
	
	public ArrayList<ItemVO> eventTypeSearch(SqlSession mapper, String eventType) {
		System.out.println("ItemDAO 클래스의 eventTypeSearch() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("eventTypeSearch", eventType);
	}
	
	public ArrayList<ItemVO> itemPriceSearch(SqlSession mapper, int itemPrice) {
		System.out.println("ItemDAO 클래스의 itemPriceSearch() 메소드 실행");
		return (ArrayList<ItemVO>) mapper.selectList("itemPriceSearch", itemPrice);
	}
	
	public void averscoreUpdate(SqlSession mapper, ItemVO vo) {
		System.out.println("ItemDAO 클래스의 averscoreUpdate() 메소드 실행");
		mapper.update("averscoreUpdate", vo);		
	}
	
	public ArrayList<EventboardVO> selectEVList(SqlSession mapper) {
		System.out.println("ItemDAO 클래스의 selectEVList() 메소드 실행");
		return (ArrayList<EventboardVO>) mapper.selectList("selectEVList");
	}

}













