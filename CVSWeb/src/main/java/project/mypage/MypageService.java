package project.mypage;

public class MypageService {
	private static MypageService instance = new MypageService();
	private MypageService() {}
	public static MypageService getInstance() {
		return instance;
	}
}
