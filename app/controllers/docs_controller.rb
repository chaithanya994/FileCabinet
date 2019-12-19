class DocsController < ApplicationController
  before_action :find_doc, only:[:show, :edit, :update, :destroy]
  
  def index
    if current_user
      @docs = Doc.where(user_id: current_user)
    else
      @docs = Doc.all
    end
  end

  def new
    if current_user
      @doc = current_user.docs.build
    else
      @doc = Doc.new
    end
  end

  def show
  end

  def create
    @doc = current_user.docs.build(doc_params)
    if @doc.save
      redirect_to @doc
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @doc.update(doc_params)
      redirect_to @doc
    else
      render 'edit'
    end
  end

  def destroy
    @doc.destroy
    redirect_to docs_path
  end
   
   private
    
    def find_doc
      @doc = Doc.find(params[:id])
    end
    
    def doc_params
      params.require(:doc).permit(:title, :content)
    end
end
