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

end
