<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="./images/favicon.png"/>
<script	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
<script	src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
<link rel="stylesheet" href="./css/main.css">
<script type="text/javascript">
	function fn_sendFB(sns) {
	    var thisUrl = document.URL;
	    var snsTitle = "모다: 모두 모으다";
	    if( sns == 'facebook' ) {
	        var url = "http://www.facebook.com/sharer/sharer.php?u="+encodeURIComponent(thisUrl);
	        window.open(url, "", "width=486, height=286");
	    }
	    else if( sns == 'twitter' ) {
	        var url = "http://twitter.com/share?url="+encodeURIComponent(thisUrl)+"&text="+encodeURIComponent(snsTitle);
	        window.open(url, "tweetPop", "width=486, height=286,scrollbars=yes");
	    }
	    else if( sns == 'kakaotalk' ) {
	        // 사용할 앱의 JavaScript 키 설정
	        Kakao.init('36e39b3dce6c1f9eab9b68b6fbfd8144');
	        
	        // 카카오링크 버튼 생성
	        Kakao.Link.createDefaultButton({
	            container: '#btnKakao', // HTML에서 작성한 ID값
	            objectType: 'feed',
	            content: {
		        title: "모다: 모두 모으다", // 보여질 제목
		        description: "편의점 행사 정보가 모두 모여있는 곳!", // 보여질 설명
	            imageUrl: thisUrl, // 콘텐츠 URL
	            link: {
	                mobileWebUrl: thisUrl,
	                webUrl: thisUrl
	            }
	        }
	    });
	}
	}    
</script>
<script src="//developers.kakao.com/sdk/js/kakao.min.js"></script>
</head>
<body>

	<br/><br/><br/>
	<footer>
		<div class="container-fluid" style="background-color: #f8f9fa; color: #777;">
			<div class="row" style="padding: 30px; font-size: 16px;" align="center">
				<div class="col-sm-3" align="left" style="vertical-align: middle;">
					<span>
				   		<a href="#n" onclick="fn_sendFB('facebook');return false;" class="facebook" target="_self" title="페이스북 새창열림">
				   			<img alt="facebook" src="./images/icon-facebook.png">
				   		</a>
					</span>
					<span>
				    	<a href="#n" onclick="fn_sendFB('twitter');return false;" class="twitter" target="_self" title="트위터 새창열림">
				   			<img alt="twitter" src="./images/icon-twitter.png">
				    	</a>
					</span>
					<span>
						<a href="#n" id="btnKakao" onclick="fn_sendFB('kakaotalk');return false;" class="kakaotalk" target="_self" title="카카오톡 새창열림">
				   			<img alt="twitter" src="./images/icon-kakao.png">
						</a>
					</span>
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