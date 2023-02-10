package com.project.member;

import java.util.Date;

public class MemberVO 
{
	private String id;
	private String password;
	private String nickname;
	private String email;
	private Date signupdate;
	private String grade;
	private String image;
	private String introduce;
	
	public MemberVO() {}


	public MemberVO(String id, String pss, String nick, String email) 
	{
		this.id = id;
		this.password = pss;
		this.nickname = nick;
		this.email = email;
	}


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


	public String getGrade() {
		return grade;
	}


	public void setGrade(String grade) {
		this.grade = grade;
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
		return "MemberVO [id=" + id + ", password=" + password + ", nickname=" + nickname + ", email=" + email
				+ ", signupdate=" + signupdate + ", grade=" + grade + ", image=" + image + ", introduce=" + introduce
				+ "]";
	}

	
}
