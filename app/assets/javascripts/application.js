// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require_tree .

jQuery.fn.getFormValues = function(){
    var formvals = {};
    jQuery.each(jQuery(':input',this).serializeArray(),function(i,obj){        
        if (formvals[obj.name] == undefined)
            formvals[obj.name] = obj.value;
        else if (typeof formvals[obj.name] == Array) 
            formvals[obj.name].push(obj.value);
        else formvals[obj.name] = [formvals[obj.name],obj.value];
    });    
    return formvals;
}