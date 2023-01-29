class BooksController < ApplicationController
    before_action :find_book, only: [:show,:edit,:update,:destroy]
    before_action :authenticate_user!, only: [:edit,:update,:destroy, :new]
    before_action :correct_user!, only: [:edit,:update,:destroy]
    def index
            @books = Book.all.order("created_at DESC")
    end
 
    def show
    end
    def new
        @book = current_user.books.build
    end 

    def create
        @book = current_user.books.build(book_params)            
        if @book.save
            redirect_to root_path
        end
    end
    def edit
    end

    def update
        if @book.update(book_params)
            redirect_to book_path(@book)
        end
    end

    def destroy
        if @book.destroy
            redirect_to root_path
        end
    end

    def correct_user!
        @book = current_user.books.find_by(id: params[:id])
        redirect_to root_path, notice: 'Not Authorized!' if @book.nil?
    end
    private
    def book_params
        params.require(:book).permit(:title, :description, :author )
    end

    def find_book
        @book = Book.find_by(id: params[:id])
    end
end
