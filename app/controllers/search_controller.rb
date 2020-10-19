class SearchController < ApplicationController
  def search
    @model = params[:search][:model]
    how = params[:search][:how]
    @content = params[:search][:content]
    
    if @model == 'user'
      @users = User.search(how,@content)
    else
      @books = Book.search(how,@content)
    end
  end
end
