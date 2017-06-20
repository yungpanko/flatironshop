class ReviewsController < ApplicationController
  # before_action :authenticate
  before_action :set_review, only: [:show, :edit, :update, :delete]

  def index
    @reviews = Review.all
  end

  def new
    @review = Review.new
  end

  def create
    review = Review.new(review_params)
    if review.save
      redirect_to reviews_path
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
    @review.update(review_params)
    redirect_to review_path(@review)
  end

  def delete
    @review.destroy
    redirect_to reviews_path
  end


  private

  def review_params
    params.require(:review).permit(:content, :rating, :item_id)
  end

  def set_review
    @review = Review.find(params[:id])
  end
end
