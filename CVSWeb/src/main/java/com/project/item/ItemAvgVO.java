package com.project.item;

public class ItemAvgVO {
	
	private int itemIdx;
	private double averscore;
	private int avgIndex;
	private String ID;
	private double updateScore;
	private double newAvg;
	
	public ItemAvgVO() {
		// TODO Auto-generated constructor stub
	}

	public int getItemIdx() {
		return itemIdx;
	}

	public void setItemIdx(int itemIdx) {
		this.itemIdx = itemIdx;
	}

	public double getAverscore() {
		return averscore;
	}

	public void setAverscore(double averscore) {
		this.averscore = averscore;
	}

	public int getAvgIndex() {
		return avgIndex;
	}

	public void setAvgIndex(int avgIndex) {
		this.avgIndex = avgIndex;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public double getUpdateScore() {
		return updateScore;
	}

	public void setUpdateScore(double updateScore) {
		this.updateScore = updateScore;
	}

	public double getNewAvg() {
		return newAvg;
	}

	public void setNewAvg(double newAvg) {
		this.newAvg = newAvg;
	}

	@Override
	public String toString() {
		return "ItemAvgVO [itemIdx=" + itemIdx + ", averscore=" + averscore + ", avgIndex=" + avgIndex + ", ID=" + ID
				+ ", updateScore=" + updateScore + ", newAvg=" + newAvg + "]";
	}
	
	
	
}
