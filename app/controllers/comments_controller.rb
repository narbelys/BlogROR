class CommentsController < ApplicationController
    
    http_basic_authenticate_with name: "narbe", password: "2301", only: :destroy
    
  def index
    @comment = Article.all
  end
    
  def new
    @comment = Article.comments.new
  end

  def create
      
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    
    print @comment.save
    print @comment.errors.full_messages
      
    if @comment.save
        flash[:success] = "Comentario enviado"
      redirect_to article_path(@article)
    else
        flash[:error] = @comment.errors.full_messages
        redirect_to article_path(@article)
       #render :json => ['hotels' => @article.comments, 'country' =>  @article]
    end
    
      
    #@article = Article.find(params[:article_id])
    #@comment = @article.comments.new(comment_params)
    #redirect_to article_path(@article)
      
    #if @comment.save
        #redirect_to article_path(@article)
         #redirect_to @comment
    #else
        #print @comment.errors.full_messages
        #print '----------'
        #redirect_to article_path(@article)
        #render 'articles/show'
    #end
      
      
  end
    
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    redirect_to article_path(@article)
  end
    
  private
    def comment_params
      params.require(:comment).permit(:commenter, :body)
    end
end
