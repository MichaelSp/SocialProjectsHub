class Position < ActiveRecord::Base
  belongs_to :project

  enum target_group: [:refugee, :community, :entrepreneur, :volunteer]

  default_scope { order :pos }
end
