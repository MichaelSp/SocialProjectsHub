class Filter
  attr_accessor :target_group, :project_name

  def initialize params = {}
    params = params[:project] if params.has_key?(:project)
    self.target_group = params[:target_group]
    self.project_name = params[:project_name]
  end

  def model_name
    'Project'
  end

  def projects
    results = Project.includes(:positions)
    if target_group
      results = results.where(positions: {target_group: Position.target_groups[target_group]})
      results = results.order('positions.pos')
    end
    search = "%#{project_name}%"
    results = results.where("`name` LIKE ? OR `description` LIKE ?", search, search) if project_name
    results
  end
end