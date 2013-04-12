function captureData(url){
	var generateData = {'send_email': false}
	$.ajax({
	 url: url,
	 data: generateData,
	 success: captureDataComplete
    });
}

$(document).ready(function(){
		$("#suiteTable").tablesorter( {headers: { 3: {sorter: false}, 4: {sorter: false}}});
});

function captureDataComplete(data){
	//send html5 notifications
	//haveNewSuiteData, directoryDoesNotExist, display_name
	if (window.webkitNotifications.checkPermission() == 0) {
		var myNotification;
		var mySubject;
		if (data[1]){
			//directory or JSON files were missing
			mySubject = data[2] + " DATA ALERT";
			myNotification ="The directory or JSON files do NOT exist"
		}
		else {
			mySubject = data[2]
			if (data[0]){
				myNotification = "New data was found"
			}
			else {
				myNotification = "No new data was found"
			}
		} 
		window.webkitNotifications.createNotification('http://images4.wikia.nocookie.net/__cb20110309055904/memoryalpha/en/images/7/7a/Data,_2379.jpg',mySubject,myNotification).show();
	}
}

function drawSuiteBarVisualization(d) {
          
    var data = d
    // Create and populate the data table.
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Build Date');
    dataTable.addColumn('number', 'Duration (milliseconds)');
    dataTable.addColumn('string', 'Status');
    dataTable.addColumn('string', 'Suite');
    dataTable.addColumn({type:'string', role:'tooltip'});
    dataTable.addColumn('string', 'Browser');
    dataTable.addColumn('string', 'Mobilizer Version');
    
    for(var i=0; i < data.length; i++) {
      dataTable.addRow([data[i].build_date+"_"+data[i].build_time, data[i].duration/1000000, data[i].status, data[i].name,
      	data[i].duration_converted + "\n hr:min:sec:ms \n" + data[i].mobilizer_build_tag, data[i].browser, data[i].mobilizer]);
    }
  
    var statusBarPicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'control1',
      'options': {
        'filterColumnLabel': 'Status',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
    
    var browserBarPicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'browser1',
      'options': {
        'filterColumnLabel': 'Browser',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
    
    var versionBarPicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'version1',
      'options': {
        'filterColumnLabel': 'Mobilizer Version',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
    
    // Define a slider control for the 'Build Date' column
    var slider = new google.visualization.ControlWrapper({
      'controlType': 'StringFilter',
      'containerId': 'control2',
      'options': {
        'filterColumnLabel': 'Build Date',
          'ui': {'labelStacking': 'vertical'}
      }
    });
        
    var barChart = new google.visualization.ChartWrapper({
      'chartType': 'BarChart',
      'containerId': 'chart1',
      'options': {
        'width': 900,
        'height': 700,
        'tooltip': {'column':4},
        'hAxis': {
        	'slantedText': true,
        	'title': "Duration (milliseconds)"
        },
        'vAxis': {
        	'title': "Run Date"
        },
        'chartArea': {top: 10, right: 0, bottom: 0}
      },
      // Configure the barchart to use columns 0 (Build Date/Time Stamp) and 1 (Duration)
      'view': {'columns': [0, 1, 4]}
    });
  
    // Create the dashboard.
    new google.visualization.Dashboard(document.getElementById('dashboard')).
      bind(statusBarPicker, barChart).
      bind(slider, barChart).
      bind(browserBarPicker, barChart).
      bind(versionBarPicker, barChart).
      // Draw the dashboard
      draw(dataTable);
}

function drawSuiteLineVisualization(d2) {
	      	
  	var data3 = d2
  	
    // Create and populate the data table.
    var dataTable3 = new google.visualization.DataTable();
    dataTable3.addColumn('date', 'Build Date');
    dataTable3.addColumn('number', 'Duration (milliseconds)');
    dataTable3.addColumn('string', 'Status');
    dataTable3.addColumn('string', 'Suite');
    dataTable3.addColumn({type:'string', role:'tooltip'});
    dataTable3.addColumn('string', 'Browser');
    dataTable3.addColumn('string', 'Mobilizer Version');
    
    for(var i=0; i < data3.length; i++) {
    	dataTable3.addRow([new Date(data3[i].runstamp), data3[i].duration/1000000, data3[i].status, data3[i].name,
    		data3[i].duration_converted + "\n hr:min:sec:ms \n" + data3[i].mobilizer_build_tag, data3[i].browser, data3[i].mobilizer]);
    }
  	
  	var datePicker = new google.visualization.ControlWrapper({
       'controlType': 'ChartRangeFilter',
       'containerId': 'suiteRangeFilter',
       'options': {
         // Filter by the date axis.
         'filterColumnIndex': 0,
         'ui': {
           'chartType': 'LineChart',
           'chartOptions': {
             'chartArea': {'width': '90%', 'height':'50'},
             'hAxis': {'textPosition': 'out', 'slantedText': true}
           },
           // Display a single series that shows the closing value of the stock.
           // Thus, this view has two columns: the date (axis) and the stock value (line series).
           'chartView': {
             'columns': [0, 1]
           }
       }},
     });
    
    var statusLinePicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'statusLineFilter',
      'options': {
        'filterColumnLabel': 'Status',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
    
    var browserLinePicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'browser2',
      'options': {
        'filterColumnLabel': 'Browser',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
    
    var versionLinePicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'version2',
      'options': {
        'filterColumnLabel': 'Mobilizer Version',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
      	
    var lineChart = new google.visualization.ChartWrapper({
      'chartType': 'LineChart',
      'containerId': 'linechart',
      'options': {
        'width': 1000,
        'height': 700,
        'pointSize': 6,
        'tooltip': {'column':4},
        // 'hAxis': {
        	// 'slantedText': true,
        	// 'title': "Run Date"
        // },
        'hAxis': {
        	'slantedText': true,
        	'title': "Run Date"
        },
        'vAxis':{
        	'title': "Duration (milliseconds)"
        },        
        'chartArea': {top: 10, right: 0, bottom: 0}
      },
      'view': {'columns': [0, 1, 4]}
    });
  	
    // Create the dashboard.
    new google.visualization.Dashboard(document.getElementById('dashboard3')).
      bind(statusLinePicker, [lineChart, datePicker]).
      bind(datePicker, lineChart).
      bind(browserLinePicker, lineChart).
      bind(versionLinePicker, lineChart).
      // Draw the dashboard
      draw(dataTable3);
}


// THIS IS FOR THE EXECUTIVE SUMMARY PAGE !!!!!!!!!!!!!!!!!!!
function drawSummaryLineVisualization(d2) {
	      	
  	var data3 = d2
  	
  	var average = getAverage(data3)
  	var converted_average = convertAverage(average)
  	
    // Create and populate the data table.
    var dataTable3 = new google.visualization.DataTable();
    dataTable3.addColumn('date', 'Build Date');
    dataTable3.addColumn('number', 'Duration (milliseconds)');
    dataTable3.addColumn({type:'boolean',role:'certainty'});
    dataTable3.addColumn('string', 'Status');
    dataTable3.addColumn('string', 'Suite');
    dataTable3.addColumn({type:'string', role:'tooltip'});
    dataTable3.addColumn('string', 'Browser');
    dataTable3.addColumn('string', 'Mobilizer Version');
    dataTable3.addColumn('number', 'Average (milliseconds)')
    dataTable3.addColumn({type:'boolean',role:'certainty'});
    dataTable3.addColumn({type:'string', role:'tooltip'});
    
    for(var i=0; i < data3.length; i++) {
    	dataTable3.addRow([new Date(data3[i].runstamp), data3[i].duration/1000000, true, data3[i].status, data3[i].name,
    		data3[i].duration_converted + "\n hr:min:sec:ms \n" + data3[i].mobilizer_build_tag, data3[i].browser, data3[i].mobilizer, parseInt(average), false, converted_average]);
    }
    
    var statusSummaryPicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'statusSummaryFilter',
      'options': {
        'filterColumnLabel': 'Status',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
    
    var browserSummaryPicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'browserSummaryFilter',
      'options': {
        'filterColumnLabel': 'Browser',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
    
    var versionSummaryPicker = new google.visualization.ControlWrapper({
      'controlType': 'CategoryFilter',
      'containerId': 'versionSummaryFilter',
      'options': {
        'filterColumnLabel': 'Mobilizer Version',
        'ui': {
          'labelStacking': 'vertical',
          'allowTyping': false,
          'allowMultiple': false
        }
      }
    });
      	
    var lineChart = new google.visualization.ChartWrapper({
      'chartType': 'LineChart',
      'containerId': 'linechart',
      'options': {
        'width': 900,
        'height': 700,
        'pointSize': 6,
        'tooltip': {'column':5},
        'hAxis': {
        	'slantedText': true,
        	'title': "Run Date"
        },
        'vAxis':{
        	'title': "Duration (milliseconds)"
        },        
        'chartArea': {top: 10, right: 0, bottom: 0}
      },
      // Configure the linechart to use columns 0 (Build Date/Time Stamp), 1 (Duration) for the graph, and column 5 as a tooltip
      'view': {'columns': [0, 1, 5, 8, 9, 10]}
    });
  	
    // Create the dashboard.
    new google.visualization.Dashboard(document.getElementById('dashboard3')).
      bind(statusSummaryPicker, lineChart).
      bind(browserSummaryPicker, lineChart).
      bind(versionSummaryPicker, lineChart).
      // Draw the dashboard
      draw(dataTable3);
}
