package com.project.item;

public class MyItemVO {

	private String id;
	private int itemIdx;
	
	public MyItemVO() {
		// TODO Auto-generated constructor stub
	}

	public MyItemVO(String id, int itemIdx) {
		super();
		this.id = id;
		this.itemIdx = itemIdx;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getItemIdx() {
		return itemIdx;
	}

	public void setItemIdx(int itemIdx) {
		this.itemIdx = itemIdx;
	}

	@Override
	public String toString() {
		return "MyItemVO [id=" + id + ", itemIdx=" + itemIdx + "]";
	}

	
}
