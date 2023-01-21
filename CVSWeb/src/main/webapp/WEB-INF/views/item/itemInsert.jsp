<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>상품 등록 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript" src="../js/jquery-3.6.1.js" defer></script>
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript" src="../js/itemInsert.js" defer></script>
</head>
<body>
	<div class="container" style="margin-top: 100px; width: 800px">
		<form method="post" action="insertOK"> 
			<table class="table table-hover table-bordered">
				<thead>
					<tr>
						<th class="info" colspan="2" style="text-align: center; vertical-align: middle;">
							<h2>상품 등록</h2>
						</th>
					</tr>
				</thead>
				<tbody>
					<tr>
					<th style="text-align: center; width: 150px; vertical-align: middle;">상품 사진</th>
						<td>
							<div class="upload">
								<input type="file" id="imgFile" class="real-upload form-control" accept="image/*" required multiple>
								<input type="hidden" id="itemImage" name="itemImage">
								<img src="" alt="5MB 이하, *.jpg, *.png, *.gif 파일만 업로드 가능합니다." id="image">							
							</div>					
 							<script>
							    const realUpload = document.querySelector('.real-upload');
							    realUpload.addEventListener('change', getImageFiles);
							    
								function getImageFiles(e) {
							    	const files = e.currentTarget.files;
							      	if ([...files].length >= 2) { // 두장 이상의 사진을 등록한 경우
							       		alert('한 장의 이미지만 첨부해주세요.')
							       		return;
							      	}
							      	const selectFile = document.getElementById('imgFile').files[0];
							      	const file = URL.createObjectURL(selectFile);
							      	document.getElementById('image').src = file; // 미리보기용
							      	
									var form = document.getElementById('imgFile').files[0];
									var formData = new FormData();
									formData.append('image', form);
									
							      	 $.ajax({
									        type: "POST",
									        enctype: 'multipart/form-data',
									        url: "itemImageInsertOK",
									        data: formData,
									        processData: false,
									        contentType: false,
									        cache: false,
									        timeout: 600000,
									        success: response => {
									            document.getElementById('itemImage').value = response;
									        },
									        error: function (e) {
									            alert("등록실패: " + e.status);
									        }
									    });
							    }								
							</script> 
						</td>
					</tr>				
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">상품명</th>
						<td>
							<input class="form-control" type="text" placeholder="상품명을 입력해주세요." name="itemName">
						</td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">원가</th>
						<td>
							<input class="form-control" type="text" placeholder="원가를 입력해주세요." name="itemPrice" width="600px;">
						</td>
					</tr>				
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">카테고리</th>
						<td>
							<select class="form-select" name="category">
								<option>식품</option>
								<option>음료/아이스크림</option>
								<option>과자/빵</option>
								<option>잡화</option>
								<option>기타상품</option>
							</select>
						</td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">판매 편의점</th>
						<td>
							<select class="form-select" name="sellCVS" size="6">
								<option selected>CU</option>
								<option>GS25</option>
								<option>세븐일레븐</option>
								<option>ministop</option>
								<option>이마트24</option>
								<option>C·SPACE</option>
							</select>
						</td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">행사</th>
						<td>
							<select class="form-select" name="eventType" id="eventType">
								<option selected>1+1</option>
								<option>2+1</option>
								<option>덤증정</option>
								<option>할인</option>
								<option>기타행사</option>
							</select>
						</td>
					</tr>
					<tr>
						<th style="text-align: center; width: 150px; vertical-align: middle;">증정 상품</th>
						<td>
							<input class="form-control" type="text" placeholder="증정상품명을 입력해주세요" name="addItemName" width="600px;">
						</td>
					</tr>				
				</tbody>
				<tfoot>
					<tr>
						<td colspan="1" align="center">
							<input class="btn btn-success" type="button" onclick="location.href='../'" value="메인으로">
						</td>
						<td colspan="1" align="center">
							<input class="btn btn-primary" type="submit" value="등록">
						</td>
					</tr>					
				</tfoot>
			</table>
		</form>
	</div>

</body>
</html>