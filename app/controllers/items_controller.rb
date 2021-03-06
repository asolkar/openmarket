class ItemsController < InheritedResources::Base
  respond_to :html, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :item_not_found

  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :save_referer, :only => [:edit, :destroy, :show]
  before_filter :load_photos, :only => [:show, :edit, :update]

  after_filter :item_not_found, :only => [:edit, :destroy, :show, :update]
  after_filter :not_users_item, :only => [:edit, :destroy, :update]

  belongs_to :shop

  protected
    def collection
      @items ||= end_of_association_chain.order(:created_at).page(params[:page]).per(5)
    end

  private
    def save_referer
      session[:return_to] ||= request.referer
      session[:return_to] ||= root_path # If empty, go to root
    end

    def item_not_found
      unless @item
        flash[:alert] = "Could not find item with ID " + params[:id] + " within shop ID " + params[:shop_id]
        redirect_to session.delete(:return_to)
        return false
      end
    end

    def not_users_item
      unless @shop.user == current_user
        flash[:alert] = "You are not to owner of this shop. You cannot edit items within"
        redirect_to session.delete(:return_to)
        return false
      end
    end

    def load_photos
      @photos = resource.photos.order(:created_at).page(params[:page]).per(5)
    end
end
