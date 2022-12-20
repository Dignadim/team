package com.project.dao;

import java.util.ArrayList;
import java.util.HashMap;

import com.project.board.free.FreeboardCommentVO;
import com.project.board.free.FreeboardVO;

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


}
