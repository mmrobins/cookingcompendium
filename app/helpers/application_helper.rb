# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  def unit_select(object, method, html_options = {})
    select object, method, Food::UNITS.collect {|unit| [unit, unit] }, {:include_blank => true }
  end
end
