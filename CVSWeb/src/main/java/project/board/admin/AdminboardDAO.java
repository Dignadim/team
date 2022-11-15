package project.board.admin;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

public class AdminboardDAO {
	
	private static AdminboardDAO instance = new AdminboardDAO();
	private AdminboardDAO() { }
	public static AdminboardDAO getInstance() {
		return instance;
	}
	
	public ArrayList<AdminboardVO> adSelectList(SqlSession mapper, HashMap<String, Integer> hmap) {
		System.out.println("AdminboardDAO의 adSelectListt() 메소드");
		return (ArrayList<AdminboardVO>) mapper.selectList("adSelectList", hmap);
	}
	
}
