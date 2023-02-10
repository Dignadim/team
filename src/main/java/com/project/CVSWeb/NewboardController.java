package com.project.CVSWeb;

import java.util.HashMap;

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

@Controller
@RequestMapping("/new")
public class NewboardController {
	
	private static final Logger logger = LoggerFactory.getLogger(NewboardController.class);
	
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/view")
	public String newView(HttpServletRequest request, Model model, HttpServletResponse response) {
		logger.info("NewboardController의 newView()");
		
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));		
		} catch (NumberFormatException e) { }
		
		ItemDAO mapper = sqlSession.getMapper(ItemDAO.class);
		
//		신상품: 등록된지 30일 이내의 상품
//		1페이지 분량의 신상품을 얻어온다.
		
		AbstractApplicationContext ctx = new GenericXmlApplicationContext("classpath:applicationCTX.xml");
		ItemList newItemList = ctx.getBean("itemList", ItemList.class);
		
		int pageSize = 12;
		int totalCount = mapper.selectNewItemCount();
		
		newItemList.initItemList(pageSize, totalCount, currentPage);
		
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", newItemList.getStartNo());
		hmap.put("endNo", newItemList.getEndNo());	
		
		newItemList.setList(mapper.selectNewItemList(hmap));
		// System.out.println(newItemList);
		
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("newItemList", newItemList);
		
		return "board/new/newView";
	}

}
