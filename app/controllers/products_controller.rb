class ProductsController < ApplicationController

  # 例外処理記述
  rescue_from ActiveRecord::RecordNotFound, with: :rescue404_product #レコードが存在しない場合のエラー画面

  def index
    @products = Product.all
  end

  def show
    @product = Product.find(params[:id])
    @comments = @product.comments
    @comment = Comment.new

    # チャットページへの遷移処理追加
    if user_signed_in? #ユーザーがサインインしていたら
        @producer = Producer.find_by(id: @product.producer_id) # 商品を投稿している producer を取得
        rooms = current_user.rooms #現在ログインしているユーザーが所持している全ての rooms を取得
        @producer_ids = [] #配列を用意
        rooms.each do |r| #「現在ログインしているユーザーが所持している全てのrooms」を1つずつ取り出す
          @producer_ids << r.producer_id #ログインしているユーザーの相手、つまり producer の producer_id を @producer_ids に格納
        end  
        #これにより、 Producerの producer_id があるかどうかview側で判断して、「チャットしたことある相手なのかどうか」を判断している
    end
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

  def rescue404_product(e)
    @exception = e
    render template: 'error/404_product_not_found', status: 404
  end

end