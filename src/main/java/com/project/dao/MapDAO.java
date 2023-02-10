package com.project.dao;

import java.util.ArrayList;

import com.project.map.AddressVO;
import com.project.map.MapParam;
import com.project.map.MapVO;

public interface MapDAO {
	
	void autoMapInsert(ArrayList<MapVO> list);
	
	ArrayList<AddressVO> getGugun(String sido);

	ArrayList<MapVO> searchAdd(MapParam mapParam);

	void deleteAllMap();

	ArrayList<MapVO> itemMap(MapParam mapParam);

	void deleteRepeated();

	

}
