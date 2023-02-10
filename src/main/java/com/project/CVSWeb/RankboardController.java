package com.project.CVSWeb;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.AbstractApplicationContext;
import org.springframework.context.support.GenericXmlApplicationContext;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.project.dao.ItemDAO;
import com.project.item.ItemList;
import com.project.item.ItemVO;

@Controller
@RequestMapping("/rank")
public class RankboardController {

	private static final Logger logger = LoggerFactory.getLogger(RankboardController.class);

	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/view")
	public String rankView(HttpServletRequest request, Model model, HttpServletResponse response) {
		logger.info("RankboardController의 rankView()");
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
		//	기본 카테고리는 전부
		String category = "모두";
		//	카테고리속성을 받아온다.
		String reCategory = (String) request.getParameter("category");
		
		//	받아온 카테고리 속성이 존재한다면 그걸로 카테고리를 바꿔준다.
		if(reCategory != null) {
			category = reCategory;
		}
		
		//	받아온 카테고리 속성의 상품만 담은 리스트를 만들어준다.
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList itemCate = ctx.getBean("itemList", ItemList.class);
		
		if (category.equals("모두")) {
			itemCate.setList(mapper.selectItems());
		} else {
			itemCate.setList(mapper.selectItemCate(category));
		}
		
		//	카테고리 속성의 상품만 담은 리스트에서 조회수 상위 ()개의 상품만 가져온다.
		int count = 12;
		try {
			// 리스트를 temp에 담아준다.
			ArrayList<ItemVO> tempList = itemCate.getList();
			List<ItemVO> result = null;
			
			//	조회수 기준으로 정렬을 해준다.
			 MiniComparator comp = new MiniComparator();  
		        Collections.sort(tempList, comp); 
			//System.out.println(tempList.size());
			
			//	요구하는 개수보다 리스트 크기가 작은지 큰지 구분해서
			if(tempList.size() <= count)
			{
				result = tempList.subList(0, tempList.size());
			}
			else 
			{
				//	요구하는 크기만큼 리스트를 잘라서 옮겨담아준다.
				result = tempList.subList(0, count);
			}
			//	마지막으로 빈 리스트를 만든뒤
			ArrayList<ItemVO> tempList2 = new ArrayList<ItemVO>();
			tempList2.addAll(result);	//	자른 리스트를 담아주고
			itemCate.setList(tempList2);	//	그 리스트를 ItemList(ArrayList가 아니다) 형태의 list에 담아주고
			model.addAttribute("itemTOP", itemCate);
		} catch (NullPointerException e) {	}
		
//		model.addAttribute("itemTOP", itemCate);
		model.addAttribute("category", category);
		return "board/rank/rankView";
	}
	
	//	list안의 조회수 기준으로 정렬해주는 기능
	class MiniComparator implements Comparator<ItemVO> {  
	    @Override  
	    public int compare(ItemVO first, ItemVO second) {  
	    	int firstValue = first.getHit();  
	    	int secondValue = second.getHit();  
	    	
	    	// Order by descending   
	    	if (firstValue > secondValue) {  
	    		return -1;  
	    	} else if (firstValue < secondValue) {  
	    		return 1;  
	    	} else {  
	    		return 0;  
	    	}  
	    }
	}
	
}
