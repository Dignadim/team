package com.project.dao;

import java.util.ArrayList;

import com.project.member.MemberVO;

public interface MemberDAO {

	MemberVO mbSearch(String userID);

	void mbInsert(MemberVO memberVO);

	void updateInfo(MemberVO memberVO);

	ArrayList<MemberVO> amSelectList();

	ArrayList<MemberVO> amSelectAdmin();

	ArrayList<MemberVO> amSelectNomal();

	ArrayList<MemberVO> amSelectWarning();

	ArrayList<MemberVO> amSelectBlock();

	void adminBlockWarning(MemberVO memberVO);

	void adminBlockBlock(MemberVO memberVO);

	void adminBlockClear(MemberVO memberVO);


}
