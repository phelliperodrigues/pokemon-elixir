defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Acctions, Status}

  @computer_name "Robotnik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]

  def create_player(name, move_avg, move_rnd, move_heal) do
    Player.build(name, move_avg, move_rnd, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Status.print_round_message(Game.info())
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_other, move) do
    move
    |> Acctions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Acctions.heal()
      _ -> Acctions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    Status.wait_computer_move_message()
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
    IO.puts("======= Your Turn, Choose your next move! =======")
  end

  defp computer_move(_), do: :ok
end
