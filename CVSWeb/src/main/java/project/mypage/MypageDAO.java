package project.mypage;

public class MypageDAO {
	private static MypageDAO instance = new MypageDAO();
	private MypageDAO() {}
	public static MypageDAO getInstance() {
		return instance;
	}

}
