<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 보기</title>
<link rel="icon" href="../../../images/favicon.png"/>
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.9.1/font/bootstrap-icons.css">
<link rel="stylesheet" href="../../../css/listView.css"/>
<script type="text/javascript" src="../../../js/freeboard.js" defer="defer"></script>
<style type="text/css">
	
	* {
		font-family: "Pretendard";
	}
	
</style>
</head>
<body>

   <!-- header -->
   <header>
      <div class="container-fluid">
         <nav class="navbar navbar-expand-sm bg-light">
            <div class="col-sm-2">
               <a href="../../connectMain.jsp"><img src="../../../images/teamlogo.png" style="width: 30px;"></a>
            </div>
            <div class="container-fluid col-sm-5">
               <ul class="navbar-nav">
                  <li class="nav-item" style="padding-right: 70px;">
                      <a class="nav-link" href="../../item/itemList.jsp?">모든 상품 보기</a>
                   </li>               
                  <li class="nav-item dropdown" style="padding-right: 70px;">
                     <a class="nav-link dropdown-toggle" href="#" role="button"   data-bs-toggle="dropdown">행사 보기</a>
                     <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="../event/list.jsp">모든 행사 보기</a></li>
                        <li><a class="dropdown-item" href="#">GS25</a></li>
                        <li><a class="dropdown-item" href="#">CU</a></li>
                        <li><a class="dropdown-item" href="#">세븐일레븐</a></li>
                        <li><a class="dropdown-item" href="#">ministop</a></li>
                        <li><a class="dropdown-item" href="#">이마트24</a></li>
                        <li><a class="dropdown-item" href="#">기타 편의점</a></li>
                     </ul>
                  </li>
                  <li class="nav-item dropdown">
                     <a class="nav-link dropdown-toggle" href="#" role="button"   data-bs-toggle="dropdown">게시판</a>
                     <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="./list.jsp">자유게시판</a></li>
                        <li><a class="dropdown-item" href="../rank/rank.jsp">랭킹게시판</a></li>
                        <li><a class="dropdown-item" href="#">신상게시판</a></li>
                     </ul>
                  </li>
               </ul>
            </div>
            <!-- 검색은 추후 구현 -->
            <div class="col-sm-2">
               <input type="text" class="form-control" placeholder="검색할 내용을 입력하세요." style="width: 200px; display: none;">
            </div> 
            <div class="col-sm-1">
               <button type="button" class="btn btn-primary" onclick="#" style="display:none;">검색</button>
            </div>
            <div class="col-sm-2">
               <c:if test="${id == null}">
                  <button type="button" class="btn btn-primary" onclick="location.href='../../logRegi/login_form.jsp'">로그인</button>   
               </c:if>            
               <c:if test="${id != null}">
                  <button type="button" class="btn btn-danger" onclick="location.href='../../logRegi/login_out.jsp'">로그아웃</button>
                  <c:if test="${grade.trim() != null && grade.trim() == 'y'}">
                     <button class="btn btn-info" style="padding: 6px;" onclick="../../item/itemInsert.jsp">관리 페이지로</button>   
                  </c:if>
                  <c:if test="${grade.trim() == null || grade.trim() != 'y'}">
                     <button type="button" class="btn btn-warning" onclick="location.href='../../myPage/myPageView.jsp'">마이페이지</button>   
                     <input type="hidden" value="${grade}">
                  </c:if>
               </c:if>               
            </div>
         </nav>
      </div>
   </header>
   <br/><br/>

	<div class="m-3">
		<table class="table table-bordered" style="width: 1000px; margin-left: auto; margin-right: auto;">
			<tr class="table-primary">
				<th colspan="5" style="font-size: 30px; text-align: center;">자유게시판</th>
			</tr>
			<tr>
				<td colspan="5" align="right"> 
					${freeboardList.totalCount}건 (${freeboardList.currentPage} / ${freeboardList.totalPage})
				</td>
			</tr>
			<tr class="table-light">
				<th style="width: 100px; text-align: center;">번호</th>
				<th style="width: 560px; text-align: center;">제목</th>
				<th style="width: 120px; text-align: center;">닉네임</th>
				<th style="width: 150px; text-align: center;">작성일</th>
				<th style="width: 70px; text-align: center;">조회수</th>
			</tr>
			<jsp:useBean id="date" class="java.util.Date"/>
				
			<!-- 공지글 -->
			<c:if test="${currentPage == 1}">
			<c:forEach var="fb_vo" items="${fb_notice}">
				<tr class="table-warning">
					<td align="center">
						<i class="bi bi-envelope-exclamation-fill"></i>
					</td>
					<td>
						<i class="bi bi-tags"></i>
						<c:set var="fb_subject" value="${fn:replace(fb_vo.fb_subject, '<', '&lt;')}"/>
						<c:set var="fb_subject" value="${fn:replace(fb_subject, '>', '&gt;')}"/>
						
						<a href="increment.jsp?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}">
							${fb_subject} (${fb_vo.fb_commentCount})
						</a>
						
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<img alt="New" src="../../../images/ic_new.gif"/>
						</c:if>
						
						<c:if test="${fb_vo.fb_hit > 100}">
							<img alt="hot" src="../../../images/hot.gif"/>
						</c:if>
					</td>
					<td align="center">
						${fb_vo.nickname}
					</td>
					<td align="center">
						<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
							<fmt:formatDate value="${fb_vo.fb_date}" pattern="a h:mm"/>
						</c:if>
						<c:if test="${date.year != fb_vo.fb_date.year || date.month != fb_vo.fb_date.month || date.date != fb_vo.fb_date.date}">
							<fmt:formatDate value="${fb_vo.fb_date}" pattern="yyyy.MM.dd(E)"/>
						</c:if>
					</td>
					<td align="center">
						${fb_vo.fb_hit}
					</td>
				</tr>
			</c:forEach>
			</c:if>
			
			<c:set var="list" value="${freeboardList.list}"/>
			
			<c:if test="${list.size() == 0}">
			<tr>
				<td colspan="5">
					<marquee>테이블에 저장된 글이 없습니다.</marquee>
				</td>
			</tr>		
			</c:if>

			<c:if test="${list.size() != 0}">
			<c:set var="num" value="${freeboardList.totalCount - ((freeboardList.currentPage-1) * 10) }"/>
			<c:forEach var="fb_vo" items="${list}">
			<tr>
				<td align="center">
					${num}
				</td>
				<td>
					<i class="bi bi-tags"></i>
					<c:set var="fb_subject" value="${fn:replace(fb_vo.fb_subject, '<', '&lt;')}"/>
					<c:set var="fb_subject" value="${fn:replace(fb_subject, '>', '&gt;')}"/>
						
					<a href="increment.jsp?fb_idx=${fb_vo.fb_idx}&currentPage=${freeboardList.currentPage}">
						${fb_subject} (${fb_vo.fb_commentCount})
					</a>
						
					<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
						<img alt="New" src="../../../images/ic_new.gif"/>
					</c:if>
						
					<c:if test="${fb_vo.fb_hit > 100}">
						<img alt="hot" src="../../../images/hot.gif"/>
					</c:if>
				</td>
				<td align="center">
					${fb_vo.nickname}
				</td>
				<td align="center">
					<c:if test="${date.year == fb_vo.fb_date.year && date.month == fb_vo.fb_date.month && date.date == fb_vo.fb_date.date}">
						<fmt:formatDate value="${fb_vo.fb_date}" pattern="a h:mm"/>
					</c:if>
					<c:if test="${date.year != fb_vo.fb_date.year || date.month != fb_vo.fb_date.month || date.date != fb_vo.fb_date.date}">
						<fmt:formatDate value="${fb_vo.fb_date}" pattern="yyyy.MM.dd(E)"/>
					</c:if>
				</td>
				<td align="center">
					${fb_vo.fb_hit}
				</td>
			</tr>	
			<c:set var="num" value="${num-1}"/>		<!--  -->
			</c:forEach>
			</c:if>

			<tr align="center" class="table table-light">
				<td colspan="4" align="center">
					<c:if test="${freeboardList.currentPage > 1}">
						<button 
							class="btn btn-outline-primary" 
							type="button" 
							title="첫 페이지로 이동합니다."
							onclick="location.href='?currentPage=1'"
						>≪</button> 
					</c:if>
					<c:if test="${freeboardList.currentPage <= 1}">
						<button 
							class="btn btn-outline-secondary" 
							type="button" 
							disabled="disabled" 
							title="이미 첫 페이지입니다."
						>≪</button>
					</c:if>
					
					<c:if test="${freeboardList.startPage > 1}">
						<button 
							class="btn btn-outline-primary"
							type="button" 
							title="이전 10페이지로 이동합니다."
							onclick="location.href='?currentPage=${freeboardList.startPage - 1}'"
						>＜</button>
					</c:if>
					<c:if test="${freeboardList.startPage <= 1}">
						<button 
							class="btn btn-outline-secondary" 
							type="button" 
							disabled="disabled" 
							title="이미 첫 10페이지입니다."
						>＜</button>
					</c:if>
					
					<c:forEach var="i" begin="${freeboardList.startPage}" end="${freeboardList.endPage}" step="1">
						<c:if test="${freeboardList.currentPage == i}">
							<button 
								class="btn btn-outline-secondary" 
								type="button" 
								disabled="disabled"
							>${i}</button> 
						</c:if>
						<c:if test="${freeboardList.currentPage != i}">
							<button 
								class="btn btn-outline-primary" 
								type="button" 
								onclick="location.href='?currentPage=${i}'"
							>${i}</button>
						</c:if>
					</c:forEach>
				
					<c:if test="${freeboardList.endPage < freeboardList.totalPage}">
					<button 
						class="btn btn-outline-primary" 
						type="button" 
						title="다음 10페이지로 이동합니다."
						onclick="location.href='?currentPage=${freeboardList.endPage + 1}'"
					>＞</button>
					</c:if>
					<c:if test="${freeboardList.endPage >= freeboardList.totalPage}">
					<button 
						class="btn btn-outline-secondary" 
						type="button" 
						disabled="disabled" 
						title="이미 마지막 10페이지입니다."
					>＞</button>
					</c:if>
					
					<c:if test="${freeboardList.currentPage < freeboardList.totalPage}">
					<button 
						class="btn btn-outline-primary" 
						type="button" 
						title="마지막 페이지로 이동합니다."
						onclick="location.href='?currentPage=${freeboardList.totalPage}'"
					>≫</button>
					</c:if>
					<c:if test="${freeboardList.currentPage >= freeboardList.totalPage}">
					<button 
						class="btn btn-outline-secondary" 
						type="button" 
						disabled="disabled" 
						title="이미 마지막 페이지입니다."
					>≫</button>
					</c:if>
				</td>
				<td colspan="1" align="right">
				<!-- 
					만약 로그인 하지 않고 누르는 경우 alert('회원만 이용 가능한 서비스입니다.')
					alert가 나온 후 바로 로그인 모달창 띄우기
				  -->
				<c:if test="${id == null}">
					<input class="btn btn-outline-primary btn-sm" type="button" value="글쓰기" 
						 onclick="cautionMsg()"/>
				</c:if>
				<c:if test="${id != null}">
					<input type="hidden" id="id" name="id" value="${id}">
					<input class="btn btn-outline-primary btn-sm" type="button" value="글쓰기" 
						 onclick="location.href='insert.jsp'"/>
				</c:if>
				</td>
			</tr>
		</table>
	</div><br/><br/>
	
   <!-- footer  -->
   <footer>
      <div class="container-fluid" style="background-color: #f8f9fa; color: #777;">
         <div class="row" style="padding: 30px; font-size: 16px;" align="center">
            <div class="col-sm-3">
               &nbsp;
            </div>
            <div class="col-sm-6">
               <br/>
               &copy;4조&nbsp;&nbsp;최성민&nbsp;&nbsp;길동현&nbsp;&nbsp;김민주&nbsp;&nbsp;신수혁&nbsp;&nbsp;최형록
               &nbsp;<br/>
            </div>
            <div class="col-sm-3">
               &nbsp;
            </div>
         </div>
      </div>
   </footer>

</body>
</html>