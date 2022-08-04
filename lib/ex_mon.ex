defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Acctions, Status}

  @computer_name "Robotnik"
  def create_player(name, move_avg, move_heal, move_rnd) do
    Player.build(name, move_avg, move_heal, move_rnd)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message()
  end

  def make_move(move) do
    move
    |> Acctions.fetch_move()
  end
end
