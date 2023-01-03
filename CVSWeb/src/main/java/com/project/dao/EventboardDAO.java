package com.project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.project.board.event.EventboardCommentVO;
import com.project.board.event.EventboardList;
import com.project.board.event.EventboardVO;
import com.project.board.event.SearchTool;
import com.project.util.calendar.ScheduleManager;
import com.project.util.calendar.ScheduleVO;

public interface EventboardDAO {

	void evInsert(EventboardVO eventboardVO);

	int evSelectCount();

	ArrayList<EventboardVO> evSelectList(HashMap<String, Integer> hmap);

	ArrayList<EventboardVO> evSelectNotice();

	void evIncrement(int ev_idx);

	EventboardVO evSelectByIdx(int ev_idx);

	void evUpdate(EventboardVO eventboardVO);

	void evDelete(int ev_idx);

	void evInsertComment(EventboardCommentVO eventboardCommentVO);

	void evUpdateComment(EventboardCommentVO eventboardCommentVO);

	void evDeleteComment(EventboardCommentVO eventboardCommentVO);

	int evCommentCount(int ev_idx);

	ArrayList<EventboardCommentVO> evSelectCommentList(int ev_idx);

	int evSelectCountCategory(SearchTool param);

	ArrayList<EventboardVO> evSelectListCategory(SearchTool param);

	int evSelectCountMulti(SearchTool param);

	ArrayList<EventboardVO> evSelectListMulti(SearchTool param);

	ArrayList<EventboardVO> aebSelectList();

	ArrayList<ScheduleVO> initSchedList();

	void insertSched(ScheduleVO vo);

	void updateSched(ScheduleVO vo);

	void deleteSched(int ev_idx);

}
