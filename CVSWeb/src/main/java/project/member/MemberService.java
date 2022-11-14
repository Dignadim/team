package project.member;

import org.apache.ibatis.session.SqlSession;

import project.mybatis.MySession;


public class MemberService {
	private static MemberService instance = new MemberService();
	private MemberService() { }
	public static MemberService getInstance() {
		return instance;
	}
	
//	insertOK.jsp에서 호출되는 메인글이 저장된 객체를 넘겨받고 mapper를 얻어온 후 메인글을 저장하는
//	FreeboardDAO 클래스의 insert sql 명령을 실행하는 메소드를 호출하는 메소드
	public void insert(MemberVO vo)
	{
		SqlSession mapper = MySession.getSession();
		MemberDAO.getInstance().insert(mapper, vo);
		mapper.commit();
		mapper.close();
	}
	
	public void changePassword(MemberVO mbvo) 
	{
		System.out.println("MemberService의 changePassword ");
		SqlSession mapper = MySession.getSession();
		MemberDAO.getInstance().changePassword(mapper,mbvo);

		mapper.commit();
		mapper.close();
	}
	
//	문자열 id를 받아서 MemberDB 테이블에 같은 id가 있는지 확인해서 있으면 해당 아이디를 가진 MemberVO 전체를 리턴해준다.
	public MemberVO searchID(String id)
	{
		SqlSession mapper = MySession.getSession();
		MemberVO vo = MemberDAO.getInstance().search(mapper, id);
		
		mapper.close();
		
		return vo;
	}
	
	public void update(MemberVO vo) {
		
		SqlSession mapper = MySession.getSession();
		MemberDAO.getInstance().update(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}
	
}