package project.signup;

import java.io.IOException;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.ibatis.io.*;


public class LoginEx {
	
	public LoginVO getDB(String id) throws IOException {

		SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
		
		SqlSessionFactory factory = builder.build(Resources.getResourceAsReader("com/tjoeun/mybatis/configuration.xml"));
		
		SqlSession ss = factory.openSession(true);
		
		LoginVO vo = (LoginVO) ss.selectOne("search", id);
		return vo;
	}
	
	public int insertDB(LoginVO vo) throws IOException {
		SqlSessionFactoryBuilder builder = new SqlSessionFactoryBuilder();
		
		SqlSessionFactory factory = builder.build(Resources.getResourceAsReader("com/tjoeun/mybatis/configuration.xml"));
		
		SqlSession ss = factory.openSession(true);
		
		int cnt = ss.insert("insert", vo);
		
		return cnt;
	}
}
