package project.member;

import java.util.ArrayList;

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
	
	public MemberVO selectById(SqlSession mapper, String id) {
		return (MemberVO) mapper.selectOne("selectById", id);
	}
	public void update(SqlSession mapper, MemberVO vo) {
		mapper.update("update", vo);
	}
	
	
	// 어드민List로가는 코드
	
	public ArrayList<MemberVO> amSelectList(SqlSession mapper) {
		System.out.println("MemberDAO의 abSelectList() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amSelectList");
	}
}
