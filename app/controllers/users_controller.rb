class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  before_action do
    authorize! action_name, @user || User
  end

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(:name)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user.password = '***'
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      if can? :all, User
        redirect_to users_path
      else
        User.current = @user
        session[:user_id] = @user.id
        redirect_to projects_path, notice: 'User was successfully created.'
      end
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to users_path, notice: 'User was successfully updated.' }
        format.json { render :index, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    p = params.require(:user).permit(:name, :email, :phone, :password, :password_confirmation, :admin, :translator)
    p.delete(:password) and p.delete(:password_confirmation) if p[:password] == '***' || p[:password].blank?
    p
  end
end
