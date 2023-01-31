class BooksController < ApplicationController
    before_action :find_book, only: [:show,:edit,:update,:destroy, :index]
    before_action :authenticate_user!, only: [:edit,:update,:destroy, :new]
    before_action :correct_user!, only: [:edit,:update,:destroy]
    BOOK_PER_PAGE = 6
    def index
        @page = params.fetch(:page, 0).to_i
        @books = Book.offset(@page*BOOK_PER_PAGE).limit(BOOK_PER_PAGE).order("Created_at DESC")
    end
 
    def show
        @book.update(views:@book.views + 1)
    end
    def new
        @book = current_user.books.build
    end 

    def create
        @book = current_user.books.build(book_params)            
        if @book.save
            redirect_to books_path,notice: 'Book Added!'
        else
            render :new , status: :unprocessable_entity
        end
    end
    def edit
    end

    def update
        if @book.update(book_params)
            redirect_to book_path(@book),notice: 'Updated!'
        else
            render :edit, status: :unprocessable_entity
        end                                                 
    end

    def destroy
        if @book.destroy
            redirect_to books_path, alert: 'Deleted!'
        end
    end

    def correct_user!
        @book = current_user.books.find_by(id: params[:id])
        redirect_to root_path, alert: 'Not Authorized!' if @book.nil?
    end
    private
    def book_params
        params.require(:book).permit(:title, :description, :author, :image )
    end

    def find_book
        @book = Book.find_by(id: params[:id])
    end
end
    