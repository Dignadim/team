package project.board.free;

import java.util.ArrayList;
import java.util.HashMap;

public interface FreeboardDAO 
{

	ArrayList<FreeboardVO> selectFreeHitList();

	ArrayList<FreeboardVO> fbSelectNotice();

	int fbSelectCount();

	ArrayList<FreeboardVO> fbSelectList(HashMap<String, Integer> hmap);

	int fbCommentCount(int fb_idx);

	void fbIncrement(int idx);

	FreeboardVO fbSelectByIdx(int idx);

	ArrayList<FreeboardCommentVO> fbSelectCommentList(int idx);

	void fbInsert(FreeboardVO vo);

	void fbUpdate(FreeboardVO vo);

	void fbDelete(int fb_idx);

	boolean fbInsertComment(FreeboardCommentVO fbc_vo);

	boolean fbUpdateComment(FreeboardCommentVO fbc_vo);

	boolean fbDeleteComment(int idx);


}
