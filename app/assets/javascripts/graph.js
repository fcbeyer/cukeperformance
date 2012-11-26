// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

function getBvtData() {
	var url = document.location.href;
	$.getJSON(url, {'suite_name':'BVT'}, drawGraphs);
}

function getPortalSmokeData() {
	var url = document.location.href;
	$.getJSON(url, {'suite_name':'PortalSmoke'}, drawGraphs);
}

function drawGraphs(json) {
	drawVisualization(json);
	drawVisualization2(json);
}
