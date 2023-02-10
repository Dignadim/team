<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 수정</title>
<link rel="icon" href="../images/favicon.png"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="../css/myPageView.css">
<script type="text/javascript" src="../js/myPage.js"></script>
</head>
<body>

<!-- header -->
<%@ include file="../util/hfer/header.jsp" %>

<div class="m-3">
<jsp:useBean id="date" class="java.util.Date"/>
	<div id= "wrap">
	<nav style="display: none;">메뉴영역</nav>
		<div id="content" class="container">
				<div class="b">
					<div class="container mt-3" align="center" style="vertical-align: middle;">
						<div style="padding: 80px 20px;">
							<input type="file" id="imgFile" class="real-upload" accept="image/*" required multiple style="display: none;">
							<div class="upload">
								<img src="${image}" alt="프로필사진" id="profile">
							</div>
							<h2 style="padding-top: 60px">프로필 사진</h2>

							<script>
							    const realUpload = document.querySelector('.real-upload');
							    const upload = document.querySelector('.upload');
							
							    upload.addEventListener('click', () => realUpload.click());
							    realUpload.addEventListener('change', getImageFiles);
							    
								function getImageFiles(e) {
							    	const files = e.currentTarget.files;
							      	if ([...files].length >= 2) { // 두장 이상의 사진을 등록한 경우
							       		alert('한 장의 이미지만 첨부해주세요.')
							       		return;
							      	}
							      	const selectFile = document.getElementById('imgFile').files[0];
							      	const file = URL.createObjectURL(selectFile);
							      	document.getElementById('profile').src = file; // 미리보기용
							      	
									var form = document.getElementById('imgFile').files[0];
									var formData = new FormData();
									formData.append('image', form);
									
							      	 $.ajax({
									        type: "POST",
									        enctype: 'multipart/form-data',
									        url: "profileUpdate",
									        data: formData,
									        processData: false,
									        contentType: false,
									        cache: false,
									        timeout: 600000,
									        success: response => {
									            // alert("성공");
									            document.getElementById('image').value = response;
									        },
									        error: function (e) {
									            alert("등록실패");
									        }
									    });
									
							    }
								
							</script>

						</div>
						<div align="center" style="width: 90%">
							자기소개
							<textarea class="form-control" id="selfIntroduce" name="selfIntroduce" style="resize: none; width: 500px; margin: 15px;" 
							rows="3" onkeyup="updateIntro()">${introduce}</textarea>
						</div>
					</div>
				</div>
		<div class="b"> 
			<form id=f action="updateInfoOK"  method="post"  align="center" onsubmit="return checkInfo(this);"><br /><br /><br /><br /><br />
				<table class="table table-bordered" align="center" style="width: 500px; vertical-align: middle; margin: 20px; border-radius: 5px;">
					<tr height="70px">
						<th style="vertical-align: middle;">ID</th>
						<td align="left">
							<input type="hidden" name="image" id="image" value="${image}"/>
							<input type="hidden" name="introduce" id="introduce" value="${introduce}"/>
							<input type="hidden" name="id" value="${id}"/> 
							${id}
						</td>
						
					</tr>
					<tr height="70px">
						<th style="vertical-align: middle;"><label for="nickname" class="form-label">닉네임</label></th>
						<td>
							<input class="form-control" id="nickname" name="nickname" type="text" value="${nickname}">
						</td>
					</tr>
					<tr height="70px">
						<th style="vertical-align: middle;"><label for="email" class="form-label">이메일</label></th>
						<td>
							<input class="form-control" id="email" name="email" type="email" value="${email}">
						</td>
					</tr>
					<tr height="70px">
						<th style="vertical-align: middle;">가입일자</th>
						<td align="left">
							${signupdate.year + 1900} - ${signupdate.month + 1} - ${signupdate.date}
						</td>
					</tr> 
					<tr height="70px">
						<th style="vertical-align: middle;"><label for="password" class="form-label">비밀번호 변경</label></th>
						<td>
							<input class="form-control id="password" name="password" type="password" value="${password}">
						</td>
					</tr>
					<tr height="70px">
						<th style="vertical-align: middle;"><label for="password2" class="form-label">비밀번호 확인</label></th>
						<td>
							<input class="form-control" id="password2" name="password2" type="password" value="${password}">
						</td>
					</tr>				
					<tr>
						<td colspan="2" align="center">		   
							<button
								style="margin: 5px;"
								class="btn btn-outline-warning"
								type= "submit"
								title="정보수정"
								>정보수정</button>	
							<button
								style="margin: 5px;"
								class="btn btn-outline-info"
								type= "reset"
								title="원래대로"
								>원래대로</button>	
							<button
								style="margin: 5px;"
								class="btn btn-outline-secondary"
								type= "button"
								title="돌아가기"
								onclick="history.back()"
								>돌아가기</button>	
							</td>
						</tr>			
					</table>
				</form>
			</div>
		</div>
	</div>
</div>
<div class="clear">&nbsp;</div>

<!-- footer  -->
<%@ include file="../util/hfer/footer.jsp" %>

</body>
</html>