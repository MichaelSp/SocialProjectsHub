class Link < ActiveRecord::Base
  belongs_to :project

  def self.background
    where(category: 'background')
  end
end