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
 	
 	def step_failure_image
 		if !@step.reason_for_failure.empty?
#			<p>
#				<a href="#imageButton" role="button" class="btn btn-info">Show Image</a>
#			</p>
#			
#			<div id="imageButton" class="modal hide fade" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
#				<%= render 'steps/show_image' %>
#			</div>
 		end
 	end

end
