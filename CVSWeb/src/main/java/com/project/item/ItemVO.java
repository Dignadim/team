package com.project.item;

import java.text.DecimalFormat;
import java.util.Date;

public class ItemVO {

	private int idx;
	private String category;
	private String itemName;
	private int itemPrice;
	private String sellCVS;
	private double averscore;
	private String eventType;
	private int eventSale;
	private int hit = 0;
	private String itemImage;
	private Date itemDate;
	private String hashTag;
	
	public ItemVO() {
	
	}
	
	public ItemVO(int idx, String category, String itemName, int itemPrice, String sellCVS, double averscore,
			String eventType, int eventSale, int hit, String itemImage, Date itemDate, String hashTag) {
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
		this.itemImage = itemImage;
		this.itemDate = itemDate;
		this.hashTag = hashTag;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

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

	public double getAverscore() {
		DecimalFormat df = new DecimalFormat("#.00"); 
		return Double.parseDouble(df.format(averscore));
	}

	public void setAverscore(double averscore) {
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

	public String getItemImage() {
		return itemImage;
	}

	public void setItemImage(String itemImage) {
		this.itemImage = itemImage;
	}

	public Date getItemDate() {
		return itemDate;
	}

	public void setItemDate(Date itemDate) {
		this.itemDate = itemDate;
	}

	public String getHashTag() {
		return hashTag;
	}

	public void setHashTag(String hashTag) {
		this.hashTag = hashTag;
	}
	
	@Override
	public String toString() {
		return "ItemVO [idx=" + idx + ", category=" + category + ", itemName=" + itemName + ", itemPrice=" + itemPrice
				+ ", sellCVS=" + sellCVS + ", averscore=" + averscore + ", eventType=" + eventType + ", hit=" + hit
				+ ", itemImage=" + itemImage + ", itemDate=" + itemDate + ", hashTag=" + hashTag + "]";
	}

	
	
}
