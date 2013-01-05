class ItemsController < InheritedResources::Base
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]
  before_filter :load_shop

  # GET /items/new
  # GET /items/new.json
  def new

    @item = Item.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  # POST /items
  # POST /items.json
  def create
    @item = @shop.items.new(params[:item])

    respond_to do |format|
      if @item.save
        format.html { redirect_to @shop, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /items
  # GET /items.json
  def index
    @items = @shop.items

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shops }
    end
  end

  private
    def load_shop
      if params.has_key?(:shop_id)
        @shop = Shop.find(params[:shop_id])
      else
        @shop = current_user.shops.where(:id => params[:shop_id])
      end
    end
end
