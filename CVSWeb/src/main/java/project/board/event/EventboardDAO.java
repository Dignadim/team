package project.board.event;

import java.util.ArrayList;
import java.util.HashMap;

import project.util.calendar.ScheduleVO;

public interface EventboardDAO 
{
//	모든 스케줄을 받아오는 용도
	ArrayList<ScheduleVO> initSchedList();

	ArrayList<EventboardVO> selectEVList();

	ArrayList<EventboardVO> evSelectNotice();

	int evSelectCount();

	ArrayList<EventboardVO> evSelectList(HashMap<String, Integer> hmap);

	int evCommentCount(int ev_idx);

	void evInsert(EventboardVO vo);

	void insertSched(ScheduleVO scheduleVO);

	void evIncrement(int idx);

	EventboardVO evSelectByIdx(int idx);

	ArrayList<EventboardCommentVO> evSelectCommentList(int idx);

	void evDelete(int ev_idx);

	void deleteSched(int ev_idx);

	void updateSched(ScheduleVO scheduleVO);

	void evUpdate(EventboardVO vo);

	boolean evInsertComment(EventboardCommentVO evc_vo);

	boolean evUpdateComment(EventboardCommentVO evc_vo);

	boolean evDeleteComment(int evc_idx);

	int evSelectCountCategory(String trim);

	ArrayList<EventboardVO> evSelectListCategory(HashMap<String, String> hmap);

	int evSelectCountMulti(HashMap<String, String> hmap);

	ArrayList<EventboardVO> evSelectListMulti(HashMap<String, String> hmap);



}
