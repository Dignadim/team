package com.project.util.calendar;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.jsoup.Connection;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

import com.project.board.event.EventboardVO;


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
	@Override
	public String toString() {
		return "ScheduleManager [schedList=" + schedList + "]";
	}
	
//	날짜 크롤링
	
	public ArrayList<ScheduleVO> getGS25Date() {
		ArrayList<ScheduleVO> list = new ArrayList<ScheduleVO>();
		String targetSite = "";
		Document doc = null;
		
		try {
			int page = 0;
			while(true) {
				page++;
				targetSite = "http://gs25.gsretail.com/board/boardList?CSRFToken=8f35eb2a-1562-44be-9ff0-390b02611142";
				// gs 행사페이지 접속
				Thread.sleep(500); 
				Connection.Response response = Jsoup.connect(targetSite)
						.timeout(3000)
						.header("Origin", "http://gs25.gsretail.com")
						.header("Referer", "http://gs25.gsretail.com/gscvs/ko/customer-engagement/event/current-events")
						.header("Accept", "application/json, text/javascript, */*; q=0.01")
						.header("Content-Type", "application/x-www-form-urlencoded; charset=UTF-8")
						.header("Accept-Encoding", "gzip, deflate")
						.header("Accept-Language", "ko-KR,ko;q=0.9,en-US;q=0.8,en;q=0.7")
						.data("pageNum", page+"")
						.data("modelName", "event")
						.data("parameterList", "brandCode:GS25@!@eventFlag:CURRENT")
						.ignoreContentType(true)
						.method(Connection.Method.GET)
						.execute();
				
				doc = response.parse();
				
				String str = doc.select("body").text().replaceAll("\\\\", "").substring(1);
				str = str.substring(0, str.length() - 1);
				
				JSONObject jsonObj = (JSONObject) new JSONParser().parse(str);
				JSONArray jsonArr = (JSONArray) jsonObj.get("results");	
				
				if(jsonArr.size() == 0) {
					break;
				}
				for(int i=0; i<jsonArr.size(); i++) {
					JSONObject gs25Object = (JSONObject) jsonArr.get(i);
					
					String startDate = gs25Object.get("startDate").toString();
					String endDate = gs25Object.get("endDate").toString();
					int sYear = 0;
					int sMonth = 0;
					int sDay = 0;
					int eYear = 0;
					int eMonth = 0;
					int eDay = 0;
					
					// 시작 년, 월, 일 구하기
					if(startDate.substring(0, 3).trim().equals("Jan")) {
						sMonth = 1;
					} else if(startDate.substring(0, 3).trim().equals("Feb")) {
						sMonth = 2; 
					} else if(startDate.substring(0, 3).trim().equals("Mar")) {
						sMonth = 3;
					} else if(startDate.substring(0, 3).trim().equals("Apr")) {
						sMonth = 4;
					} else if(startDate.substring(0, 3).trim().equals("May")) {
						sMonth = 5;
					} else if(startDate.substring(0, 3).trim().equals("Jun")) {
						sMonth = 6;
					} else if(startDate.substring(0, 3).trim().equals("Jul")) {
						sMonth = 7;
					} else if(startDate.substring(0, 3).trim().equals("Aug")) {
						sMonth = 8;
					} else if(startDate.substring(0, 3).trim().equals("Sep")) {
						sMonth = 9;
					} else if(startDate.substring(0, 3).trim().equals("Oct")) {
						sMonth = 10;
					} else if(startDate.substring(0, 3).trim().equals("Nov")) {
						sMonth = 11;
					} else {
						sMonth = 12;
					}
					if (startDate.substring(4, 6).indexOf(",") == -1) {
						sYear = Integer.parseInt(startDate.substring(8, 12));
						sDay = Integer.parseInt(startDate.substring(4, 6));
					} else {
						sYear = Integer.parseInt(startDate.substring(7, 11));
						sDay = Integer.parseInt(startDate.substring(4, 5)); 
					}
					
					// 종료 년, 월, 일 구하기
					if(endDate.substring(0, 3).trim().equals("Jan")) {
						eMonth = 1;
					} else if(endDate.substring(0, 3).trim().equals("Feb")) {
						eMonth = 2; 
					} else if(endDate.substring(0, 3).trim().equals("Mar")) {
						eMonth = 3;
					} else if(endDate.substring(0, 3).trim().equals("Apr")) {
						eMonth = 4;
					} else if(endDate.substring(0, 3).trim().equals("May")) {
						eMonth = 5;
					} else if(endDate.substring(0, 3).trim().equals("Jun")) {
						eMonth = 6;
					} else if(endDate.substring(0, 3).trim().equals("Jul")) {
						eMonth = 7;
					} else if(endDate.substring(0, 3).trim().equals("Aug")) {
						eMonth = 8;
					} else if(endDate.substring(0, 3).trim().equals("Sep")) {
						eMonth = 9;
					} else if(endDate.substring(0, 3).trim().equals("Oct")) {
						eMonth = 10;
					} else if(endDate.substring(0, 3).trim().equals("Nov")) {
						eMonth = 11;
					} else {
						eMonth = 12;
					}
					
					if (endDate.substring(4, 6).indexOf(",") == -1) {
						eYear = Integer.parseInt(endDate.substring(8, 12));
						eDay = Integer.parseInt(endDate.substring(4, 6));
					} else {
						eYear = Integer.parseInt(endDate.substring(7, 11));
						eDay = Integer.parseInt(endDate.substring(4, 5)); 
					}
					
					String event = gs25Object.get("title").toString().replace("u0026", "&");
					
					ScheduleVO scheduleVO = new ScheduleVO();
					scheduleVO.setsYear(sYear);
					scheduleVO.setsMonth(sMonth);
					scheduleVO.setsDay(sDay);
					scheduleVO.seteYear(eYear);
					scheduleVO.seteMonth(eMonth);
					scheduleVO.seteDay(eDay);
					scheduleVO.setEvent(event);
					scheduleVO.setCVS("GS25");
					
					list.add(scheduleVO);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<ScheduleVO> getCUDate() {
		ArrayList<ScheduleVO> list = new ArrayList<ScheduleVO>();
		String targetSite = "";
		Document doc = null;
		
		try {
			int page = 0;
			while (true) {
				targetSite = "https://cu.bgfretail.com/brand_info/news_listAjax.do";
				page++;
				Map<String, String> data = new HashMap<String, String>();
				data.put("pageIndex", page + "");
				data.put("idx", 0 + "");
				data.put("search2", "");
				data.put("searchKeyword", "");
				data.put("searchCondition", "");

				Thread.sleep(500);
				doc = Jsoup.connect(targetSite)
						.data(data)
						.post();
				
	            Date date = new Date();
	            SimpleDateFormat sdf = new SimpleDateFormat("yyyy.MM");

	            Elements dds = doc.select("dl > dd"); // 행사 날짜
	            String stop = "n"; // while 반복을 끝낼 때 사용
	            
	            Elements elements = doc.select("tbody > tr");
	            
				for (int i = 0; i < dds.size(); i++) {
					if (!dds.get(i).text().trim().substring(0, 7).equals(sdf.format(date))) {
						stop = "y"; // 현재 월과 사이트에 등록된 월이 같지 않으면 while문을 멈추기 위해 stop의 값을 y로 바꿔준다.
						break;
					} else {
						String idx[] = elements.get(i).select("h3 > a").attr("href").split("'");
						targetSite = "https://cu.bgfretail.com/brand_info/news_view.do?category=brand_info&depth2=5&idx="+idx[1];
						
						Thread.sleep(500);

						doc = Jsoup.connect(targetSite)
								.header("Origin", "https://cu.bgfretail.com")
								.header("Referer", "https://cu.bgfretail.com/brand_info/news_list.do?category=brand_info&depth2=5&sf=N")
								.cookie("JSESSIONID", "Z1dGjLYJpky11TnymspbhCGBSJZyy5cNyYv1GXJjL1MGLMjgLycS!-578416747")
								.data("pageIndex", page + "")
								.data("search2", "")
								.data("searchKeyword", "")
								.data("searchCondition", "")
								.post();

						String startDate = doc.select("thead th").get(1).text();
						startDate.substring(6, 7);
						int sYear = Integer.parseInt(startDate.substring(0, 4));
						
						int sMonth = 0;
						if(startDate.substring(5, 6).equals("0")) {
							sMonth = Integer.parseInt(startDate.substring(6, 7));
						} else {
							sMonth = Integer.parseInt(startDate.substring(5, 7));
						}
						
						int sDay = 0;
						if(startDate.substring(8, 9).equals("0")) {
							sDay = Integer.parseInt(startDate.substring(9));
						} else {
							sDay = Integer.parseInt(startDate.substring(8));
						}
						
						String event = doc.select("thead th").get(0).text();
						
						ScheduleVO scheduleVO = new ScheduleVO();
						scheduleVO.setsYear(sYear);
						scheduleVO.setsMonth(sMonth);
						scheduleVO.setsDay(sDay);
						scheduleVO.setEvent(event);
						scheduleVO.setCVS("CU");
						
						list.add(scheduleVO);
					}
				}
				if(stop.equals("y")) {
					break;
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<ScheduleVO> getSevenElevenDate() {
		ArrayList<ScheduleVO> list = new ArrayList<ScheduleVO>();
		String targetSite = "";
		Document doc = null;

		targetSite = "https://www.7-eleven.co.kr/event/eventList.asp";
		
		try {
			Thread.sleep(500);
			doc = Jsoup.connect(targetSite).get();
			Elements dds = doc.select("dd.date");
			Elements divs = doc.select("div.event_over");
			
			for(int i=0; i<dds.size(); i++) {
				String dateArr[] = dds.get(i).text().split(" ~ ");
				String startArr[] = dateArr[0].split("-");
				String endArr[] = dateArr[1].split("-");
				
				int sYear = Integer.parseInt(startArr[0]);
				
				int sMonth = 0;
				if(startArr[1].substring(0, 1).equals("0")) {
					sMonth = Integer.parseInt(startArr[1].substring(1));
				} else {
					sMonth = Integer.parseInt(startArr[1]);
				}
				
				int sDay = 0;
				if(startArr[2].substring(0, 1).equals("0")) {
					sDay = Integer.parseInt(startArr[2].substring(1));
				} else {
					sDay = Integer.parseInt(startArr[2]);
				}
				
				int eYear = Integer.parseInt(endArr[0]);
				
				int eMonth = 0;
				if(endArr[1].substring(0, 1).equals("0")) {
					eMonth = Integer.parseInt(endArr[1].substring(1));
				} else {
					eMonth = Integer.parseInt(endArr[1]);
				}
				
				int eDay = 0;
				if(endArr[2].substring(0, 1).equals("0")) {
					eDay = Integer.parseInt(endArr[2].substring(1));
				} else {
					eDay = Integer.parseInt(endArr[2]);
				}
				
				String event = divs.select("dt").get(i).text();
				
				ScheduleVO scheduleVO = new ScheduleVO();
				scheduleVO.setsYear(sYear);
				scheduleVO.setsMonth(sMonth);
				scheduleVO.setsDay(sDay);
				scheduleVO.seteYear(eYear);
				scheduleVO.seteMonth(eMonth);
				scheduleVO.seteDay(eDay);
				scheduleVO.setEvent(event);
				scheduleVO.setCVS("세븐일레븐");
				
				list.add(scheduleVO);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<ScheduleVO> getEmart24Date() {
		ArrayList<ScheduleVO> list = new ArrayList<ScheduleVO>();
		String targetSite = "";
		Document doc = null;
		
		targetSite = "https://emart24.co.kr/service/event.asp";
		
		try {
			int page = 0;
			while(true) {
				page++;
				doc = Jsoup.connect(targetSite)
							.data("cpage", page+"")
							.data("seq", "")
							.post();
				
				if(doc.select("label.on").size() == 0) { // 진행중인 이벤트가 없을 때 반복문을 중단한다.
					break;
				}
				
				Elements elements = doc.select("tbody > tr");
				
				for(Element element : elements) {
					Elements ele = element.select("td"); // 2 event
					if(ele.get(4).text().equals("진행중")) {
						String dateArr[] = ele.get(3).text().split(" - ");
						String startArr[] = dateArr[0].split("-");
						String endArr[] = dateArr[1].split("-");
						
						int sYear = Integer.parseInt(startArr[0]);
						
						int sMonth = 0;
						if(startArr[1].substring(0, 1).equals("0")) {
							sMonth = Integer.parseInt(startArr[1].substring(1));
						} else {
							sMonth = Integer.parseInt(startArr[1]);
						}
						
						int sDay = 0;
						if(startArr[2].substring(0, 1).equals("0")) {
							sDay = Integer.parseInt(startArr[2].substring(1));
						} else {
							sDay = Integer.parseInt(startArr[2]);
						}
						
						int eYear = Integer.parseInt(endArr[0]);
						
						int eMonth = 0;
						if(endArr[1].substring(0, 1).equals("0")) {
							eMonth = Integer.parseInt(endArr[1].substring(1));
						} else {
							eMonth = Integer.parseInt(endArr[1]);
						}
						
						int eDay = 0;
						if(endArr[2].substring(0, 1).equals("0")) {
							eDay = Integer.parseInt(endArr[2].substring(1));
						} else {
							eDay = Integer.parseInt(endArr[2]);
						}
						
						String event = ele.get(2).text();
						
						ScheduleVO scheduleVO = new ScheduleVO();
						scheduleVO.setsYear(sYear);
						scheduleVO.setsMonth(sMonth);
						scheduleVO.setsDay(sDay);
						scheduleVO.seteYear(eYear);
						scheduleVO.seteMonth(eMonth);
						scheduleVO.seteDay(eDay);
						scheduleVO.setEvent(event);
						scheduleVO.setCVS("이마트24");
						
						list.add(scheduleVO);
					}
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
//	public void getMinistopEvent() {
//		// 행사를 반 년째 안 함...
//	}
	
//	public ArrayList<ScheduleVO> getCspaceDate() { // 날짜 가져올 때 걸리는게 너무 많아서 현재 양식으로는 힘들 것 같음
//		ArrayList<ScheduleVO> list = new ArrayList<ScheduleVO>();
//		String targetSite = "";
//		Document doc = null;
//		
//	
//		return list;
//	}
	
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









