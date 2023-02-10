package com.project.map;

public class MapVO {

	private int mapIdx;
	private String storeName;
	private String whichCVS;
	private String address;
	
	public MapVO() {
		// TODO Auto-generated constructor stub
	}

	public void initMapVO(int mapIdx, String storeName, String whichCVS, String address) {
		this.mapIdx = mapIdx;
		this.storeName = storeName;
		this.whichCVS = whichCVS;
		this.address = address;
	}

	public int getMapIdx() {
		return mapIdx;
	}

	public void setMapIdx(int mapIdx) {
		this.mapIdx = mapIdx;
	}

	public String getStoreName() {
		return storeName;
	}

	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}

	public String getWhichCVS() {
		return whichCVS;
	}

	public void setWhichCVS(String whichCVS) {
		this.whichCVS = whichCVS;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	@Override
	public String toString() {
		return "MapVO [mapIdx=" + mapIdx + ", storeName=" + storeName + ", whichCVS=" + whichCVS + ", address="
				+ address + "]";
	}
	
	
	
}
