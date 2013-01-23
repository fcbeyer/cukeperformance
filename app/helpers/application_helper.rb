module ApplicationHelper
	
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
	
end