class BookCommentsController < ApplicationController

  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id = book.id
    comment.save
    redirect_to request.referer
    # @comment = Comment.new(book_comment_params)
    # @comment.user_id = current_user.id
    # if comment.save
    #   redirect_back(fallback_location: root_path)
    # else
    #   redirect_back(fallback_location: root_path)
    # end
  end

  def destroy
    BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
    redirect_to request.referer
    # @book = Book.find(params[:book_id])
    # book_comment = @book.book_comments.find(params[:id])
    # book_comment.destroy
  end


  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)
  end

end
