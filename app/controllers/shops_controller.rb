class ShopsController < InheritedResources::Base
  respond_to :html, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :shop_not_found

  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :save_referer, :only => [:edit, :destroy, :show]
  before_filter :load_items, :only => [:show]

  after_filter :shop_not_found, :only => [:edit, :destroy, :show]
  after_filter :not_users_shop, :only => [:edit, :destroy]

  protected
    def begin_of_association_chain
      if params.has_key?(:username)
        @user = User.find_by_username(params[:username])
      end
      if action_name == "create" || action_name == "update"
        @user = current_user;
      end
    end

    def collection
      @shops ||= end_of_association_chain.order(:created_at).page(params[:page]).per(10)
    end

  private
    def save_referer
      session[:return_to] ||= request.referer
      session[:return_to] ||= root_path # If empty, go to root
    end

    def shop_not_found
      unless @shop
        flash[:alert] = "Could not find shop with ID " + params[:id]
        redirect_to session.delete(:return_to)
        return false
      end
    end

    def not_users_shop
      unless @shop.user == current_user
        flash[:alert] = "You are not to owner of this shop. You cannot edit it"
        redirect_to session.delete(:return_to)
        return false
      end
    end

    def load_items
      @items = resource.items.order(:created_at).page(params[:page]).per(5)
    end
end

