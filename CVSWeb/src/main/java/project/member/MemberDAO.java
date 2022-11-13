package project.member;

import org.apache.ibatis.session.SqlSession;


public class MemberDAO {
	private static MemberDAO instance = new MemberDAO();
	private MemberDAO() { }
	public static MemberDAO getInstance() {
		return instance;
	}
	
	public void insert(SqlSession mapper, MemberVO vo) {
		mapper.insert("mbInsert", vo);
	}
	public void changePassword(SqlSession mapper, MemberVO mbvo)
	{
		System.out.println("MemberDao의 changePassword" );
		mapper.update("mbChangePassword", mbvo);
	}
	public MemberVO search(SqlSession mapper, String id) 
	{
		return (MemberVO) mapper.selectOne("mbSearch", id);
	}
}
