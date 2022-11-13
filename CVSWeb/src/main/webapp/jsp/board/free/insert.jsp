<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글 작성</title>
<link rel="icon" href="../../../images/favicon.png"/>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="../../../css/freeboard.css"/>
<style type="text/css">
	body {
		font-family: 'Pretendard Variable';
	}
</style>
</head>
<body>
	

	<header>
	 		<div>
	 			<a href="#" style="color: black; font-weight: bold; position: relative; top: 20px; left: 20px; 
	 				border: 10px solid;">사이트 이름</a>
	 		</div>
	</header>
	<form class="m-3" action="insertOK.jsp" method="post">
		<table class="table" style="width: 900px; height: 450px; margin-left: auto; margin-right: auto; margin-top: 80px;">
			<tr class="table-secondary" style="height: 30px;">
				<th class="align-middle table-secondary" style="padding: 10px; text-align: center;">
					<label for="subject">제목</label>
				</th>
				<td colspan="2">
					<input id="fb_subject" class="form-control form-control-sm" type="text" name="fb_subject"
						placeholder="제목을 입력해주세요."/>
				</td>
			</tr>		
			<tr class="table-secondary">
				<th class="align-top table-secondary" style="padding: 10px; text-align: center;">
					<label for="content">내용</label>
				</th>
				<td colspan="2">
					<textarea id="fb_content" class="form-control form-control-sm" rows="15" name="fb_content" 
					 	style="resize: none;" placeholder="내용을 입력해주세요."></textarea>
				</td>
			</tr>
			<tr class="table-secondary">
				<td colspan="3" align="right">
					<input class="btn btn-primary btn-lg" type="submit" value="등록"
						style="font-size: 13px;"/>
				</td>
			</tr>		
			<tr>
				<td colspan="3" align="right" style="border: 0px; outline: 0px;">
					<input class="btn btn-dark" type="button" value="목록보기" onclick="location.href='list.jsp'"/>
				</td>
			</tr>	
		</table>	
	</form>	

</body>
</html>