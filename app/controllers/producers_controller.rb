class ProducersController < ApplicationController
  def index
    @producers = Producer.all
  end

  def show
    @producer = Producer.find(params[:id])
  end


  def edit
    @producer = current_producer
  end

  def update
    @producer = current_producer
    if @producer.update(producer_params)
      redirect_to producer_path, notice: "ユーザーを更新した"
    else
      render :edit
    end
  end

  private

  def producer_params
    params.require(:producer).permit(:name, :email, :image, :profile, :prefecture_id)
  end
end
