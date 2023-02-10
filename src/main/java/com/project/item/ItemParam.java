package com.project.item;

public class ItemParam {

	private int startNo;
	private int endNo;
	private String value;
	
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	
	@Override
	public String toString() {
		return "ItemParam [startNo=" + startNo + ", endNo=" + endNo + ", value=" + value + "]";
	}
	
}
