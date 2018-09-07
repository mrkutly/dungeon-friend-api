class GameChannel < ApplicationCable::Channel
  def subscribed
    @game = Game.find_by(id: params[:game])
    stream_for @game
  end

  def received(data)
    GameChannel.broadcast_to(@game, { game: @game, users: @game.players } )
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end
