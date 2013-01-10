class UsersController < InheritedResources::Base
  respond_to :html, :json

  # actions :all, :except => [:index]

  before_filter :require_user, :only => [:index, :show, :edit, :update]
  before_filter :already_logged_in, :only => [:new]
  before_filter :no_user_listing, :only => [:index]

  def show
    if params.has_key?(:username)
      @user = User.find_by_username(params[:username])
    else
      @user = current_user
    end

    @shops = @user.shops.order(:created_at).page(params[:page]).per(5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  private

  def already_logged_in
    if current_user
      flash[:notice] = "You are already logged as " + current_user.fullname
      redirect_to '/'
    end
  end

  def no_user_listing
    flash[:alert] = "User listing is not allowed"
    redirect_to '/'
  end
end
