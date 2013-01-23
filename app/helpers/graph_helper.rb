module GraphHelper
  
  def begin_date_display
    content_tag(:div, :class => "field") do
      select_date(@begin_date, :prefix => "begin_date")
    end
  end
  
  def end_date_display
    content_tag(:div, :class => "field") do
      select_date(Time.now, :prefix => "end_date")
    end
  end    
  
  def select_suite_display
    content_tag(:div, :class => "field") do
      select_tag :suite_name,options_from_collection_for_select(@suite_list,"name","display_name")
    end
  end
  
end
