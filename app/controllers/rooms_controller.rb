class RoomsController < ApplicationController
  def index #producerとしてログインした際の、「DMリスト」画面
      # チャットページへの遷移処理追加
    if producer_signed_in? # producer がサインインしていたら
      @users = User.all #全てのuserを取得
      rooms = current_producer.rooms #現在ログインしているproducerが所持している全ての rooms を取得
      @user_ids = [] #配列を用意
      rooms.each do |r| #「現在ログインしているユーザーが所持している全てのrooms」を1つずつ取り出す
        @user_ids << r.user_id #ログインしているユーザーの相手、つまり user の user_id を @user_ids に格納
      end  
      #これにより、 userの user_id があるかどうかview側で判断して、「チャットしたことある相手なのかどうか」を判断している
    end
  end

  def show #トークルーム画面
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
        @user = User.find_by(id: @room.user_id) # @userに、現在 room に入っている user の情報を全て格納する
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
