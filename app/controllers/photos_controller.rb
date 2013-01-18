class PhotosController < InheritedResources::Base
  respond_to :html, :json

  rescue_from ActiveRecord::RecordNotFound, :with => :photo_not_found

  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :save_referer, :only => [:edit, :destroy, :show]

  after_filter :photo_not_found, :only => [:edit, :destroy, :show, :update]

  belongs_to :item

  #
  # Overriding to set redirection
  #
  def create
    create! { shop_item_photo_path(@photo.item.shop, @photo.item, @photo) }
  end
  def destroy
    destroy! { shop_item_path(@photo.item.shop, @photo.item) }
  end

  protected
    def collection
      @photos ||= end_of_association_chain.order(:created_at).page(params[:page]).per(5)
    end

  private
    def save_referer
      session[:return_to] ||= request.referer
      session[:return_to] ||= root_path # If empty, go to root
    end

    def photo_not_found
      unless @photo
        flash[:alert] = "Could not find photo with ID " + params[:id]
        redirect_to session.delete(:return_to)
        return false
      end
    end
end
