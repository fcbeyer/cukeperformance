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
		var myNotification;
		var myAlertSubject;
		var myOkSubject;
		var alertGenerated;
		for(var i=1; i < data.length; i++) {
			myNotification = "the current average for ";
			myAlertSubject = data[0] + " PERFORMANCE ALERT";
			myOkSubject = data[0] + " is Okay";
			alertGenerated = data[i][1] 
			myNotification = myNotification + data[i][0].browser + " is " + data[i][2]
			if (alertGenerated) {
				window.webkitNotifications.createNotification('http://media.tumblr.com/tumblr_m63vd5EW2I1qly8of.jpg',myAlertSubject,myNotification).show();	
			} else {
				window.webkitNotifications.createNotification('http://media.tumblr.com/tumblr_m63vd5EW2I1qly8of.jpg',myOkSubject,myNotification).show();
			}
    	}
	}
}