package project.mypage;

import java.util.Date;

public class MypageVO {

	private String id;
	private String password;
	private String nickname;
	private String email;
	private Date signupdate;
	private String image;
	private String introduce;
	
	public MypageVO() {}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Date getSignupdate() {
		return signupdate;
	}

	public void setSignupdate(Date signupdate) {
		this.signupdate = signupdate;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getIntroduce() {
		return introduce;
	}

	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}

	@Override
	public String toString() {
		return "MypageVO [id=" + id + ", password=" + password + ", nickname=" + nickname + ", email=" + email
				+ ", signupdate=" + signupdate + ", image=" + image + ", introduce=" + introduce + "]";
	}
	
	
	
	
}
