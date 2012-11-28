// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

function getData(suite,view) {
	var url = document.location.href;
	var formData = $('#graphParameterData').getFormValues();
	formData['suite_name'] = suite;
	if (view == "Suites"){
		$.getJSON(url, {'suite_name':suite}, drawSuiteGraphs);
	}
	else if (view == "Features") {
		$.getJSON(url, {'suite_name':suite}, drawFeatureGraphs);
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
