package project.item;

import java.util.ArrayList;
import java.util.HashMap;


public interface ItemDAO 
{
//	현재 행사중인 상품을 최신순으로 10개만 얻어온다.
	ArrayList<ItemVO> selectEventItemList();
//	조회수 순위별 상품 탑 5를 얻어온다.
	ArrayList<ItemVO> selectItemTOP5();
//	브라우저에 출력할 startNo endNo를 넘겨받아서 1페이지 분량의 상품 목록을 얻어오는 sql 명령을 실행하는 메소드
	ArrayList<ItemVO> selectItemList(HashMap<String, Integer> hmap);
//	아이템의 총 개수를 구해오는 메소드
	int selectItemCount();
//	해당 인덱스인 상품의 조회수를 1증가 시키는 메소드
	void itemIncrement(int idx);
//	해당 vo로 DB에 정보를 입력해주는 메소드
	void itemInsert(ItemVO vo);
//	해당 인덱스인 상품 한개를 얻어오는 메소드
	ItemVO itemSelectByIdx(int idx);
//	해당 인덱스인 상품을 지우는 메소드
	void itemDelete(int idx);

	
//	아이템 평점 관련 메소드들

//	평점을 준 아이디가 평점을 준 아이템idx와 id를 비교해서 이미 준적이 있나 구별하기 위한 용도
	String selectAvgID(ItemAvgVO ao);
//	평점 테이블에서 해당 인덱스번호의 점수를 얻어온다.
	double getRealAvg(int idx);
//	평점 DB안에다가 새로운 평점을 넣어주는 메소드
	void insertUpdateScore(ItemAvgVO ao);
//	해당 아이템idx에 해당하는 평점들을 모두 구해서 평균을 내주는 녀석
	double selectNewAvg(int itemIdx);
//	해당 아이템에게 새 점수를 넣어준다.
	void UpdateScore(ItemAvgVO ao);
//	상품정보를 수정해준다.	
	void itemUpdate(ItemVO vo);
	
//	아이템 댓글 관련 메소드들
	
	
//	해당 idx에 해당하는 댓글들을 가져와서 ArrayList<ItemCommentVO>로 반환한다.
	ArrayList<ItemCommentVO> selectItemCommentList(int idx);
	
	boolean insertItemComment(ItemCommentVO co);
	boolean deleteItemComment(int idx);
	boolean updateItemComment(ItemCommentVO co);
	int selectItemCount(ItemDAO mapper);
	ArrayList<ItemVO> selectItemListReverse(HashMap<String, Integer> hmap);
	ArrayList<ItemVO> selectItemListHigher(HashMap<String, Integer> hmap);
	ArrayList<ItemVO> selectItemListLower(HashMap<String, Integer> hmap);
	ArrayList<ItemVO> selectItemListBetter(HashMap<String, Integer> hmap);
	ArrayList<ItemVO> selectItemListWorse(HashMap<String, Integer> hmap);
	ArrayList<ItemVO> search(String itemName);
	ArrayList<ItemVO> categorySearch(String searchWord);
	ArrayList<ItemVO> itemPriceSearch(int parseInt);
	ArrayList<ItemVO> eventTypeSearch(String searchWord);
	ArrayList<ItemVO> SellCVSSearch(String searchWord);
	ArrayList<ItemVO> selectItems();
	ArrayList<ItemVO> selectItemCate(String category);
	int selectNewItemCount(ItemDAO mapper);
	ArrayList<ItemVO> selectNewItemList(HashMap<String, Integer> hmap);


}
