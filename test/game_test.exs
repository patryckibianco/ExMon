defmodule ExMon.GameTest do
  use ExUnit.Case
  alias ExMon.{Game, Player}

  describe "start/2" do
    test "starts the game state" do
      player = Player.build(:punch, :kick, :heal, "Horla")
      computer = Player.build(:punch, :kick, :heal, "CPU")

      assert {:ok, _pid} = Game.start(computer, player)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "CPU"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Horla"
        },
        status: :started,
        turn: :player
      }

      player = Player.build(:punch, :kick, :heal, "Horla")
      computer = Player.build(:punch, :kick, :heal, "CPU")
      Game.start(computer, player)

      assert expected_response == Game.info()
    end
  end

  describe "update/1" do
    test "returns the game state updated" do
      player = Player.build(:punch, :kick, :heal, "Horla")
      computer = Player.build(:punch, :kick, :heal, "CPU")
      Game.start(computer, player)

      expected_response = %{
        computer: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "CPU"
        },
        player: %Player{
          life: 100,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Horla"
        },
        status: :started,
        turn: :player
      }

      assert expected_response == Game.info()

      new_state = %{
        computer: %Player{
          life: 88,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "CPU"
        },
        player: %Player{
          life: 77,
          moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
          name: "Horla"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert expected_response == Game.info()
    end
  end

  describe "player/0" do
    test "returns a player from game state" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Horla"
      }

      player = Player.build(:punch, :kick, :heal, "Horla")
      computer = Player.build(:punch, :kick, :heal, "CPU")
      Game.start(computer, player)

      assert expected_response == Game.player()
    end
  end

  describe "turn/0" do
    test "returns a turn from game state" do
      player = Player.build(:punch, :kick, :heal, "Horla")
      computer = Player.build(:punch, :kick, :heal, "CPU")
      Game.start(computer, player)

      assert :player == Game.turn()
    end
  end

  describe "attacker/1" do
    test "returns a attacker from a turn" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :punch, move_heal: :heal, move_rnd: :kick},
        name: "Horla"
      }

      player = Player.build(:punch, :kick, :heal, "Horla")
      computer = Player.build(:punch, :kick, :heal, "CPU")
      Game.start(computer, player)

      assert expected_response == Game.attacker(:player)
    end
  end
end
