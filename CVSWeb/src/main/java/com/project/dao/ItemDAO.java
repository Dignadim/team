package com.project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.project.board.event.EventboardVO;
import com.project.board.free.FreeboardList;
import com.project.board.free.FreeboardVO;
import com.project.item.ItemAvgVO;
import com.project.item.ItemCommentVO;
import com.project.item.ItemList;
import com.project.item.ItemVO;

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

	ArrayList<ItemVO> SellCVSSearch(String passJSON);

	ArrayList<ItemVO> categorySearch(String passJSON);

	ArrayList<ItemVO> eventTypeSearch(String passJSON);

	ArrayList<ItemVO> itemPriceSearch(int parseInt);

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



}
