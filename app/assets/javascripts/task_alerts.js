function testAlert(alert,url){
	var alertData = {'alert': alert}
	$.ajax({
	 url: url,
	 data: alertData,
	 success: alertComplete
    });
}

function alertComplete(){
	//send html5 notifications
}

function askPermission(){
    window.webkitNotifications.requestPermission("hey this is awesome?");
}
