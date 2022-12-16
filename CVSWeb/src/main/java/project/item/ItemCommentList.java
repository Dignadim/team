package project.item;

import java.util.ArrayList;

public class ItemCommentList {

	private ArrayList<ItemCommentVO> list = new ArrayList<ItemCommentVO>();

	public ArrayList<ItemCommentVO> getList() {
		return list;
	}
	public void setList(ArrayList<ItemCommentVO> list) {
		this.list = list;
	}
	
	@Override
	public String toString() {
		return "ItemCommentList [list=" + list + "]";
	}
		
}
