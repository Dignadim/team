package com.tjoeun.vo;

public class ItemVO {

	private int idx;
	private String category;
	private String itemName;
	private int itemPrice;
	private String sellCVS;
	private int averscore;
	private String eventType;
	private int eventSale;
	private int hit = 0;
	
	public ItemVO() {
	
	}

	public ItemVO(int idx, String category, String itemName, int itemPrice, String sellCVS, int averscore,
			String eventType, int eventSale, int hit) {
		super();
		this.idx = idx;
		this.category = category;
		this.itemName = itemName;
		this.itemPrice = itemPrice;
		this.sellCVS = sellCVS;
		this.averscore = averscore;
		this.eventType = eventType;
		this.eventSale = eventSale;
		this.hit = hit;
	}

	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;	}

	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getItemName() {
		return itemName;
	}
	public void setItemName(String itemName) {
		this.itemName = itemName;
	}
	public int getItemPrice() {
		return itemPrice;
	}
	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}
	public String getSellCVS() {
		return sellCVS;
	}
	public void setSellCVS(String sellCVS) {
		this.sellCVS = sellCVS;
	}
	public int getAverscore() {
		return averscore;
	}
	public void setAverscore(int averscore) {
		this.averscore = averscore;
	}
	public String getEventType() {
		return eventType;
	}
	public void setEventType(String eventType) {
		this.eventType = eventType;
	}
	public int getEventSale() {
		return eventSale;
	}
	public void setEventSale(int eventSale) {
		this.eventSale = eventSale;
	}
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}

	@Override
	public String toString() {
		return "ItemVO [idx=" + idx + ", category=" + category + ", itemName=" + itemName + ", itemPrice=" + itemPrice + ", sellCVS=" + sellCVS + ", averscore=" + averscore + ", eventType=" + eventType + ", eventSale=" + eventSale + ", hit=" + hit + "]";
	}

	
}
