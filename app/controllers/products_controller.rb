class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @comments = @product.comments
    @comment = Comment.new
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new (product_params)
    @product.producer_id = current_producer.id
    if @product.save
      redirect_to product_path(@product), notice: "投稿に成功しました"
    else
      render :new
    end
  end

  def edit
    @product = Product.find(params[:id])
    if @product.producer_id != current_producer.id
      redirect_to products_path, alert: "不正なアクセスです"
    end
  end

  def update
    @product = Product.find(params[:id])
    if @product.update (product_params)
      redirect_to product_path(@product), notice: "編集に成功しました"
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :description, :price, :content, :image)
  end
end