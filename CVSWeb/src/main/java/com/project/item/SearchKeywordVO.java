package com.project.item;

public class SearchKeywordVO {

	private int searchIdx;
	private String keyword;
	
	public SearchKeywordVO() {
		// TODO Auto-generated constructor stub
	}

	public int getSearchIdx() {
		return searchIdx;
	}

	public void setSearchIdx(int searchIdx) {
		this.searchIdx = searchIdx;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "SearchKeywordVO [searchIdx=" + searchIdx + ", keyword=" + keyword + "]";
	}
	
}
