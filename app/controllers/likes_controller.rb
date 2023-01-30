class LikesController < ApplicationController
  def create
    @like = current_user.likes.new(like_params)
    if @like.save
      flash[:notice] = "Added to your liked book!"
    end
    redirect_to books_path(@book)
  end

  def destroy
    @like = current_user.likes.find_by(params[:id])
    @like.destroy
    redirect_to books_path(@book)
    flash[:alert] = 'Removed from your liked book'
  end

  def like_params
    params.require(:like).permit(:book_id)
  end
end
