class MessagesController < ApplicationController
  def create
    @room = Room.find(params[:room_id]) # Roomモデルから、 該当のroomを取ってくる
    @message = Message.new(message_params) #新規メッセージ作成
    #メッセージがuserによるものだったらis_user=true, producerによるものだったらis_user=false
    if user_signed_in? #もしユーザーがサインインしていたら
      @message.is_user = true # is_userをtrueにして、 userの発言としている
    elsif producer_signed_in? #もし producer がサインインしていたら
      @message.is_user = false # is_userをtrueにして、 producerの発言としている
    end
    @message.room_id = @room.id #messageのroom_idに、現在のルームのidを代入する。　これで、room_id と content が揃うので、message を save 出来る
    if @message.save # メッセージを save できたら
      redirect_to room_url(@room) #現在のroomに遷移する
    else
      redirect_to room_url(@room)
    end
  end

  private
  def message_params
    params.require(:message).permit(:content)
  end
end
