ActiveAdmin.register User do
  before_filter :only => [:show, :edit, :update, :destroy] do
    @user = User.find_by_username(params[:id])
  end
end
