package com.project.dao;

import java.util.ArrayList;

import com.project.member.MemberList;
import com.project.member.MemberVO;
import com.project.member.MsgVO;
import com.project.util.report.ReportVO;


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

	void goMsg(MsgVO msgVO);

	ArrayList<MsgVO> getMsg(String id);

	ArrayList<MsgVO> getToMsg(String id);

	void goTrash(MsgVO msgVO);

	ArrayList<MsgVO> getTrashMsg(String id);

	void recover(MsgVO msgVO);

	ArrayList<MemberVO> msrch(String id);

	int getIfTrash(int msgIdx);

	String getTrashId(int msgIdx);

	void goTrashList(MsgVO msgVO);

	String getTrashId2(int msgIdx);

	String isAdmin(String id);

	ArrayList<ReportVO> rpSelectList();

	void deleteMe(String id);

	ArrayList<MemberVO> getAllMember();

	void goNotice(MemberList list);

	ArrayList<ReportVO> rpSelectEventList();

	ArrayList<ReportVO> rpSelectEventCommentList();

	ArrayList<ReportVO> rpSelectFreeList();

	ArrayList<ReportVO> rpSelectFreeCommentList();


}
