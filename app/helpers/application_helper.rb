module ApplicationHelper
	
	def loading_bar
		content_tag(:div, :id => "loading_screen", :style => "display: none", :class => "progress progress-striped active") do
			content_tag(:div, :style => "width: 100%;", :class => "bar") do
				"Loading"
			end
		end
	end
	
end