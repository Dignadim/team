package com.project.map;

public class MapParam {

	private String ssido;
	private String sgugun;
	private String whichCVS;
	private String storeName;
	
	public String getSsido() {
		return ssido;
	}
	public void setSsido(String ssido) {
		this.ssido = ssido;
	}
	public String getSgugun() {
		return sgugun;
	}
	public void setSgugun(String sgugun) {
		this.sgugun = sgugun;
	}
	public String getWhichCVS() {
		return whichCVS;
	}
	public void setWhichCVS(String whichCVS) {
		this.whichCVS = whichCVS;
	}
	public String getStoreName() {
		return storeName;
	}
	public void setStoreName(String storeName) {
		this.storeName = storeName;
	}
	
	@Override
	public String toString() {
		return "MapParam [ssido=" + ssido + ", sgugun=" + sgugun + ", whichCVS=" + whichCVS + ", storeName=" + storeName
				+ "]";
	}

	
}
