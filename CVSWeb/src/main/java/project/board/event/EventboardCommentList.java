package project.board.event;

import java.util.ArrayList;

public class EventboardCommentList {
	
	private ArrayList<EventboardCommentVO> list = new ArrayList<>();

	public ArrayList<EventboardCommentVO> getList() {
		return list;
	}

	public void setList(ArrayList<EventboardCommentVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "EventboardCommentList [list=" + list + "]";
	}

}
