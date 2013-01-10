class ShopsController < InheritedResources::Base
  respond_to :html, :json

  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy, :my_index]
  before_filter :save_referer, :only => [:edit, :destroy]
  before_filter :load_items, :only => [:show]
  before_filter :begin_of_association_chain, :only => [:my_index]
  before_filter :collection, :only => [:my_index]

  after_filter :shop_not_found, :only => [:edit, :destroy]
  after_filter :not_users_shop, :only => [:edit, :destroy]

  def my_index
    respond_to do |format|
      format.html # my_index.html.erb
      format.json { render json: @shops }
    end
  end

  protected
    def begin_of_association_chain
      @current_user
    end

    def collection
      @shops ||= end_of_association_chain.order(:created_at).page(params[:page]).per(10)
    end

  private
    def save_referer
      session[:return_to] ||= request.referer
    end

    def shop_not_found
      unless @shop
        flash[:alert] = "Could not find shop with ID " + @shop.id
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

