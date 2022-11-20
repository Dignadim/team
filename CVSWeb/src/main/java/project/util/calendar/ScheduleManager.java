package project.util.calendar;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import project.mybatis.MySession;

public class ScheduleManager 
{
	private static ScheduleManager instance = new ScheduleManager();
	private ArrayList<ScheduleVO> schedList = new ArrayList<ScheduleVO>();
	private ScheduleManager() { initList(); }
	//	첫 실행시 DB안에 이미지 정보들을 모두 긁어와 리스트에 넣어둔다.
	private void initList() 
	{
		SqlSession mapper = MySession.getSession();
		
		//	DB안에 있는 모든 값들을 list안에 불러서 저장한다.
		schedList.clear();
		schedList = (ArrayList<ScheduleVO>)mapper.selectList("initSchedList");
		
		//	System.out.println(schedList + "스케줄리스트들 초기화 완료");
		//	System.out.println(schedList.size() + ": 스케줄리스트의 크기");
		mapper.close();
	}
	public static ScheduleManager getInstance() {
		return instance;
	}
	public ArrayList<ScheduleVO> getList()
	{
		return schedList;
	}
	
	public void insertSched(ScheduleVO vo) {
		SqlSession mapper = MySession.getSession();
		mapper.insert("insertSched", vo);
		mapper.commit();
		mapper.close();
		//	추가된 내용이 있으니 arrayList를 한번 갱신해준다.
		initList();
	}
	
	//	수정된 vo를 넘겨주면 그 내용을 반영해주는 수정함수
	public void updateSched(ScheduleVO vo)
	{
		SqlSession mapper = MySession.getSession();
		mapper.update("updateSched", vo);
		mapper.commit();
		mapper.close();
		//	DB에 변경사항이 있으면 arrayList도 갱신
		initList();
	}
	
	//	리스트 중에서 특정 gup를 가지고 있는 값을 찾아서 리턴해주는 함수
	public ScheduleVO getFindVOByGup(int gup)
	{
		ScheduleVO vo;
		
		FindGup find = new FindGup();
		
		vo = find.find(schedList, gup);
		
		if(vo != null) return vo;
		else return null;
	}
	
	//	삭제할 gup를 받아서 해당 gup의 vo를 지워주는 함수
	public void delete(int gup)
	{
		SqlSession mapper = MySession.getSession();
		mapper.delete("deleteSched", gup);
		mapper.commit();
		mapper.close();
		//	DB에 변경사항이 있었으니 arrayList 갱신
		initList();
	}


}

class FindGup 
{  
	//	특정 리스트에서 특정 gup를 가진 녀석이 있나 찾는 함수
	public ScheduleVO find(ArrayList<ScheduleVO> list, int gup) 
	{  
		ScheduleVO vo;
		// 반복문을 돌려서
		for(int i = 0; i < list.size(); i++)
		{
			// 리스트의 i번째 인덱스가 가진 gup 가 넘겨받은 gup와 같으면
			if(list.get(i).getGup() == gup) 
			{
				//	그걸 리턴해주고
				vo = list.get(i);
				return vo;
			}
		}
		
		//	다돌았는데 같은걸 못 찾았으면 null을 리턴해준다.
		return null;
	}

}









