package com.project.map;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

// 추후에 void를 list 형태로 리턴해서 컨트롤러에서 DB에 넣을 수 있도록 수정 예정
// i값, j값, 선택자, 변수명 등은 사이트별로 맞게 조절해서 사용할 것
// 얻어와야할 값: 지점명, 주소, 무슨 편의점인지(CU, GS 등...) => MapVO 참고
// 지도는 지점명 정보를 얻어오기 위해 시도 정보, 구군 정보도 추가로 크롤링해서 반복문으로 넣어줘야 함
public class MapManager {
	
	String targetSite = "";
	Document doc = null;
	
	public void getGS25Map() {
		
	}
	
	public void getCUMap() {
		/*
		// 모든 jumpo~~ 데이터를 보내지 않으면(""로 보낸다 하더라도) 데이터가 넘어오지 않는 것 같음(확실x)
		  
		for (int i = 1; i <= 2; i++) {
			
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("pageIndex", i+"")
	            		.data("listType", "")
	            		.data("jumpoCode", "")
	            		.data("jumpoLotto", "")
	            		.data("jumpoToto", "")
	            		.data("jumpoCash", "")
	            		.data("jumpoHour", "")
	            		.data("jumpoCafe", "")
	            		.data("jumpoDelivery", "")
	            		.data("jumpoBakery", "")
	            		.data("jumpoFry", "")
	            		.data("jumpoMultiDevice", "")
	            		.data("jumpoPosCash", "")
	            		.data("jumpoBattery", "")
	            		.data("jumpoAdderss", "")
	            		.data("jumpoSido", "")
	            		.data("jumpoGugun", "")
	            		.data("jumpodong", "")
	            		.data("user_id", "")
	            		.data("sido", "")
	            		.data("Gugun", "")
	            		.data("jumpoName", "")
	            		.post();
	            
	            Elements elements = doc.select("td > span");
	            for (Element element : elements) {
	            	element.select("div > p");
	            	System.out.println(element.text());
	            }
	            
	            
	        } catch(Exception e) {}
		}		  
		*/
	}
	
	public void getSevenElevenMap() {
		/*
		storeLaySido와 storeLayGu의 value에 지역 정보를 적어줘야 한다.
		
		targetSite = "https://www.7-eleven.co.kr/util/storeLayerPop.asp";
		for (int i = 1; i <= 2; i++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("storeLaySido", "서울")
	            		.data("storeLayGu", "서대문구")
	            		.post();
	            
	            Elements elements = doc.select("a > span");
	            for (Element element : elements) {
	            	System.out.println(element.text());
	            }
	            
	       	} catch(Exception e) {}
	       
			}		
		*/
	}
	
	public void getEmart24Map() {
		/*
		targetSite = "https://www.emart24.co.kr/introduce2/findBranch.asp";
		for (int i = 1; i <= 5; i++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("cpage", i+"")
	            		.data("wpsido", "")
	            		.data("spgugun", "")
	            		.data("stplacesido", "")
	            		.data("stplacegugun", "")
	            		.post();
	            Thread.sleep(500);
	            Elements elements = doc.select("td > strong");
	            for (Element element : elements) {
	            	System.out.println(element);
	            }
	            
	       	} catch(Exception e) {}
	       
			}		
		*/
	}
	
	public void getMinistopMap() {
	
	}
	
	public void getCspaceMap() {
		/*
		address_sido_s와 address_gugun_s에 ""를 보내면 저절로 전국의 데이터를 출력해줘서 따로 시도/구군 정보를 크롤링할 필요 없다.
		
		targetSite = "https://www.cspace.co.kr/intro/store.html";
		for (int i = 1; i <= 5; i++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("cpage", i+"")
	            		.data("spage", (i+10)+"")
	            		.data("address_sido_s", "")
	            		.data("address_gugun_s", "")
	            		.data("id_position_move", "calSelId")
	            		.get();
	            Thread.sleep(500);
	            Elements elements = doc.select("td > a");
	            for (Element element : elements) {
	            	System.out.println(element);
	            }
	            
	       	} catch(Exception e) {}
	       
			}
		
		 */		
	}
	  
	
}
