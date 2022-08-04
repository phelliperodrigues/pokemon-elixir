defmodule ExMon do
  alias ExMon.Player

  def create_player(name, move_avg, move_heal, move_rnd) do
    Player.build(name, move_avg, move_heal, move_rnd)
  end
end
