class Position < ActiveRecord::Base
  belongs_to :project

  enum target_group: [:refugee, :community, :entrepreneur, :volunteer]

  validates_uniqueness_of :target_group, scope: :project

  default_scope { order :pos }
end
