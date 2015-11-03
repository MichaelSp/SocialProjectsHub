class Link < ActiveRecord::Base
  belongs_to :project

  [:background_image, :image, :homepage, :twitter, :facebook].each do |cat|
    scope cat, -> { where(category: cat.to_s) }
    define_method :"#{cat}?" do
      category == cat.to_s
    end
  end

end