class UsersController < ApplicationController
  before_filter :require_user, :only => [:index, :show, :edit, :update]

  # GET /users/new
  # GET /users/new.json
  def new
    #
    # If a user is already logged in, creation of new user should be disabled
    #
    if current_user
      flash[:notice] = "You are already logged as " + current_user.fullname
      redirect_to '/'
      return false
    end

    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /users
  # GET /users.json
  def index
    @user = current_user

    respond_to do |format|
      format.html { redirect_to @user, notice: 'User listing is not allowed.' }
      format.json { render json: @user, status: :unprocessable_entity, location: @user }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    if params.has_key?(:id)
      @user = User.find(params[:id])
    else
      @user = current_user
    end

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end
