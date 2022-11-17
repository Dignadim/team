package project.member;

import java.util.ArrayList;

public class MemberList {

	private ArrayList<MemberVO> list = new ArrayList<>();

	public ArrayList<MemberVO> getList() {
		return list;
	}

	public void setList(ArrayList<MemberVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "MemberList [list=" + list + "]";
	}
	
	
}
