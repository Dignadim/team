<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사진 업로드 페이지</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../../css/main.css">
<script type="text/javascript" src="../../js/itemInsert.js" defer></script>
</head>
<body>

	<div class="container" style="margin-top: 100px; width: 800px">
		<form method="post" action="itemImageInsertOK.jsp" enctype="multipart/form-data"> 
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