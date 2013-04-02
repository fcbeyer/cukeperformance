module ApplicationHelper
	
	def alert_information
		if browser.ie?
  		return "Alerts notifications do NOT work in IE.  Please switch over to Chrome or Firefox for a better experience"
    elsif browser.firefox?
    	return raw("<a href=\"https://addons.mozilla.org/en-us/firefox/addon/html-notifications/\" target=\"_blank\">Please make sure this add-on is enabled to receive notifications</a>")
    else
    	return "Alert notifications are supported, make sure they are enabled!"
		end
	end
	
  def display_button(size, color)
 		if browser.ie?
 			return enabled_or_disabled_button(size,color,false)
 		else
 			return enabled_or_disabled_button(size,color,true)
 		end
 	end
 	
 	def enabled_or_disabled_button(size, color, enable)
 		if enable.kind_of?(FalseClass)
 			#disable the button
 			return raw("class=\"btn btn-#{size} btn-#{color}\" disabled")
 		else
 			#enable the button
 			return raw("class=\"btn btn-#{size} btn-#{color}\"")
 		end
 	end
	
	
	def loading_bar
		content_tag(:div, :id => "loading_screen", :style => "display: none", :class => "progress progress-striped active") do
			content_tag(:div, :style => "width: 100%;", :class => "bar") do
				"Loading"
			end
		end
	end
	
	def model_status_display(model_name)
    if model_name.status == "failed"
	  	content_tag(:td) do
	  		content_tag(:span, :class => "badge badge-warning") do
	  			model_name.status
	  		end
	  	end
	  elsif model_name.status == "skipped"
	  	content_tag(:td) do
	  		content_tag(:span, :class => "label label-info") do
	  			model_name.status
	  		end
	  	end
	  else
	  	content_tag(:td) do
	  		content_tag(:span, :class => "label label-inverse") do
	  			model_name.status
	  		end
	  	end
		end    
 	end
 	
 	def keyword_or_name_display(current_model)
 		if current_model.name.length == 0
 			content_tag(:td) do
 				current_model.keyword
 			end
 		else
 			content_tag(:td) do
 				current_model.name
 			end
 		end
 	end
 	
 	def keyword_or_name_link(current_model)
 		if current_model.name.length == 0
 			return current_model.keyword
 		else
 			return current_model.name
 		end
 	end
 	
 	def get_generate_data_url(suite)
 		root_url + auto_create_suites_path(suite.name)
 	end
	
end