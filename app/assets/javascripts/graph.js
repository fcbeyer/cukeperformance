// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
function getData(view,graph){
	$('#loading_screen').show();
	var url = document.location.href
	var formData = $('#graphParameterData').getFormValues();
	$.ajax({
	 url: url,
	 data: formData,
	 success: graph,
	 complete: hideLoading
    });
}

function getAverage(data) {
	average = 0;
	for(var i = 0; i < data.length; i++){
		average += data[i].duration/1000000 
	}
	average /= data.length;
	return average
}

function convertAverage(data){
	var seconds = data / 1000;
	var numhours = padNumber(Math.floor(((seconds % 31536000) % 86400) / 3600),"hours");
	var numminutes = padNumber(Math.floor((((seconds % 31536000) % 86400) % 3600) / 60),"minutes");
	var numseconds = padNumber(Math.floor((((seconds % 31536000) % 86400) % 3600) % 60),"seconds");
	var nummilliseconds = padNumber((data % 1000),"milliseconds");
	converted =  numhours + ":" + numminutes + ":" + numseconds + ":" + nummilliseconds
	return converted

}

function padNumber(number,unitOfTime){
	if (unitOfTime == "milliseconds" && number < 100){
		return ("0" + parseInt(number))
	}
	else if (number < 10){
		return ("0" + number)
	}
	else {
		return parseInt(number)
	}
}

function hideLoading() {
	$('#loading_screen').hide();
}

function drawSuitesGraphs(json) {
	drawSuiteBarVisualization(json);
	drawSuiteLineVisualization(json);
}

function drawFeaturesGraphs(json) {
	drawFeatureBarVisualization(json);
	drawFeatureLineVisualization(json);
}

function drawScenariosGraphs(json) {
	drawScenarioBarVisualization(json);
	drawScenarioLineVisualization(json);
}

function drawStepsGraphs(json) {
	drawStepBarVisualization(json);
	drawStepLineVisualization(json);
}

function drawSummaryGraphs(json){
	drawSummaryLineVisualization(json);
}

//used for updating summary graph page select_tag
$(document).ready(function(){
	$("#summary_suite_name").on("ajax:success", function(evt, data, status, xhr){
	      	drawSummaryGraphs(data);
	});
});