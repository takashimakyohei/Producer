class RoomsController < ApplicationController
  def index

  end
  
  def show
    @room = Room.find(params[:id]) #ルーム情報の取得（ user_id, producer_id が入っているかどうかを調べる）
    @message = Message.new #新規メッセージ作成
    @messages = @room.messages

    if user_signed_in? #もし、ユーザーがサインインしていて
      if @room.user_id == current_user.id #かつ、roomに入っている user_id が、 現在ログインしているユーザーのidだったら
        @producer = @room.producer # @producerに、現在 room に入っている producer の情報を全て格納する
      else
        redirect_to "/"
      end

    elsif producer_signed_in? #もし、producerがログインしていて
      if @room.producer_id == current_producer.id #かつ、 roomに入っている producer_id が、 現在ログインしている producer のidだったら
        @user = @room.user # @userに、現在 room に入っている user の情報を全て格納する
      else
        redirect_to "/"
      end
    end
  end

  def create
    if user_signed_in? #もしユーザーがサインインしていたら
      @room = Room.new(room_producer_params)
      @room.user_id = current_user.id # @room の user_id に、 現在ログインしているユーザーのidを代入する。 
    else
      redirect_to "/"
    end

    if  @room.save
      redirect_to :action => "show", :id => @room.id
    else
      redirect_to "/"
    end
  end

  private

  def room_producer_params
    params.require(:room).permit(:producer_id)
  end


end
