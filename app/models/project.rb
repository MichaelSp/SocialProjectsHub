class Project < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :owners, class_name: "User"
  has_many :images, dependent: :destroy

  has_many :positions, dependent: :destroy

  accepts_nested_attributes_for :positions
  accepts_nested_attributes_for :images

  accepts_attachments_for :images, attachment: :file, append: true

  include PgSearch
  pg_search_scope :full_text_search,
                  against: [:name, :description],#{name: 'A', homepage: 'B', description: 'D'},
                  associated_against: {categories: :name}

  before_save do
    [:facebook, :twitter, :homepage].each do |link|
      url = send(link)
      send("#{link}=", "http://#{url}") unless url.blank? || url =~ /https?:\/\//
    end
  end

  def background_image
    images.where(category: 'background').first || images.where(category: 'image').first
  end

  def category_ids= cats
    ids = cats.map do |cat|
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
