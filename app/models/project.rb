class Project < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :owners, class_name: "User"
  has_and_belongs_to_many :links, dependent: :destroy

  has_many :positions, dependent: :destroy

  accepts_nested_attributes_for :positions
  accepts_nested_attributes_for :links

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

  [:facebook, :twitter, :homepage].each do |link|
    define_method link do
      links.send(link).first
    end
  end

end
