package project.item;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import org.apache.ibatis.session.SqlSession;

import project.board.event.EventboardList;
import project.board.free.FreeboardList;
import project.mybatis.MySession;

public class ItemService {

	private static ItemService instance = new ItemService();

	private ItemService() {

	}

	public static ItemService getInstance() {
		return instance;
	}

	// itemInsertOK.jsp에서 호출되는, 메인글이 저장된 객체를 넘겨받고 mapper를 얻어온 후 메인글을 저장하는 ItemDAO
	// 클래스의 insert sql 명령을 실행하는 메소드를 호출하는 메소드
	public void itemInsert(ItemVO vo) {
		System.out.println("ItemService의 itemInsert()");
		SqlSession mapper = MySession.getSession();

		ItemDAO.getInstance().itemInsert(mapper, vo);

		mapper.commit();
		mapper.close();
	}

	// itemList.jsp에서 호출되는, mapper를 얻어온 후 모든 공지글을 얻어오는 ItemDAO 클래스의 select sql 명령을
	// 실행하는 메소드를 호출하는 메소드
	public ArrayList<ItemVO> selectItems() {
		System.out.println("ItemService의 selectItems()");
		SqlSession mapper = MySession.getSession();

		ArrayList<ItemVO> items = ItemDAO.getInstance().selectItems(mapper);

		mapper.close();
		return items;
	}

	// itemList.jsp에서 호출되는, 브라우저에 출력할 페이지 번호를 넘겨받고 mapper를 얻어온 후 1페이지 분량의 상품 목록을
	// 얻어오는 ItemDAO 클래스의 select sql 명령을 실행하는 메소드를 호출하는 메소드
	public ItemList selectItemList(int currentPage) {
		System.out.println("ItemService의 selectItemList()");
		SqlSession mapper = MySession.getSession();

		ItemList itemList = null;
		ItemDAO dao = ItemDAO.getInstance();

		int pageSize = 12;
		int totalCount = dao.selectItemCount(mapper);

		itemList = new ItemList(pageSize, totalCount, currentPage);

		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", itemList.getStartNo());
		hmap.put("endNo", itemList.getEndNo());

		itemList.setList(dao.selectItemList(mapper, hmap));

		mapper.close();
		return itemList;
	}

	// itemSelectByIdx.jsp에서 호출되는, 상품 번호를 넘겨 받고 mapper를 얻어온 후 상품 1건을 얻어오는 ItemDAO
	// 클래스의 select sql 명령을 실행하는 메소드를 호출하는 메소드
	public ItemVO itemSelectByIdx(int idx) {
		System.out.println("ItemService의 itemSelectByIdx()");
		SqlSession mapper = MySession.getSession();

		ItemVO vo = ItemDAO.getInstance().itemSelectByIdx(mapper, idx);

		mapper.close();
		return vo;
	}

	// itemIncrement.jsp에서 호출되는, 조회수를 증가시킬 상품 번호를 넘겨 받고 mapper를 얻어온 후 상품의 hit를 증가시키는
	// ItemDAO 클래스의 update sql 명령을 실행하는 메소드를 호출하는 메소드
	public void itemIncrement(int idx) {
		System.out.println("ItemService의 itemIncrement()");
		SqlSession mapper = MySession.getSession();

		ItemDAO.getInstance().itemIncrement(mapper, idx);

		mapper.commit();
		mapper.close();
	}

	// itemUpdate.jsp에서 호출되는, 메인글을 수정할 정보가 저장된 객체를 넘겨 받고 mapper를 얻어온 후 메인글 1건을 수정하는
	// ItemDAO 클래스의 update sql 명령을 실행하는 메소드를 호출하는 메소드
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

	public ItemList selectItemTOP5() {
		System.out.println("ItemService의 selectItemTOP5()");
		SqlSession mapper = MySession.getSession();

		ItemList itemTOP5 = new ItemList();
		ItemDAO dao = ItemDAO.getInstance();

		itemTOP5.setList(dao.selectItemTOP5(mapper));

		mapper.close();
		return itemTOP5;
	}

	// 조회수 순위별 탑 아이템을 얻어온다.(count의 개수만큼)
	public ItemList selectItemTOP(int count) {
		SqlSession mapper = MySession.getSession();

		ItemList itemTOP = new ItemList();
		ItemDAO dao = ItemDAO.getInstance();

		itemTOP.setList(dao.selectItemTOP(mapper, count));

		mapper.close();
		return itemTOP;
	}

	public FreeboardList selectFreeHitList() {
		System.out.println("ItemService의 selectFreeHitList()");
		SqlSession mapper = MySession.getSession();

		FreeboardList freeHitList = new FreeboardList();
		ItemDAO dao = ItemDAO.getInstance();

		freeHitList.setList(dao.selectFreeHitList(mapper));

		mapper.close();
		return freeHitList;
	}

	public void averscoreUpdate(ItemAvgVO ao) {
		System.out.println("ItemService의 averscoreUpdate()");
		SqlSession mapper = MySession.getSession();

		// 새 평점을 itemavg 테이블에 넣는다.
		ItemAvgDAO dao = ItemAvgDAO.getInstance();
		dao.insertUpdateScore(mapper, ao);

		// idx가 일치하는 평점들의 새 평균을 가져온다.
		double newAvg = dao.selectNewAvg(mapper, ao.getItemIdx());
		ao.setNewAvg(newAvg);

		// 새 평점을 item 테이블의 averscore 칼럼에 입력한다.
		dao.UpdateScore(mapper, ao);

		mapper.commit();
		mapper.close();
	}

	public String selectAvgID(ItemAvgVO ao) {
		System.out.println("ItemService의 selectAvgID()");
		SqlSession mapper = MySession.getSession();

		String avgID = ItemAvgDAO.getInstance().selectAvgID(mapper, ao);

		mapper.close();
		return avgID;
	}

	public EventboardList selectEVList() {
		System.out.println("ItemService의 selectEVList()");
		SqlSession mapper = MySession.getSession();

		EventboardList evList = new EventboardList();

		evList.setList(ItemDAO.getInstance().selectEVList(mapper));

		mapper.close();
		return evList;
	}

	// 특정 카테고리의 상품만 리스트로 반환해주는 용도
	public ItemList selectItemCateList(String category) {
		SqlSession mapper = MySession.getSession();

		ItemList itemCate = new ItemList();
		ItemDAO dao = ItemDAO.getInstance();

		itemCate.setList(dao.selectItemCateList(mapper, category));
		// System.out.println(itemCate);
		mapper.close();
		return itemCate;
	}

	// 특정 카테고리의 상품만 담긴 리스트를 받아서 그중에 조회수 높은 count 개수만큼만 담아서 반환하는 메소드
	public ItemList selectItemCateListHit(ItemList list, int count) {
		// 리스트가 공백이면 함수에서 내쫓는다.
		if (list.getList().size() == 0)
			return null;

		// 리스트를 temp에 담아준다.
		ArrayList<ItemVO> tempList = list.getList();
		List<ItemVO> result = null;

		// 조회수 기준으로 정렬을 해준다.
		MiniComparator comp = new MiniComparator();
		Collections.sort(tempList, comp);
		// System.out.println(tempList.size());

		// 요구하는 개수보다 리스트 크기가 작은지 큰지 구분해서
		if (tempList.size() <= count) {
			result = tempList.subList(0, tempList.size());
		} else {
			// 요구하는 크기만큼 리스트를 잘라서 옮겨담아준다.
			result = tempList.subList(0, count);
		}
		// 마지막으로 빈 리스트를 만든뒤
		ArrayList<ItemVO> tempList2 = new ArrayList<ItemVO>();
		tempList2.addAll(result); // 자른 리스트를 담아주고
		list.setList(tempList2); // 그 리스트를 ItemList(ArrayList가 아니다) 형태의 list에 담아주고

		// 내쫓는다.
		return list;
	}
	
	public ItemList itemListSort(int currentPage, int mode) {
		System.out.println("ItemService의 itemListSort()");
		SqlSession mapper = MySession.getSession();

		ItemList itemList = null;
		ItemDAO dao = ItemDAO.getInstance();

		int pageSize = 12;
		int totalCount = dao.selectItemCount(mapper);

		itemList = new ItemList(pageSize, totalCount, currentPage);

		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", itemList.getStartNo());
		hmap.put("endNo", itemList.getEndNo());

		if (mode == 1) {
			itemList.setList(dao.selectItemList(mapper, hmap));
		} else if (mode == 2) {
			itemList.setList(dao.selectItemListReverse(mapper, hmap));
		} else if (mode == 3) {
			itemList.setList(dao.selectItemListHigher(mapper, hmap));
		} else if (mode == 4){
			itemList.setList(dao.selectItemListLower(mapper, hmap));
		} else if (mode == 5){
			itemList.setList(dao.selectItemListBetter(mapper, hmap));
		} else {
			itemList.setList(dao.selectItemListWorse(mapper, hmap));			
		}

		mapper.close();
		return itemList;
	}
	
}

//	list안의 조회수 기준으로 정렬해주는 기능
class MiniComparator implements Comparator<ItemVO> {
	@Override
	public int compare(ItemVO first, ItemVO second) {
		int firstValue = first.getHit();
		int secondValue = second.getHit();

		// Order by descending
		if (firstValue > secondValue) {
			return -1;
		} else if (firstValue < secondValue) {
			return 1;
		} else {
			return 0;
		}
	}

	
	

}
