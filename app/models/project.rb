class Project < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_and_belongs_to_many :owners, class_name: "User"
  has_many :images, dependent: :destroy
  has_many :project_translations, autosave: true, dependent: :destroy

  has_many :positions, dependent: :destroy

  accepts_nested_attributes_for :positions
  accepts_nested_attributes_for :images

  accepts_attachments_for :images, attachment: :file, append: true


  validate do
    errors.add(:positions, :not_empty) if positions.map(&:pos).compact.empty?
  end

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

  def languages
    (['eng'] + project_translations.pluck(:language_code)).map{|code| LanguageList::LanguageInfo.find(code)}
  end

  def translation_for name, language
    return send(name) if language == 'eng'
    project_translations.find_by_language_code(language).try(:send, name.to_sym) || ''
  end

  def set_translation_for name, language, text
    call = :"#{name}="
    return send(call, text) if language == 'eng'
    translation = project_translations.where(language_code: language).first_or_initialize
    translation.send(call, text)
    translation.save
  end

  def method_missing method, *args, &block
    call = method.to_s
    if call.starts_with?('name_') || call.starts_with?('description_')
      if call.ends_with?('=')
        name, language, text = *[call.sub(/=$/,'').split('_'), args].flatten
        self.set_translation_for name, language, text
      else
        translation_for *call.split('_')
      end
    else
      super
    end
  end

end
