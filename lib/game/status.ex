defmodule ExMon.Game.Status do
  alias ExMon.Player

  def print_round_message(%{status: :started} = info) do
    IO.puts("\n ========= The battle has started!! ========= \n")
    IO.inspect(info)
    IO.puts("\n -------------------------------------------- \n")
  end

  def print_round_message(%{status: :continue, turn: player} = info) do
    IO.inspect(info)
    IO.puts("\n ========= It's #{player} turn ========= \n")
    IO.puts("\n --------------------------------------- \n")
  end

  def print_round_message(%{status: :game_over, computer: %Player{life: computer_life}} = info)
      when computer_life == 0 do
    IO.puts("\n ========= The game is over ========= \n")
    IO.puts("\n ------------- You win! ------------- \n")
    IO.puts("\n ------------------------------------ \n")
    IO.inspect(info)
  end

  def print_round_message(%{status: :game_over, player: %Player{life: player_life}} = info)
      when player_life == 0 do
    IO.puts("\n ========= The game is over ========= \n")
    IO.puts("\n ------------- You lose! ------------ \n")
    IO.puts("\n ------------------------------------ \n")
    IO.inspect(info)
  end

  def print_wrong_move_message(move) do
    IO.puts("\n Oh oh! Looks that you're trying to do an inexistent move: #{move}\n ")
    # {:error, "Oh oh! Looks that you're trying to do an inexistent move: #{move}"}
  end

  def print_attack_turn_message(:computer, damage) do
    IO.puts("Player attacks enemy dealing #{damage} of damage")
  end

  def print_attack_turn_message(:player, damage) do
    IO.puts("CPU attacks enemy dealing #{damage} of damage")
  end

  def print_heal_turn_message(player, :heal, life) do
    IO.puts("The #{player} healed it self to #{life} points")
  end
end
