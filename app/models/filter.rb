class Filter
  attr_accessor :target_group, :project_name, :categories

  def initialize params = {}
    params = params[:project] if params.has_key?(:project)
    self.target_group = params[:target_group] || :refugee
    self.project_name = params[:project_name]
    self.categories = params[:category_ids].blank? ? [] : Category.where(id: params[:category_ids].split(",").flatten).uniq
  end

  def model_name
    'Project'
  end

  def projects
    results = Project.joins(:positions).joins(:categories)
    if target_group
      results = results.where.not(positions: {pos: nil})
      results = results.where(positions: {target_group: Position.target_groups[target_group]})
      results = results.order('positions.pos')
    end
    results = results.where(categories_projects: {category_id: category_ids}) unless categories.blank?
    results = results.merge(Project.full_text_search(project_name)) unless project_name.blank?
    results
  end

  def possible_categories
    Category.joins(:categories_projects).where(categories_projects: {project_id: projects.map(&:id) }).uniq
  end

  def category_ids
    @categories.map(&:id)
  end
end