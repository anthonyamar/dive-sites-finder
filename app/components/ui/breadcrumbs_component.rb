# frozen_string_literal: true

class Ui::BreadcrumbsComponent < ViewComponent::Base
  
  attr_reader :links, :classes
  
  def initialize(links, classes: "")
    @links = links # Array of hashes like { link: "/path/", text: "My link" }
    @classes = classes
  end

end