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
	public ArrayList<MemberVO> amselectAll(SqlSession mapper) {
		System.out.println("MemberDAO의 amselectAll() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amselectAll");
	}
	public ArrayList<MemberVO> amselectAdmin(SqlSession mapper) {
		System.out.println("MemberDAO의 amselectAdmin() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amselectAdmin");
	}
	public ArrayList<MemberVO> amselectNomal(SqlSession mapper) {
		System.out.println("MemberDAO의 amselectNomal() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amselectNomal");
	}
	public ArrayList<MemberVO> amselectWarning(SqlSession mapper) {
		System.out.println("MemberDAO의 amselectWarning() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amselectWarning");
	}
	public ArrayList<MemberVO> amselectblock(SqlSession mapper) {
		System.out.println("MemberDAO의 amselectblock() 메소드");
		return (ArrayList<MemberVO>) mapper.selectList("amselectblock");
	}
	
	
}
