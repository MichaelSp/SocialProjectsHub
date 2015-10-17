class Project < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :owners, class_name: "User"
  has_and_belongs_to_many :links

  has_many :positions

  accepts_nested_attributes_for :positions
end
