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
	
// adminService에서 호출하는 코드	
	// 어드민 신규가입출력 코드
	
	public ArrayList<MemberVO> amSelectList(SqlSession mapper) {
		System.out.println("MemberDAO의 abSelectList() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amSelectList");
	}
	
	
	// 어드민 회원관리 정렬 코드
	public ArrayList<MemberVO> amSelectAll(SqlSession mapper) {
		System.out.println("MemberDAO의 amSelectAll() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amSelectAll");
	}
	public ArrayList<MemberVO> amSelectAdmin(SqlSession mapper) {
		System.out.println("MemberDAO의 amSelectAdmin() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amSelectAdmin");
	}
	public ArrayList<MemberVO> amSelectNomal(SqlSession mapper) {
		System.out.println("MemberDAO의 amSelectNomal() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amSelectNomal");
	}
	public ArrayList<MemberVO> amSelectWarning(SqlSession mapper) {
		System.out.println("MemberDAO의 amSelectWarning() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amSelectWarning");
	}
	public ArrayList<MemberVO> amSelectBlock(SqlSession mapper) {
		System.out.println("MemberDAO의 amSelectblock() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amSelectblock");
	}
	
	
	
}
