class SearchController < ApplicationController
  def simple
    if params[:search].present?
      q = "%#{params[:search]}%"
      @items = Item.where('name LIKE ? or description LIKE ?', q, q)
      @shops = Shop.where('name LIKE ? or description LIKE ?', q, q)
    else
      @items = Item.find(:all)
      @shops = Shop.find(:all)
    end
    @items = @items.order(:created_at).page(params[:page]).per(5)
    @shops = @shops.order(:created_at).page(params[:page]).per(5)
  end

  def advanced
  end
end
