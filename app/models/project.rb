class Project < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :owners, class_name: "User"
end
