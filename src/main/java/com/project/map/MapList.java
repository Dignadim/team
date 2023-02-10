package com.project.map;

import java.util.ArrayList;

public class MapList {

	private ArrayList<MapVO> list = new ArrayList<MapVO>();
	
	public MapList() {
		// TODO Auto-generated constructor stub
	}
	
	public MapList(ArrayList<MapVO> list) {
		super();
		this.list = list;
	}

	@Override
	public String toString() {
		return "MapList [list=" + list + "]";
	}
	
	
	
}
