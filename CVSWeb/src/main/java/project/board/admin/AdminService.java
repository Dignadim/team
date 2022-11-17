package project.board.admin;

import org.apache.ibatis.session.SqlSession;

import project.board.free.FreeboardDAO;
import project.board.free.FreeboardList;
import project.member.MemberDAO;
import project.member.MemberList;
import project.mybatis.MySession;

public class AdminService {

private static AdminService instance = new AdminService();
private AdminService() { }
public static AdminService getInstance() {
	return instance;
}




// adminList.jsp에서 호출되는 mapper를 얻어온 후
// FreeboardDAO 클래스의 테이블에 저장된 전체 카테고리 목록을 얻어오는
//select sql 명령을 실행하는 메소드를 호출하는 메소드
public FreeboardList abSelectList() {
	System.out.println("adminService의 abSelectList() 메소드");
	SqlSession mapper = MySession.getSession();
// 전체 카테고리 목록을 저장해서 리턴시킬 객체를 선언한다.
FreeboardList freeboardList = new FreeboardList();
//테이블에서 얻어온 전체 카테고리 목록을 freeboardList 클래스의 ArrayList에 저장한다.
freeboardList.setList(FreeboardDAO.getInstance().abSelectList(mapper));

mapper.close();
return freeboardList;
}

public MemberList amSelectList() {
	System.out.println("adminService의 amSelectList() 메소드");
	SqlSession mapper = MySession.getSession();

MemberList memberList = new MemberList();
memberList.setList(MemberDAO.getInstance().amSelectList(mapper));
	
mapper.close();
return memberList;
}
			
}


