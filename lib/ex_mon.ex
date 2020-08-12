defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.Status
  alias ExMon.Game.Actions

  @computer_name "CPU"
  @computer_moves [:move_avg, :move_rnd, :move_heal]

  def create_player(move_avg, move_rnd, move_heal, name) do
    Player.build(move_avg, move_rnd, move_heal, name)
  end

  def start_game(player) do
    create_player(:dragon_kick, :water_storm, :heal, @computer_name)
    |> Game.start(player)

    Game.info()
    |> Status.print_round_message()
  end

  def make_move(move) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move)
  end

  defp handle_status(:game_over, _move), do: Status.print_round_message(Game.info())

  defp handle_status(_, move) do
    move
    |> Actions.fetch_move()
    |> do_move()

    computer_move(Game.info())
  end

  defp do_move({:error, move}), do: Status.print_wrong_move_message(move)

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Status.print_round_message(Game.info())
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move = {:ok, Enum.random(@computer_moves)}
    do_move(move)
  end

  defp computer_move(_), do: :ok
end
