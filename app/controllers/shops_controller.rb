class ShopsController < InheritedResources::Base
  before_filter :require_user, :only => [:new, :create, :edit, :update, :destroy]

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
    @shops = Shop.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @shops }
    end
  end

end
