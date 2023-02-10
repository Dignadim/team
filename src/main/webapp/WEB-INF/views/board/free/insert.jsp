<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>          
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link rel="icon" href="../images/favicon.png"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="../css/freeboard.css"/>
<script type="text/javascript" src="../js/freeboard.js" defer="defer"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/ckeditor.js"></script>
<script src="https://cdn.ckeditor.com/ckeditor5/34.0.0/classic/translations/ko.js"></script>
<script>
  ClassicEditor.create( document.querySelector( '#fb_content') );
  language: "ko"
</script>
    
   	<style>
	.ck.ck-editor {
    	max-width: 900px;
	}
	.ck-editor__editable {
	    min-height: 500px;
	    max-height: 500px;
	}
	</style>
</head>
<body>
	
<!-- header -->
<%@ include file="../../util/hfer/header.jsp" %>
	
	<form class="m-3" action="insertOK" method="post" name='insertForm'>
		<table class="table" style="width: 900px; height: 450px; margin-left: auto; margin-right: auto; margin-top: 80px;">
			<tr style="height: 30px;" class="table-light">
				<th style="display: none;">
					id: <input type="text" id="memberID" name="id" value="${id}">
					nickname: <input type="text" id="nickname" name="nickname" value="${nickname}">
				</th>
				<th class="align-middle table-primary" style="padding: 10px; text-align: center;">
					<label for="subject">제목</label>
				</th>
				<td colspan="2">
					<input id="fb_subject" class="form-control form-control-sm" type="text" name="fb_subject"
						placeholder="제목을 입력해주세요."/>
				</td>
				<th class="align-middle" width="80">
				<c:if test="${grade.trim().equals('y')}">
					공지글 <input class="form-check-input" type="checkbox" name="fb_notice" value="yes"/>
				</c:if>
				</th>
			</tr>		
			<tr class="table-light">
				<th class="align-top table-primary" style="padding: 10px; text-align: center; vertical-align: middle !important;">
					<label for="content">내용</label>
				</th>
				<td colspan="2">
					<textarea id="fb_content" class="form-control form-control-sm" rows="15" name="fb_content" style="resize: none;" onkeyup="test()" placeholder="내용을 입력해주세요.">&nbsp;</textarea>		
<!--\ 					<script>
					  ClassicEditor
					    .create( document.querySelector( '#fb_content' ) )
					    .catch( error => {
					      console.error( error );
					    } );
					</script>	 -->			
					<input id="fb_content" onclick="insertItem()" class="btn btn-dark" type="button" value="상품 이미지 삽입">		
				</td>
				<th></th>
			</tr>
			<tr class="table-light">
				<td colspan="4" align="right">
 			   <input class="btn btn-primary btn-lg" type="button" value="등록"
						style="font-size: 13px;" onclick="insertEmptyChk()"/>
				</td>
			</tr>		
			<tr>
				<td colspan="4" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark" type="button" value="목록보기" onclick="location.href='list'"/>
				</td>
			</tr>	
		</table>	
	</form><br/><br/>		
	
<!-- Modal -->
<div class="modal" tabindex="-1" id="itemModal" style="display: none;">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title">상품 사진 등록하기</h5>
        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close" onclick="modalClose()"></button>
      </div>
      <div class="modal-body">
        <p>검색창에 상품 이름을 검색해보세요.</p>
	<input type="text" id="fb_search_item" onkeyup="fb_search()" class="form-control">
		<div  style="overflow: auto; width: 450px; height: 200px;" align="center">
			<table>
				<tbody id="fb_tbody">
				</tbody>
			</table>
		</div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal" onclick="modalClose()">닫기</button>
      </div>      
	</div>
    </div>
    </div>
	
	
<!-- footer  -->
<%@ include file="../../util/hfer/footer.jsp" %>
	
</body>
</html>