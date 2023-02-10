function updateAverscore() {
	let itemIdx = document.getElementById('itemIdx').value;
	let updateScore = document.getElementById('updateAverscore').value
	let originalScore = document.getElementById('originalItemAverscore').value;
	let ID = document.getElementsByName('ID')[0].value;
	let currentPage = document.getElementById('itemCommentCurrentPage').value;
	console.log(updateScore);
	if(updateScore == null || updateScore == "") {
		alert('평점을 입력해주세요.');
	} else {
		location.href='updateAverscoreOK?averscore=' + originalScore + '&itemIdx=' + itemIdx + '&updateScore=' + updateScore + '&ID=' + ID + '&currentPage=' + currentPage;		
	}
	
}

function test(idx, mode, title, content) {
	let frm = document.itemCommentForm

	document.getElementById('itemCommentIdx').value = idx;

	frm.mode.value = mode;
	frm.insertBtn.value = title;
	while (content.indexOf('<br/>') != -1) {
		content = content.replace('<br/>', '\r\n');
	}
	frm.content.value = content;
	frm.content.focus();			
		
}

function commentEmptyChk() {
	let content = $('#content').val();
	
	$.ajax({
		type: 'POST',
		url: 'commentEmptyCheck',
		data: { 
			content: content,
		},
		success: response => {
			switch(response) {
				case '1':
					alert('내용을 입력해주세요.');
					break;
				case '2':
					document.itemCommentForm.submit();
					break
			}
		},
		error: error => {
			console.log('요청실패: ', error.status);
		}
	});
}

function deleteItemComment(idx, mode) {
	let frm = document.itemCommentForm
	
	document.getElementById('itemCommentIdx').value = idx;
	frm.mode.value = mode;
	
	let b = confirm('댓글을 삭제하시겠습니까?')
	if (b == true) {
		frm.submit();
	} else {
		frm.content.value = '';
		frm.insertBtn.value = '등록';
		frm.mode.value = 1;
	}
}

function myItem(id, idx) {	
	mit = document.getElementById('myItemToggle');
	itemModal = document.getElementById('itemModal');
	if (mit.value == 1) {
		$.ajax({
			type: 'POST',
			url: 'myItem',
			data: { 
				id: id,
				idx: idx,
				mit: mit.value
			},
			success: res => {
			},
			error: error => {
				console.log('요청실패: ', error.status);
			}
		});		
		mit.value = 2				
		document.getElementById('myItemInner').innerHTML = 
			'<img alt="찜" src="../images/heart-red.png" id="myItemOff" style="height: 35px; margin-right: 30px;">'
		itemModal.style.display = 'block'	
	} else if (mit.value == 2) {
		$.ajax({
			type: 'POST',
			url: 'myItem',
			data: { 
				id: id,
				idx: idx,
				mit: mit.value
			},
			success: res => {
			},
			error: error => {
				console.log('요청실패: ', error.status);
			}
		});		
		mit.value = 1		
		document.getElementById('myItemInner').innerHTML = 
			'<img alt="찜" src="../images/heart-black.png" id="myItemOn" style="height: 35px; margin-right: 30px;">'
	}
	
}

function modalClose() {
	document.getElementById('itemModal').style.display = 'none'
}

function profileView(id) {
	
	$.ajax({
		type: 'POST',
		url: 'isAdmin',
		data: {
			id: id
		},
		success: res => {				
			
			if (res == 1) {
				alert('관리자의 프로필은 볼 수 없습니다!')
				
			} else {
				let url = '../member/profileView?id=' + id;
				let title = '프로필 보기';
				let option = 'top=100px, left=100px, width=800px, height=800px';
				window.open(url, title, option);				
			}
			
		},
		error: e => {
			console.log(e)
		}
	})	
	
}

onload = () => {
	
	// 찜 여부를 확인하는 기능
	let id = document.getElementsByName('ID')[0].value 
	let itemIdx = document.getElementsByName('itemIdx')[0].value	
	$.ajax({
		type: 'POST',
		url: 'isMyItem',
		data: {
			id: id,
			itemIdx: itemIdx
		},
		success: res => {				
			if (res == 2) {
				// 찜한 적 있음
				document.getElementById('myItemToggle').value = res;
				document.getElementById('myItemInner').innerHTML = '<img alt="찜" src="../images/heart-red.png" id="myItemOff" style="height: 35px; margin-right: 30px;">'
			} else {
				// 찜한 적 없음
				document.getElementById('myItemToggle').value = res;
//				document.getElementById('myItemInner').innerHTML = '<img alt="찜" src="../images/heart-black.png" id="myItemOn" style="height: 35px; margin-right: 30px;">'
			}
		},
		error: e => {
			console.log(e)
		}
	})	
	
	// 현재 위치를 반영해서 지도를 구현하는 기능
	if (navigator.geolocation) {
		
	    // GeoLocation을 이용해서 접속 위치를 얻어옵니다
	    navigator.geolocation.getCurrentPosition(function(position) {
	        
        var lat = position.coords.latitude, // 위도
            lon = position.coords.longitude; // 경도
	        
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
		    center: new kakao.maps.LatLng(lat, lon), // 지도의 중심좌표
		    level: 4 // 지도의 확대 레벨
		}; 
		
		//지도를 생성합니다    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		
		// 이동/확대/축소 안 막으면 렉걸림..
		// 마우스 드래그와 모바일 터치를 이용한 지도 이동을 막는다
		map.setDraggable(false);		
		// 마우스 휠과 모바일 터치를 이용한 지도 확대, 축소를 막는다
		map.setZoomable(false);   		
		
		//주소-좌표 변환 객체를 생성합니다
		var geocoder = new kakao.maps.services.Geocoder();
		
		var marker = new kakao.maps.Marker(), // 클릭한 위치를 표시할 마커입니다
		infowindow = new kakao.maps.InfoWindow({zindex:1}); // 클릭한 위치에 대한 주소를 표시할 인포윈도우입니다
		
		//현재 지도 중심좌표로 주소를 검색하고 콜백 함수를 실행합니다.
		searchAddrFromCoords(map.getCenter(), displayCenterInfo);
		
		//중심 좌표나 확대 수준이 변경됐을 때 지도 중심 좌표에 대한 주소 정보를 표시하도록 이벤트를 등록합니다
		kakao.maps.event.addListener(map, 'idle', function() {
			searchAddrFromCoords(map.getCenter(), displayCenterInfo); 
		});
		
		function searchAddrFromCoords(coords, callback) {
			// 좌표로 행정동 주소 정보를 요청합니다
			geocoder.coord2RegionCode(coords.getLng(), coords.getLat(), callback);         
		}
		
		function searchDetailAddrFromCoords(coords, callback) {
			// 좌표로 법정동 상세 주소 정보를 요청합니다
			geocoder.coord2Address(coords.getLng(), coords.getLat(), callback);
		}
		
		//지도 좌측상단에 지도 중심좌표에 대한 주소정보를 표출하는 함수입니다
		function displayCenterInfo(result, status) {
			if (status === kakao.maps.services.Status.OK) {
			    var infoDiv = document.getElementById('centerAddr');
			
			    for(var i = 0; i < result.length; i++) {
			        // 행정동의 region_type 값은 'H' 이므로
			        if (result[i].region_type === 'H') {
			            infoDiv.innerHTML = result[i].address_name;
			            break;
			        }
			    }
			    
			    let list = result[0].address_name.split(' ')
			    
		        $.ajax({
		    		type: 'POST',
		    		url: 'itemMap',
		    		data: {
		    			ssido : list[0],
		    			sgugun: list[1],
		    			whichCVS: document.getElementById('whichCVS').value
		    		},
		    		success: res => {
		    			// DB에서 편의점 정보, 지점명, 주소를 가져온다.
		    			let object = eval('(' + res + ')')
		    			let result = object.result;
		    			
		    			positions = []
		    			if (result.length == 0) {
		    			} else {
							for (let j = 0; j < result.length; j++) {	
								positions[j] = {
									address : result[j][0].value,
									storeName : result[j][1].value,
									whichCVS : result[j][2].value						
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
		    							content: '<div class="mm">[' + position.whichCVS + '] ' + position.storeName +'<br/>' + 
		    							position.address + '</div>'
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
		    						
		    					} 
		    				});    
		    			}); 
		    		},
		    		error: e => {
		    			console.log(JSON.stringify(e))
		    		}
		        });	    
			    
		        // 마커를 클릭한 위치에 표시합니다 
		        marker.setPosition(mouseEvent.latLng);
		        marker.setMap(map);
		
		        // 인포윈도우에 클릭한 위치에 대한 법정동 상세 주소정보를 표시합니다
		        infowindow.setContent(content);
		        infowindow.open(map, marker); 
		        
			}    
		}	        
   
	    });
	    
	} else { // HTML5의 GeoLocation을 사용할 수 없을때 마커 표시 위치와 인포윈도우 내용을 설정합니다
	    alert('위치 정보를 사용할 수 없습니다.')
	}
	
}

// 같은 이름의 상품이 다른 편의점에서는 얼마인지 그래프로 보여주는 기능
// Load the Visualization API and the corechart package.
google.charts.load('current', {'packages':['corechart']});

// Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawChart);

// Callback that creates and populates a data table,
// instantiates the pie chart, passes in the data and
// draws it.
function drawChart() {
	
	let itemName = document.getElementById('itemName').value
	
	// ajax로 db에서 같은 이름을 가진 상품 정보를 가져온다.
	$.ajax({
		type: 'POST',
		url: 'sameItemName',
		data: {
			itemName : itemName
		},
		success: res => {		
			
			let object = eval('(' + res + ')')
			let result = object.result;
				
			if (result.length != 0) {
				
				var temp = ['', '', '']
				for (let j = 0; j < result.length; j++) {	
					if (j == 0) {
						temp[j] = ['편의점', '가격', { role: 'style' }]					
					}
					temp[j+1] = [result[j][0].value,  result[j][1].value * 1, 
						'rgb(' + (Math.floor(Math.random() * 225 + 1)) +  ', ' + (Math.floor(Math.random() * 225 + 1)) + ', ' + (Math.floor(Math.random() * 225 + 1)) + ')']				
				}
				
				var data =  google.visualization.arrayToDataTable(temp);		
				
				// Set chart options
				var options = {
						'title':'다른 편의점의 같은 상품 가격',
						'width':400,
						'height':300,
						'fontName': 'Pretendard',
						'fontSize': 15,	
						'legend': {position: 'none'},
						'chartArea': {width: '70%', height: '70%'},
				};
				
				// Instantiate and draw our chart, passing in some options.
				var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
				chart.draw(data, options);
				
				document.getElementById('noChart').style.display = 'none'	
					
			}
			
		},
		error: e => {
			console.log(e.status)
		}
	})		

  
  
}	