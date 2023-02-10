package com.project.board.event;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
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

// 추후에 void를 list 형태로 리턴해서 컨트롤러에서 DB에 넣을 수 있도록 수정 예정
// i값, j값, 선택자, 변수명 등은 사이트별로 맞게 조절해서 사용할 것
// 얻어와야할 값: 제목, 내용, 날짜 => EventboardVO 참고 
public class EventManager {
	
	String targetSite = "";
	Document doc = null;
	
	public ArrayList<EventboardVO> getGS25Event() {
	ArrayList<EventboardVO> list = new ArrayList<EventboardVO>();
		
		
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
				
				// 페이지에 접속했으면 파싱 후 값을 doc에 전달한다.
				doc = response.parse();
				
//				// text() 메소드를 이용해서 내용을 문자열로 옮겨준다.
				String str = doc.select("body").text().replaceAll("\\\\", "").substring(1); // "\" 제거, 첫번째 글자 제거
				
				str = str.substring(0, str.length() - 1); // 마지막 글자 제거
				
				// JSON데이터 형태로 만든 문자열 str을 넣어 JSON Object 로 만들어 준다.
				JSONObject jsonObj = (JSONObject) new JSONParser().parse(str);
				
				// JSON Object에서 필요한 정보가 있는, 즉 results 배열을 추출한다.
				JSONArray jsonArr = (JSONArray) jsonObj.get("results");	
				
				if(jsonArr.size() == 0) {
					break;
				}
				
				// 배열의 사이즈만큼 배열을 돌려준다.
				for(int i=0; i<jsonArr.size(); i++) {
					// 추출한 배열을 새로운 JSON Object에 넣어주고, 필요한 정보들을 빼온다.
					JSONObject gs25Object = (JSONObject) jsonArr.get(i);
					
					// GS는 이벤트페이지의 이미지와 이벤트 상세보기 페이지의 이미지가 다르고
					// 우리가 쓰고자 하는 이미지는 상세보기에 있기때문에 새로 타겟 사이트를 다시 만들어서
					// 다시 크롤링을 해줘야되는 것 같다..
					String eventCode = gs25Object.get("eventCode").toString(); // 이거 하나때문에..
					
					targetSite = 
							String.format("http://gs25.gsretail.com/gscvs/ko/customer-engagement/event/detail/"
									+ "publishing?pageNum=%d&eventCode=%s", page, eventCode);
					Thread.sleep(500); 
					doc = Jsoup.connect(targetSite).get();
					
					if(doc.text().trim().length() == 0) {
						targetSite = 
								String.format("http://gs25.gsretail.com/gscvs/ko/customer-engagement/event/detail/"
										+ "stamp?pageNum=%d&eventCode=%s", page, eventCode);
						Thread.sleep(500); 
						doc = Jsoup.connect(targetSite).get();
					}
					
					String subject = doc.select("h3.tit > strong").text(); // 행사제목
					
					// GS25 행사 상세보기의 이미지의 경우 html의 양식들이 다 같지가 않아서
					// 약간 이미지를 따오는 게 번거롭다.
					Elements ps = doc.select("span.event-web-contents > p");
					String image = ps.select("img").attr("src"); // 행사이미지
					
					if(image.trim().length() == 0) {
						ps = doc.select("div.visible > p");
						image = ps.select("img").attr("src"); // 행사이미지
					}
					
					// 앞서 말한듯이, 양식이 다르기 때문에 받아온 정보를 그냥 다 넘겨버리면
					// ev_filename에 null 값이 들어가게 되어 엑박이 뜨게 될 것이다.
					// 그런 점을 방지하기 위해 이미지를 받아온 부분만 넘겨주기로 했다.
					if(image != null && !image.equals("")) { 
						EventboardVO eventboardVO = new EventboardVO();
						eventboardVO.setEv_sellcvs("GS25");
						eventboardVO.setEv_subject(subject);
						eventboardVO.setEv_content("."); // content를 notnull로 설정해서 에러 방지차원에서 content에 "."을 준다.
						eventboardVO.setEv_filename(image);
						eventboardVO.setId("admin1"); // 씨스페이스와 같은 이유
						eventboardVO.setNickname("관리자1"); // 씨스페이스와 같은 이유
						eventboardVO.setEv_notice("no");
						
						list.add(eventboardVO);
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	   public ArrayList<EventboardVO> getCUEvent() {
		      ArrayList<EventboardVO> list = new ArrayList<EventboardVO>();
		      
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

								Elements tbody = doc.select("tbody");
								
								String subject = doc.select("thead th").get(0).text();
								String image = tbody.select("img").attr("src");
								String content = tbody.select("span").text();
								
								if (image != null && !image.equals("")) {
									EventboardVO eventboardVO = new EventboardVO();
									eventboardVO.setEv_sellcvs("CU");
									eventboardVO.setEv_subject(subject);
									eventboardVO.setEv_content(content);
									eventboardVO.setEv_filename(image);
									eventboardVO.setId("admin1");
									eventboardVO.setNickname("관리자1");
									eventboardVO.setEv_notice("no");

									list.add(eventboardVO);
								}   
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
	   
	public ArrayList<EventboardVO> getSevenElevenEvent() {
		ArrayList<EventboardVO> list = new ArrayList<EventboardVO>();
		targetSite = "https://www.7-eleven.co.kr/event/eventList.asp";
		
		try {
			doc = Jsoup.connect(targetSite).get();
			Elements subject = doc.select("#listUl img");
			Elements findContent = doc.select("#listUl .event_img");
			int contentNo1 = Integer.parseInt(findContent.attr("href").substring(23, 26));
			int contentNo2 = Integer.parseInt(findContent.attr("href").substring(30, 31));
			
			for (int i = 0; i <= subject.size() - 1; i++) {
				String eventSubject = subject.get(i).attr("alt");			
				targetSite = "https://www.7-eleven.co.kr/event/eventView.asp?seqNo=" + (contentNo1 - i) + "&listNo="
						+ (contentNo2 + i) + "&intPageSize=8";
				doc = Jsoup.connect(targetSite).get();
				Elements lastContent = doc.select(".gallery_view img");
				String ev_filename = "https://www.7-eleven.co.kr" + lastContent.attr("src");
				EventboardVO eventboardVO = new EventboardVO();
				eventboardVO.setEv_sellcvs("세븐일레븐");
				eventboardVO.setEv_subject(eventSubject);			
				eventboardVO.setEv_content(".");
				eventboardVO.setEv_filename(ev_filename);
				eventboardVO.setId("admin1");
				eventboardVO.setNickname("관리자1");
				eventboardVO.setEv_notice("no");
				list.add(eventboardVO);
				Thread.sleep(500);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}	
	
	public ArrayList<EventboardVO> getEmart24Event() {
		
		ArrayList<EventboardVO> list = new ArrayList<EventboardVO>();
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
					Elements ele = element.select("td");
					if(ele.get(4).text().equals("진행중")) {
						String seq = ele.get(0).text();
						targetSite = "https://emart24.co.kr/service/eventView.asp?seq="+seq;
						Thread.sleep(500);
						doc = Jsoup.connect(targetSite).get();
						
						String subject = doc.select("td.title").text();
						String image = "https://emart24.co.kr" +
								doc.select("td.contArea3 > img").attr("src");
						
						EventboardVO eventboardVO = new EventboardVO();
						eventboardVO.setEv_sellcvs("이마트24");
						eventboardVO.setEv_subject(subject);
						eventboardVO.setEv_content(".");
						eventboardVO.setEv_filename(image);
						eventboardVO.setId("admin1");
						eventboardVO.setNickname("관리자1");
						eventboardVO.setEv_notice("no");
						
						list.add(eventboardVO);
					}
				}
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return list;
		
	}
	
	public void getMinistopEvent() {
		// 행사를 반 년째 안 함...
	}
	
	public ArrayList<EventboardVO> getCspaceEvent() {
		ArrayList<EventboardVO> list = new ArrayList<EventboardVO>();		
		for(int i=1; i<=1; i++) {
			targetSite = 
					String.format("https://www.cspace.co.kr/board_event01/list.php?tn=board_event01&list_count_s=&G_state=Y&pm=&b_category=00010000000000000000&cpage=%d&spage=1"
							, i);
			// System.out.println(targetSite);
			try {
				// 타겟 사이트의 정보를 얻어온다.
				Thread.sleep(500); 
				doc = Jsoup.connect(targetSite).get();
				
				// 메소드를 사용해서 필요한 정보를 얻어온다.
				Elements elesSpan = doc.select("div.hidden-xs"); // 글의 제목
				Elements elesImg = doc.select("div.img"); // 글의 이미지
				
				// 글의 이미지와 제목의 수는 같으므로 둘 중에 하나로 for문을 돌려준다.
				for (int j=0; j<elesSpan.size(); j++) {
					String subject = elesSpan.select("span").get(j).text(); // 행사 제목
					String image = "https://www.cspace.co.kr"+
							elesImg.select("img").get(j).attr("src"); // 행사 이미지
					
					// 가져온 값을 VO에 넣어준다.
					EventboardVO eventboardVO = new EventboardVO();
					eventboardVO.setEv_sellcvs("C·SPACE");
					eventboardVO.setEv_subject(subject);
					eventboardVO.setEv_content("."); // content를 notnull로 설정해서 에러 방지차원에서 content에 "."을 준다.
					eventboardVO.setEv_filename(image);
					// id, nickname도 notnull로 되어있어서 임시방편으로 관리자 아이디, 닉네임을 따로 적어서 전달하게 했습니다.
					eventboardVO.setId("admin1");
					eventboardVO.setNickname("관리자1");
					eventboardVO.setEv_notice("no");
					
					list.add(eventboardVO);
				}
			} catch(Exception e) {
				e.printStackTrace();
			}
		}
		
		return list;
	}
	
}
