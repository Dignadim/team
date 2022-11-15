package project.board.admin;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import project.board.free.FreeboardCommentDAO;
import project.mybatis.MySession;

public class AdminboardService {

private static AdminboardService instance = new AdminboardService();
private AdminboardService() { }
public static AdminboardService getInstance() {
	return instance;
}

public void adSelectList(int currentPage) {
	System.out.println("adSelectList의 abSelectList() 메소드");
	SqlSession mapper = MySession.getSession();
	AdminboardDAO ab_dao = AdminboardDAO.getInstance();
	
	AdminboardList adminboardList = new AdminboardList(pageSize, totalCount, currentPage);
	hmap.put("startNo", adminboardList.getStartNo());
	hmap.put("endNo", adminboardList.getEndNo());
	
	
	mapper.close();
	return adminboardList;
			
}

}
