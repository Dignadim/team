package com.project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.project.board.event.SearchTool;
import com.project.board.free.FreeboardCommentVO;
import com.project.board.free.FreeboardVO;
import com.project.member.MemberVO;
import com.project.util.report.ReportVO;

public interface FreeboardDAO {

	void fbInsert(FreeboardVO freeboardVO);

	int fbSelectCount();

	ArrayList<FreeboardVO> fbSelectList(HashMap<String, Integer> hmap);

	void fbIncrement(int fb_idx);

	FreeboardVO fbSelectByIdx(int fb_idx);

	void fbUpdate(FreeboardVO freeboardVO);

	void fbDelete(int fb_idx);

	void fbInsertComment(FreeboardCommentVO freeboardCommentVO);

	ArrayList<FreeboardVO> fbSelectNotice();

	int fbCommentCount(int fb_idx);

	ArrayList<FreeboardCommentVO> fbSelectCommentList(int fb_idx);

	void fbUpdateComment(FreeboardCommentVO freeboardCommentVO);

	void fbDeleteComment(FreeboardCommentVO freeboardCommentVO);

	ArrayList<FreeboardVO> abSelectList();

	ArrayList<FreeboardCommentVO> fbReplyCommentList(int fbc_idx);

	void fbReplyInsert(FreeboardCommentVO freeboardCommentVO);

	int fbReplyCount(int fbc_idx);

	int fbSelectCountSubject(SearchTool searchTool);

	ArrayList<FreeboardVO> fbSelectListSubject(SearchTool searchTool);

	int fbSelectCountContent(SearchTool searchTool);

	ArrayList<FreeboardVO> fbSelectListContent(SearchTool searchTool);

	int fbSelectCountSubCon(SearchTool searchTool);

	ArrayList<FreeboardVO> fbSelectListCountSubCon(SearchTool searchTool);

	int fbSelectCountNickname(SearchTool searchTool);

	ArrayList<FreeboardVO> fbSelectListCountNickname(SearchTool searchTool);

	void reportOK(ReportVO reportVO);

	void reportDelete(int fb_idx);

	void changeCommentInfo(MemberVO memberVO);

	ArrayList<FreeboardCommentVO> selectReportComment(int idx);

	void deleteRC(int idx);

	void changeBoardInfo(MemberVO memberVO);



}
