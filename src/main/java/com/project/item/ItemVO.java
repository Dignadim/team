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
	private int hit = 0;
	private String itemImage;
	private Date itemDate;
	private String addItemName;
	private String addItemImage;
	
	
	public ItemVO() {
	
	}
	
	public ItemVO(int idx, String category, String itemName, int itemPrice, String sellCVS, double averscore,
			String eventType, int hit, String itemImage, Date itemDate, String addItemName,
			String addItemImage) {
		super();
		this.idx = idx;
		this.category = category;
		this.itemName = itemName;
		this.itemPrice = itemPrice;
		this.sellCVS = sellCVS;
		this.averscore = averscore;
		this.eventType = eventType;
		this.hit = hit;
		this.itemImage = itemImage;
		this.itemDate = itemDate;
		this.addItemName = addItemName;
		this.addItemImage = addItemImage;
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

	public String getAddItemName() {
		return addItemName;
	}

	public void setAddItemName(String addItemName) {
		this.addItemName = addItemName;
	}

	public String getAddItemImage() {
		return addItemImage;
	}

	public void setAddItemImage(String addItemImage) {
		this.addItemImage = addItemImage;
	}

	@Override
	public String toString() {
		return "ItemVO [idx=" + idx + ", category=" + category + ", itemName=" + itemName + ", itemPrice=" + itemPrice
				+ ", sellCVS=" + sellCVS + ", averscore=" + averscore + ", eventType=" + eventType + ", hit=" + hit
				+ ", itemImage=" + itemImage + ", itemDate=" + itemDate + ", addItemName=" + addItemName
				+ ", addItemImage=" + addItemImage + "]";
	}
	
}
