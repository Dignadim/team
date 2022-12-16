package project.board.admin;

import java.util.ArrayList;
import java.util.HashMap;

import project.board.event.EventboardVO;
import project.board.free.FreeboardVO;
import project.member.MemberList;
import project.member.MemberVO;

public interface AdminDAO 
{
//	아이디값을 기준으로 그 아이디가 DB에 있으면 VO전체를 리턴해준다.
	MemberVO mbSearch(String id);
//	MemberVO를 받아서 DB에 추가해주는 용도
	void mbInsert(MemberVO vo);
	void memberUpdate(MemberVO vo);
	MemberVO selectById(String id);
	
	ArrayList<MemberVO> amSelectList();

	ArrayList<MemberVO> amSelectAdmin();

	ArrayList<MemberVO> amSelectNomal();

	ArrayList<MemberVO> amSelectWarning();

	ArrayList<MemberVO> amSelectBlock();

	ArrayList<FreeboardVO> abSelectList();

	ArrayList<EventboardVO> aebSelectList();

	void adminBlock(HashMap<String, String> hmap);



}
