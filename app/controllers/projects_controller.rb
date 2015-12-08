class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action only: [:edit, :update, :destroy] do
    authorize! action_name, @project
  end
  # GET /projects
  # GET /projects.json
  def index
    @projects = @filter.projects
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  # GET /projects/new
  def new
    @project = Project.new
    add_relations
  end

  # GET /projects/1/edit
  def edit
    add_relations
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = Project.new(project_params)
    @project.owners = [User.current] if User.current

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params) && delete_images
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def delete_images
    @project.images.where(category: 'delete').destroy_all
  end

  def add_relations
    Position.target_groups.each do |target_group, id|
      @project.positions.build target_group: target_group if @project.positions.send(target_group).empty?
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_project
    @project = Project.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def project_params
    p = params.require(:project).permit(:name, :gps_position, :target_group, :rating, :description,
                                        :facebook, :twitter, :homepage,
                                        positions_attributes: [:id, :pos, :target_group], category_ids: [],
                                        images_files: [], images_attributes: [:id, :category]
    )
    p.merge! params.require(:project).select { |param| param.starts_with?('name_') || param.starts_with?('description_') }
    p
  end
end
