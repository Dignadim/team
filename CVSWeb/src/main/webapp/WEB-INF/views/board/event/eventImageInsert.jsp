<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>이미지 업로드</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/main.css">
</head>
<body>

	<div class="container" style="margin-top: 100px; page: auto;">
		<form method="post" action="eventImageInsertOK" enctype="multipart/form-data"> 
			<table class="table table-bordered">
				<thead>
					<tr>
						<th>사진 업로드</th>
					</tr>
				</thead>				
				<tbody>
					<tr>
						<td>
							<input type="file" class="form-control" name="ev_filename" value=""/>
						</td>
					</tr>
					<tr>
						<td>
							<input type="submit" class="btn btn-outline-success" name="ev_file" value="업로드"/>
						</td>
					</tr>
				</tbody>
			</table>
		</form>
	</div>

</body>
</html>