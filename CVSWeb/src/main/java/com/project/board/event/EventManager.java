package com.project.board.event;

import java.io.IOException;

import java.util.HashMap;
import java.util.Map;

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
	
	public void getGS25Event() {
		/*

		*/
	}
	
	public void getCUEvent() {
		/*
		targetSite = "https://cu.bgfretail.com/brand_info/news_listAjax.do";
		for (int i = 1; i <= 10; i++) {
			
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("idx", "0")
	            		.data("pageIndex", i+"")
	            		.post();
	            
	            Elements elements = doc.select("div");
	            for (Element element : elements) {
	            	element.select("h3 > a");
	            	System.out.println(element.text());
	            }
	       } catch (Exception e) {
	    	   
	       }
	                				
		}
		*/
		
	}
	
	public void getSevenElevenEvent() {
		 
		/*
		targetSite = "https://www.7-eleven.co.kr/event/listMoreAjax.asp";
		for (int i = 1; i <= 1; i++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("intPageSize", 10+"")
	            		.data("state", "y")
	            		.post();
	            
	            Elements elements = doc.select("div > dl");
	            for (Element element : elements) {
	            	System.out.println(element.text());
	            }
	            
	       	} catch(Exception e) {}
	       
		}
		*/
	}
	
	public void getEmart24Event() {
		/*
		가끔 주소창, 네트워크에 아무 정보가 안 뜸
		cpage가 페이지 수

		// 행사 리스트 페이지
		targetSite = "https://emart24.co.kr/service/event.asp";
		
		// 행사 개별 페이지
		https://emart24.co.kr/service/eventView.asp?seq=
	
		for (int i = 1; i <= 5; i++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("cpage", i+"")
	            		.post();
	            Thread.sleep(500);
	            Elements elements = doc.select("td > a");
	            for (Element element : elements) {
	            	System.out.println(element);
	            }
	            
	       	} catch(Exception e) {}
	       
			}		
		
		 */
	}
	
	public void getMinistopEvent() {
		// 행사를 반 년째 안 함...
	}
	
	public void getCspaceEvent() {

		/*
		targetSite = "https://www.cspace.co.kr/board_event01/list.php?tn=board_event01&G_state=Y&b_category=00010000000000000000";
		for (int i = 1; i <= 5; i++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("cpage", i+"")
	            		.data("spage", (i+10)+"")
	            		.data("b_category", "00010000000000000000")
	            		.get();
	            Thread.sleep(500);
	            Elements elements = doc.select("div > span");
	            for (Element element : elements) {
	            	System.out.println(element);
	            }
	            
	       	} catch(Exception e) {}
	       
		}
		 */
	}
	
}
