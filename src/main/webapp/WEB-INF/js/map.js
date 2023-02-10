let x = document.getElementById("demo");

function getLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else { 
    x.innerHTML = "이 브라우저에서 위치 정보가 지원되지 않습니다.";
  }
}

function showPosition(position) {
  x.innerHTML = "Latitude: " + position.coords.latitude + 
  "<br>Longitude: " + position.coords.longitude;
}

function selectSido() {
	let ssido = document.getElementById('ssido');
	let sgugun = document.getElementById('sgugun');
	$.ajax({
		type: 'POST',
		url: 'selectSido',
		data: {
			sido: ssido.value
		},
		success: res => {
			sgugun.innerHTML = '<option>(구군 선택)</option>'
			
			let object = eval('(' + res + ')')
			let result = object.result;
			let opt = ''
			
			for (let i = 0; i < result.length; i++) {
				opt += '<option>'
				opt += result[i][1].value
				opt += '</option>'
			}
			sgugun.innerHTML = opt
			
			if(ssido.value == '(시도 선택)') {
				sgugun.innerHTML = '<option>(구군 선택)</option>'
			}
		},
		error: e => {
			console.log(e)
		}
	});
}

function searchAdd() {
	let searchAdd = document.getElementById('searchAdd');
	let scvs = document.getElementById('scvs');
	let ssido = document.getElementById('ssido');
	let sgugun = document.getElementById('sgugun');
	let tbody = document.getElementById('tbody');
	$.ajax({
		type: 'POST',
		url: 'searchAdd',
		data: {
			storeName : searchAdd.value.trim(),
			whichCVS : scvs.value,
			ssido : ssido.value,
			sgugun : sgugun.value
		},
		success: res => {

			var mapContainer = document.getElementById('map'), // 지도를 표시할 div 			
			mapOption = {
				center: new kakao.maps.LatLng(37.5696638,126.98427), // 지도의 중심좌표
				level: 6 // 지도의 확대 레벨
			};  
			// 지도 생성
			var map = new kakao.maps.Map(mapContainer, mapOption); 
			var geocoder = new kakao.maps.services.Geocoder();
			
			// DB에서 편의점 정보, 지점명, 주소를 가져온다.
			let object = eval('(' + res + ')')
			let result = object.result;
			
			tbody.innerHTML = ''
			positions = []
			if (result.length == 0) {
				tbody.innerHTML = '<tr><td colspan="3" align="center">편의점 정보가 없습니다!</td></tr>'
			} else {
				for (let i = 0; i < result.length; i++) {	
					tbody.innerHTML += '<tr><td>[' + result[i][2].value + '] ' + result[i][1].value + '</td><td colspan="2">' + result[i][0].value + '</td></tr>'
					positions[i] = {
						address : result[i][0].value,
						storeName : result[i][1].value,
						whichCVS : result[i][2].value						
					}
				}
			}
			
			positions.forEach(function (position) { 
				// 주소로 좌표를 검색
				geocoder.addressSearch(position.address, function(result, status) {		
					// 정상적으로 검색이 완료됐으면 
					if (status === kakao.maps.services.Status.OK) {		
						var coords = new kakao.maps.LatLng(result[0].y, result[0].x);		
						// 결과값으로 받은 위치를 마커로 표시
						var marker = new kakao.maps.Marker({
							map: map,
							position: coords
						});
						// 인포윈도우로 장소에 대한 설명을 표시
						var infowindow = new kakao.maps.InfoWindow({
							content: '<div class="mm">[' + position.whichCVS + '] ' + position.storeName + '</div>'
						});	
						
						// 마커에 마우스오버 이벤트를 등록합니다
						kakao.maps.event.addListener(marker, 'mouseover', function() {
						  // 마커에 마우스오버 이벤트가 발생하면 인포윈도우를 마커위에 표시합니다
						    infowindow.open(map, marker);
						});

						// 마커에 마우스아웃 이벤트를 등록합니다
						kakao.maps.event.addListener(marker, 'mouseout', function() {
						    // 마커에 마우스아웃 이벤트가 발생하면 인포윈도우를 제거합니다
						    infowindow.close();
						});
						
						// 지도의 중심을 결과값으로 받은 위치로 이동
						map.setCenter(coords);
						
					} 
				});    
			});    			
			
		},
		error: e => {
			console.log(e)
		}
	});	
}

onload = () => {
	
	hideSpinner()
	
	var mapContainer = document.getElementById('map'), // 지도를 표시할 div 			
	mapOption = {
		center: new kakao.maps.LatLng(37.5696638,126.98427), // 지도의 중심좌표
		level: 6 // 지도의 확대 레벨
	};  
// 지도 생성
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var geocoder = new kakao.maps.services.Geocoder();
	
	var positions = []
	
	positions.forEach(function (position) { 
		// 주소로 좌표를 검색
		geocoder.addressSearch(position.address, function(result, status) {		
			// 정상적으로 검색이 완료됐으면 
			if (status === kakao.maps.services.Status.OK) {		
				var coords = new kakao.maps.LatLng(result[0].y, result[0].x);		
				// 결과값으로 받은 위치를 마커로 표시
				var marker = new kakao.maps.Marker({
					map: map,
					position: coords
				});
				// 인포윈도우로 장소에 대한 설명을 표시
				var infowindow = new kakao.maps.InfoWindow({
					content: '<div class="mm">[' + position.whichCVS + ']' + position.storeName + '</div>'
				});
				infowindow.open(map, marker);		
				// 지도의 중심을 결과값으로 받은 위치로 이동
				map.setCenter(coords);
			} 
		});    
	});    
	
}

function mapCrawling() {
	showSpinner()
	location.href='mapCrawling';
}

function showSpinner() {
    document.getElementsByClassName('layerPopup')[0].style.display='block';
}
function hideSpinner() {
    document.getElementsByClassName('layerPopup')[0].style.display='none';
}

