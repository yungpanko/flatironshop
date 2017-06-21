class ReviewsController < ApplicationController
  # before_action :authenticate
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  def index
    @reviews = []
    current_user.orders.each do |order|
      order.items.each do |item|
        @reviews << item.review if item.review
      end
    end
  end

  def new
    @review = Review.new
    session[:item_id] = params[:item_id]
    @item = Item.find(session[:item_id])
  end

  def create
    @item = Item.find(session[:item_id])
    review = Review.new(review_params)
    review.item_id = session[:item_id]
    if review.save
      flash[:info] = "Your review has been submitted!"
      redirect_to orders_path
    else
      render 'new'
    end
  end

  def show
    # byebug
  end

  def edit
    @item = @review.item
  end

  def update
    @review.update(review_params)
    redirect_to reviews_path
  end

  def destroy
    @review.destroy
    redirect_to reviews_path
  end


  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end

  def set_review
    @review = Review.find(params[:id])
  end

end
