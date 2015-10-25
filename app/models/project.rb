class Project < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :owners, class_name: "User"
  has_and_belongs_to_many :links, dependent: :destroy

  has_many :positions, dependent: :destroy

  accepts_nested_attributes_for :positions

  def category_ids= cats
    ids =  cats.map do |cat|
      next if cat.empty?
      case cat
        when /\A\d+\z/
          cat
        when String
          Category.create!(name: cat).id
      end
    end.compact
    super ids
  end

end
