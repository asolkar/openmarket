class ItemsController < InheritedResources::Base
  respond_to :html, :json

  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :save_referer, :only => [:edit, :destroy]

  after_filter :item_not_found, :only => [:edit, :destroy]
  after_filter :not_users_item, :only => [:edit, :destroy]

  belongs_to :shop

  def collection
    @items ||= end_of_association_chain.order(:created_at).page(params[:page]).per(5)
  end

  private
    def save_referer
      session[:return_to] ||= request.referer
    end

    def item_not_found
      unless @item
        flash[:alert] = "Could not find item with ID " + @item.id + " within shop ID " + @shop.id
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
end
