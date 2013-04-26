module StepsHelper
	
	def step_status_show_display
    if @step.status == "failed"
	  	content_tag(:span, :class => "badge badge-warning") do
	  		@step.status
	  	end
	  elsif @step.status == "skipped"
	  	content_tag(:span, :class => "label label-info") do
	  		@step.status
	  	end
	  else
	  	content_tag(:span, :class => "label label-inverse") do
	  		@step.status
	  	end
		end    
 	end

 	def step_failure_display
 		if !@step.reason_for_failure.nil?
 			if !@step.reason_for_failure.empty?
 				content_tag(:p) do 					
 				  @step.reason_for_failure
 				end
 			end
 		end
 	end

 	def step_display_failure_image
		if !@step.failure_image.nil?
			if !@step.failure_image.empty?		
				data1 = create_fail_button()
				#Build image HTML.  Can't use 'image_tag' since image is not stored within rails folder structure
				data2 = raw("<div id=\"imageButton\" style=\"display:none\"><img id=\"image\" alt=\"Embedded Image\" class=\"img-polaroid\" src=\"data:image/png;base64," + @step.failure_image + "\"/></div>")
				data3 = data1 + data2
				return data3
			end
		end
 	end
 	
 	def create_fail_button
		content_tag(:p) do
			content_tag(:a, :href => "#imageButton", :role => "button", :class => "btn", :onclick => "showStepFailedImage()") do
				"Show Image"
			end
		end
 	end
 	
end
