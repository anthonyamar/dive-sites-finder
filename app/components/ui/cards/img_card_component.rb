# frozen_string_literal: true

class Ui::Cards::ImgCardComponent < ViewComponent::Base
  
  attr_reader :classes, :image, :alt_image, :link, :title, :sub_title
  
  def initialize(
    classes: "",
    image: "", 
    alt_image: "", 
    link: "", 
    title: "", 
    sub_title: ""
  )
    
    @image = image
    @alt_image = alt_image
    @link = link
    @title = title
    @sub_title = sub_title
  end

end
