package com.project.util.report;

import java.util.ArrayList;

public class ReportList {

	ArrayList<ReportVO> list = new ArrayList<ReportVO>();

	public ArrayList<ReportVO> getList() {
		return list;
	}

	public void setList(ArrayList<ReportVO> list) {
		this.list = list;
	}

	@Override
	public String toString() {
		return "ReportList [list=" + list + "]";
	}
	
	
	
	
	
}
