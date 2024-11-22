class ReviewsController < ApplicationController
  before_action :set_list, only: %i[create]
  before_action :set_review, only: %i[destroy]

  def create
    @review = Review.new(review_params)
    @review.list = @list
    if @review.save
      redirect_to list_path(@list)
    else
      @bookmark = Bookmark.new
      render 'lists/show', status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to list_path(@review.list)
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def review_params
    params.require(:review).permit(:comment, :rating)
  end
end
