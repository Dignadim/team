package project.board.admin;

import java.util.ArrayList;

import project.board.free.FreeboardVO;

public class AdminboardList {
	
	private ArrayList<AdminboardVO> list = new ArrayList<>();

	public ArrayList<AdminboardVO> getList() {
		return list;
	}

	public void setList(ArrayList<AdminboardVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "AdminboardList [list=" + list + "]";
	}
	
	
}