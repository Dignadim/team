package project.util.calendar;

import java.util.ArrayList;


public class ScheduleManager 
{
	private static ScheduleManager instance = new ScheduleManager();
	private ArrayList<ScheduleVO> schedList = new ArrayList<ScheduleVO>();	//	DB정보를 담은 ArrayList
	private ScheduleManager() { clearList(); }
	//	첫 실행시 DB안에 이미지 정보들을 모두 긁어와 리스트에 넣어둔다.
	private void clearList() 
	{
//		System.out.println("스케줄 매니저 호출");
		//	DB안에 있는 모든 값들을 list안에 불러서 저장한다.
		schedList.clear();
		
//		System.out.println(schedList + "스케줄리스트들 초기화 완료");
		//	System.out.println(schedList.size() + ": 스케줄리스트의 크기");
	}
	public static ScheduleManager getInstance() 
	{
		return instance;
	}
	public ArrayList<ScheduleVO> getList()
	{
		return schedList;
	}
	public void setList(ArrayList<ScheduleVO> list)
	{
		this.schedList = list;
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









