function testAlert(alert,url){
	var alertData = {'alert': alert}
	$.ajax({
	 url: url,
	 data: alertData,
	 success: alertComplete
    });
}

function alertComplete(data){
	//send html5 notifications
	if (window.webkitNotifications.checkPermission() == 0) {
		var myNotification = "for browser ";
		var myAlertSubject = data[0] + " PERFORMANCE ALERT";
		var myOkSubject = data[0] + " is Okay";
		var alertGenerated;
		for(var i=1; i < data.length; i++) {
			alertGenerated = data[i][1] 
			myNotification = myNotification + data[i][0].browser
			if (alertGenerated) {
				window.webkitNotifications.createNotification('http://media.tumblr.com/tumblr_m63vd5EW2I1qly8of.jpg',myAlertSubject,myNotification).show();	
			} else {
				window.webkitNotifications.createNotification('http://media.tumblr.com/tumblr_m63vd5EW2I1qly8of.jpg',myOkSubject,myNotification).show();
			}
    	}
	}
}
