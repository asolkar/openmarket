class ShopsController < InheritedResources::Base
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy, :my_index]

  # GET /shops/new
  # GET /shops/new.json
  def new

    @shop = Shop.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @shop }
    end
  end

  # POST /shops
  # POST /shops.json
  def create
    @shop = current_user.shops.new(params[:shop])

    respond_to do |format|
      if @shop.save
        format.html { redirect_to @shop, notice: 'Shop was successfully created.' }
        format.json { render json: @shop, status: :created, location: @shop }
      else
        format.html { render action: "new" }
        format.json { render json: @shop.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /shops
  # GET /shops.json
  def index
    # @shops = Shop.all.page(params[:page]).per(10)
    @shops = Shop.order(:created_at).page(params[:page]).per(10)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shops }
    end
  end

  # GET /my_index
  # GET /my_index.json
  def my_index
    @shops = current_user.shops

    respond_to do |format|
      format.html # my_index.html.erb
      format.json { render json: @shops }
    end
  end

  # GET /shops/1/edit
  # GET /shops/1/edit.json
  def edit
    session[:return_to] ||= request.referer

    @shop = Shop.find(params[:id])

    unless @shop
      flash[:alert] = "Could not find shop with ID " + @shop.id
      redirect_to session.delete(:return_to)
      return false
    end
    unless @shop.user == current_user
      flash[:alert] = "You are not to owner of this shop. You cannot edit it"
      redirect_to session.delete(:return_to)
      return false
    end
  end

  # GET /shops/1
  # GET /shops/1.json
  def show
    @shop = Shop.find(params[:id])

    @items = @shop.items.order(:created_at).page(params[:page]).per(5)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # DELETE /shops/1
  # DELETE /shops/1.json
  def destroy
    session[:return_to] ||= request.referer

    @shop = Shop.find(params[:id])

    unless @shop
      flash[:alert] = "Could not find shop with ID " + @shop.id
      redirect_to session.delete(:return_to)
      return false
    end
    unless @shop.user == current_user
      flash[:alert] = "You are not to owner of this shop. You cannot delete it"
      redirect_to session.delete(:return_to)
      return false
    end

    @shop.destroy

    respond_to do |format|
      format.html { redirect_to session.delete(:return_to) }
      format.json { head :no_content }
    end
  end
end
