package com.project.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.project.board.event.EventboardVO;
import com.project.board.free.FreeboardVO;
import com.project.item.ItemAvgVO;
import com.project.item.ItemCommentVO;
import com.project.item.ItemParam;
import com.project.item.ItemVO;
import com.project.item.MyItemVO;
import com.project.item.SearchKeywordVO;

public interface ItemDAO {

	void itemInsert(ItemVO itemVO);

	int selectItemCount();

	ArrayList<ItemVO> selectItemList(HashMap<String, Integer> hmap);

	void itemIncrement(int idx);

	ItemVO itemSelectByIdx(int idx);

	double getRealAvg(int idx);

	String selectAvgID(ItemAvgVO itemAvgVO);

	void insertUpdateScore(ItemAvgVO itemAvgVO);

	double selectNewAvg(int itemIdx);

	void UpdateScore(ItemAvgVO itemAvgVO);

	void itemUpdate(ItemVO itemVO);

	void itemDelete(int idx);

	ArrayList<ItemVO> selectItemCommentList(int idx);

	void insertItemComment(ItemCommentVO itemCommentVO);

	void updateItemComment(ItemCommentVO itemCommentVO);

	void deleteItemComment(int idx);

	ArrayList<ItemVO> SellCVSSearch(ItemParam itemParam);

	ArrayList<ItemVO> categorySearch(ItemParam itemParam);

	ArrayList<ItemVO> eventTypeSearch(ItemParam itemParam);

	ArrayList<ItemVO> itemPriceSearch(HashMap<String, Integer> hmap);

	ArrayList<ItemVO> search(String passJSON);

	ArrayList<ItemVO> selectItems();

	ArrayList<ItemVO> selectItemListReverse(HashMap<String, Integer> hmap);

	ArrayList<ItemVO> selectItemListHigher(HashMap<String, Integer> hmap);

	ArrayList<ItemVO> selectItemListLower(HashMap<String, Integer> hmap);

	ArrayList<ItemVO> selectItemListBetter(HashMap<String, Integer> hmap);

	ArrayList<ItemVO> selectItemListWorse(HashMap<String, Integer> hmap);

	ArrayList<EventboardVO> selectEVList();

	ArrayList<ItemVO> selectEventItemList();

	ArrayList<ItemVO> selectItemTOP5();

	ArrayList<FreeboardVO> selectFreeHitList();

	ArrayList<ItemVO> selectItemCate(String category);

	int selectNewItemCount();

	ArrayList<ItemVO> selectNewItemList(HashMap<String, Integer> hmap);

	ArrayList<SearchKeywordVO> selectHotKeyword();

	int getMaxIdx();

	void saveKeyword(String itemName);

	ArrayList<ItemVO> isearch(ItemParam itemParam);

	ArrayList<ItemAvgVO> getAvgInfo(int idx);

	void setMyItem(MyItemVO myItemVO);

	void cancelMyItem(MyItemVO myItemVO);

	ArrayList<MyItemVO> getMyItem(String id);

	ArrayList<ItemVO> getMyItemList(List<Integer> idxList);

	int isMyItem(MyItemVO myItemVO);

	int isearchCount(String itemName);

	int categorySearchCount(String category);

	int sellCVSSearchCount(String sellCVS);

	int eventTypeSearchCount(String eventType);

	int itemPriceSearchCount(int i);

	String getImgLink(int idx);

	void autoItemInsert(ArrayList<ItemVO> list);

	ArrayList<ItemVO> sameCategoryItem(String category);

	ArrayList<ItemVO> getSameItemName(String itemName);

	ArrayList<ItemVO> adminChart();

	String getImgPath(int idx);

}
