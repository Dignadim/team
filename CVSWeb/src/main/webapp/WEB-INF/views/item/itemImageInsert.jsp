<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 업로드 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<link rel="stylesheet" href="../css/main.css">
<script type="text/javascript" src="../js/jquery-3.6.1.js" defer></script>
<script type="text/javascript" src="../js/itemInsert.js" defer></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

	<div class="container" style="margin-top: 100px; width: 800px">
		<form method="post" action="itemImageInsertOK" enctype="multipart/form-data"> 
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>사진 업로드</th>
					</tr>
				</thead>				
				<tbody>
					<tr>
						<td>
							<input type="file" name="itemImage"/>
							<div>&nbsp;&nbsp; 5MB 이하, *.jpg, *.png, *.gif 파일만 업로드 가능합니다.</div>
						</td>
					</tr>
					<tr>
						<td>
							<div id="imageThumbnail"></div>
						</td>
					</tr>
					<tr>
						<td>
							<input type="submit" class="btn btn-outline-success" name="itemImage" value="업로드"/>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>

</body>
</html>