package com.project.item;

import java.io.IOException;
import java.util.ArrayList;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

// i값, j값, 선택자, 변수명 등은 사이트별로 맞게 조절해서 사용할 것
// 얻어와야할 값: 상품명, 가격, 이미지 주소, 행사 정보(1+1, 2+1 등...) => ItemVO 참고 
// return한 list는 추후에 컨트롤러를 통해 DB에 넣을 예정
public class ItemManager {
	
	String targetSite = "";
	Document doc = null;
	ArrayList<ItemVO> list = new ArrayList<ItemVO>();
	
	public ArrayList<ItemVO> getGS25Item() {
		
		return list;
	}
	
	public ArrayList<ItemVO> getCUItem() {
		/*
		targetSite = "https://cu.bgfretail.com/event/plusAjax.do";
		for (int i = 2; i <= 10; i++) {
			
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("pageIndex", i+"")
	            		.data("listType", 1+"")
	            		.post();
	            
	            Elements elements = doc.select("div");
	            for (Element element : elements) {
	            	element.select("div > p");
	            	System.out.println(element.text());
	            }
	       } catch (Exception e) {
	    	   
	       }
	                				
		}
		*/
		
		return list;
	}
	
	public void getSevenElevenItem() {
		/*
		// 이중 반복문이 특징. i는 페이지 수, j는 상품 유형
		 
		targetSite = "https://www.7-eleven.co.kr/product/listMoreAjax.asp";
		for (int i = 1; i <= 2; i++) {
			for (int j = 1; j <= 4; j++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("intPageSize", 10+"")
	            		.data("intCurrPage", i+"")
	            		.data("pTab", j+"")
	            		.post();
	            
	            Elements elements = doc.select("dl > dd");
	            for (Element element : elements) {
	            	System.out.println(element.text());
	            }
	            
	       	} catch(Exception e) {}
	       
			}
		}
		*/
	}
	
	public void getEmart24Item() {
		/*
		cpage가 페이지 수
		 
		targetSite = "https://www.emart24.co.kr/product/eventProduct.asp?";
		for (int i = 1; i <= 5; i++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("cpage", i+"")
	            		.post();
	            Thread.sleep(500);
	            Elements elements = doc.select("div > p");
	            for (Element element : elements) {
	            	System.out.println(element);
	            }
	            
	       	} catch(Exception e) {}
	       
			}		
		
		 */
	}
	
	public void getMinistopItem() {
		// 됐다 안 됐다 함
	}
	
	public void getCspaceItem() {
		/*
		cpage가 페이지고 spage는 cpage로부터 계산된 startPage인데 (i+10)이랑은 좀 다를 수 있음
		특이사항: 다른 사이트와는 달리 get 방식
		  
		targetSite = "https://www.cspace.co.kr/service/product.html";
		for (int i = 1; i <= 5; i++) {
				
	       try {
	    	   System.out.println("===================================================");
	            doc = Jsoup.connect(targetSite)
	            		.data("cpage", i+"")
	            		.data("spage", (i+10)+"")
	            		.data("id_position_move", "calSelId")
	            		.get();
	            Thread.sleep(500);
	            Elements elements = doc.select("dl > dt");
	            for (Element element : elements) {
	            	System.out.println(element);
	            }
	            
	       	} catch(Exception e) {}
	       
			}		
		*/
	}
	  
	
}
