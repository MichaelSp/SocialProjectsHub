class ProjectTranslation < ActiveRecord::Base
  belongs_to :project

  validates_uniqueness_of :language_code, scope: :project
end
