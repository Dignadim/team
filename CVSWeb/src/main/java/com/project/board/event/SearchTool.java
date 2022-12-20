package com.project.board.event;

public class SearchTool {

	private int startNo = 0;
	private int endNo = 0;
	private String category;
	private String searchText;
	
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
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getSearchText() {
		return searchText;
	}
	public void setSearchText(String searchText) {
		this.searchText = searchText;
	}
	
	@Override
	public String toString() {
		return "Param [startNo=" + startNo + ", endNo=" + endNo + ", category=" + category + ", searchText="
				+ searchText + "]";
	}
	
}
