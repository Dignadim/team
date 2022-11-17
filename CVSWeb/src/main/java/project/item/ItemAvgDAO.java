package project.item;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

public class ItemAvgDAO {
	
	private static ItemAvgDAO instance = new ItemAvgDAO();
	private ItemAvgDAO() {
		
	}
	public static ItemAvgDAO getInstance() {
		return instance;
	}
	
	public void insertUpdateScore(SqlSession mapper, ItemAvgVO ao) {
		System.out.println("ItemAvgDAO의 insertUpdateScore() 메소드 실행");
		mapper.insert("insertUpdateScore", ao);
	}
	
	public double selectNewAvg(SqlSession mapper, int idx) {
		System.out.println("ItemAvgDAO의 selectNewAvg() 메소드 실행");
		return (double) mapper.selectOne("selectNewAvg", idx);
	}
	
	public void UpdateScore(SqlSession mapper, ItemAvgVO ao) {
		System.out.println("ItemAvgDAO의 UpdateScore() 메소드 실행");
		mapper.update("UpdateScore", ao);
	}
	
	public String selectAvgID(SqlSession mapper, ItemAvgVO ao) {
		System.out.println("ItemAvgDAO의 selectAvgID() 메소드 실행");
		return (String) mapper.selectOne("selectAvgID", ao);
	}

}
	
	














