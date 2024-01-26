# frozen_string_literal: true

class Ui::Containers::WavesComponent < ViewComponent::Base
  
  def initialize(classes: "", variant: rand(1..5))
    @classes = classes
    @variant = variant
  end
  
end
