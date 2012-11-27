function drawSuiteBarVisualization(d) {
          
    var data = d
    // Create and populate the data table.
    var dataTable = new google.visualization.DataTable();
    dataTable.addColumn('string', 'Build Date');
    dataTable.addColumn('number', 'Duration');
    dataTable.addColumn('string', 'Status');
    dataTable.addColumn('string', 'Suite');
    dataTable.addColumn({type:'string', role:'tooltip'});
    
    for(var i=0; i < data.length; i++) {
      dataTable.addRow([data[i].build_date+"_"+data[i].build_time, data[i].duration, data[i].status, data[i].name, data[i].duration_converted]);
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

        'chartArea': {top: 0, right: 0, bottom: 0}
      },
      // Configure the barchart to use columns 0 (Build Date/Time Stamp) and 1 (Duration)
      'view': {'columns': [0, 1, 4]}
    });
  
    // Create the dashboard.
    new google.visualization.Dashboard(document.getElementById('dashboard')).
      bind(statusBarPicker, barChart).
      bind(slider, barChart).
      // Draw the dashboard
      draw(dataTable,
        {title:"Suite Performance",
         vAxis: {title: "Build"},
         hAxis: {title: "Duration in Nanoseconds"}}
      );
}

function drawSuiteLineVisualization(d2) {
	      	
  	var data3 = d2
  	
    // Create and populate the data table.
    var dataTable3 = new google.visualization.DataTable();
    dataTable3.addColumn('date', 'Build Date');
    dataTable3.addColumn('number', 'Duration');
    dataTable3.addColumn('string', 'Status');
    dataTable3.addColumn('string', 'Suite');
    dataTable3.addColumn({type:'string', role:'tooltip'});
    
    for(var i=0; i < data3.length; i++) {
    	dataTable3.addRow([new Date(data3[i].runstamp), data3[i].duration, data3[i].status, data3[i].name, data3[i].duration_converted]);
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
             'chartArea': {'width': '90%'},
             'hAxis': {'slantedText': true}
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
      	
    var lineChart = new google.visualization.ChartWrapper({
      'chartType': 'LineChart',
      'containerId': 'linechart',
      'options': {
        'width': 900,
        'height': 700,
        'pointSize': 6,
        'tooltip': {'column':4},
        'hAxis': {
        	'slantedText': true
        },
        
        'chartArea': {top: 0, right: 0, bottom: 0}
      },
      // Configure the barchart to use columns 0 (Build Date/Time Stamp) and 1 (Duration)
      'view': {'columns': [0, 1, 4]}
    });
  	
    // Create the dashboard.
    new google.visualization.Dashboard(document.getElementById('dashboard3')).
      bind(statusLinePicker, [lineChart, datePicker]).
      bind(datePicker, lineChart).
      // Draw the dashboard
      draw(dataTable3);
}
