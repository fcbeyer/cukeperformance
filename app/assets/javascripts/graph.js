// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

function getData(view) {
	var url = document.location.href;
	var formData = $('#graphParameterData').getFormValues();
	if (view == "Summary"){
		$.getJSON(url, {'suite_name':suite}, drawSummaryGraphs);
	}
	else if (view == "Suites"){
		$.getJSON(url, formData, drawSuiteGraphs);
	}
	else if (view == "Features") {
		// old way of getting data $.getJSON(url, {'suite_name':suite}, drawFeatureGraphs);
		$.getJSON(url, formData, drawFeatureGraphs);
	}
	else if (view == "Scenarios") {
		$.getJSON(url, formData, drawScenarioGraphs);
	}
	else {
		$.getJSON(url, formData, drawStepGraphs);	
	}
}

function drawSuiteGraphs(json) {
	drawSuiteBarVisualization(json);
	drawSuiteLineVisualization(json);
}

function drawFeatureGraphs(json) {
	drawFeatureBarVisualization(json);
	drawFeatureLineVisualization(json);
}

function drawScenarioGraphs(json) {
	drawScenarioBarVisualization(json);
	drawScenarioLineVisualization(json);
}

function drawStepGraphs(json) {
	drawStepBarVisualization(json);
	drawStepLineVisualization(json);
}

function drawSummaryGraphs(json){
	//drawSummaryBarVisualization(json);
	drawSummaryLineVisualization(json);
}

//used for updating summary graph page select_tag
$(document).ready(function(){
	$("#summary_suite_name").live("ajax:success", function(evt, data, status, xhr){
	      	drawSummaryGraphs(data);
	});
});