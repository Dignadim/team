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




// adminList.jsp에서 호출되는 mapper를 얻어온 후 FreeboardDAO 클래스의 테이블에 저장된 전체 카테고리 목록을 얻어옴
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

// 전체 멤버리스트를 얻어옴 
public MemberList amSelectList() {
	System.out.println("adminService의 amSelectList() 메소드");
	SqlSession mapper = MySession.getSession();

MemberList memberList = new MemberList();
memberList.setList(MemberDAO.getInstance().amSelectList(mapper));
	
mapper.close();
return memberList;
}


// mode별 분기.
public MemberList memberListSort(int mode) {
	System.out.println("adminService의 memberListSort() 메소드");
	SqlSession mapper = MySession.getSession();
	
	MemberList memberList = null;
	MemberDAO dao = MemberDAO.getInstance();
	
	if (mode == 1) {
		memberList.setList(dao.amSelectAll(mapper));
	} else if (mode == 2) {
		memberList.setList(dao.amSelectAdmin(mapper));
	} else if (mode == 3) {
		memberList.setList(dao.amSelectNomal(mapper));
	} else if (mode == 4){
		memberList.setList(dao.amSelectWarning(mapper));
	} else { 
		memberList.setList(dao.amSelectBlock(mapper));
	}

	mapper.close();
	
	
	return memberList;
}


}

